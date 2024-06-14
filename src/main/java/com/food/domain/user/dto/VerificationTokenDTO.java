package com.food.domain.user.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VerificationTokenDTO {
    private Long id;
    private String token;
    private String email;
    private LocalDateTime expiryDate;
    private String verified = "N"; // 기본값은 'N'
}