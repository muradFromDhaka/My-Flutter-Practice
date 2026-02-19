package com.messaging.springWebSockets.service;

import com.messaging.springWebSockets.entity.ChatMessageOld;
import com.messaging.springWebSockets.repo.ChatMessageRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ChatService {


    private final ChatMessageRepository chatMessageRepository;

    public ChatService(ChatMessageRepository chatMessageRepository) {
        this.chatMessageRepository = chatMessageRepository;
    }

    public ChatMessageOld save(ChatMessageOld message) {
        return chatMessageRepository.save(message);
    }

    public List<ChatMessageOld> getGroupHistory(String groupId) {
        return chatMessageRepository.findByGroupIdOrderByTimestampAsc(groupId);
    }

    public List<ChatMessageOld> getPrivateHistory(String user1, String user2) {
        return chatMessageRepository.findPrivateMessagesBetweenUsers(user1, user2);
    }

    public List<String> getUserConversations(String username) {
        List<ChatMessageOld> messages = chatMessageRepository.findBySenderOrReceiverOrderByTimestampDesc(username, username);

        return messages.stream()
                .map(msg -> {
                    if (msg.getGroupId() != null) {
                        return "GROUP:" + msg.getGroupId();
                    } else if (msg.getSender().equals(username)) {
                        return "USER:" + msg.getReceiver();
                    } else {
                        return "USER:" + msg.getSender();
                    }
                })
                .distinct()
                .collect(Collectors.toList());
    }

    // NEW: Get users who have chatted with current user
    public List<String> getUsersWhoChattedWith(String username) {
        List<ChatMessageOld> messages = chatMessageRepository.findBySenderOrReceiver(username, username);

        return messages.stream()
                .map(msg -> {
                    if (msg.getSender().equals(username)) {
                        return msg.getReceiver();
                    } else {
                        return msg.getSender();
                    }
                })
                .filter(user -> user != null && !user.equals(username))
                .distinct()
                .collect(Collectors.toList());
    }
}