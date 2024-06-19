package com.food.domain.order.controller;

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
public class OrderController {

    private final OrderService orderService;

    @PostMapping("/prepareCheckout")
    public ResponseEntity<Void> prepareCheckout(@RequestBody CheckoutRequestDTO request, HttpSession session) {
        try {
            session.setAttribute("checkoutItems", request.getProductIds());
            session.setAttribute("customerId", request.getCustomerId());
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/prepareCheckoutAll")
    public ResponseEntity<Void> prepareCheckoutAll(@RequestBody CheckoutRequestDTO request, HttpSession session) {
        try {
            session.setAttribute("checkoutAll", true);
            session.setAttribute("customerId", request.getCustomerId());
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}