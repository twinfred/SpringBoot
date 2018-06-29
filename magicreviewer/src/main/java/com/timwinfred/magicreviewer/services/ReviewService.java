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
	
	// get a card's average rating
	public List<Integer> getAllRatingsForACard(Long id){
		return reviewRepository.getAllRatingsForACard(id);
	}
	
	// delete a review
	public void deleteReview(Long id) {
		reviewRepository.deleteById(id);
		return;
	}
	
	// does card have a review yet?
	public boolean doesCardHaveReview(Long id) {
		int reviewCount = reviewRepository.getAllReviewsForACard(id).size();
		if(reviewCount == 0) {
			return false;
		}else {
			return true;
		}
	}
	
	// save review edit
	public void saveReview(Review review) {
		reviewRepository.save(review);
	}
	
	// get 4 most recent reviews
	public List<Review> getRecent3Reviews(){
		return reviewRepository.findFirst3ByOrderByCreatedAtDesc();
	}
}
