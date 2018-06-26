package com.timwinfred.magicreviewer.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
	public String card(@RequestParam(value="name") String cardName, Model model, HttpSession session, @ModelAttribute("thisReview") Review review) {
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
			List<Integer> ratings = rService.getAllRatingsForACard(card.getId());
			Integer ratingCount = ratings.size();
			Integer ratingTotal = 0;
			for(Integer rating: ratings) {
				ratingTotal += rating;
			}
			Double avgRating = (double) ratingTotal / (double) ratingCount;
			model.addAttribute("ratingCount", ratingCount);
			model.addAttribute("avgRating", avgRating);
		}
		return "card.jsp";
	}
	
	@PostMapping("/review")
	public String addReview(@Valid @ModelAttribute("thisReview") Review thisReview, BindingResult result, HttpSession session, Model model, @RequestParam(value="cardName") String cardName, @RequestParam(value="rating") int reviewRating) {
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
			thisReview.setUser(user);
			Card dbCard = cService.getCardByName(cardName);
			if(dbCard == null) {
				Card newCard = new Card();
				newCard.setName(cardName);
				Card savedCard = cService.createCard(newCard);
				thisReview.setCard(savedCard);
			} else {
				thisReview.setCard(dbCard);
			}
			thisReview.setStatus(1);
			thisReview.setRating(reviewRating);
			rService.createReview(thisReview);
			return "redirect:/card?name=" + cardName;
		}
	}
	
	@RequestMapping("/review/delete/{id}")
	public String deleteReview(@PathVariable(value="id", required=true) Long id, HttpSession session) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/";
		}else {
			Long user_id = (Long) session.getAttribute("user_id");
			Review thisReview = rService.getReviewById(id);
			User thisUser = uService.getUserById(user_id);
			if(thisReview.getUser().getUsername().equals(thisUser.getUsername()) || thisUser.getUser_level() == 9) {
				String cardName = thisReview.getCard().getName();
				rService.deleteReview(id);
				return "redirect:/card?name=" + cardName;
			}else {
				return "redirect:/";
			}
		}
	}
}
