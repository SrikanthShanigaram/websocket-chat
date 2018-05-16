package com.chat.websocketchat.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class FailureLoginHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest arg0, HttpServletResponse arg1,
			org.springframework.security.core.AuthenticationException arg2) throws IOException, ServletException {
		arg1.sendRedirect("/status?error="+arg2.getMessage());
	}
}