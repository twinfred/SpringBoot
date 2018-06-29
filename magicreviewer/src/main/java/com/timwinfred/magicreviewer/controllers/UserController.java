package com.timwinfred.magicreviewer.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.timwinfred.magicreviewer.models.Review;
import com.timwinfred.magicreviewer.models.User;
import com.timwinfred.magicreviewer.services.ReviewService;
import com.timwinfred.magicreviewer.services.UserService;

@Controller
public class UserController {
	private final UserService uService;
	private final ReviewService rService;
    
    public UserController(UserService uService, ReviewService rService) {
        this.uService = uService;
        this.rService = rService;
    }
    
    @RequestMapping("/account")
    public String account(HttpSession session, Model model) {
    	if(session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	} else {
    		User user = uService.getUserById((Long) session.getAttribute("user_id"));
    		model.addAttribute("user", user);
    		List<Object[]> myReviews = rService.getAllReviewsByAUser(user.getId());
    		model.addAttribute("myReviews", myReviews);
    		List<Review> recentReviews = rService.getRecent3Reviews();
    		model.addAttribute("recentReviews", recentReviews);
    		return "account.jsp";
    	}
    }
    
    @RequestMapping("/leaderboard")
    public String leaderboard(@RequestParam(value="top", required=false) String resultCount, Model model, HttpSession session) {
    	if(resultCount == null) {
    		resultCount = "10";
    	}
    	if(session.getAttribute("user_id") != null) {
			User user = uService.getUserById((Long) session.getAttribute("user_id"));
			model.addAttribute("user", user);
		}
    	if(resultCount.equals("10")) {
    		model.addAttribute("number", resultCount);
    		List<User> topUsers = uService.getTop10UsersByPoints();
    		model.addAttribute("topUsers", topUsers);
    	}else {
    		model.addAttribute("number", "50");
    		List<User> topUsers = uService.getTop50UsersByPoints();
    		model.addAttribute("topUsers", topUsers);
    	}
    	List<Review> recentReviews = rService.getRecent3Reviews();
		model.addAttribute("recentReviews", recentReviews);
    	return "leaderboard.jsp";
    }
    
    @RequestMapping("/login")
    public String login(Model model) {
    	List<Review> recentReviews = rService.getRecent3Reviews();
		model.addAttribute("recentReviews", recentReviews);
    	return "login.jsp";
    }
    
    @RequestMapping("/registration")
    public String registration(@ModelAttribute("user") User user, HttpSession session, Model model) {
    	if(session.getAttribute("user_id") == null) {
    		List<Review> recentReviews = rService.getRecent3Reviews();
    		model.addAttribute("recentReviews", recentReviews);
    		return "registration.jsp";
    	} else {
    		return "redirect:/account";
    	}	
    }
    
    @PostMapping("/registration")
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session, Model model) {
    	if(result.hasErrors()) {
    		List<Review> recentReviews = rService.getRecent3Reviews();
    		model.addAttribute("recentReviews", recentReviews);
    		return "registration.jsp";
    	} else {
    		user.setPoints(0);
    		User firstUser = uService.getUserById((long) 1);
    		if(firstUser == null) {
    			user.setUser_level(9);
    		}else {
    			user.setUser_level(0);
    		}
    		User newUser = uService.registerUser(user);
    		session.setAttribute("user_id", newUser.getId());
    		return "redirect:/";
    	}
    }
    
    @PostMapping("/login")
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session, @ModelAttribute("user") User user) {
    	boolean authenticated = uService.authenticateUser(email, password);
    	if(authenticated == true) {
    		User thisUser = uService.findByEmail(email);
    		session.setAttribute("user_id", thisUser.getId());
    		return "redirect:/";
    	} else {
    		user.setEmail("");
    		model.addAttribute("error", "The email or password you entered was incorrect.");
    		List<Review> recentReviews = rService.getRecent3Reviews();
    		model.addAttribute("recentReviews", recentReviews);
    		return "login.jsp";
    	}
    }
    
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
    	session.invalidate();
    	return "redirect:/";
    }
}
