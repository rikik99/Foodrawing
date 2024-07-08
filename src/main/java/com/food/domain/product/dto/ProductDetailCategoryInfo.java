package com.food.domain.product.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetailCategoryInfo {
	private String productNumber;
    private String name;
    private String description;
    private BigDecimal price;
    private int quantity;
    private String filePath;
    private Long salesPostId;
    private String salesPostTitle;
    private String salesPostDescription;
    private LocalDateTime createdDate;
    private LocalDateTime lastPostDate;
    private LocalDateTime updatedDate;
    private LocalDateTime startPostDate;
    private String status;
    private BigDecimal discountAmount;
    private String discountType;
    private BigDecimal discountValue;
    private BigDecimal minPrice;
    private BigDecimal discountedPrice; // 추가: 할인된 가격
    private String categoryName;
    private String categoryCode;
    private int nextVal;
}
