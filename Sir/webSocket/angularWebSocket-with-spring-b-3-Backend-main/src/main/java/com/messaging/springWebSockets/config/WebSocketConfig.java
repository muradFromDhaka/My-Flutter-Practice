package com.messaging.springWebSockets.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // Native WebSocket endpoint
        registry.addEndpoint("/websocket")
                .setAllowedOriginPatterns("*")
                .withSockJS(); // Add SockJS fallback

        // Chat endpoint with SockJS
        registry.addEndpoint("/ws-chat")
                .setAllowedOriginPatterns("*")
                .withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // Enable multiple simple broker destinations
        registry.enableSimpleBroker("/topic", "/queue", "/user");

        // Application destination prefix (for @MessageMapping)
        registry.setApplicationDestinationPrefixes("/app");

        // User destination prefix (for private messages)
        registry.setUserDestinationPrefix("/user");
    }
}