package com.chat.websocketchat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
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
    	System.out.println("============inside userdetail service=========");
    	User user = userService.getUser(userName)
    			.orElseThrow(() -> new UsernameNotFoundException(String.format("User with userName=%s was not found", userName)));
    	System.out.println(user+" in service");
        //return new UserDetail(user);
    	org.springframework.security.core.userdetails.User u=  new org.springframework.security.core.userdetails.User(
    	        user.getUserName(), 
    	        user.getPassword(), // shall to be the already BCrypt-encrypted password
    	        AuthorityUtils.createAuthorityList(user.getRole().toString()));
    	System.out.println(u.getPassword()+" :::: encoded");
    	return u;
    }

}
