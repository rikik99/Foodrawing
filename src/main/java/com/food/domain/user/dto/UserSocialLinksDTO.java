package com.food.domain.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserSocialLinksDTO {
    private Long id;
    private Long userId;
    private String provider;
    private String providerId;
}
