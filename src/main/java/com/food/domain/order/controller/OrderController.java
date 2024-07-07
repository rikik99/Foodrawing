package com.food.domain.order.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
    private final PaymentMapper paymentMapper;
    private final UserMapper userMapper;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }

    @PostMapping("/checkoutPage")
    public String checkoutPage(@RequestParam(value = "customerId", required = true) Long customerId, @RequestParam List<String> productNumbers, Model model) {
        log.info("Received customerId: {}", customerId);
        log.info("Received productNumbers: {}", productNumbers);

        List<CartInfoDTO> selectedItems = orderService.getSelectedItems(productNumbers, customerId);

        model.addAttribute("cartItems", selectedItems);
        log.info("selectedItems = {}", selectedItems);
        int totalPrice = selectedItems.stream().mapToInt(item -> item.getPrice() * item.getQuantity()).sum();
        int discountPrice = selectedItems.stream().mapToInt(item -> item.getDiscountValue() * item.getQuantity()).sum();
        int finalPrice = totalPrice - discountPrice;

        Long orderNumber = generateUniqueOrderNumber();

        Long adminId = userMapper.getIdByAdminName();
        paymentMapper.insertOrder(orderNumber, adminId);

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
        log.info("Received productNumber: {}", productNumber);

        List<CartInfoDTO> selectedItems = orderService.getProduct(productNumber, quantity);
        selectedItems.get(0).setQuantity(quantity);

        model.addAttribute("cartItems", selectedItems);
        log.info("selectedItems = {}", selectedItems);
        int totalPrice = selectedItems.get(0).getPrice() * selectedItems.get(0).getQuantity();
        int discountPrice = selectedItems.get(0).getDiscountValue() * selectedItems.get(0).getQuantity();
        int finalPrice = totalPrice - discountPrice;

        Long orderNumber = generateUniqueOrderNumber();

        Long adminId = userMapper.getIdByAdminName();
        paymentMapper.insertOrder(orderNumber, adminId);

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
            number = Long.parseLong(orderNumber);
            System.out.println("Long value: " + number);
            return number;
        } catch (NumberFormatException e) {
            System.err.println("Invalid string format for conversion to long: " + orderNumber);
            return null;
        }
    }
    

}
