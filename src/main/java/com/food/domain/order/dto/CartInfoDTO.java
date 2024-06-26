package com.food.domain.order.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartInfoDTO {
	private Long id;
	private Long salesPostId;
    private int quantity;
    private int productQuantity;
    private String productNumber;
    private String name;
    private String description;
    private int price;
    private String fileName;
    private String filePath;
    private String fileType;
    private String discountName;
    private String discountType;
    private int discountValue;
    private int maxDiscount;
    private int minPrice;
}
