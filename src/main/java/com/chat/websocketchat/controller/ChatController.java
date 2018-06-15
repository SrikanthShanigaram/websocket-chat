package com.chat.websocketchat.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.chat.websocketchat.model.ChatMessage;
import com.chat.websocketchat.model.User;

@Controller
public class ChatController {
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	public static List<User> users = new ArrayList<>();

   // @MessageMapping("/chat.sendMessage")
    //@SendTo("/topic/{room}")
	@MessageMapping("/topic/{room}")
    public void sendMessage(@DestinationVariable String room,@Payload ChatMessage chatMessage) {
    	System.out.println(room);
    	System.out.println("===================----------------");
        this.simpMessagingTemplate.convertAndSend("/topic/"+room,chatMessage);
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public ChatMessage addUser(@Payload ChatMessage chatMessage, 
                               SimpMessageHeaderAccessor headerAccessor) {
        // Add username in web socket session
    	System.out.println("===========");
        headerAccessor.getSessionAttributes().put("user", chatMessage.getUser());
        if(!users.contains(chatMessage.getUser())) {
        	users.add(chatMessage.getUser());
        }
        return chatMessage;
    }
}