package com.food.domain.order.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.order.dto.DeliveryDTO;
import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderDetailDTO;
import com.food.domain.order.dto.OrderDetailRequest;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.order.dto.OrderStatusRequest;
import com.food.domain.order.dto.PaymentRequest;

@Mapper
public interface PaymentMapper {

    void insertOrder(PaymentRequest paymentRequest);

    void insertOrderDetail(OrderDetailDTO detail);

    void insertOrderStatus(OrderStatusDTO orderStatusRequest);

    void updateProductQuantity(@Param("productNumber") String string, @Param("quantity") int i);

    void deleteCartItem(@Param("customerId") String customerId, @Param("productNumber") Long long1);
    
    boolean existsOrderNumber(@Param("orderNumber") String orderNumber);

	Long getOrderId(Long orderNumber);

	void insertNoDiscountOrderDetail(OrderDetailDTO detail);

	void insertDelivery(DeliveryDTO deliveryDTO);

	String getProductNumberBySalesPostId(Long salesPostId);

	void deleteCartItem(String identifierId, String productNumber);

	void insertOrder(Long orderNumber, Long adminId);

	void updateOrder(OrderDTO orderDTO);

	void increaseStock(@Param("productNumber") String productNumber, @Param("quantity") int quantity);

	void deleteOrder(Long orderNumber);
}