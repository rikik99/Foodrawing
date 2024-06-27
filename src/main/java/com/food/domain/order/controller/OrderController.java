package com.food.domain.order.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.mapper.PaymentMapper;
import com.food.domain.order.service.OrderService;
import com.food.domain.user.mapper.UserMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    
    @Autowired
	private PaymentMapper paymentMapper;
    
    @Autowired
	private UserMapper userMapper;

    @PostMapping("/checkoutPage")
    public String checkoutPage(@RequestParam(value = "customerId", required = true) Long customerId, @RequestParam List<String> productNumbers, Model model) {
    	log.info("Received customerId: {}", customerId);
        log.info("Received productNumbers: {}", productNumbers);
    	
        List<CartInfoDTO> selectedItems = orderService.getSelectedItems(productNumbers, customerId);

        model.addAttribute("cartItems", selectedItems);
        log.info("selectedItems = {}", selectedItems);
        // 금액 관련 정보도 model에 추가
        int totalPrice = selectedItems.stream().mapToInt(item -> item.getPrice() * item.getQuantity()).sum();
        //이 로직이 맞나?
        int discountPrice = selectedItems.stream().mapToInt(item -> item.getDiscountValue() * item.getQuantity()).sum(); // 할인 금액 계산 로직 추가
        int finalPrice = totalPrice - discountPrice;
        
        Long orderNumber = generateUniqueOrderNumber();
		
        //주문번호 미리 독점
        //admin id 얻기
        Long adminId = userMapper.getIdByAdminName();
		paymentMapper.insertOrder(orderNumber, adminId);
		
		//재고 마이너스
		for (CartInfoDTO detail : selectedItems) {
            paymentMapper.updateProductQuantity(detail.getProductNumber(), detail.getQuantity());
        }
		
		model.addAttribute("orderNumber", orderNumber);

        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("discountPrice", discountPrice);
        model.addAttribute("finalPrice", finalPrice);

        return "order/checkoutPage";
    }
    
    @PostMapping("/buy/checkoutPage")
    public String buyCheckoutPage(@RequestParam(value = "customerId", required = true) Long customerId, @RequestParam String productNumber, @RequestParam int quantity, Model model) {
    	log.info("Received customerId: {}", customerId);
        log.info("Received productNumbers: {}", productNumber);
    	
        List<CartInfoDTO> selectedItems = orderService.getProduct(productNumber, quantity);
        selectedItems.get(0).setQuantity(quantity);

        model.addAttribute("cartItems", selectedItems);
        log.info("selectedItems = {}", selectedItems);
        // 금액 관련 정보도 model에 추가
        int totalPrice = (selectedItems.get(0).getPrice() * selectedItems.get(0).getQuantity());
        //이 로직이 맞나?
        int discountPrice = selectedItems.get(0).getDiscountValue() * selectedItems.get(0).getQuantity(); // 할인 금액 계산 로직 추가
        int finalPrice = totalPrice - discountPrice;
        
        Long orderNumber = generateUniqueOrderNumber();
		
        //주문번호 미리 독점
        //admin id 얻기
        Long adminId = userMapper.getIdByAdminName();
		paymentMapper.insertOrder(orderNumber, adminId);
		
		//재고 마이너스
		for (CartInfoDTO detail : selectedItems) {
            paymentMapper.updateProductQuantity(detail.getProductNumber(), detail.getQuantity());
        }
		
		model.addAttribute("orderNumber", orderNumber);

        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("discountPrice", discountPrice);
        model.addAttribute("finalPrice", finalPrice);

        return "order/checkoutPage";
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
}