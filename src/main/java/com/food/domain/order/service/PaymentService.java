package com.food.domain.order.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.order.dto.DeliveryDTO;
import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderDetailDTO;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.order.dto.OrderStatusRequest;
import com.food.domain.order.dto.PaymentRequest;
import com.food.domain.order.mapper.PaymentMapper;

@Service
public class PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;

    public void processOrder(PaymentRequest paymentRequest) {
        // 주문 번호 생성
        Long orderNumber = paymentRequest.getOrder().getOrderNumber();
        
        // OrderDTO 생성 및 설정
        OrderDTO orderDTO = new OrderDTO();
        orderDTO.setIdentifierId(paymentRequest.getOrder().getIdentifierId());
        orderDTO.setIdentifierType("customer");
        orderDTO.setOrderDate(LocalDateTime.now());
        orderDTO.setTotalAmount(paymentRequest.getFinalPrice().toString());
        orderDTO.setOrderNumber(orderNumber);
        orderDTO.setPaymentId(paymentRequest.getOrder().getPaymentId());
        orderDTO.setPaymentType(paymentRequest.getOrder().getPaymentType());
        paymentRequest.setOrder(orderDTO);
        
        // DeliveryDTO 생성 및 설정
        DeliveryDTO deliveryDTO = new DeliveryDTO();
        deliveryDTO.setRecipientName(paymentRequest.getDeliverName());
        deliveryDTO.setRecipientPhone(paymentRequest.getDeliverPhone());
        deliveryDTO.setRecipientAddress(paymentRequest.getDelivery().getRecipientAddress());
        deliveryDTO.setRecipientAddressDetail(paymentRequest.getDelivery().getRecipientAddressDetail());
        deliveryDTO.setRecipientZipcode(paymentRequest.getDelivery().getRecipientZipcode());
        deliveryDTO.setDeliveryStatus(paymentRequest.getDelivery().getDeliveryStatus());
        deliveryDTO.setDeliveryComment(paymentRequest.getDelivery().getDeliveryComment());
        deliveryDTO.setDeliveryStartDate(LocalDateTime.now());
        deliveryDTO.setEstimatedArrivalDate(LocalDate.now().plusDays(3));
        paymentRequest.setDelivery(deliveryDTO);
        
        // Order 저장
        paymentMapper.updateOrder(orderDTO);
        System.out.println("paymentRequest: " + paymentRequest);
        
        orderDTO.setId(paymentMapper.getOrderId(orderNumber));
        deliveryDTO.setOrderId(orderDTO.getId());
        
        //Delevery 저장
        paymentMapper.insertDelivery(deliveryDTO);

        // OrderDetail 저장
        List<OrderDetailDTO> orderDetails = paymentRequest.getOrderDetails();
        System.out.println("orderDetails: " + orderDetails);
        for (OrderDetailDTO detail : orderDetails) {
            detail.setOrderId(paymentRequest.getOrder().getId());
            System.out.println("detail: " + detail);
            if(detail.getDiscountPrice() == null) {
            	paymentMapper.insertNoDiscountOrderDetail(detail);
            } else {
            	paymentMapper.insertOrderDetail(detail);
            }

            // 상품 재고 감소 장바구니 올때로 변경해야함
            //paymentMapper.updateProductQuantity(detail.getOrderId(), detail.getQuantity());
            
            //productNumber 얻기
            String productNumber = paymentMapper.getProductNumberBySalesPostId(detail.getSalesPostId());
            
            // 장바구니에서 상품 제거
            paymentMapper.deleteCartItem(paymentRequest.getOrder().getIdentifierId(), productNumber);
        }

        // OrderStatus 저장
        OrderStatusDTO orderStatusRequest = new OrderStatusDTO();
        orderStatusRequest.setOrderId(paymentRequest.getOrder().getId());
        orderStatusRequest.setOrderStatus(paymentRequest.getOrder().getPaymentType().equals("vbank") ? "입금전" : "결제완료");
        paymentMapper.insertOrderStatus(orderStatusRequest);
    }

    private Long generateUniqueOrderNumber() {
        String orderNumber;
        do {
            orderNumber = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd")) + new Random().nextInt(10000000);
        } while (paymentMapper.existsOrderNumber(orderNumber));
        
        long number;
        
        try {
            // String을 long으로 변환
            number = Long.parseLong(orderNumber);
            System.out.println("Long value: " + number);
            return number;
        } catch (NumberFormatException e) {
            System.err.println("Invalid string format for conversion to long: " + orderNumber);
            return null;
        }   
    }
    
    public void increaseStock(String productNumber, int quantity) {
    	paymentMapper.increaseStock(productNumber, quantity);
    }

	public void deleteOrder(Long orderNumber) {
		paymentMapper.deleteOrder(orderNumber);
	}
}
