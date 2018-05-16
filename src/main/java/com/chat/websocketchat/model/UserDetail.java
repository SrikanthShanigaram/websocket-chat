package com.chat.websocketchat.model;

import org.springframework.security.core.authority.AuthorityUtils;

public class UserDetail extends org.springframework.security.core.userdetails.User {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3208176328808230806L;
	private User user;

    public UserDetail(User user) {
        super(user.getUserName(), user.getPassword(), AuthorityUtils.createAuthorityList(user.getRole().toString()));
        this.user = user;
    }

    public String getId() {
        return user.getUserId();
    }

    public Role getRole() {
        return user.getRole();
    }

    @Override
    public String toString() {
        return "UserDetail{" +
                "user=" + user +
                "} " + super.toString();
    }
}
