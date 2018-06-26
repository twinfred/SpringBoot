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

import com.timwinfred.magicreviewer.models.Card;
import com.timwinfred.magicreviewer.models.Review;
import com.timwinfred.magicreviewer.models.User;
import com.timwinfred.magicreviewer.services.CardService;
import com.timwinfred.magicreviewer.services.ReviewService;
import com.timwinfred.magicreviewer.services.UserService;

@Controller
public class ReviewController {
	public final UserService uService;
	public final ReviewService rService;
	public final CardService cService;
	
	public ReviewController(UserService uService, ReviewService rService, CardService cService) {
		this.uService = uService;
		this.rService = rService;
		this.cService = cService;
	}
	
	@RequestMapping("/card")
	public String card(@RequestParam(value="name") String cardName, Model model, HttpSession session, @ModelAttribute("review") Review review) {
		if(session.getAttribute("user_id") != null) {
			User user = uService.getUserById((Long) session.getAttribute("user_id"));
			model.addAttribute("user", user);
		}
		model.addAttribute("cardName", cardName);
		Card card = cService.getCardByName(cardName);
		if(card != null) {
			model.addAttribute("card", card);
			List<Object[]> reviews = rService.getAllReviewsForACard(card.getId());
			model.addAttribute("reviews", reviews);
		}
		return "card.jsp";
	}
	
	@PostMapping("/review")
	public String addReview(@Valid @ModelAttribute("review") Review review, BindingResult result, HttpSession session, Model model, @RequestParam(value="cardName") String cardName) {
		if(result.hasErrors()) {
			model.addAttribute("cardName", cardName);
			Card card = cService.getCardByName(cardName);
			if(card != null) {
				model.addAttribute("card", card);
				List<Object[]> reviews = rService.getAllReviewsForACard(card.getId());
				model.addAttribute("reviews", reviews);
			}
			return "card.jsp";
		} else {
			User user = uService.getUserById((Long) session.getAttribute("user_id"));
			review.setUser(user);
			Card dbCard = cService.getCardByName(cardName);
			if(dbCard == null) {
				Card newCard = new Card();
				newCard.setName(cardName);
				Card savedCard = cService.createCard(newCard);
				review.setCard(savedCard);
			} else {
				review.setCard(dbCard);
			}
			rService.createReview(review);
			return "redirect:/card?name=" + cardName;
		}
	}
}
