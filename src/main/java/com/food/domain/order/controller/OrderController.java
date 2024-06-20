package com.food.domain.order.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @RequestMapping("/checkoutPage")
    public String checkoutPage(@RequestParam(value = "customerId", required = true) Long customerId, @RequestParam List<String> productIds, Model model) {
    	log.info("Received customerId: {}", customerId);
        log.info("Received productIds: {}", productIds);
    	
        List<CartInfoDTO> selectedItems = orderService.getSelectedItems(productIds, customerId);

        model.addAttribute("cartItems", selectedItems);
        log.info("selectedItems = {}", selectedItems);
        // 금액 관련 정보도 model에 추가
        int totalPrice = selectedItems.stream().mapToInt(item -> item.getPrice() * item.getQuantity()).sum();
        int discountPrice = 0; // 할인 금액 계산 로직 추가
        int finalPrice = totalPrice - discountPrice;

        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("discountPrice", discountPrice);
        model.addAttribute("finalPrice", finalPrice);

        return "order/checkoutPage";
    }
}