package com.food.domain.order.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import com.food.domain.user.dto.CustomerDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDTO {
    private Long id;
    private String identifierId;
    private String identifierType;
    private LocalDateTime orderDate;
    private String totalAmount;
    private Long orderNumber;
    private String paymentId;
    private String paymentType;
    
    private OrderStatusDTO orderStatus;
    private List<OrderDetailDTO> orderDetailList;
    private CustomerDTO customer;
    
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public String getFormattedOrderDate() {
        if (orderDate != null) {
            return orderDate.format(formatter);
        }
        return "";
    }
    
}