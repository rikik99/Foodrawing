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
public class ResponseDTO {
    private Long id;
    private Long inquiriesId;
    private Long adminId;
    private String message;
    private LocalDateTime createdDate;
    private String resolvedYn;
    private LocalDateTime resolvedDate;
}
