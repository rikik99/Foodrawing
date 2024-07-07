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

@RestController
@RequestMapping("/guest/order")
public class GuestOrderRestController {
	 @PostMapping("/prepareCheckout")
	    public ResponseEntity<Map<String, Object>> prepareCheckout(@RequestBody CheckoutRequestDTO request) {
	        Map<String, Object> response = new HashMap<>();
	        try {
	            // 로직 수행
	            response.put("success", true);
	            return ResponseEntity.ok(response);
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", "결제 준비 중 오류가 발생했습니다.");
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
	    }

	    @PostMapping("/prepareCheckoutAll")
	    public ResponseEntity<Map<String, Object>> prepareCheckoutAll(@RequestBody CheckoutRequestDTO request) {
	        Map<String, Object> response = new HashMap<>();
	        try {
	            // 로직 수행
	            response.put("success", true);
	            return ResponseEntity.ok(response);
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", "결제 준비 중 오류가 발생했습니다.");
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
	    }
}
