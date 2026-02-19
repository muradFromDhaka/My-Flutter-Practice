// src/app/models/chat-message.model.ts
// src/app/models/chat-message.model.ts
// src/app/model/ChatMessage.ts
export interface ChatMessage {
  id?: number;
  sender: string;
  groupId?: string;      // for group messages
  receiver?: string;     // for private messages
  content: string;
  timestamp?: Date;
  type?: 'group' | 'private'; // Add this for easier filtering
}

export interface Conversation {
  id: string;
  type: 'group' | 'private';
  name: string;
  lastMessage?: string;
  lastMessageTime?: Date;
  unreadCount?: number;
}

// Add Notification model
export interface Notification {
  id?: number;
  type: 'message' | 'system' | 'mention';
  title: string;
  message: string;
  sender?: string;
  recipient: string;
  relatedId?: string;
  timestamp: Date;
  read: boolean;
  priority: 'low' | 'medium' | 'high';
}

export interface NotificationPreferences {
  userId: string;
  desktopNotifications: boolean;
  soundNotifications: boolean;
  emailNotifications: boolean;
  mentionNotifications: boolean;
  groupMessageNotifications: boolean;
  privateMessageNotifications: boolean;
}