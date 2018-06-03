package com.chat.websocketchat.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StreamUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.chat.websocketchat.model.Role;
import com.chat.websocketchat.model.User;
import com.chat.websocketchat.model.UserDetail;
import com.chat.websocketchat.service.CustomSequenceService;
import com.chat.websocketchat.service.UserImageService;
import com.chat.websocketchat.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserImageService userImageService;
	
	@Autowired
	private CustomSequenceService customSequenceService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

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
	public ModelAndView processRegistration(@RequestParam("dp") MultipartFile file,ModelAndView modelAndView, @ModelAttribute User user, BindingResult bindingResult, HttpServletRequest request) {
		System.out.println("===============lll");
		user = new User();
		user.setUserName(request.getParameter("userName"));
		User userExists = userService.getUser(user.getUserName()).orElse(null);
		System.out.println(userExists+" user Exists");
		if (userExists != null) {
			modelAndView.addObject("alreadyRegisteredMessage", "Oops!  There is already a user registered with the user name provided.");
			modelAndView.setViewName("register");
			bindingResult.reject("username");
		}
			
		if (bindingResult.hasErrors()) { 
			modelAndView.setViewName("register");		
		} else {
			try {
//			long userId = RandomUtils.nextInt();
//			userImageService.storeUserImage(file,userId);
			user.setPassword(passwordEncoder.encode(request.getParameter("password")));
			user.setUserId(customSequenceService.getNextSequence(User.class.getName()));
			user.setRole(Role.USER);
			user.setCreateDate(new Date());
			user.setEmail(request.getParameter("email"));
			user.setModifiedDate(new Date());
			user = userService.saveUser(user);
			userImageService.storeUserImage(file,user.getUserId());
			modelAndView.addObject("confirmationMessage", user.getUserName()+" created successfully");
			modelAndView.setViewName("register");
			}catch (DuplicateKeyException dke) {
				modelAndView.addObject("alreadyRegisteredMessage", "Oops!  The user name or email have been already taken.");
				bindingResult.reject("username");
			} catch (IOException e) {
				modelAndView.addObject("confirmationMessage", user.getUserName()+" created successfully but image was not updated.");
			} catch (Exception e) {
				e.printStackTrace();
				modelAndView.addObject("alreadyRegisteredMessage", "Oops! Error : "+e.getMessage());
			}
		}
		modelAndView.setViewName("register");
		return modelAndView;
	}
	@GetMapping(value= {"/*","/index"})
	public String index() {
		return "index";
	}
	
	@GetMapping(value= "/editProfile")
	public ModelAndView getUserEditView(ModelAndView modelAndView,HttpServletRequest request) {
		UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		modelAndView.addObject("editUser", userDetail.getUser());
		modelAndView.setViewName("register");
		return modelAndView;
	}
	
	@RequestMapping(value="/imageDisplay/{userId}",method=RequestMethod.GET)
	public @ResponseBody byte[] getImage(@PathVariable long userId,HttpServletResponse response) throws FileNotFoundException, IOException {
		File imgFile = userImageService.getFile(userId);
		return StreamUtils.copyToByteArray(new FileInputStream(imgFile));
	}
	
	@PostMapping(value="updateUser")
	public ModelAndView updateUser(@RequestParam("dp") MultipartFile file,ModelAndView modelAndView, HttpServletRequest request) {
		long userId = NumberUtils.toLong(request.getParameter("userId"));
		User user = userService.getUser(userId).orElse(null);
		if(user==null) {
			modelAndView.addObject("error", "Oops!  User not found.");
			modelAndView.setViewName("register");
			return modelAndView;
		}
		String userName = request.getParameter("userName");
		if(userName!=null) {
			user.setUserName(userName);
		}
		String email = request.getParameter("email");
		if(email!=null) {
			user.setEmail(email);
		}
		String password = request.getParameter("password");
		if(password!=null) {
			user.setPassword(passwordEncoder.encode(password));
		}
		if(!file.isEmpty()) {
			try {
				userImageService.storeUserImage(file, userId);
			}catch (Exception e) {
				modelAndView.addObject("error", "Oops!  Failed to store image.");
				modelAndView.addObject("editUser", user);
				modelAndView.setViewName("register");
				return modelAndView;
			}
		}
		try {
			System.out.println(user);
			userService.updateUser(user);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		modelAndView.addObject("success", "Updated user successfully.");
		modelAndView.addObject("editUser", user);
		modelAndView.setViewName("register");
		return modelAndView;
	}
	
}
