package com.food.domain.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.order.dto.PaymentRequest;
import com.food.domain.order.service.PaymentService;

@RestController
@RequestMapping("/payment")
public class PaymentRestController {
	@Autowired
    private PaymentService paymenyService;

    @PostMapping("/result")
    public ResponseEntity<?> handleOrderResult(@RequestBody PaymentRequest paymentRequest) {
    	try {
    		paymenyService.processOrder(paymentRequest);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
}
