import { Injectable } from '@angular/core';
import { Client } from '@stomp/stompjs';
import { BehaviorSubject, Observable } from 'rxjs';
import { ChatMessage, Conversation, Notification } from '../model/ChatMessage';
import { HttpClient } from '@angular/common/http';
import { AddMemberRequest, ChatGroup, CreateGroupRequest, GroupEvent } from '../model/model';

// Fix for SockJS global issue
(window as any).global = window;

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  private client!: Client;
  private connectionStatus = new BehaviorSubject<boolean>(false);
  public connectionStatus$ = this.connectionStatus.asObservable();
  
  // Notifications
  private notifications = new BehaviorSubject<Notification[]>([]);
  public notifications$ = this.notifications.asObservable();
  private unreadCount = new BehaviorSubject<number>(0);
  public unreadCount$ = this.unreadCount.asObservable();

  // Real-time message subjects
  private privateMessageSubject = new BehaviorSubject<ChatMessage | null>(null);
  public privateMessage$ = this.privateMessageSubject.asObservable();
  
// neww added for group chat
 private userGroupsSubject = new BehaviorSubject<ChatGroup[]>([]);
  public userGroups$ = this.userGroupsSubject.asObservable();
  
  private groupEventSubject = new BehaviorSubject<GroupEvent | null>(null);
  public groupEvent$ = this.groupEventSubject.asObservable();
  
  private baseUrl = 'http://192.168.20.40:8080';
  private websocketEndpoint = '/ws-chat';

  constructor(private http: HttpClient) {
    this.initializeClient();
  }

  private async initializeClient(): Promise<void> {
    const SockJS = (await import('sockjs-client')).default;
    
    this.client = new Client({
      webSocketFactory: () => {
        return new SockJS(`${this.baseUrl}${this.websocketEndpoint}`);
      },
      reconnectDelay: 5000,
      heartbeatIncoming: 4000,
      heartbeatOutgoing: 4000,
      debug: (str: string) => {
        console.log('STOMP:', str);
      }
    });

    this.client.onConnect = (frame: any) => {
      console.log('✅ Connected via SockJS: ' + frame);
      this.connectionStatus.next(true);
      
      // Subscribe to all real-time channels
      this.subscribeToPrivateMessages();
      this.subscribeToNotifications();
      this.subscribeToGroupEvents();
    };

    this.client.onStompError = (frame: any) => {
      console.error('❌ STOMP error: ' + frame.headers['message']);
      this.connectionStatus.next(false);
    };

    this.client.onWebSocketError = (event: any) => {
      console.error('❌ WebSocket connection error:', event);
      this.connectionStatus.next(false);
    };

    this.client.onDisconnect = () => {
      console.log('🔌 WebSocket disconnected');
      this.connectionStatus.next(false);
    };
  }

  private subscribeToPrivateMessages(): void {
    // Subscribe to private messages - FIXED: using correct destination
    const subscription = this.client.subscribe(`/user/queue/private`, (message: any) => {
      try {
        if (message.body) {
          console.log('📨 Received private message via WebSocket:', message.body);
          const chatMessage: ChatMessage = JSON.parse(message.body);
          this.processTimestamp(chatMessage);
          
          // Emit the message to all subscribers
          this.privateMessageSubject.next(chatMessage);
          
          // Create notification for new private message
          this.addNotification({
            type: 'message',
            title: `New message from ${chatMessage.sender}`,
            message: chatMessage.content.length > 50 
              ? chatMessage.content.substring(0, 50) + '...' 
              : chatMessage.content,
            sender: chatMessage.sender,
            recipient: chatMessage.receiver || '',
            relatedId: `private-${chatMessage.sender}`,
            timestamp: new Date(),
            read: false,
            priority: 'high'
          });

          // Play notification sound
          this.playNotificationSound();
        }
      } catch (error) {
        console.error('Error parsing private message:', error);
      }
    });

    console.log('✅ Subscribed to private messages');
  }

  private subscribeToNotifications(): void {
    // Subscribe to general notifications
    this.client.subscribe(`/user/queue/notifications`, (message: any) => {
      try {
        if (message.body) {
          const notification: Notification = JSON.parse(message.body);
          this.addNotification(notification);
        }
      } catch (error) {
        console.error('Error parsing notification:', error);
      }
    });
  }

  private addNotification(notification: Notification): void {
    const currentNotifications = this.notifications.value;
    const updatedNotifications = [notification, ...currentNotifications.slice(0, 49)]; // Keep last 50
    this.notifications.next(updatedNotifications);
    
    // Update unread count
    const unread = updatedNotifications.filter(n => !n.read).length;
    this.unreadCount.next(unread);
    
    // Show browser notification
    this.showBrowserNotification(notification);
  }

  private showBrowserNotification(notification: Notification): void {
    if ('Notification' in window) {
      if (Notification.permission === 'granted') {
        this.createBrowserNotification(notification);
      } else if (Notification.permission !== 'denied') {
        Notification.requestPermission().then(permission => {
          if (permission === 'granted') {
            this.createBrowserNotification(notification);
          }
        });
      }
    }
  }

  private createBrowserNotification(notification: Notification): void {
    const browserNotification = new Notification(notification.title, {
      body: notification.message,
      icon: '/assets/chat-icon.png',
      tag: 'chat-notification'
    });

    // Auto close after 5 seconds
    setTimeout(() => browserNotification.close(), 5000);

    // Handle click on notification
    browserNotification.onclick = () => {
      window.focus();
      browserNotification.close();
    };
  }

  private playNotificationSound(): void {
    // Create a simple notification sound using Web Audio API
    try {
      const audioContext = new (window.AudioContext || (window as any).webkitAudioContext)();
      const oscillator = audioContext.createOscillator();
      const gainNode = audioContext.createGain();
      
      oscillator.connect(gainNode);
      gainNode.connect(audioContext.destination);
      
      oscillator.frequency.value = 800;
      oscillator.type = 'sine';
      
      gainNode.gain.setValueAtTime(0.3, audioContext.currentTime);
      gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.5);
      
      oscillator.start(audioContext.currentTime);
      oscillator.stop(audioContext.currentTime + 0.5);
    } catch (error) {
      console.log('Audio context not supported');
    }
  }

  // Connection methods
  connect(): void {
    if (this.client && this.client.connected) {
      console.log('WebSocket already connected');
      return;
    }

    if (!this.client) {
      this.initializeClient().then(() => {
        this.client.activate();
      });
    } else {
      this.client.activate();
    }
  }

  disconnect(): void {
    if (this.client) {
      this.client.deactivate();
      this.connectionStatus.next(false);
    }
  }

  // Group chat methods
  listenToGroup(groupId: string): Observable<ChatMessage> {
    return new Observable<ChatMessage>(subscriber => {
      if (!this.client?.connected) {
        subscriber.error('WebSocket not connected');
        return;
      }

      const subscription = this.client.subscribe(`/topic/${groupId}`, (message: any) => {
        try {
          if (message.body) {
            const chatMessage: ChatMessage = JSON.parse(message.body);
            this.processTimestamp(chatMessage);
            subscriber.next(chatMessage);
          }
        } catch (error) {
          console.error('Error parsing group message:', error);
          subscriber.error(error);
        }
      });

      return () => subscription.unsubscribe();
    });
  }

  // REAL-TIME: Listen for private messages
  listenToPrivateMessages(): Observable<ChatMessage> {
    return this.privateMessage$ as Observable<ChatMessage>;
  }

  // Message sending methods
  sendGroupMessage(groupId: string, message: ChatMessage): void {
    if (!this.client?.connected) {
      console.warn('WebSocket not connected! Cannot send group message.');
      return;
    }

    try {
      if (!message.timestamp) {
        message.timestamp = new Date();
      }

      this.client.publish({
        destination: `/app/chat.send.${groupId}`,
        body: JSON.stringify(message)
      });
      console.log(`📤 Group message sent to ${groupId}`);
    } catch (error) {
      console.error('Error sending group message:', error);
    }
  }

  sendPrivateMessage(message: ChatMessage): void {
    if (!this.client?.connected) {
      console.warn('WebSocket not connected! Cannot send private message.');
      return;
    }

    try {
      if (!message.timestamp) {
        message.timestamp = new Date();
      }

      this.client.publish({
        destination: `/app/chat.private`,
        body: JSON.stringify(message)
      });
      console.log(`📤 Private message sent to ${message.receiver}`);
    } catch (error) {
      console.error('Error sending private message:', error);
    }
  }

  // // Group management Old
  // createGroup(groupName: string, createdBy: string): Observable<string> {
  //   return this.http.post<string>(`${this.baseUrl}/api/groups/create`, null, {
  //     params: { groupName, createdBy }
  //   });
  // }
  // Group Management Methods
  createGroup(request: CreateGroupRequest): Observable<ChatGroup> {
    return this.http.post<ChatGroup>(`${this.baseUrl}/api/groups/create`, request);
  }
  getAvailableGroups(): Observable<ChatGroup[]> {
    return this.http.get<ChatGroup[]>(`${this.baseUrl}/api/groups`);
  }

  // REST API methods
  getGroupHistory(groupId: string): Observable<ChatMessage[]> {
    return this.http.get<ChatMessage[]>(`${this.baseUrl}/api/messages/group/${groupId}`);
  }

  getPrivateHistory(user1: string, user2: string): Observable<ChatMessage[]> {
    return this.http.get<ChatMessage[]>(`${this.baseUrl}/api/messages/private/${user1}/${user2}`);
  }

  getUserConversations(username: string): Observable<string[]> {
    return this.http.get<string[]>(`${this.baseUrl}/api/conversations/${username}`);
  }

  getChatUsers(username: string): Observable<string[]> {
    return this.http.get<string[]>(`${this.baseUrl}/api/chat-users/${username}`);
  }

  // Notification methods
  getNotifications(): Notification[] {
    return this.notifications.value;
  }

  markNotificationAsRead(notificationId: number): void {
    const notifications = this.notifications.value.map(n => 
      n.id === notificationId ? { ...n, read: true } : n
    );
    this.notifications.next(notifications);
    
    const unread = notifications.filter(n => !n.read).length;
    this.unreadCount.next(unread);
  }

  markAllAsRead(): void {
    const notifications = this.notifications.value.map(n => ({ ...n, read: true }));
    this.notifications.next(notifications);
    this.unreadCount.next(0);
  }

  clearNotifications(): void {
    this.notifications.next([]);
    this.unreadCount.next(0);
  }

  private processTimestamp(message: ChatMessage): void {
    if (message.timestamp && typeof message.timestamp === 'string') {
      message.timestamp = new Date(message.timestamp);
    }
  }

  isConnected(): boolean {
    return this.client?.connected || false;
  }

  private subscribeToGroupEvents(): void {
    // Subscribe to group events
    this.client.subscribe(`/user/queue/groups`, (message: any) => {
      try {
        if (message.body) {
          const groupEvent: GroupEvent = JSON.parse(message.body);
          this.groupEventSubject.next(groupEvent);
          this.handleGroupEvent(groupEvent);
        }
      } catch (error) {
        console.error('Error parsing group event:', error);
      }
    });

    // Subscribe to public group events
    this.client.subscribe(`/topic/groups`, (message: any) => {
      try {
        if (message.body) {
          const groupEvent: GroupEvent = JSON.parse(message.body);
          this.groupEventSubject.next(groupEvent);
          this.handleGroupEvent(groupEvent);
        }
      } catch (error) {
        console.error('Error parsing public group event:', error);
      }
    });
  }

  private handleGroupEvent(event: GroupEvent): void {
    switch (event.type) {
      case 'ADDED_TO_GROUP':
        this.addNotification({
          type: 'system',
          title: `Added to group: ${event.group.name}`,
          message: `You have been added to the group "${event.group.name}"`,
          recipient: event.username || '',
          timestamp: new Date(),
          read: false,
          priority: 'medium'
        });
        this.loadUserGroups(event.username || '');
        break;
        
      case 'REMOVED_FROM_GROUP':
        this.addNotification({
          type: 'system',
          title: `Removed from group: ${event.group.name}`,
          message: `You have been removed from the group "${event.group.name}"`,
          recipient: event.username || '',
          timestamp: new Date(),
          read: false,
          priority: 'high'
        });
        this.loadUserGroups(event.username || '');
        break;
    }
  }



  getUserGroups(username: string): Observable<ChatGroup[]> {
    return this.http.get<ChatGroup[]>(`${this.baseUrl}/api/groups/user/${username}`);
  }

  getAccessibleGroups(username: string): Observable<ChatGroup[]> {
    return this.http.get<ChatGroup[]>(`${this.baseUrl}/api/groups/accessible/${username}`);
  }

  getPublicGroups(): Observable<ChatGroup[]> {
    return this.http.get<ChatGroup[]>(`${this.baseUrl}/api/groups/public`);
  }

  addMemberToGroup(groupId: number, request: AddMemberRequest): Observable<ChatGroup> {
    return this.http.post<ChatGroup>(`${this.baseUrl}/api/groups/${groupId}/members`, request);
  }

  removeMemberFromGroup(groupId: number, username: string, removedBy: string): Observable<ChatGroup> {
    return this.http.delete<ChatGroup>(
      `${this.baseUrl}/api/groups/${groupId}/members/${username}?removedBy=${removedBy}`
    );
  }

  getGroupMembers(groupId: number): Observable<string[]> {
    return this.http.get<string[]>(`${this.baseUrl}/api/groups/${groupId}/members`);
  }

  addAdminToGroup(groupId: number, request: AddMemberRequest): Observable<ChatGroup> {
    return this.http.post<ChatGroup>(`${this.baseUrl}/api/groups/${groupId}/admins`, request);
  }

  deleteGroup(groupId: number, username: string): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/api/groups/${groupId}?username=${username}`);
  }

  loadUserGroups(username: string): void {
    this.getUserGroups(username).subscribe({
      next: (groups) => {
        this.userGroupsSubject.next(groups);
      },
      error: (error) => {
        console.error('Error loading user groups:', error);
      }
    });
  }
}