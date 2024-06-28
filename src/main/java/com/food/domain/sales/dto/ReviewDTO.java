package com.food.domain.sales.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.support.dto.ResponseDTO;
import com.food.domain.user.dto.CustomerDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewDTO {
    private Long id;
    private Long salesPostId;
    private Long customerId;
    private Long rating;
    private String replyYn;
    private String message;
    private LocalDateTime createdDate;
    private LocalDateTime uploadDate;
    private SalesPostDTO salesPotDTO;
    private ProductDTO productDTO;
    private CustomerDTO customerDTO;
    private ReviewsReplyDTO reviewsReplyDTO;
    private ReviewFileDTO reviewFileDTO;
    
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public String getFormattedCreatedDate() {
        if (createdDate != null) {
            return createdDate.format(formatter);
        }
        return "";
    }
}
