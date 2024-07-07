package com.food.domain.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.order.dto.OrderDetailDTO;
import com.food.domain.order.dto.OrderDetailInfoDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.mapper.ProductMapper;
import com.food.domain.sales.mapper.DiscountMapper;
import com.food.domain.user.dto.GuestOrderInfoDTO;
import com.food.domain.user.mapper.GuestMapper;

@Controller
public class GuestController {

	@Autowired
	private GuestMapper guestMapper;
	@Autowired
	private ProductMapper productMapper;
	@Autowired
	private DiscountMapper discountMapper;

	@RequestMapping("/guest/myOrder")
	private ModelAndView myOrder(@RequestParam("orderNumber") String orderNumber, @RequestParam("name") String name) {
		ModelAndView mv = new ModelAndView();

		// 모든 정보를 담을 DTO
		GuestOrderInfoDTO guestOrderInfoDTO = new GuestOrderInfoDTO();
		OrderDetailInfoDTO orderDetailInfoDTO = new OrderDetailInfoDTO();

		// 주문 테이블
		guestOrderInfoDTO.setOrder(guestMapper.getGuestByOrderNumberAndName(orderNumber));

		// 주문 상세 테이블(리스트)
		orderDetailInfoDTO.setOrderDetail(guestMapper.getOrderDetailsByOrderNumber(guestOrderInfoDTO.getOrder()));
		
		//주문 상태 테이블
		guestOrderInfoDTO.setOrderStatus(guestMapper.getOrderStatusByOrderNumber(guestOrderInfoDTO.getOrder().getId()));

		// 상품 정보(product, productfile)
		for (OrderDetailDTO detail : orderDetailInfoDTO.getOrderDetail()) {
			// 판매글에서 상품 번호 가져오기
			String productNumber = productMapper.getproductBySalesPostId(detail.getSalesPostId());

			// product 테이블
			ProductDTO product = productMapper.getProductById(productNumber);

			orderDetailInfoDTO.getProduct().add(product);

			// product file
			ProductFileDTO productFile = productMapper.getProductFileByProductNumber(productNumber);

			orderDetailInfoDTO.getProductFile().add(productFile);
		}
		
		//배송정보
		guestOrderInfoDTO.setDelivery(guestMapper.getDeliveryByOrderId(guestOrderInfoDTO.getOrder().getId()));

		// OrderDetailInfoDTO를 GuestOrderInfoDTO에 설정
		guestOrderInfoDTO.getOrderDetailInfo().add(orderDetailInfoDTO);

		mv.addObject("guestOrderInfoDTO", guestOrderInfoDTO);

		mv.setViewName("order/myOrder");
		return mv;
	}
	
	@RequestMapping("/guest/findOrder")
	private ModelAndView findOrder() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("order/guestFindMyOrder");
		return mv;
	}
}
