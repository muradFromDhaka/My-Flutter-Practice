import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { Notification, NotificationPreferences } from '../model/ChatMessage';

@Injectable({
  providedIn: 'root'
})
export class NotificationService {
  private baseUrl = 'http://192.168.20.40:8080/api/notifications';
  private unreadCount = new BehaviorSubject<number>(0);
  private notifications = new BehaviorSubject<Notification[]>([]);
  
  public unreadCount$ = this.unreadCount.asObservable();
  public notifications$ = this.notifications.asObservable();

  constructor(private http: HttpClient) {}

  // WebSocket listening is handled in ChatService

  // REST API methods
  getUserNotifications(username: string): Observable<Notification[]> {
    return this.http.get<Notification[]>(`${this.baseUrl}/user/${username}`);
  }

  getUnreadNotifications(username: string): Observable<Notification[]> {
    return this.http.get<Notification[]>(`${this.baseUrl}/user/${username}/unread`);
  }

  getUnreadCount(username: string): Observable<number> {
    return this.http.get<number>(`${this.baseUrl}/user/${username}/unread-count`);
  }

  markAsRead(notificationId: number): Observable<Notification> {
    return this.http.put<Notification>(`${this.baseUrl}/${notificationId}/read`, {});
  }

  markAllAsRead(username: string): Observable<void> {
    return this.http.put<void>(`${this.baseUrl}/user/${username}/read-all`, {});
  }

  deleteNotification(notificationId: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${notificationId}`);
  }

  // Local state management
  updateUnreadCount(count: number): void {
    this.unreadCount.next(count);
  }

  addNotification(notification: Notification): void {
    const currentNotifications = this.notifications.value;
    this.notifications.next([notification, ...currentNotifications]);
    this.unreadCount.next(this.unreadCount.value + 1);
    
    // Show browser notification if permitted
    this.showBrowserNotification(notification);
  }

  markNotificationAsRead(notificationId: number): void {
    const currentNotifications = this.notifications.value;
    const updatedNotifications = currentNotifications.map(notification => 
      notification.id === notificationId ? { ...notification, read: true } : notification
    );
    this.notifications.next(updatedNotifications);
    
    // Update unread count
    const unreadCount = updatedNotifications.filter(n => !n.read).length;
    this.unreadCount.next(unreadCount);
  }

  private showBrowserNotification(notification: Notification): void {
    // Check if browser supports notifications and permission is granted
    if (!('Notification' in window)) {
      console.log('This browser does not support notifications');
      return;
    }

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

  private createBrowserNotification(notification: Notification): void {
    const browserNotification = new Notification(notification.title, {
      body: notification.message,
      icon: '/assets/chat-icon.png', // Add your icon
      badge: '/assets/chat-badge.png',
      tag: notification.id?.toString(),
      requireInteraction: notification.priority === 'high'
    });

    // Auto close after 5 seconds for low/medium priority
    if (notification.priority !== 'high') {
      setTimeout(() => browserNotification.close(), 5000);
    }

    // Handle click on notification
    browserNotification.onclick = () => {
      window.focus();
      browserNotification.close();
      // You can add navigation logic here
    };
  }

  // Sound notification
  playNotificationSound(): void {
    const audio = new Audio();
    audio.src = '/assets/notification-sound.mp3'; // Add your sound file
    audio.load();
    audio.play().catch(e => console.log('Audio play failed:', e));
  }
}