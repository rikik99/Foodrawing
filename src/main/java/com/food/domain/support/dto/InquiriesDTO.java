package com.food.domain.support.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InquiriesDTO {
    private Long id;
    private Long customerId;
    private String subject;
    private Long type;
    private Long secret;
    private String message;
    private LocalDateTime createdDate;
}
