package com.food.domain.sales.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiscountDTO {
    private Long id;
    private String onsaleYn;
    private String name;
    private String type;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private String discountType;
    private Long discountValue;
    private Long maxDiscount;
    private String description;
    private Long minPrice;
    private DiscountTargetDTO discountTargetDTO;
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YY.MM.dd");

    public String getFormattedStartDate() {
        if (startDate != null) {
            return startDate.format(formatter);
        }
        return "";
    }
    public String getFormattedEndDate() {
    	if (endDate != null) {
    		return endDate.format(formatter);
    	}
    	return "";
    }
    
}
