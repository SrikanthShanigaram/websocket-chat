package com.chat.websocketchat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.chat.websocketchat.model.User;
import com.chat.websocketchat.model.UserDetail;
@Component
public class ChatUserDetailsService implements UserDetailsService {

	@Autowired
    private UserService userService;
	
    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
    	User user = userService.getUser(userName)
    			.orElseThrow(() -> new UsernameNotFoundException(String.format("User with userName=%s was not found", userName)));
        return new UserDetail(user);
    }

}
