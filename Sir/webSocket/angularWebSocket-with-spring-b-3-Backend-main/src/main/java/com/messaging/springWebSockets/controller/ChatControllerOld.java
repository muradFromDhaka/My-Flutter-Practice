package com.messaging.springWebSockets.controller;


import com.messaging.springWebSockets.entity.ChatMessageOld;
import com.messaging.springWebSockets.entity.Notification;
import com.messaging.springWebSockets.service.ChatService;
import com.messaging.springWebSockets.service.NotificationService;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ChatControllerOld {

    private final ChatService chatService;
    private final SimpMessagingTemplate messagingTemplate;
    // Add to ChatController.java
    private final NotificationService notificationService;

    public ChatControllerOld(ChatService chatService, SimpMessagingTemplate messagingTemplate,
                             NotificationService notificationService) {
        this.chatService = chatService;
        this.messagingTemplate = messagingTemplate;
        this.notificationService = notificationService;
    }


    // Group chat - save and broadcast
    @MessageMapping("/chat.send.{groupId}")
    @SendTo("/topic/{groupId}")
    public ChatMessageOld sendGroupMessage(@DestinationVariable String groupId, ChatMessageOld msg) {
        msg.setGroupId(groupId);
        ChatMessageOld savedMessage = chatService.save(msg);

        // Create notification for group members
        notificationService.createMessageNotification(
                msg.getSender(),
                "group-" + groupId,
                msg.getContent(),
                groupId,
                Notification.Priority.MEDIUM
        );

        return savedMessage;
    }

    //
//    // Private message - save and send to both users
//    @MessageMapping("/chat.private")
//    public void sendPrivateMessage(ChatMessage msg) {
//        msg.setGroupId(null); // Ensure it's a private message
//        ChatMessage savedMessage = chatService.save(msg);
//
//        // Send to receiver
//        messagingTemplate.convertAndSendToUser(
//                msg.getReceiver(),
//                "/queue/messages",
//                savedMessage
//        );
//
//        // Also send back to sender for real-time update
//        messagingTemplate.convertAndSendToUser(
//                msg.getSender(),
//                "/queue/messages",
//                savedMessage
//        );
//
//        // Create notification for recipient
//        notificationService.createMessageNotification(
//                msg.getSender(),
//                msg.getReceiver(),
//                msg.getContent(),
//                "private-" + msg.getSender(),
//                Notification.Priority.HIGH
//        );
//    }
// Update the private message method in ChatController
    @MessageMapping("/chat.private")
    public void sendPrivateMessage(ChatMessageOld msg) {
        System.out.println("Private message received from " + msg.getSender() + " to " + msg.getReceiver());

        msg.setGroupId(null); // Ensure it's a private message
        ChatMessageOld savedMessage = chatService.save(msg);

        // Send to receiver
        messagingTemplate.convertAndSendToUser(
                msg.getReceiver(),
                "/queue/private",
                savedMessage
        );

        // Also send back to sender for real-time update
        messagingTemplate.convertAndSendToUser(
                msg.getSender(),
                "/queue/private",
                savedMessage
        );

        System.out.println("Private message sent to both users");

        // Create notification for recipient
        notificationService.createMessageNotification(
                msg.getSender(),
                msg.getReceiver(),
                msg.getContent(),
                "private-" + msg.getSender(),
                Notification.Priority.HIGH
        );
    }

    // Create new group
//    @PostMapping("/api/groups/create")
//    public String createGroup(@RequestParam String groupName, @RequestParam String createdBy) {
//        // In a real app, you'd save this to a groups table
//        return "Group '" + groupName + "' created by " + createdBy;
//    }

    // Get all available groups
    @GetMapping("/api/groups")
    public List<String> getAvailableGroups() {
        return List.of("general", "tech", "random", "sports", "music");
    }

    // REST API to get group chat history
    @GetMapping("/api/messages/group/{groupId}")
    public List<ChatMessageOld> getGroupHistory(@PathVariable String groupId) {
        return chatService.getGroupHistory(groupId);
    }

    // REST API to get private message history between two users
    @GetMapping("/api/messages/private/{user1}/{user2}")
    public List<ChatMessageOld> getPrivateHistory(@PathVariable String user1, @PathVariable String user2) {
        return chatService.getPrivateHistory(user1, user2);
    }

    // REST API to get all conversations for a user
    @GetMapping("/api/conversations/{username}")
    public List<String> getUserConversations(@PathVariable String username) {
        return chatService.getUserConversations(username);
    }

    // Get users who have chatted with current user
    @GetMapping("/api/chat-users/{username}")
    public List<String> getChatUsers(@PathVariable String username) {
        return chatService.getUsersWhoChattedWith(username);
    }


//
//    @MessageMapping("/chat.send.{groupId}")
//    @SendTo("/topic/{groupId}")
//    public ChatMessage sendGroupMessage(@DestinationVariable String groupId, ChatMessage msg) {
//        msg.setGroupId(groupId);
//        ChatMessage savedMessage = chatService.save(msg);
//
//        // Create notifications for group members (except sender)
//        // In real app, you'd get actual group members from database
//        notificationService.createMessageNotification(
//                msg.getSender(),
//                "group-" + groupId, // This would be actual usernames in real app
//                msg.getContent(),
//                groupId,
//                Notification.Priority.MEDIUM
//        );
//
//        return savedMessage;
//    }
//
//    @MessageMapping("/chat.private.{username}")
//    public void sendPrivateMessage(@DestinationVariable String username, ChatMessage msg) {
//        msg.setReceiver(username);
//        ChatMessage savedMessage = chatService.save(msg);
//
//        // Create notification for recipient
//        notificationService.createMessageNotification(
//                msg.getSender(),
//                username,
//                msg.getContent(),
//                "private-" + msg.getSender(),
//                Notification.Priority.HIGH
//        );
//
//        messagingTemplate.convertAndSendToUser(username, "/queue/messages", savedMessage);
//    }
//
//
//    // REST API to get group chat history
//    @GetMapping("/api/messages/group/{groupId}")
//    public List<ChatMessage> getGroupHistory(@PathVariable String groupId) {
//        return chatService.getGroupHistory(groupId);
//    }
//
//    // REST API to get private message history between two users
//    @GetMapping("/api/messages/private/{user1}/{user2}")
//    public List<ChatMessage> getPrivateHistory(@PathVariable String user1, @PathVariable String user2) {
//        return chatService.getPrivateHistory(user1, user2);
//    }
//
//    // REST API to get all conversations for a user
//    @GetMapping("/api/conversations/{username}")
//    public List<String> getUserConversations(@PathVariable String username) {
//        return chatService.getUserConversations(username);
//    }
//
//    // Add this temporary endpoint for testing
//    @GetMapping("/api/debug/messages")
//    public List<ChatMessage> getAllMessages() {
//        return chatService.getAllMessages(); // You'll need to add this method to ChatService
//    }
//
//    // Test endpoint to verify CORS and connectivity
//    @GetMapping("/api/test")
//    public String testEndpoint() {
//        return "Backend is running! CORS is configured.";
//    }
//
//    // Test WebSocket endpoint
//    @MessageMapping("/test.connection")
//    @SendTo("/topic/test")
//    public String testWebSocket(String message) {
//        return "WebSocket is working! Received: " + message;
//    }
}
