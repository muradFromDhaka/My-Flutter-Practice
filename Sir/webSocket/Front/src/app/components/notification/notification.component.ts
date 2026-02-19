import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { NotificationService } from '../../service/notification.service';
import { Notification } from '../../model/ChatMessage';
import { NgFor, NgIf } from '@angular/common';

@Component({
  selector: 'app-notification',
  standalone: true,
  imports: [NgIf, NgFor],
  templateUrl: './notification.component.html',
  styleUrl: './notification.component.scss'
})
export class NotificationComponent implements OnInit, OnDestroy {
  notifications: Notification[] = [];
  unreadCount = 0;
  showNotifications = false;
  currentUser = 'current-user'; // Get from auth service
  
  private notificationsSubscription!: Subscription;
  private unreadCountSubscription!: Subscription;

  constructor(private notificationService: NotificationService) {}

  ngOnInit() {
    this.loadNotifications();
    
    this.notificationsSubscription = this.notificationService.notifications$.subscribe(
      notifications => this.notifications = notifications
    );
    
    this.unreadCountSubscription = this.notificationService.unreadCount$.subscribe(
      count => this.unreadCount = count
    );
  }

  loadNotifications() {
    this.notificationService.getUserNotifications(this.currentUser).subscribe({
      next: (notifications) => {
        this.notifications = notifications;
        this.updateUnreadCount();
      },
      error: (error) => {
        console.error('Error loading notifications:', error);
      }
    });
  }

  toggleNotifications() {
    this.showNotifications = !this.showNotifications;
    if (this.showNotifications) {
      this.markAllAsRead();
    }
  }

  markAsRead(notification: Notification) {
    if (!notification.read && notification.id) {
      this.notificationService.markAsRead(notification.id).subscribe({
        next: () => {
          this.notificationService.markNotificationAsRead(notification.id!);
        },
        error: (error) => {
          console.error('Error marking notification as read:', error);
        }
      });
    }
  }

  markAllAsRead() {
    this.notificationService.markAllAsRead(this.currentUser).subscribe({
      next: () => {
        this.notifications.forEach(notification => {
          if (!notification.read) {
            this.notificationService.markNotificationAsRead(notification.id!);
          }
        });
      },
      error: (error) => {
        console.error('Error marking all as read:', error);
      }
    });
  }

  deleteNotification(notificationId: number) {
    this.notificationService.deleteNotification(notificationId).subscribe({
      next: () => {
        this.notifications = this.notifications.filter(n => n.id !== notificationId);
        this.updateUnreadCount();
      },
      error: (error) => {
        console.error('Error deleting notification:', error);
      }
    });
  }

  clearAll() {
    this.notifications.forEach(notification => {
      if (notification.id) {
        this.deleteNotification(notification.id);
      }
    });
  }

  private updateUnreadCount() {
    const unread = this.notifications.filter(n => !n.read).length;
    this.notificationService.updateUnreadCount(unread);
  }

  getPriorityClass(priority: string): string {
    switch (priority) {
      case 'high': return 'priority-high';
      case 'medium': return 'priority-medium';
      case 'low': return 'priority-low';
      default: return '';
    }
  }

  ngOnDestroy() {
    if (this.notificationsSubscription) {
      this.notificationsSubscription.unsubscribe();
    }
    if (this.unreadCountSubscription) {
      this.unreadCountSubscription.unsubscribe();
    }
  }
}
