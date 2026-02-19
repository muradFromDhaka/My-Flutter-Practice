package com.messaging.springWebSockets.controller;

// Add these methods to your existing ChatController

import com.messaging.springWebSockets.entity.ChatGroup;
import com.messaging.springWebSockets.models.AddMemberRequest;
import com.messaging.springWebSockets.models.CreateGroupRequest;
import com.messaging.springWebSockets.models.GroupEvent;
import com.messaging.springWebSockets.service.GroupService;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/groups")
public class GroupController {

    private final GroupService groupService;
    private final SimpMessagingTemplate messagingTemplate;

    public GroupController(GroupService groupService, SimpMessagingTemplate messagingTemplate) {
        this.groupService = groupService;
        this.messagingTemplate = messagingTemplate;
    }

    // Create new group
    @PostMapping("/create")
    public ChatGroup createGroup(@RequestBody CreateGroupRequest request) {
        ChatGroup group = groupService.createGroup(
                request.getName(),
                request.getDescription(),
                request.getCreatedBy(),
                request.isPrivate()
        );

        // Notify about new group creation
        messagingTemplate.convertAndSend("/topic/groups", new GroupEvent("GROUP_CREATED", group));

        return group;
    }

    // Get user's groups
    @GetMapping("/user/{username}")
    public List<ChatGroup> getUserGroups(@PathVariable String username) {
        return groupService.getUserGroups(username);
    }

    // Get accessible groups (public + user's private groups)
    @GetMapping("/accessible/{username}")
    public List<ChatGroup> getAccessibleGroups(@PathVariable String username) {
        return groupService.getAccessibleGroups(username);
    }

    // Get public groups
    @GetMapping("/public")
    public List<ChatGroup> getPublicGroups() {
        return groupService.getPublicGroups();
    }

    // Add member to group
    @PostMapping("/{groupId}/members")
    public ChatGroup addMember(@PathVariable Long groupId, @RequestBody AddMemberRequest request) {
        ChatGroup group = groupService.addMemberToGroup(groupId, request.getUsername(), request.getAddedBy());

        // Notify group about new member
        messagingTemplate.convertAndSend("/topic/group." + groupId,
                new GroupEvent("MEMBER_ADDED", group, request.getUsername()));

        // Notify the new member
        messagingTemplate.convertAndSendToUser(request.getUsername(), "/queue/groups",
                new GroupEvent("ADDED_TO_GROUP", group));

        return group;
    }

    // Remove member from group
    @DeleteMapping("/{groupId}/members/{username}")
    public ChatGroup removeMember(@PathVariable Long groupId, @PathVariable String username,
                                  @RequestParam String removedBy) {
        ChatGroup group = groupService.removeMemberFromGroup(groupId, username, removedBy);

        // Notify group about member removal
        messagingTemplate.convertAndSend("/topic/group." + groupId,
                new GroupEvent("MEMBER_REMOVED", group, username));

        // Notify the removed member
        messagingTemplate.convertAndSendToUser(username, "/queue/groups",
                new GroupEvent("REMOVED_FROM_GROUP", group));

        return group;
    }

    // Get group members
    @GetMapping("/{groupId}/members")
    public List<String> getGroupMembers(@PathVariable Long groupId) {
        return groupService.getGroupMembers(groupId);
    }

    // Add admin to group
    @PostMapping("/{groupId}/admins")
    public ChatGroup addAdmin(@PathVariable Long groupId, @RequestBody AddMemberRequest request) {
        return groupService.addAdminToGroup(groupId, request.getUsername(), request.getAddedBy());
    }

    // Delete group
    @DeleteMapping("/{groupId}")
    public ResponseEntity<?> deleteGroup(@PathVariable Long groupId, @RequestParam String username) {
        groupService.deleteGroup(groupId, username);
        return ResponseEntity.ok().build();
    }

    // Search groups
    @GetMapping("/search")
    public List<ChatGroup> searchGroups(@RequestParam String query) {
        return groupService.searchGroups(query);
    }
}

