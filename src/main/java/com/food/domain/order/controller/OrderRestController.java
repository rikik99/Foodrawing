package com.food.domain.order.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.order.dto.CheckoutRequestDTO;
import com.food.domain.order.service.OrderService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/order")
@RequiredArgsConstructor
public class OrderRestController {

    private final OrderService orderService;

    @PostMapping("/prepareCheckout")
    public ResponseEntity<Map<String, Object>> prepareCheckout(@RequestBody CheckoutRequestDTO request) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 필요한 비즈니스 로직 처리
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/prepareCheckoutAll")
    public ResponseEntity<Map<String, Boolean>> prepareCheckoutAll(@RequestBody CheckoutRequestDTO request, HttpSession session) {
        try {
            session.setAttribute("checkoutAll", true);
            session.setAttribute("customerId", request.getCustomerId());
            // You can add additional logic here if needed

            Map<String, Boolean> response = new HashMap<>();
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Boolean> response = new HashMap<>();
            response.put("success", false);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}