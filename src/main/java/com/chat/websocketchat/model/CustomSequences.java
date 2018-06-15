package com.chat.websocketchat.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*@ToString
@Getter
@Setter*/
@Document(collection = "customSequences")
public class CustomSequences {
    @Id
    private String id;
    private long seq;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public long getSeq() {
		return seq;
	}
	public void setSeq(long seq) {
		this.seq = seq;
	}
	@Override
	public String toString() {
		return "CustomSequences [id=" + id + ", seq=" + seq + "]";
	}
}