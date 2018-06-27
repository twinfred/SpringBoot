package com.timwinfred.magicreviewer.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.magicreviewer.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
	User findByEmail(String email);
	List<User> findFirst10ByOrderByPointsDesc();
	List<User> findFirst50ByOrderByPointsDesc();
}
