package com.messaging.springWebSockets.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "ChatMessage")
public class ChatMessageOld {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String sender;
    private String groupId;      // for group messages
    private String receiver;     // for private messages
    @Column(columnDefinition = "TEXT")
    private String content;
    private LocalDateTime timestamp;
}

