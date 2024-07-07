package com.food.domain.sales.dto;

import java.time.LocalDateTime;
import java.util.List;

import com.food.domain.user.dto.CustomerDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SalesReviewDTO {
	private Long id;
    private Long salesPostId;
    private Long customerId;
    private int rating;
    private String message;
    private LocalDateTime createdDate;
    private LocalDateTime uploadDate;
    private String replyYn;
    private ReviewFileDTO files;
    private ReviewReplyDTO reply;
    private CustomerDTO customer;
}
