package com.chat.websocketchat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {

	@RequestMapping("/login")
	public ModelAndView login() {
		System.out.println("=================hhh");
		return new ModelAndView("login");
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public void loginAction() {
		System.out.println("=================");
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(Model model) {
        return "index";
    }
	@RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register(Model model) {
        return "register";
    }
}
