package com.messaging.springWebSockets.repo;


import com.messaging.springWebSockets.entity.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {
    List<Notification> findByRecipientOrderByTimestampDesc(String recipient);
    List<Notification> findByRecipientAndReadFalseOrderByTimestampDesc(String recipient);
    List<Notification> findByRecipientAndReadFalse(String recipient);
    long countByRecipientAndReadFalse(String recipient);
}