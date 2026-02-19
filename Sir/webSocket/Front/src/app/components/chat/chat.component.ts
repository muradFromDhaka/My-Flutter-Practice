import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { ChatService } from '../../service/chat.service';
import { Subscription } from 'rxjs';
import { ChatMessage, Conversation, Notification } from '../../model/ChatMessage';
import { ChatGroup, CreateGroupRequest, AddMemberRequest, GroupEvent } from '../../model/model';

@Component({
  selector: 'app-chat',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './chat.component.html',
  styleUrl: './chat.component.scss'
})
export class ChatComponent implements OnInit, OnDestroy {
  // Current user
  currentUser = '';
  tempUsername = '';
  
  // Chat data
  groupMessages: ChatMessage[] = [];
  privateMessages: ChatMessage[] = [];
  conversations: Conversation[] = [];
  // availableGroups: string[] = [];
  chatUsers: string[] = [];
  notifications: Notification[] = [];
  availableGroups: ChatGroup[] = [];

  // Group management
  userGroups: ChatGroup[] = [];
  accessibleGroups: ChatGroup[] = [];
  currentGroup: ChatGroup | null = null;
  selectedGroup: ChatGroup | null = null;
  groupMembers: string[] = [];
  
  // UI state
  activeConversationType: 'group' | 'private' | null = null;
  activeGroupId = '';
  activePrivateUser = '';
  
  // Form fields
  newGroupMessage = '';
  newPrivateMessage = '';
  recipient = '';
  newGroupName = '';
  newGroupDescription = '';
  newGroupIsPrivate = false;
  newMemberUsername = '';
  
  // Modals
  showUsernameModal = true;
  showCreateGroupModal = false;
  showGroupMembersModal = false;
  showAddMemberModal = false;
  showNotifications = false;
  
  // Connection & Loading
  isConnected = false;
  isLoadingGroupHistory = false;
  isLoadingPrivateHistory = false;
  loadError = '';
  unreadCount = 0;
  
  // Subscriptions
  private groupSubscription!: Subscription;
  private privateMessageSubscription!: Subscription;
  private statusSubscription!: Subscription;
  private notificationsSubscription!: Subscription;
  private unreadCountSubscription!: Subscription;
  private userGroupsSubscription!: Subscription;
  private groupEventSubscription!: Subscription;

  constructor(private chatService: ChatService) {}


  // Add this method to check if user is in a group
isUserInGroup(group: ChatGroup): boolean {
  if (!group || !group.id) return false;
  return this.userGroups.some(userGroup => userGroup.id === group.id);
}

getAvailableGroupsCount(): number {
  if (!this.accessibleGroups || this.accessibleGroups.length === 0) return 0;
  return this.accessibleGroups.filter(group => !this.isUserInGroup(group)).length;
}

getFilteredAccessibleGroups(): ChatGroup[] {
  if (!this.accessibleGroups) return [];
  return this.accessibleGroups.filter(group => !this.isUserInGroup(group));
}
  // Getters for filtered conversations
  get privateConversations(): Conversation[] {
    return this.conversations.filter(c => c.type === 'private');
  }

  get groupConversations(): Conversation[] {
    return this.conversations.filter(c => c.type === 'group');
  }

  get unreadNotifications(): Notification[] {
    return this.notifications.filter(n => !n.read);
  }

  ngOnInit() {
    this.statusSubscription = this.chatService.connectionStatus$.subscribe(
      status => this.isConnected = status
    );

    // Subscribe to real-time private messages
    this.privateMessageSubscription = this.chatService.privateMessage$.subscribe(
      (message: ChatMessage | null) => {
        if (message && this.isPrivateMessageRelevant(message)) {
          console.log('📨 Real-time private message received:', message);
          this.handleIncomingPrivateMessage(message);
        }
      }
    );

    this.notificationsSubscription = this.chatService.notifications$.subscribe(
      notifications => this.notifications = notifications
    );

    this.unreadCountSubscription = this.chatService.unreadCount$.subscribe(
      count => this.unreadCount = count
    );

    // Group management subscriptions
    this.userGroupsSubscription = this.chatService.userGroups$.subscribe(
      groups => this.userGroups = groups
    );

    this.groupEventSubscription = this.chatService.groupEvent$.subscribe(
      event => {
        if (event) {
          this.handleGroupEvent(event);
        }
      }
    );
    
    const savedUsername = localStorage.getItem('chatUsername');
    if (savedUsername) {
      this.currentUser = savedUsername;
      this.showUsernameModal = false;
      this.initializeUserData();
    }

    // Request notification permission
    if ('Notification' in window) {
      Notification.requestPermission();
    }
  }

