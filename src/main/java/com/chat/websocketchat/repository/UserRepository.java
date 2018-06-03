package com.chat.websocketchat.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.chat.websocketchat.custom.repository.UserMongoRepository;
import com.chat.websocketchat.model.User;

public interface UserRepository extends MongoRepository<User, String>,UserMongoRepository     {
	
	public User findByUserName(String userName);
	public User findByUserId(long userId);
}