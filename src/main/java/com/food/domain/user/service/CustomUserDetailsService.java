package com.food.domain.user.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import com.food.global.auth.UserNotFoundException;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.global.auth.CustomUserDetails;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserService userService;

    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UserNotFoundException {
    	System.out.println("loadUserByUsername 발생");
        UserDTO userDTO = userService.loadUser(username);
        if (userDTO == null) {
            throw new UserNotFoundException("User not found");
        }
        return new CustomUserDetails(userDTO);
    }

    public UserDetails loadUserByEmail(String email) throws UserNotFoundException {
    	System.out.println("customuser email = "+email);
        CustomerDTO customerDTO = userService.findCustomerByEmail(email);
        if (customerDTO == null) {
            throw new UserNotFoundException("User not found");
        }
        UserDTO userDTO = userService.loadUserById(customerDTO.getUserId());
        if (userDTO == null) {
            throw new UserNotFoundException("User not found");
        }
        return new CustomUserDetails(userDTO);
    }
}
