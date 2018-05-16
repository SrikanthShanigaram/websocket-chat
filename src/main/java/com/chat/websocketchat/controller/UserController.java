package com.chat.websocketchat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {

	@GetMapping("/login")
	public String login(Model model, String error, String logout) {
		if (error != null)
            model.addAttribute("errorMsg", "Your username and password are invalid.");

        if (logout != null)
            model.addAttribute("msg", "You have been logged out successfully.");

        return "login";
	}
	@GetMapping("/register")
	public String register() {
		return "register";
	}
	/*@PostMapping("/login")
	public void afterLogin() {
		System.out.println("=============Hi inside post login===========");
	}*/
	@GetMapping("/index")
	public String index() {
		return "index";
	}
}
