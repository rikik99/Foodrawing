package com.food.global.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordEncoderGenerator {

    public static void main(String[] args) {
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String rawPassword = "q1w2e3!!";  // 원하는 비밀번호 입력
        String encodedPassword = passwordEncoder.encode(rawPassword);
        
        System.out.println(encodedPassword);  // 암호화된 비밀번호 출력
    }
}