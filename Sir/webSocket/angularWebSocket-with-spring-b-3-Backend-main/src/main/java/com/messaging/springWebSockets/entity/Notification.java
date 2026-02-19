package com.messaging.springWebSockets.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "notifications")
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private NotificationType type; // MESSAGE, SYSTEM, MENTION

    private String title;
    private String message;
    private String sender;
    private String recipient;
    private String relatedId; // groupId or conversation id
    private LocalDateTime timestamp;
    @Column(name = "is_read") // Better column name
    private boolean read;

    @Enumerated(EnumType.STRING)
    private Priority priority; // LOW, MEDIUM, HIGH

    public enum NotificationType {
        MESSAGE, SYSTEM, MENTION
    }

    public enum Priority {
        LOW, MEDIUM, HIGH
    }
}