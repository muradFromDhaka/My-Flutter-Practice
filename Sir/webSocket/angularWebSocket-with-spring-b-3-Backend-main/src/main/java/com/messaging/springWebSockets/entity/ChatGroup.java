package com.messaging.springWebSockets.entity;


import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
public class ChatGroup {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String description;
    private String createdBy;
    private LocalDateTime createdAt;
    private boolean isPrivate = false;

    @ElementCollection
    private List<String> members = new ArrayList<>();

    @ElementCollection
    private List<String> admins = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public void addMember(String username) {
        if (!members.contains(username)) {
            members.add(username);
        }
    }

    public void removeMember(String username) {
        members.remove(username);
    }

    public void addAdmin(String username) {
        if (!admins.contains(username)) {
            admins.add(username);
        }
    }

    public boolean isMember(String username) {
        return members.contains(username);
    }

    public boolean isAdmin(String username) {
        return admins.contains(username);
    }
}