package com.chat.websocketchat.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@Document(collection = "customSequences")
public class CustomSequences {
    @Id
    private String id;
    private long seq;
}