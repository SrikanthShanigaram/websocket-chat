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
		System.out.println("inside user service[repository] "+userName);
		return Optional.ofNullable(repository.findByUserName(userName));
	}
	
}
