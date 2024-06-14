package com.food.domain.order.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.dto.CheckoutRequestDTO;
import com.food.domain.order.service.OrderService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderPageController {

    private final OrderService orderService;

    @RequestMapping("/checkoutPage")
    public String checkoutPage(@RequestBody CheckoutRequestDTO request, Model model) {
        Long customerId = request.getCustomerId();
        List<String> productIds = request.getProductIds();

        List<CartInfoDTO> selectedItems = orderService.getSelectedItems(productIds, customerId);

        model.addAttribute("cartItems", selectedItems);
        // 금액 관련 정보도 model에 추가
        int totalPrice = selectedItems.stream().mapToInt(item -> item.getPrice() * item.getQuantity()).sum();
        int discountPrice = 0; // 할인 금액 계산 로직 추가
        int finalPrice = totalPrice - discountPrice;

        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("discountPrice", discountPrice);
        model.addAttribute("finalPrice", finalPrice);

        return "checkoutPage";
    }
}