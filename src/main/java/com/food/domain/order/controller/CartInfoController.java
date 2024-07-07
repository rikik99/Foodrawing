package com.food.domain.order.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.mapper.CartMapper;
import com.food.domain.order.mapper.OrderMapper;
import com.food.domain.order.service.CartService;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.mapper.ProductDetailMapper;
import com.food.domain.sales.dto.DiscountDTO;
import com.food.domain.sales.dto.DiscountInfoDTO;
import com.food.domain.sales.dto.DiscountTargetDTO;
import com.food.domain.sales.mapper.DiscountMapper;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.GuestDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.service.CustomerService;
import com.food.domain.user.service.UserService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CartInfoController {
	@Autowired
	private CartMapper cartMapper;

	@Autowired
	private OrderMapper orderMapper;

	private final CartService cartService;

	@Autowired
	private ProductDetailMapper productDetailMapper;

	@Autowired
	private DiscountMapper discountMapper;

	@Autowired
	private UserService userService;

	@Autowired
	private CustomerService customerService;

	@RequestMapping("/cart")
	public ModelAndView orderCart(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		Cookie[] cookies = request.getCookies();

		// 로그인 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isLoggedIn = authentication != null && authentication.isAuthenticated()
				&& !"anonymousUser".equals(authentication.getPrincipal());

		mv.addObject("isLoggedIn", isLoggedIn);

		String username = authentication.getName();
		System.out.println("username: " + username);
		CustomerDTO customerDTO = new CustomerDTO();
		GuestDTO guestDTO = new GuestDTO();
		if (isLoggedIn) {
			UserDTO user = userService.loadUser(username);
			// log.info("product UserDTO = {}",user);
			Long userId = user.getId();
			customerDTO = customerService.findCustomerByUserId(userId);
			// log.info("customDTO = {}", customerDTO);
			System.out.println("customerDTO: " + customerDTO);

			if (customerDTO == null) {
				// log.info("customDTO is null, redirecting to login");
				// mv.setViewName();"redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
			}
		}
		mv.addObject("customer", customerDTO);

		List<CartInfoDTO> cartItems = new ArrayList<>();
		if (isLoggedIn) {
			// 장바구니 정보
			cartItems = cartMapper.getCartListByCustomerId(customerDTO.getId());
			System.out.println("cartItems: " + cartItems);
		} else if (cookies != null) { //게스트 일때
        	for (Cookie cookie : cookies) {
                if ("guestId".equals(cookie.getName())) {
                	guestDTO.setGuestId(cookie.getValue());
                    
                	cartItems = cartMapper.getGuestCartListByGuestId(guestDTO.getGuestId());
                }
            }        	
		}

		for (CartInfoDTO cartItem : cartItems) {
			cartItem.setSalesPostId(orderMapper.getSalesPostIdByProductNumber(cartItem.getProductNumber()));

			// 상품 카테고리 정보
			String categoryCode = cartItem.getProductNumber().substring(0, 2);
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
					.getProductTargetDiscount(cartItem.getProductNumber());
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
				mv.addObject("discountInfo", discountInfo);

				if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("P")) {
					discountPrice = (int) (cartItem.getPrice()
							* (1 - (discountInfo.get(0).getDiscountDTO().getDiscountValue() * 0.01)));
				} else if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("A")) {
					discountPrice = (int) (cartItem.getPrice()
							- discountInfo.get(0).getDiscountDTO().getDiscountValue());
				}
				cartItem.setDiscountPrice(discountPrice);
			} else if (discountInfo.size() > 1) {
				mv.addObject("discountInfo", discountInfo);
				int a = 0;
				int b = 0;

				for (DiscountInfoDTO discount : discountInfo) {
					if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("P")) {
						a = (int) (cartItem.getPrice()
								* (1 - (discountInfo.get(0).getDiscountDTO().getDiscountValue() * 0.01)));
					} else if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("A")) {
						b = (int) (cartItem.getPrice() - discountInfo.get(0).getDiscountDTO().getDiscountValue());
					}
				}

				discountPrice = (a > b) ? a : b;
				cartItem.setDiscountPrice(discountPrice);
				System.out.println("discountPrice: " + discountPrice);
			}
		}
		System.out.println("cartItems2: " + cartItems);

		mv.addObject("cartItems", cartItems);

		mv.setViewName("order/cart");

		return mv;
	}
}
