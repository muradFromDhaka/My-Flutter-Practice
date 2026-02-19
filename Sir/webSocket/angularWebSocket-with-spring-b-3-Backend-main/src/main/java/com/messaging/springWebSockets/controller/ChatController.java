package com.messaging.springWebSockets.controller;

import com.messaging.springWebSockets.models.ChatMessage;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/chat")
public class ChatController {

    private final SimpMessagingTemplate messagingTemplate;

    // In-memory lists for demo
    private final List<ChatMessage> publicMessages = new ArrayList<>();
    private final Map<String, List<ChatMessage>> privateMessages = new HashMap<>();

    public ChatController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    @PostMapping("/send")
    public void sendPublic(@RequestBody ChatMessage message) {
        publicMessages.add(message); // save
        messagingTemplate.convertAndSend("/topic/messages", message);
    }

    @PostMapping("/private")
    public void sendPrivate(@RequestBody ChatMessage message) {
        privateMessages.computeIfAbsent(message.getReceiver(), k -> new ArrayList<>())
                .add(message); // save
        messagingTemplate.convertAndSendToUser(message.getReceiver(), "/queue/private", message);
    }

    // Endpoint to get old public messages
    @GetMapping("/public")
    public List<ChatMessage> getPublicMessages() {
        return publicMessages;
    }

    // Endpoint to get old private messages for a user
    @GetMapping("/private/{username}")
    public List<ChatMessage> getPrivateMessages(@PathVariable String username) {
        return privateMessages.getOrDefault(username, Collections.emptyList());
    }
}
