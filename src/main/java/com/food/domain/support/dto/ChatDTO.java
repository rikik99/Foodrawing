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
public class ChatDTO {
    private Long id;
    private Long customerId;
    private Long adminId;
    private String content;
    private LocalDateTime chatedDate;
    private LocalDateTime createdDate;
}
