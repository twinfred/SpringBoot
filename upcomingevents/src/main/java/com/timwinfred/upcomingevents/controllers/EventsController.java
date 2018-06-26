package com.timwinfred.upcomingevents.controllers;

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

import com.timwinfred.upcomingevents.models.Event;
import com.timwinfred.upcomingevents.models.User;
import com.timwinfred.upcomingevents.services.EventService;
import com.timwinfred.upcomingevents.services.UserService;

@Controller
public class EventsController {
	private final UserService uService;
	public final EventService eService;
	private final String[] states;

	public EventsController(UserService uService, EventService eService) {
		this.uService = uService;
		this.eService = eService;
		states = new String[4];
		states[0] = "CA";
		states[1] = "NV";
		states[2] = "OR";
		states[3] = "WA";
	}
	
	public String[] getStates() {
		return states;
	}

	@RequestMapping("/")
	public String loginReg(@ModelAttribute("user") User user, Model model) {
		model.addAttribute("states", this.getStates());
		return "loginReg.jsp";
	}
	
	@PostMapping("/registration")
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
    	if(result.hasErrors()) {
    		return "registrationPage.jsp";
    	} else {
    		User newUser = uService.registerUser(user);
    		session.setAttribute("user_id", newUser.getId());
    		return "redirect:/events";
    	}
    }
	
	@PostMapping("/login")
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session, @ModelAttribute("user") User user) {
    	boolean authenticated = uService.authenticateUser(email, password);
    	if(authenticated == true) {
    		User thisUser = uService.findByEmail(email);
    		session.setAttribute("user_id", thisUser.getId());
    		return "redirect:/events";
    	} else {
    		user.setEmail("");
    		model.addAttribute("states", this.getStates());
    		model.addAttribute("error", "The email or password you entered was incorrect.");
    		return "loginReg.jsp";
    	}
    }
	
	@RequestMapping("/events")
	public String home(HttpSession session, Model model, @ModelAttribute("event") Event event) {
    	if(session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	} else {
    		User user = uService.findUserById((Long) session.getAttribute("user_id"));
    		model.addAttribute("user", user);
    		model.addAttribute("states", this.getStates());
    		List<Object[]> inState = eService.getEventsInState(user.getState());
    		model.addAttribute("inState", inState);
    		List<Object[]> outState = eService.getEventsOutOfState(user.getState());
    		model.addAttribute("outState", outState);
    		List<Object[]> userRsvps = eService.getUserRsvps(user.getId());
    		model.addAttribute("rsvps", userRsvps);
    		return "dashboard.jsp";
    	}
    }
	
	@PostMapping("/events")
	public String addEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			return "dashboard.jsp";
		} else {
			event.setUploader(uService.findUserById((Long) session.getAttribute("user_id")));
			eService.createEvent(event);
			return "redirect:/events";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
    	session.invalidate();
    	return "redirect:/";
    }
}
