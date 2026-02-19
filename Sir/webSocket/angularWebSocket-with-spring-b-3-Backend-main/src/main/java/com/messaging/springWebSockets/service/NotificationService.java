package com.messaging.springWebSockets.service;


import com.messaging.springWebSockets.entity.Notification;
import com.messaging.springWebSockets.repo.NotificationRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class NotificationService {

    private final NotificationRepository notificationRepository;

    public NotificationService(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }

    public Notification save(Notification notification) {
        if (notification.getTimestamp() == null) {
            notification.setTimestamp(LocalDateTime.now());
        }
        return notificationRepository.save(notification);
    }

    public List<Notification> getUserNotifications(String username) {
        return notificationRepository.findByRecipientOrderByTimestampDesc(username);
    }

    public List<Notification> getUnreadNotifications(String username) {
        return notificationRepository.findByRecipientAndReadFalseOrderByTimestampDesc(username);
    }

    public long getUnreadCount(String username) {
        return notificationRepository.countByRecipientAndReadFalse(username);
    }

    public Notification markAsRead(Long id) {
        Notification notification = notificationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Notification not found"));
        notification.setRead(true);
        return notificationRepository.save(notification);
    }

    public void markAllAsRead(String username) {
        List<Notification> unreadNotifications =
                notificationRepository.findByRecipientAndReadFalse(username);
        unreadNotifications.forEach(notification -> notification.setRead(true));
        notificationRepository.saveAll(unreadNotifications);
    }

    public void deleteNotification(Long id) {
        notificationRepository.deleteById(id);
    }

    // Auto-create notifications for new messages
    public void createMessageNotification(String sender, String recipient,
                                          String message, String relatedId,
                                          Notification.Priority priority) {
        Notification notification = new Notification();
        notification.setType(Notification.NotificationType.MESSAGE);
        notification.setTitle("New message from " + sender);
        notification.setMessage(message.length() > 100 ? message.substring(0, 100) + "..." : message);
        notification.setSender(sender);
        notification.setRecipient(recipient);
        notification.setRelatedId(relatedId);
        notification.setTimestamp(LocalDateTime.now());
        notification.setRead(false);
        notification.setPriority(priority);

        save(notification);
    }
}