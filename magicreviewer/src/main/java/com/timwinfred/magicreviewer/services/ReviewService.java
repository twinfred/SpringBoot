package com.timwinfred.magicreviewer.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.magicreviewer.models.Review;
import com.timwinfred.magicreviewer.repositories.ReviewRepository;

@Service
public class ReviewService {
	private final ReviewRepository reviewRepository;

	public ReviewService(ReviewRepository reviewRepository) {
		this.reviewRepository = reviewRepository;
	}
	
	public Review getReviewById(Long id) {
		Optional<Review> review = reviewRepository.findById(id);
		if(review.isPresent()) {
			return review.get();
		} else {
			return null;
		}
	}
	
	public Iterable<Review> getAllReviews() {
		return reviewRepository.findAll();
	}
	
	public List<Object[]> getAllReviewsForACard(Long id) {
		return reviewRepository.getAllReviewsForACard(id);
	}
	
	public List<Object[]> getAllReviewsByAUser(Long id) {
		return reviewRepository.getAllReviewsByAUser(id);
	}
	
	// add a review
	public Review createReview(Review review) {
		return reviewRepository.save(review);
	}
}
