package com.food.domain.user.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.user.entity.User;
import com.food.domain.user.repository.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;

	public Optional<User> findById(long l) {
		return userRepository.findById(l);
	}

}
