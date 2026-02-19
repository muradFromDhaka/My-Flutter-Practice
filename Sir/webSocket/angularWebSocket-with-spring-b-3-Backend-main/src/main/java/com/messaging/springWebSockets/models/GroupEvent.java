package com.messaging.springWebSockets.models;

import com.messaging.springWebSockets.entity.ChatGroup;

import java.time.LocalDateTime;

// Event class for WebSocket notifications
public class GroupEvent {
    private String type;
    private ChatGroup group;
    private String username;
    private LocalDateTime timestamp;

    public GroupEvent(String type, ChatGroup group) {
        this.type = type;
        this.group = group;
        this.timestamp = LocalDateTime.now();
    }

    public GroupEvent(String type, ChatGroup group, String username) {
        this(type, group);
        this.username = username;
    }

    // getters and setters
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ChatGroup getGroup() {
        return group;
    }

    public void setGroup(ChatGroup group) {
        this.group = group;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }
}
