package com.food.domain.order.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.order.service.CartService;
import com.food.domain.product.entity.Product;
import com.food.domain.product.service.ProductService;
import com.food.domain.user.entity.Customer;
import com.food.domain.user.entity.User;
import com.food.domain.user.service.UserService;

@RestController
//@RequestMapping("/cart")
public class CartRestController {

//    @Autowired
//    private CartService cartService;
//
//    @Autowired
//    private ProductService productService;
//    
//    @Autowired
//    private UserService userService;
//
//    @PostMapping("/checkStock")
//    public ResponseEntity<Map<String, Object>> checkStock(@RequestBody Map<String, Object> request) {
//        try {
//            String productId = (String) request.get("productId");
//            Long quantity = Long.valueOf((Integer) request.get("quantity"));
//
//            //boolean stockAvailable = cartService.checkStock(productId, quantity);
//            Customer customer = getLoggedInCustomer(); // 실제 로그인된 사용자로 교체
//            //Product product = productService.findById(productId);
//           // boolean inCart = cartService.isInCart(customer, product);
//
//            Map<String, Object> response = new HashMap<>();
//            response.put("success", true);
//            //response.put("stockAvailable", stockAvailable);
//            //response.put("inCart", inCart);
//
//            return ResponseEntity.ok(response);
//        } catch (Exception e) {
//            e.printStackTrace(); // 로그에 예외 정보 출력
//            Map<String, Object> response = new HashMap<>();
//            response.put("success", false);
//            response.put("message", e.getMessage());
//            return ResponseEntity.status(500).body(response);
//        }
//    }
//
//    @PostMapping("/addToCart")
//    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody Map<String, Object> request) {
//        try {
//            String productId = (String) request.get("productId");
//            Long quantity = Long.valueOf((Integer) request.get("quantity"));
//
//            Customer customer = getLoggedInCustomer(); // 실제 로그인된 사용자로 교체
//            //Product product = productService.findById(productId);
//            //cartService.addToCart(customer, product, quantity);
//
//            Map<String, Object> response = new HashMap<>();
//            response.put("success", true);
//
//            return ResponseEntity.ok(response);
//        } catch (Exception e) {
//            e.printStackTrace(); // 로그에 예외 정보 출력
//            Map<String, Object> response = new HashMap<>();
//            response.put("success", false);
//            response.put("message", e.getMessage());
//            return ResponseEntity.status(500).body(response);
//        }
//    }
//
//    private Customer getLoggedInCustomer() {
//        // 실제 로그인된 사용자를 반환하는 로직을 구현하세요.
//        // 이 예제에서는 임시로 사용자 ID 1L로 설정했습니다.
//    	Optional<User> user = userService.findById(1L);
//    	
//        //return new Customer(1, user, "nick1", "John Doe", 'M', "010-1234-5678", "john.doe@example.com", LocalDate.now(), "123 Main St", "Apt 101", 12345);
//    	return null;
//    }
//    
//    @ExceptionHandler(Exception.class)
//    public ResponseEntity<Map<String, Object>> handleException(Exception e) {
//        Map<String, Object> response = new HashMap<>();
//        response.put("success", false);
//        response.put("message", e.getMessage());
//        return ResponseEntity.status(500).body(response);
//    }
}
