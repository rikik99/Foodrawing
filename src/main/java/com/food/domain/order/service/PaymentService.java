package com.food.domain.order.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.order.dto.OrderDetailRequest;
import com.food.domain.order.dto.OrderStatusRequest;
import com.food.domain.order.dto.PaymentRequest;
import com.food.domain.order.mapper.PaymentMapper;

@Service
public class PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;

    public void processOrder(PaymentRequest paymentRequest) {
        String orderNumber = generateUniqueOrderNumber();
        paymentRequest.setOrderNumber(orderNumber);
        paymentMapper.insertOrder(paymentRequest);

        List<OrderDetailRequest> orderDetails = paymentRequest.getOrderDetails();
        for (OrderDetailRequest detail : orderDetails) {
            detail.setOrderId(paymentRequest.getId());
            paymentMapper.insertOrderDetail(detail);

            // 상품 재고 감소
            paymentMapper.updateProductQuantity(detail.getSalesPostId(), detail.getQuantity());
        }

        OrderStatusRequest orderStatusRequest = new OrderStatusRequest();
        orderStatusRequest.setOrderId(paymentRequest.getId());
        orderStatusRequest.setOrderStatus(paymentRequest.getPaymentMethod().equals("vbank") ? "입금전" : "결제완료");
        paymentMapper.insertOrderStatus(orderStatusRequest);
    }

    private String generateUniqueOrderNumber() {
        String orderNumber;
        do {
            orderNumber = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd")) + new Random().nextInt(10000000);
        } while (paymentMapper.existsOrderNumber(orderNumber));
        return orderNumber;
    }
}
