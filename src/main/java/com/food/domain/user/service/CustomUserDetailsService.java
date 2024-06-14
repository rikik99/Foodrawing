package com.food.domain.user.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import com.food.global.auth.UserNotFoundException;
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
        UserDTO userDTO = userService.loadUser(username);
        System.out.println("로그인한 userVo = "+userDTO);
        if (userDTO == null) {
            throw new UserNotFoundException("User not found");
        }
        return new CustomUserDetails(userDTO);
    }
}