package com.food.domain.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberRatingDTO {
    private Long id;
    private String rating;
    private Integer minAmount;
    private Integer maxAmount;
}
