package com.timwinfred.magicreviewer.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.timwinfred.magicreviewer.models.Review;
import com.timwinfred.magicreviewer.models.User;
import com.timwinfred.magicreviewer.services.CardService;
import com.timwinfred.magicreviewer.services.ReviewService;
import com.timwinfred.magicreviewer.services.UserService;

@Controller
public class CardController {
	public final CardService cService;
	public final UserService uService;
	public final ReviewService rService;

	public CardController(CardService cService, UserService uService, ReviewService rService) {
		this.cService = cService;
		this.uService = uService;
		this.rService = rService;
	}
	
	@RequestMapping("/")
	public String index(HttpSession session, Model model) {
		if(session.getAttribute("user_id") != null) {
			User user = uService.getUserById((Long) session.getAttribute("user_id"));
			model.addAttribute("user", user);
		}
		List<Review> recentReviews = rService.getRecent3Reviews();
		model.addAttribute("recentReviews", recentReviews);
		return "index.jsp";
	}
	
	@RequestMapping("/search")
	public String search(@RequestParam(value="q", required=true) String searchQuery, Model model, HttpSession session) {
		if(searchQuery.equals("")) {
			return "redirect:/";
		}
		if(session.getAttribute("user_id") != null) {
			User user = uService.getUserById((Long) session.getAttribute("user_id"));
			model.addAttribute("user", user);
		}
		model.addAttribute("searchQuery", searchQuery);
		List<Review> recentReviews = rService.getRecent3Reviews();
		model.addAttribute("recentReviews", recentReviews);
		return "search.jsp";
	}
}
