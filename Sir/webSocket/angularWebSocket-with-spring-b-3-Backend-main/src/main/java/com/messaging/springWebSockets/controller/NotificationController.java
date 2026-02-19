package com.messaging.springWebSockets.controller;


import com.messaging.springWebSockets.entity.Notification;
import com.messaging.springWebSockets.service.NotificationService;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    private final NotificationService notificationService;
    private final SimpMessagingTemplate messagingTemplate;

    public NotificationController(NotificationService notificationService,
                                  SimpMessagingTemplate messagingTemplate) {
        this.notificationService = notificationService;
        this.messagingTemplate = messagingTemplate;
    }

    // Send notification via WebSocket
    @MessageMapping("/notifications.send")
    public void sendNotification(Notification notification) {
        Notification savedNotification = notificationService.save(notification);
        messagingTemplate.convertAndSendToUser(
                notification.getRecipient(),
                "/queue/notifications",
                savedNotification
        );
    }

    // REST endpoints
    @GetMapping("/user/{username}")
    public List<Notification> getUserNotifications(@PathVariable String username) {
        return notificationService.getUserNotifications(username);
    }

    @GetMapping("/user/{username}/unread")
    public List<Notification> getUnreadNotifications(@PathVariable String username) {
        return notificationService.getUnreadNotifications(username);
    }

    @GetMapping("/user/{username}/unread-count")
    public long getUnreadCount(@PathVariable String username) {
        return notificationService.getUnreadCount(username);
    }

    @PutMapping("/{id}/read")
    public Notification markAsRead(@PathVariable Long id) {
        return notificationService.markAsRead(id);
    }

    @PutMapping("/user/{username}/read-all")
    public void markAllAsRead(@PathVariable String username) {
        notificationService.markAllAsRead(username);
    }

    @DeleteMapping("/{id}")
    public void deleteNotification(@PathVariable Long id) {
        notificationService.deleteNotification(id);
    }
}