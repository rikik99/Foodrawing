package com.food.domain.order.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.order.dto.PaymentRequest;
import com.food.domain.order.dto.PaymentResponse;
import com.food.domain.order.dto.RestoreRequest;
import com.food.domain.order.service.PaymentService;

@RestController
//@RequestMapping("/payment")
public class PaymentRestController {
	@Autowired
    private PaymentService paymentService;

    @PostMapping("/payment/result")
    public ResponseEntity<?> handleOrderResult(@RequestBody PaymentRequest paymentRequest) {
    	try {
    		System.out.println("paymentRequest:" + paymentRequest);
    		paymentService.processOrder(paymentRequest);
    		return ResponseEntity.ok(new PaymentResponse("success", "Payment processed successfully"));
        } catch (Exception e) {
            // 오류 발생 시 오류 메시지와 함께 500 응답 반환
        	e.printStackTrace();
        	return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new PaymentResponse("error", e.getMessage()));
        }
    }
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleException(Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new PaymentResponse("error", e.getMessage()));
    }
    
    @PostMapping("/payment/restoreStock")
    public ResponseEntity<Map<String, String>> restoreStock(@RequestBody RestoreRequest restoreRequest) {
        try {
            List<String> productNumbers = restoreRequest.getProductNumbers();
            List<String> quantities = restoreRequest.getQuantities();

            for (int i = 0; i < productNumbers.size(); i++) {
                String productNumber = productNumbers.get(i);
                int quantity = Integer.parseInt(quantities.get(i));
                paymentService.increaseStock(productNumber, quantity);
                System.out.println("재고 복구: " + productNumber + ' ' + quantity);
            }
            
            System.out.println("재고 복구됨");
            //주문번호 삭제
            paymentService.deleteOrder(restoreRequest.getOrderNumber());
            System.out.println("주문 번호 삭제됨");

            return ResponseEntity.ok(Map.of("status", "success"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Map.of("status", "error", "message", e.getMessage()));
        }
    }
}