  private isPrivateMessageRelevant(message: ChatMessage): boolean {
    return (
      (message.sender === this.currentUser && message.receiver === this.activePrivateUser) ||
      (message.receiver === this.currentUser && message.sender === this.activePrivateUser) ||
      (message.receiver === this.currentUser && !this.activePrivateUser)
    );
  }

  private handleIncomingPrivateMessage(message: ChatMessage): void {
    if (this.activeConversationType === 'private' && 
        ((message.sender === this.activePrivateUser && message.receiver === this.currentUser) ||
         (message.receiver === this.activePrivateUser && message.sender === this.currentUser))) {
      
      const messageExists = this.privateMessages.some(
        msg => msg.id === message.id || 
               (msg.sender === message.sender && 
                msg.content === message.content && 
                Math.abs(new Date(msg.timestamp as any).getTime() - new Date(message.timestamp as any).getTime()) < 1000)
      );
      
      if (!messageExists) {
        this.privateMessages.push(message);
        this.privateMessages.sort((a, b) => 
          new Date(a.timestamp as any).getTime() - new Date(b.timestamp as any).getTime()
        );
      }
    }

    if (message.sender !== this.currentUser && !this.chatUsers.includes(message.sender)) {
      this.chatUsers.push(message.sender);
    }

    this.updateConversationList();
  }

  initializeUserData() {
    this.loadConversations();
    this.loadAvailableGroups();
    this.loadChatUsers();
    this.loadUserGroups();
    this.loadAccessibleGroups();
    this.connect();
  }

  // User Management
  setUsername() {
    if (this.tempUsername.trim()) {
      this.currentUser = this.tempUsername.trim();
      this.showUsernameModal = false;
      localStorage.setItem('chatUsername', this.currentUser);
      this.initializeUserData();
    }
  }

  changeUsername() {
    this.showUsernameModal = true;
    this.tempUsername = this.currentUser;
    this.disconnect();
  }

  connect() {
    if (!this.currentUser) {
      this.showUsernameModal = true;
      return;
    }
    this.chatService.connect();
  }

  disconnect() {
    this.chatService.disconnect();
    this.unsubscribeAll();
  }

  // Group Management Methods
  loadUserGroups(): void {
    if (this.currentUser) {
      this.chatService.loadUserGroups(this.currentUser);
    }
  }

  loadAccessibleGroups(): void {
    if (this.currentUser) {
      this.chatService.getAccessibleGroups(this.currentUser).subscribe({
        next: (groups) => {
          this.accessibleGroups = groups;
        },
        error: (error) => {
          console.error('Error loading accessible groups:', error);
        }
      });
    }
  }

  createGroup(): void {
    if (this.newGroupName.trim() && this.currentUser) {
      const request: CreateGroupRequest = {
        name: this.newGroupName.trim(),
        description: this.newGroupDescription.trim(),
        createdBy: this.currentUser,
        isPrivate: this.newGroupIsPrivate
      };

      this.chatService.createGroup(request).subscribe({
        next: (group) => {
          console.log('Group created:', group);
          this.newGroupName = '';
          this.newGroupDescription = '';
          this.newGroupIsPrivate = false;
          this.showCreateGroupModal = false;
          
          this.loadUserGroups();
          this.loadAccessibleGroups();
          
          alert(`Group "${group.name}" created successfully!`);
        },
        error: (error) => {
          console.error('Error creating group:', error);
          alert('Error creating group: ' + (error.error?.message || error.message));
        }
      });
    }
  }

