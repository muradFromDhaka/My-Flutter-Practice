package com.messaging.springWebSockets.models;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Task {
    private String name;
    private int days;
    public Task() {} // needed for Jackson

    public Task(String name, int days) {
        this.name = name;
        this.days = days;
    }
}