package com.timwinfred.magicreviewer.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.timwinfred.magicreviewer.models.Review;

public interface ReviewRepository extends CrudRepository<Review, Long> {
	@Query("SELECT r.id, r.rating, r.title, r.review, r.status, r.createdAt, r.user.id, r.user.username FROM Review r WHERE r.card.id = ?1 ORDER BY r.createdAt")
	List<Object[]> getAllReviewsForACard(Long id);
	
	@Query("SELECT r.id, r.rating, r.title, r.review, r.status, r.createdAt FROM Review r WHERE r.user.id = ?1 ORDER BY r.createdAt")
	List<Object[]> getAllReviewsByAUser(Long id);
	
	@Query("SELECT r.rating FROM Review r WHERE r.card.id = ?1")
	List<Integer> getAllRatingsForACard(Long id);
}