  openGroupMembers(group: ChatGroup): void {
    this.selectedGroup = group;
    this.loadGroupMembers(group.id!);
    this.showGroupMembersModal = true;
  }

  openCurrentGroupMembers(): void {
    if (this.currentGroup) {
      this.openGroupMembers(this.currentGroup);
    }
  }

  loadGroupMembers(groupId: number): void {
    this.chatService.getGroupMembers(groupId).subscribe({
      next: (members) => {
        this.groupMembers = members;
      },
      error: (error) => {
        console.error('Error loading group members:', error);
      }
    });
  }

  openAddMemberModal(group: ChatGroup): void {
    this.selectedGroup = group;
    this.newMemberUsername = '';
    this.showAddMemberModal = true;
  }

  addMemberToGroup(): void {
    if (this.newMemberUsername.trim() && this.selectedGroup && this.currentUser) {
      const request: AddMemberRequest = {
        username: this.newMemberUsername.trim(),
        addedBy: this.currentUser
      };

      this.chatService.addMemberToGroup(this.selectedGroup.id!, request).subscribe({
        next: (group) => {
          console.log('Member added:', group);
          this.newMemberUsername = '';
          this.showAddMemberModal = false;
          this.loadGroupMembers(this.selectedGroup!.id!);
          this.loadUserGroups();
          alert(`User ${request.username} added to group successfully!`);
        },
        error: (error) => {
          console.error('Error adding member:', error);
          alert('Error adding member: ' + (error.error?.message || error.message));
        }
      });
    }
  }

  removeMemberFromGroup(username: string): void {
    if (this.selectedGroup && this.currentUser && confirm(`Remove ${username} from group?`)) {
      this.chatService.removeMemberFromGroup(this.selectedGroup.id!, username, this.currentUser).subscribe({
        next: (group) => {
          console.log('Member removed:', group);
          this.loadGroupMembers(this.selectedGroup!.id!);
          this.loadUserGroups();
          alert(`User ${username} removed from group successfully!`);
        },
        error: (error) => {
          console.error('Error removing member:', error);
          alert('Error removing member: ' + (error.error?.message || error.message));
        }
      });
    }
  }

  promoteToAdmin(username: string): void {
    if (this.selectedGroup && this.currentUser) {
      const request: AddMemberRequest = {
        username: username,
        addedBy: this.currentUser
      };

      this.chatService.addAdminToGroup(this.selectedGroup.id!, request).subscribe({
        next: (group) => {
          console.log('User promoted to admin:', group);
          this.loadGroupMembers(this.selectedGroup!.id!);
          alert(`User ${username} is now a group admin!`);
        },
        error: (error) => {
          console.error('Error promoting to admin:', error);
          alert('Error promoting user: ' + (error.error?.message || error.message));
        }
      });
    }
  }

  deleteGroup(group: ChatGroup): void {
    if (confirm(`Are you sure you want to delete the group "${group.name}"? This action cannot be undone.`)) {
      this.chatService.deleteGroup(group.id!, this.currentUser).subscribe({
        next: () => {
          console.log('Group deleted:', group.name);
          this.loadUserGroups();
          this.loadAccessibleGroups();
          
          if (this.activeGroupId === group.name) {
            this.activeConversationType = null;
            this.activeGroupId = '';
            this.currentGroup = null;
          }
          
          alert(`Group "${group.name}" deleted successfully!`);
        },
        error: (error) => {
          console.error('Error deleting group:', error);
          alert('Error deleting group: ' + (error.error?.message || error.message));
        }
      });
    }
  }

  isGroupAdmin(group: ChatGroup): boolean {
    return group.admins.includes(this.currentUser);
  }

  isGroupCreator(group: ChatGroup): boolean {
    return group.createdBy === this.currentUser;
  }

  getCurrentGroupMemberCount(): number {
    return this.currentGroup?.members?.length || 0;
  }

