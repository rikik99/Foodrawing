package com.food.domain.user.dto;

import java.util.ArrayList;
import java.util.List;

import com.food.domain.order.dto.DeliveryDTO;
import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderDetailDTO;
import com.food.domain.order.dto.OrderDetailInfoDTO;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GuestOrderInfoDTO {
	private GuestDTO guest;
	private OrderDTO order;
	private OrderStatusDTO orderStatus;
	private DeliveryDTO delivery;
	private List<ProductDTO> product;
	private List<ProductFileDTO> productFile;
	private List<OrderDetailDTO> orderDetail;
	private List<OrderDetailInfoDTO> orderDetailInfo;

	// 기본 생성자 추가
	public GuestOrderInfoDTO() {
		this.guest = new GuestDTO();
		this.order = new OrderDTO();
		this.orderStatus = new OrderStatusDTO();
		this.delivery = new DeliveryDTO();
		this.product = new ArrayList<>();
		this.productFile = new ArrayList<>();
		this.orderDetail = new ArrayList<>();
		this.orderDetailInfo = new ArrayList<>();
	}
}
