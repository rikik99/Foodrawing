package com.food.domain.order.dto;

import java.util.ArrayList;
import java.util.List;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;

import lombok.Data;

@Data
public class OrderDetailInfoDTO {
	private List<OrderDetailDTO> orderDetail;
	private List<ProductDTO> product;
	private List<ProductFileDTO> productFile;
	
	public OrderDetailInfoDTO() {
		this.product = new ArrayList<>();
		this.productFile = new ArrayList<>();
		this.orderDetail = new ArrayList<>();
	}
}
