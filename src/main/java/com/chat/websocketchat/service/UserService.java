package com.chat.websocketchat.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chat.websocketchat.model.User;
import com.chat.websocketchat.repository.UserRepository;
@Service
public class UserService {

	@Autowired
	private UserRepository repository;

	public Optional<User> getUser(String userName) {
		return Optional.ofNullable(repository.findByUserName(userName));
	}
	
	public User saveUser(User user) throws Exception {
		return repository.save(user);
	}
	public void updateUser(User user) throws Exception {
		repository.update(user);
	}

	public Optional<User> getUser(long userId) {
		return Optional.ofNullable(repository.findByUserId(userId));
	}
	
}
