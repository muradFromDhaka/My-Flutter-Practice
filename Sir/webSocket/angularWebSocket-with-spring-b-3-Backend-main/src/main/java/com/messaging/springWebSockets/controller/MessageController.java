package com.messaging.springWebSockets.controller;

import com.messaging.springWebSockets.models.Message;
import com.messaging.springWebSockets.models.OutputMessage;
import com.messaging.springWebSockets.models.Task;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RestController
public class MessageController {

//    @MessageMapping("/chat")
//    @SendTo("/topic/messages")
//    public OutputMessage send(Message message) throws Exception {
//        String time = new SimpleDateFormat("HH:mm").format(new Date());
//        return new OutputMessage(message.getFrom(), message.getText(), time);
//    }


    private final List<Task> tasks;

    public MessageController() {
        tasks = new ArrayList<>();
    }


    @GetMapping("/getAll")
    public List<Task> gettAll() {
        return tasks;
    }


    @MessageMapping("/add_new_task")
    @SendTo("/topic/tasks/added_task") // <- Add /topic prefix
    public Task addTask(Task task) {
        tasks.add(task);
        return task;
    }




//    @MessageMapping("/add_new_task")
//    @SendTo("/tasks/added_task")
//    public List<Task> addTask(@RequestBody Task task) {
//        tasks.add(task);
//        return tasks;
//    }


}