  handleGroupEvent(event: GroupEvent): void {
    switch (event.type) {
      case 'GROUP_CREATED':
        this.loadAccessibleGroups();
        break;
      case 'MEMBER_ADDED':
      case 'MEMBER_REMOVED':
        if (this.selectedGroup && this.selectedGroup.id === event.group.id) {
          this.loadGroupMembers(event.group.id!);
        }
        this.loadUserGroups();
        break;
      case 'ADDED_TO_GROUP':
        this.loadUserGroups();
        this.loadAccessibleGroups();
        break;
      case 'REMOVED_FROM_GROUP':
        this.loadUserGroups();
        this.loadAccessibleGroups();
        if (this.activeGroupId === event.group.name) {
          this.activeConversationType = null;
          this.activeGroupId = '';
          this.currentGroup = null;
        }
        break;
    }
  }

  // Group Chat Methods
  selectGroup(group: ChatGroup): void {
    if (!this.currentUser) {
      this.showUsernameModal = true;
      return;
    }

    if (group.isPrivate && !group.members.includes(this.currentUser)) {
      alert('You are not a member of this private group');
      return;
    }

    this.activeGroupId = group.name;
    this.activeConversationType = 'group';
    this.activePrivateUser = '';
    this.currentGroup = group;
    this.loadError = '';
    this.loadGroupHistory(group.name);
  }

  private subscribeToGroup(groupId: string): void {
    if (this.groupSubscription) {
      this.groupSubscription.unsubscribe();
    }

    this.groupSubscription = this.chatService.listenToGroup(groupId).subscribe({
      next: (message: ChatMessage) => {
        const messageExists = this.groupMessages.some(
          msg => msg.id === message.id
        );
        
        if (!messageExists) {
          this.groupMessages.push(message);
          this.groupMessages.sort((a, b) => 
            new Date(a.timestamp as any).getTime() - new Date(b.timestamp as any).getTime()
          );
        }
      },
      error: (error) => {
        console.error('Group chat error:', error);
      }
    });
  }

  loadGroupHistory(groupId: string): void {
    this.isLoadingGroupHistory = true;
    this.groupMessages = [];
    
    this.chatService.getGroupHistory(groupId).subscribe({
      next: (messages: ChatMessage[]) => {
        this.groupMessages = messages.map(msg => ({
          ...msg,
          timestamp: new Date(msg.timestamp as any)
        }));
        
        this.groupMessages.sort((a, b) => 
          new Date(a.timestamp as any).getTime() - new Date(b.timestamp as any).getTime()
        );
        
        this.isLoadingGroupHistory = false;
        this.subscribeToGroup(groupId);
      },
      error: (error) => {
        console.error('Error loading group history:', error);
        this.isLoadingGroupHistory = false;
        this.subscribeToGroup(groupId);
      }
    });
  }

  sendGroupMessage(): void {
    if (this.newGroupMessage.trim() && this.currentUser) {
      const chatMessage: ChatMessage = {
        sender: this.currentUser,
        content: this.newGroupMessage.trim(),
        groupId: this.activeGroupId,
        timestamp: new Date(),
        type: 'group'
      };
      
      this.chatService.sendGroupMessage(this.activeGroupId, chatMessage);
      this.newGroupMessage = '';
    }
  }

  // Private Chat Methods
  // loadAvailableGroups(): void {
  //   this.chatService.getAvailableGroups().subscribe({
  //     next: (groups) => {
  //       this.availableGroups = groups;
  //     },
  //     error: (error) => {
  //       console.error('Error loading groups:', error);
  //     }
  //   });
  // }
loadAvailableGroups(): void {
  this.chatService.getAvailableGroups().subscribe({
    next: (groups: ChatGroup[]) => {
      this.availableGroups = groups ?? [];
    },
    error: (error) => {
      console.error('Error loading groups:', error);
      this.availableGroups = [];
    }
  });
}

  loadChatUsers(): void {
    this.chatService.getChatUsers(this.currentUser).subscribe({
      next: (users) => {
        this.chatUsers = users;
      },
      error: (error) => {
        console.error('Error loading chat users:', error);
      }
    });
  }

  selectPrivateUser(username: string): void {
    if (!this.currentUser) {
      this.showUsernameModal = true;
      return;
    }

    this.activePrivateUser = username;
    this.activeConversationType = 'private';
    this.activeGroupId = '';
    this.currentGroup = null;
    this.privateMessages = [];
    this.loadPrivateHistory(username);
  }

