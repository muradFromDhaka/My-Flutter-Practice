package com.messaging.springWebSockets.repo;

import com.messaging.springWebSockets.entity.ChatMessageOld;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessageOld, Long> {

    List<ChatMessageOld> findByGroupIdOrderByTimestampAsc(String groupId);

    List<ChatMessageOld> findBySenderOrReceiverOrderByTimestampDesc(String sender, String receiver);

    // NEW: Find by sender OR receiver (for getting chat users)
    List<ChatMessageOld> findBySenderOrReceiver(String sender, String receiver);

    @Query("SELECT cm FROM ChatMessageOld cm WHERE " +
            "(cm.sender = :user1 AND cm.receiver = :user2) OR " +
            "(cm.sender = :user2 AND cm.receiver = :user1) " +
            "ORDER BY cm.timestamp ASC")
    List<ChatMessageOld> findPrivateMessagesBetweenUsers(@Param("user1") String user1,
                                                         @Param("user2") String user2);}