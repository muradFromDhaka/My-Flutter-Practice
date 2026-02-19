package com.messaging.springWebSockets.repo;


import com.messaging.springWebSockets.entity.ChatGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChatGroupRepository extends JpaRepository<ChatGroup, Long> {

    List<ChatGroup> findByNameContainingIgnoreCase(String name);

    List<ChatGroup> findByCreatedBy(String createdBy);

    @Query("SELECT g FROM ChatGroup g WHERE :username MEMBER OF g.members")
    List<ChatGroup> findByMembersContaining(@Param("username") String username);

    @Query("SELECT g FROM ChatGroup g WHERE g.isPrivate = false OR :username MEMBER OF g.members")
    List<ChatGroup> findAccessibleGroups(@Param("username") String username);

    boolean existsByName(String name);
}