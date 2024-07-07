package com.food.domain.order.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.order.dto.DeliveryDTO;
import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderDetailDTO;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.order.dto.PaymentRequest;
import com.food.domain.order.mapper.PaymentMapper;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.mapper.ProductDetailMapper;
import com.food.domain.product.mapper.ProductMapper;
import com.food.domain.sales.dto.DiscountDTO;
import com.food.domain.sales.dto.DiscountInfoDTO;
import com.food.domain.sales.dto.DiscountTargetDTO;
import com.food.domain.sales.mapper.DiscountMapper;
import com.food.domain.user.dto.CustomerReservesDTO;
import com.food.domain.user.dto.GuestDTO;

@Service
public class PaymentService {

	@Autowired
	private PaymentMapper paymentMapper;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private ProductDetailMapper productDetailMapper;
	
	@Autowired
	private DiscountMapper discountMapper;

	public void processOrder(PaymentRequest paymentRequest) {
		// 주문 번호 생성
		Long orderNumber = paymentRequest.getOrder().getOrderNumber();

		// OrderDTO 생성 및 설정
		OrderDTO orderDTO = new OrderDTO();
		orderDTO.setIdentifierId(paymentRequest.getOrder().getIdentifierId());
		orderDTO.setIdentifierType("customer");
		orderDTO.setOrderDate(LocalDateTime.now());
		orderDTO.setTotalAmount(paymentRequest.getFinalPrice().toString());
		orderDTO.setOrderNumber(orderNumber);
		orderDTO.setPaymentId(paymentRequest.getOrder().getPaymentId());
		orderDTO.setPaymentType(paymentRequest.getOrder().getPaymentType());
		paymentRequest.setOrder(orderDTO);

		// DeliveryDTO 생성 및 설정
		DeliveryDTO deliveryDTO = new DeliveryDTO();
		deliveryDTO.setRecipientName(paymentRequest.getDeliverName());
		deliveryDTO.setRecipientPhone(paymentRequest.getDeliverPhone());
		deliveryDTO.setRecipientAddress(paymentRequest.getDelivery().getRecipientAddress());
		deliveryDTO.setRecipientAddressDetail(paymentRequest.getDelivery().getRecipientAddressDetail());
		deliveryDTO.setRecipientZipcode(paymentRequest.getDelivery().getRecipientZipcode());
		deliveryDTO.setDeliveryStatus(paymentRequest.getDelivery().getDeliveryStatus());
		deliveryDTO.setDeliveryComment(paymentRequest.getDelivery().getDeliveryComment());
		deliveryDTO.setDeliveryStartDate(LocalDateTime.now());
		deliveryDTO.setEstimatedArrivalDate(LocalDate.now().plusDays(3));
		paymentRequest.setDelivery(deliveryDTO);

		// Order 저장
		paymentMapper.updateOrder(orderDTO);
		System.out.println("paymentRequest: " + paymentRequest);

		orderDTO.setId(paymentMapper.getOrderId(orderNumber));
		deliveryDTO.setOrderId(orderDTO.getId());

		// Delevery 저장
		paymentMapper.insertDelivery(deliveryDTO);

		// OrderDetail 저장
		List<OrderDetailDTO> orderDetails = paymentRequest.getOrderDetails();
		System.out.println("orderDetails: " + orderDetails);
		for (OrderDetailDTO detail : orderDetails) {
			detail.setOrderId(paymentRequest.getOrder().getId());
			System.out.println("detail: " + detail);
			if (detail.getDiscountPrice() == null) {
				paymentMapper.insertNoDiscountOrderDetail(detail);
			} else {
				paymentMapper.insertOrderDetail(detail);
			}

			// 상품 재고 감소 장바구니 올때로 변경해야함
			// paymentMapper.updateProductQuantity(detail.getOrderId(),
			// detail.getQuantity());

			// productNumber 얻기
			String productNumber = paymentMapper.getProductNumberBySalesPostId(detail.getSalesPostId());

			// 장바구니에서 상품 제거
			paymentMapper.deleteCartItem(paymentRequest.getOrder().getIdentifierId(), productNumber);
		}

		// OrderStatus 저장
		OrderStatusDTO orderStatusRequest = new OrderStatusDTO();
		orderStatusRequest.setOrderId(paymentRequest.getOrder().getId());
		orderStatusRequest.setOrderStatus(paymentRequest.getOrder().getPaymentType().equals("vbank") ? "입금전" : "결제완료");
		paymentMapper.insertOrderStatus(orderStatusRequest);

		// 적립금 저장
		CustomerReservesDTO reserve = new CustomerReservesDTO();
		reserve.setOrderId(orderDTO.getId());
		reserve.setCustomerId(Long.valueOf(orderDTO.getIdentifierId()));
		
		BigDecimal number = new BigDecimal("0.01");
        // 연산 수행
        BigDecimal point = paymentRequest.getFinalPrice().multiply(number);
        // 반올림하여 long 타입으로 변환
        Long pointLong = point.setScale(0, RoundingMode.HALF_UP).longValue();
		reserve.setReserves(pointLong);
		paymentMapper.insertCustomerReserves(reserve);
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

	public void increaseStock(String productNumber, int quantity) {
		paymentMapper.increaseStock(productNumber, quantity);
	}

	public void deleteOrder(Long orderNumber) {
		paymentMapper.deleteOrder(orderNumber);
	}

	public void processGuestOrder(PaymentRequest paymentRequest) {
		// 주문 번호 생성
		Long orderNumber = paymentRequest.getOrder().getOrderNumber();

		GuestDTO guestDTO = new GuestDTO();
		guestDTO.setGuestId(paymentRequest.getGuestId());
		guestDTO.setName(paymentRequest.getCustomerName());
		guestDTO.setPassword(paymentRequest.getPassword());
		guestDTO.setAddress(paymentRequest.getDelivery().getRecipientAddress());
		guestDTO.setAddressDetail(paymentRequest.getDelivery().getRecipientAddressDetail());
		guestDTO.setEmail(paymentRequest.getEmail());
		guestDTO.setPhone(paymentRequest.getCustomerPhone());
		guestDTO.setZipcode(paymentRequest.getDelivery().getRecipientZipcode());
		System.out.println("guestDTO: " + guestDTO);
		paymentMapper.updateGuest(guestDTO);

		// OrderDTO 생성 및 설정
		OrderDTO orderDTO = new OrderDTO();
		orderDTO.setIdentifierId(paymentRequest.getOrder().getIdentifierId());
		orderDTO.setIdentifierType("guest");
		orderDTO.setOrderDate(LocalDateTime.now());
		orderDTO.setTotalAmount(paymentRequest.getFinalPrice().toString());
		orderDTO.setOrderNumber(orderNumber);
		orderDTO.setPaymentId(paymentRequest.getOrder().getPaymentId());
		orderDTO.setPaymentType(paymentRequest.getOrder().getPaymentType());
		paymentRequest.setOrder(orderDTO);

		// DeliveryDTO 생성 및 설정
		DeliveryDTO deliveryDTO = new DeliveryDTO();
		deliveryDTO.setRecipientName(paymentRequest.getDeliverName());
		deliveryDTO.setRecipientPhone(paymentRequest.getDeliverPhone());
		deliveryDTO.setRecipientAddress(paymentRequest.getDelivery().getRecipientAddress());
		deliveryDTO.setRecipientAddressDetail(paymentRequest.getDelivery().getRecipientAddressDetail());
		deliveryDTO.setRecipientZipcode(paymentRequest.getDelivery().getRecipientZipcode());
		deliveryDTO.setDeliveryStatus(paymentRequest.getDelivery().getDeliveryStatus());
		deliveryDTO.setDeliveryComment(paymentRequest.getDelivery().getDeliveryComment());
		deliveryDTO.setDeliveryStartDate(LocalDateTime.now());
		deliveryDTO.setEstimatedArrivalDate(LocalDate.now().plusDays(3));
		paymentRequest.setDelivery(deliveryDTO);

		// Order 저장
		paymentMapper.updateOrder(orderDTO);
		System.out.println("paymentRequest: " + paymentRequest);

		orderDTO.setId(paymentMapper.getOrderId(orderNumber));
		deliveryDTO.setOrderId(orderDTO.getId());

		// Delevery 저장
		paymentMapper.insertDelivery(deliveryDTO);

		// OrderDetail 저장
		List<OrderDetailDTO> orderDetails = paymentRequest.getOrderDetails();
		System.out.println("orderDetails: " + orderDetails);
		for (OrderDetailDTO detail : orderDetails) {
			detail.setOrderId(paymentRequest.getOrder().getId());
			// 상품찾고 할인 찾기
			String productNumber = productMapper.getproductBySalesPostId(detail.getSalesPostId());
			System.out.println("productNumber: " + productNumber);
			
			// 상품 카테고리 정보
			String categoryCode = productNumber.substring(0, 2);
			ProductCategoryDTO productCategoryInfo = productDetailMapper.getCategoryByCategryCode(categoryCode);

			//상품 정보
			ProductDTO productInfo = productDetailMapper.getProductById(productNumber);
			detail.setUnitPrice(productInfo.getPrice());
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
					.getProductTargetDiscount(productNumber);
			System.out.println("productTargetDiscount: " + productTargetDiscount);
			if (productTargetDiscount != null) {
				DiscountDTO productDiscount = discountMapper.getDiscount(productTargetDiscount.getDiscountId());
				DiscountInfoDTO productDiscountInfo = new DiscountInfoDTO();
				productDiscountInfo.setDiscountDTO(productDiscount);
				productDiscountInfo.setDiscountTargetDTO(productTargetDiscount);
				discountInfo.add(productDiscountInfo);
				System.out.println("productDiscount: " + productDiscount);
			}

			// productDetailMapper.getDiscount(productCategoryInfo,
			// salesPost.getProductNumber());
			int discountPrice = 0;

			// 할인가 계산
			if (discountInfo.size() == 1) {
				if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("P")) {
					discountPrice = (int) (productInfo.getPrice()
							* (1 - (discountInfo.get(0).getDiscountDTO().getDiscountValue() * 0.01)));
				} else if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("A")) {
					discountPrice = (int) (productInfo.getPrice()
							- discountInfo.get(0).getDiscountDTO().getDiscountValue());
				}
			} else if (discountInfo.size() > 1) {
				int a = 0;
				int b = 0;

				for (DiscountInfoDTO discount : discountInfo) {
					if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("P")) {
						a = (int) (productInfo.getPrice()
								* (1 - (discountInfo.get(0).getDiscountDTO().getDiscountValue() * 0.01)));
					} else if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("A")) {
						b = (int) (productInfo.getPrice() - discountInfo.get(0).getDiscountDTO().getDiscountValue());
					}
				}

				discountPrice = (a > b) ? a : b;
			}
			detail.setDiscountPrice(Long.valueOf(discountPrice));

			System.out.println("detail: " + detail);
			if (detail.getDiscountPrice() == null) {
				paymentMapper.insertNoDiscountOrderDetail(detail);
			} else {
				paymentMapper.insertOrderDetail(detail);
			}

			// 상품 재고 감소 장바구니 올때로 변경해야함
			// paymentMapper.updateProductQuantity(detail.getOrderId(),
			// detail.getQuantity());

			// productNumber 얻기
			String productNumber2 = paymentMapper.getProductNumberBySalesPostId(detail.getSalesPostId());

			// 장바구니에서 상품 제거
			paymentMapper.deleteGuestCartItem(paymentRequest.getOrder().getIdentifierId(), productNumber2);
		}

		// OrderStatus 저장
		OrderStatusDTO orderStatusRequest = new OrderStatusDTO();
		orderStatusRequest.setOrderId(paymentRequest.getOrder().getId());
		orderStatusRequest.setOrderStatus(paymentRequest.getOrder().getPaymentType().equals("vbank") ? "입금전" : "결제완료");
		paymentMapper.insertOrderStatus(orderStatusRequest);
	}
}
