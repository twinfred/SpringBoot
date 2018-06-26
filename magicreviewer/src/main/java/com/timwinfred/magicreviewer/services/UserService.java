package com.timwinfred.magicreviewer.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.timwinfred.magicreviewer.models.User;
import com.timwinfred.magicreviewer.repositories.UserRepository;

@Service
public class UserService {
	private final UserRepository userRepository;
    
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    
    // find a single user
    public User getUserById(Long id) {
    	Optional<User> user = userRepository.findById(id);
    	if(user.isPresent()) {
    		return user.get();
    	} else {
    		return null;
    	}
    }
    
    // find all users
    public Iterable<User> getAllUsers() {
    	return userRepository.findAll();
    }
    
    // register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepository.save(user);
    }
    
    // find user by email
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    // find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    // authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepository.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    
    // get to 50 users by points (leaderboard)
    public List<User> getTop50UsersByPoints() {
    	return userRepository.findFirst50ByOrderByPoints();
    }
    
    // get to 10 users by points (leaderboard)
    public List<User> getTop10UsersByPoints() {
    	return userRepository.findFirst10ByOrderByPoints();
    }
    
    // add 5 points to user
}