  startPrivateChat(): void {
    if (this.recipient.trim() && this.currentUser) {
      if (this.recipient.trim() === this.currentUser) {
        alert('You cannot start a private chat with yourself!');
        return;
      }
      this.selectPrivateUser(this.recipient.trim());
      this.recipient = '';
    }
  }

  loadPrivateHistory(otherUser: string): void {
    this.isLoadingPrivateHistory = true;
    this.privateMessages = [];
    
    this.chatService.getPrivateHistory(this.currentUser, otherUser).subscribe({
      next: (messages: ChatMessage[]) => {
        this.privateMessages = messages.map(msg => ({
          ...msg,
          timestamp: new Date(msg.timestamp as any),
          type: 'private'
        }));
        
        this.privateMessages.sort((a, b) => 
          new Date(a.timestamp as any).getTime() - new Date(b.timestamp as any).getTime()
        );
        
        this.isLoadingPrivateHistory = false;
      },
      error: (error) => {
        console.error('Error loading private history:', error);
        this.isLoadingPrivateHistory = false;
      }
    });
  }

  sendPrivateMessage(): void {
    if (this.newPrivateMessage.trim() && this.activePrivateUser && this.currentUser) {
      const chatMessage: ChatMessage = {
        sender: this.currentUser,
        content: this.newPrivateMessage.trim(),
        receiver: this.activePrivateUser,
        timestamp: new Date(),
        type: 'private'
      };
      
      this.chatService.sendPrivateMessage(chatMessage);
      this.newPrivateMessage = '';
      
      this.privateMessages.push(chatMessage);
      this.privateMessages.sort((a, b) => 
        new Date(a.timestamp as any).getTime() - new Date(b.timestamp as any).getTime()
      );
    }
  }

  // Notifications
  toggleNotifications(): void {
    this.showNotifications = !this.showNotifications;
    if (this.showNotifications) {
      this.chatService.markAllAsRead();
    }
  }

  markNotificationAsRead(notification: Notification): void {
    if (notification.id) {
      this.chatService.markNotificationAsRead(notification.id);
    }
  }

  clearNotifications(): void {
    this.chatService.clearNotifications();
  }

  getUnreadCountForUser(username: string): number {
    return this.notifications.filter(n => 
      !n.read && 
      n.sender === username && 
      n.type === 'message'
    ).length;
  }

  // Conversation management
  loadConversations(): void {
    if (!this.currentUser) return;

    this.chatService.getUserConversations(this.currentUser).subscribe({
      next: (conversations: string[]) => {
        this.conversations = conversations.map(conv => {
          const [type, id] = conv.split(':');
          return {
            id: id,
            type: type.toLowerCase() as 'group' | 'private',
            name: id,
            lastMessage: '',
            lastMessageTime: new Date()
          };
        });
      },
      error: (error) => {
        console.error('Error loading conversations:', error);
      }
    });
  }

  updateConversationList(): void {
    this.loadConversations();
    this.loadChatUsers();
  }

  // Utility methods
  getActiveMessages(): ChatMessage[] {
    if (this.activeConversationType === 'group') {
      return this.groupMessages;
    } else if (this.activeConversationType === 'private') {
      return this.privateMessages;
    }
    return [];
  }

  private unsubscribeAll(): void {
    if (this.groupSubscription) {
      this.groupSubscription.unsubscribe();
    }
    if (this.privateMessageSubscription) {
      this.privateMessageSubscription.unsubscribe();
    }
    if (this.userGroupsSubscription) {
      this.userGroupsSubscription.unsubscribe();
    }
    if (this.groupEventSubscription) {
      this.groupEventSubscription.unsubscribe();
    }
  }

  ngOnDestroy(): void {
    this.disconnect();
    if (this.statusSubscription) {
      this.statusSubscription.unsubscribe();
    }
    if (this.notificationsSubscription) {
      this.notificationsSubscription.unsubscribe();
    }
    if (this.unreadCountSubscription) {
      this.unreadCountSubscription.unsubscribe();
    }
    this.unsubscribeAll();
  }
}