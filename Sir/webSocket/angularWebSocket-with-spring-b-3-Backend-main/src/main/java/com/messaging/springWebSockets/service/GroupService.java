package com.messaging.springWebSockets.service;


import com.messaging.springWebSockets.entity.ChatGroup;
import com.messaging.springWebSockets.repo.ChatGroupRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class GroupService {

    private final ChatGroupRepository groupRepository;

    public GroupService(ChatGroupRepository groupRepository) {
        this.groupRepository = groupRepository;
    }

    public ChatGroup createGroup(String name, String description, String createdBy, boolean isPrivate) {
        if (groupRepository.existsByName(name)) {
            throw new RuntimeException("Group name already exists");
        }

        ChatGroup group = new ChatGroup();
        group.setName(name);
        group.setDescription(description);
        group.setCreatedBy(createdBy);
        group.setPrivate(isPrivate);
        group.addMember(createdBy);
        group.addAdmin(createdBy);

        return groupRepository.save(group);
    }

    public Optional<ChatGroup> getGroupById(Long groupId) {
        return groupRepository.findById(groupId);
    }

    public Optional<ChatGroup> getGroupByName(String name) {
        return groupRepository.findByNameContainingIgnoreCase(name)
                .stream()
                .findFirst();
    }

    public List<ChatGroup> getUserGroups(String username) {
        return groupRepository.findByMembersContaining(username);
    }

    public List<ChatGroup> getAccessibleGroups(String username) {
        return groupRepository.findAccessibleGroups(username);
    }

    public List<ChatGroup> getPublicGroups() {
        return groupRepository.findAll().stream()
                .filter(group -> !group.isPrivate())
                .toList();
    }

    public ChatGroup addMemberToGroup(Long groupId, String username, String addedBy) {
        ChatGroup group = groupRepository.findById(groupId)
                .orElseThrow(() -> new RuntimeException("Group not found"));

        if (!group.isAdmin(addedBy)) {
            throw new RuntimeException("Only admins can add members");
        }

        group.addMember(username);
        return groupRepository.save(group);
    }

    public ChatGroup removeMemberFromGroup(Long groupId, String username, String removedBy) {
        ChatGroup group = groupRepository.findById(groupId)
                .orElseThrow(() -> new RuntimeException("Group not found"));

        if (!group.isAdmin(removedBy)) {
            throw new RuntimeException("Only admins can remove members");
        }

        if (username.equals(group.getCreatedBy())) {
            throw new RuntimeException("Cannot remove group creator");
        }

        group.removeMember(username);
        group.getAdmins().remove(username);

        return groupRepository.save(group);
    }

    public ChatGroup addAdminToGroup(Long groupId, String username, String addedBy) {
        ChatGroup group = groupRepository.findById(groupId)
                .orElseThrow(() -> new RuntimeException("Group not found"));

        if (!group.isAdmin(addedBy)) {
            throw new RuntimeException("Only admins can add other admins");
        }

        if (!group.isMember(username)) {
            throw new RuntimeException("User must be a member first");
        }

        group.addAdmin(username);
        return groupRepository.save(group);
    }

    public void deleteGroup(Long groupId, String username) {
        ChatGroup group = groupRepository.findById(groupId)
                .orElseThrow(() -> new RuntimeException("Group not found"));

        if (!group.getCreatedBy().equals(username)) {
            throw new RuntimeException("Only group creator can delete the group");
        }

        groupRepository.delete(group);
    }

    public List<String> getGroupMembers(Long groupId) {
        ChatGroup group = groupRepository.findById(groupId)
                .orElseThrow(() -> new RuntimeException("Group not found"));
        return group.getMembers();
    }

    public List<ChatGroup> searchGroups(String query) {return null;
    }
}