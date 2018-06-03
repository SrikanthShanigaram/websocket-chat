package com.chat.websocketchat.custom.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;

import com.chat.websocketchat.model.User;

public class UserMongoRepositoryImpl implements UserMongoRepository {

	@Autowired
	private MongoTemplate mongoTemplate;
	
	@Override
	public void update(User user) {
		mongoTemplate.save(user);
	}

}
