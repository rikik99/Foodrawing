package com.food.domain.order.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.order.dto.OrderDetailRequest;
import com.food.domain.order.dto.OrderStatusRequest;
import com.food.domain.order.dto.PaymentRequest;

@Mapper
public interface PaymentMapper {

    void insertOrder(PaymentRequest paymentRequest);

    void insertOrderDetail(OrderDetailRequest orderDetailRequest);

    void insertOrderStatus(OrderStatusRequest orderStatusRequest);

    void updateProductQuantity(@Param("salesPostId") String salesPostId, @Param("quantity") int quantity);

    boolean existsOrderNumber(@Param("orderNumber") String orderNumber);
}