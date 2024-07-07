package com.food.domain.order.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.mapper.PaymentMapper;
import com.food.domain.order.mapper.ReserveMapper;
import com.food.domain.order.service.OrderService;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.mapper.ProductDetailMapper;
import com.food.domain.sales.dto.DiscountDTO;
import com.food.domain.sales.dto.DiscountInfoDTO;
import com.food.domain.sales.dto.DiscountTargetDTO;
import com.food.domain.sales.mapper.DiscountMapper;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.GuestDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.mapper.UserMapper;
import com.food.domain.user.service.CustomerService;
import com.food.domain.user.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private PaymentMapper paymentMapper;

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private ProductDetailMapper productDetailMapper;

	@Autowired
	private DiscountMapper discountMapper;

	@Autowired
	private ReserveMapper reserveMapper;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CustomerService customerService;

	@PostMapping("/checkoutPage")
	public String checkoutPage(@RequestParam(value = "customerId", required = true) Long customerId,
			@RequestParam List<String> productNumbers, Model model) {
		log.info("Received customerId: {}", customerId);
		log.info("Received productNumbers: {}", productNumbers);

		int totalOriginalPrice = 0;

		//로그인 가져오기
		   Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	       boolean isLoggedIn = authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal());
	       
	       String username = authentication.getName();
	       System.out.println("username: " + username);
	       CustomerDTO customerDTO = new CustomerDTO();
	       GuestDTO guestDTO = new GuestDTO();
	       if (isLoggedIn) {
	    	   UserDTO user = userService.loadUser(username);
	    	   log.info("product UserDTO = {}",user);
	    	   Long userId = user.getId();
	    	   customerDTO = customerService.findCustomerByUserId(userId);
	    	   log.info("customDTO = {}", customerDTO);
	    	   System.out.println("customerDTO: " + customerDTO);
	    	   
	    	   if (customerDTO == null) {
		           log.info("customDTO is null, redirecting to login");
		           //mv.setViewName();"redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
		       }
	       }
	       model.addAttribute("customer", customerDTO);

		List<CartInfoDTO> selectedItems = orderService.getSelectedItems(productNumbers, customerId);
		for (CartInfoDTO selectedItem : selectedItems) {
			selectedItem.setSalesPostId(orderService.getSalesPostIdByProductNumber(selectedItem.getProductNumber()));
			totalOriginalPrice += selectedItem.getPrice();
		}
		model.addAttribute("totalOriginalPrice", totalOriginalPrice);

		// 할인 계산
		int totalDiscountPrice = discoutPrice(selectedItems);
		model.addAttribute("totalDiscountPrice", totalDiscountPrice);

		model.addAttribute("cartItems", selectedItems);
		log.info("selectedItems = {}", selectedItems);
		// 금액 관련 정보도 model에 추가
		int totalPrice = selectedItems.stream().mapToInt(item -> item.getPrice() * item.getQuantity()).sum();
		// 이 로직이 맞나?
		int discountPrice = selectedItems.stream().mapToInt(item -> item.getDiscountValue() * item.getQuantity()).sum(); // 할인
																															// 금액
																															// 계산
																															// 로직
																															// 추가
		int finalPrice = totalOriginalPrice - totalDiscountPrice;

		Long orderNumber = generateUniqueOrderNumber();

		// 주문번호 미리 독점
		// admin id 얻기
		Long adminId = userMapper.getIdByAdminName();
		paymentMapper.insertOrder(orderNumber, adminId);

		// 재고 마이너스
		for (CartInfoDTO detail : selectedItems) {
			paymentMapper.updateProductQuantity(detail.getProductNumber(), detail.getQuantity());
		}

		// 회원 쿠폰

		// 회원 적립금
		int reserves = reserveMapper.getReservesByCustomerId(customerId);

		model.addAttribute("orderNumber", orderNumber);

		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("discountPrice", discountPrice);
		model.addAttribute("finalPrice", finalPrice);
		model.addAttribute("reserves", reserves);

		return "order/checkoutPage";
	}

	@PostMapping("/buy/checkoutPage")
	public String buyCheckoutPage(@RequestParam(value = "customerId", required = true) Long customerId,
			@RequestParam String productNumber, @RequestParam int quantity, Model model) {
		log.info("Received customerId: {}", customerId);
		log.info("Received productNumbers: {}", productNumber);

		int totalOriginalPrice = 0;

		List<CartInfoDTO> selectedItems = orderService.getProduct(productNumber, quantity);
		selectedItems.get(0).setQuantity(quantity);
		for (CartInfoDTO selectedItem : selectedItems) {
			selectedItem.setSalesPostId(orderService.getSalesPostIdByProductNumber(selectedItem.getProductNumber()));
			totalOriginalPrice += selectedItem.getPrice();
		}
		model.addAttribute("totalOriginalPrice", totalOriginalPrice);

		// 할인 계산
		int totalDiscountPrice = discoutPrice(selectedItems);
		model.addAttribute("totalDiscountPrice", totalDiscountPrice);

		model.addAttribute("cartItems", selectedItems);
		log.info("selectedItems = {}", selectedItems);
		// 금액 관련 정보도 model에 추가
		int totalPrice = (selectedItems.get(0).getPrice() * selectedItems.get(0).getQuantity());
		// 이 로직이 맞나?
		int discountPrice = selectedItems.get(0).getDiscountValue() * selectedItems.get(0).getQuantity(); // 할인 금액 계산 로직
																											// 추가
		int finalPrice = totalPrice - discountPrice;

		Long orderNumber = generateUniqueOrderNumber();

		// 주문번호 미리 독점
		// admin id 얻기
		Long adminId = userMapper.getIdByAdminName();
		paymentMapper.insertOrder(orderNumber, adminId);

		// 재고 마이너스
		for (CartInfoDTO detail : selectedItems) {
			paymentMapper.updateProductQuantity(detail.getProductNumber(), detail.getQuantity());
		}

		// 회원 쿠폰

		// 회원 적립금
		int reserves = reserveMapper.getReservesByCustomerId(customerId);

		model.addAttribute("orderNumber", orderNumber);

		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("discountPrice", discountPrice);
		model.addAttribute("finalPrice", finalPrice);

		return "order/checkoutPage";
	}

	private Long generateUniqueOrderNumber() {
		String orderNumber;
		do {
			orderNumber = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"))
					+ new Random().nextInt(10000000);
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

	// 할인 계산
	private int discoutPrice(List<CartInfoDTO> selectedItems) {
		int totalDiscountPrice = 0;

		for (CartInfoDTO selectedItem : selectedItems) {
			int originalPrice = selectedItem.getPrice();
			int curDiscount = 0;

			// 상품 카테고리 정보
			String categoryCode = selectedItem.getProductNumber().substring(0, 2);
			ProductCategoryDTO productCategoryInfo = productDetailMapper.getCategoryByCategryCode(categoryCode);

			// 상품 할인 정보(카테고리 or 상품 할인)
			List<DiscountInfoDTO> discountInfo = new ArrayList<>();

			// 카테고리로 할인 가져오기
			DiscountTargetDTO categoryTargetDiscount = discountMapper
					.getCategroyTargetDiscount(productCategoryInfo.getId());
			if (categoryTargetDiscount != null) {
				DiscountDTO categoryDiscount = discountMapper.getDiscount(categoryTargetDiscount.getDiscountId());
				DiscountInfoDTO categoryDiscountInfo = new DiscountInfoDTO();
				categoryDiscountInfo.setDiscountDTO(categoryDiscount);
				categoryDiscountInfo.setDiscountTargetDTO(categoryTargetDiscount);
				discountInfo.add(categoryDiscountInfo);
			}

			// 상품으로 할인 가져오기
			DiscountTargetDTO productTargetDiscount = discountMapper
					.getProductTargetDiscount(selectedItem.getProductNumber());
			if (productTargetDiscount != null) {
				DiscountDTO productDiscount = discountMapper.getDiscount(productTargetDiscount.getDiscountId());
				DiscountInfoDTO productDiscountInfo = new DiscountInfoDTO();
				productDiscountInfo.setDiscountDTO(productDiscount);
				productDiscountInfo.setDiscountTargetDTO(productTargetDiscount);
				discountInfo.add(productDiscountInfo);
			}
			System.out.println("discountInfo: " + discountInfo);

			// productDetailMapper.getDiscount(productCategoryInfo,
			// salesPost.getProductNumber());
			int discountPrice = 0;

			// 할인가 계산
			if (discountInfo.size() == 1) {
				if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("P")) {
					discountPrice = (int) (selectedItem.getPrice()
							* (1 - (discountInfo.get(0).getDiscountDTO().getDiscountValue() * 0.01)));
				} else if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("A")) {
					discountPrice = (int) (selectedItem.getPrice()
							- discountInfo.get(0).getDiscountDTO().getDiscountValue());
				}
				selectedItem.setDiscountPrice(discountPrice);
				curDiscount = discountPrice;
				totalDiscountPrice += originalPrice - discountPrice;
			} else if (discountInfo.size() > 1) {
				int a = 0;
				int b = 0;

				for (DiscountInfoDTO discount : discountInfo) {
					if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("P")) {
						a = (int) (selectedItem.getPrice()
								* (1 - (discountInfo.get(0).getDiscountDTO().getDiscountValue() * 0.01)));
					} else if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("A")) {
						b = (int) (selectedItem.getPrice() - discountInfo.get(0).getDiscountDTO().getDiscountValue());
					}
				}

				discountPrice = (a > b) ? a : b;
				selectedItem.setDiscountPrice(discountPrice);
				curDiscount = discountPrice;
				totalDiscountPrice += originalPrice - discountPrice;
				System.out.println("discountPrice: " + discountPrice);
			}
		}
		return totalDiscountPrice;
	}
}