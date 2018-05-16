package com.chat.websocketchat.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.chat.websocketchat.model.Role;
import com.chat.websocketchat.model.User;
import com.chat.websocketchat.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;

	@GetMapping("/login")
	public String login(Model model, String error, String logout) {
		if (error != null)
            model.addAttribute("errorMsg", "Your username and password are invalid.");

        if (logout != null)
            model.addAttribute("msg", "You have been logged out successfully.");

        return "login";
	}
	@GetMapping("/status")
	public String status(Model model, String error, String logout) {
		if (error != null)
            model.addAttribute("error", error);


        return "status";
	}
	@GetMapping("/register")
	public ModelAndView register(ModelAndView modelAndView, User user) {
		modelAndView.addObject("user", user);
		modelAndView.setViewName("register");
		return modelAndView;
	}
	@PostMapping("/register")
	public ModelAndView processRegistration(ModelAndView modelAndView, @ModelAttribute User user, BindingResult bindingResult, HttpServletRequest request) {
		System.out.println("=============Hi inside post register===========");
		System.out.println(user);
		System.out.println(modelAndView);
		System.out.println(bindingResult);
		// Lookup user in database by e-mail
		user = new User();
		user.setUserName(request.getParameter("userName"));
		user.setPassword(request.getParameter("password"));
		user.setUserId(RandomUtils.nextInt()+"");
		user.setRole(Role.USER);
		User userExists = userService.getUser(user.getUserName()).orElse(null);
		
		System.out.println(userExists);
		
		if (userExists != null) {
			modelAndView.addObject("alreadyRegisteredMessage", "Oops!  There is already a user registered with the email provided.");
			modelAndView.setViewName("register");
			bindingResult.reject("email");
		}
			
		if (bindingResult.hasErrors()) { 
			modelAndView.setViewName("register");		
		} else { 
		    userService.saveUser(user);
			modelAndView.addObject("confirmationMessage", "A confirmation e-mail has been sent to " + user.getUserName());
			modelAndView.setViewName("register");
		}
		return modelAndView;
	}
	@GetMapping("/index")
	public String index() {
		return "index";
	}
}
