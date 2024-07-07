package com.food.domain.user.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.order.dto.DeliveryDTO;
import com.food.domain.order.dto.GuestCartDTO;
import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderDetailDTO;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.user.dto.GuestDTO;

@Mapper
public interface GuestMapper {

	String findLastGuestIdByDate(LocalDate today);

	void insertGuestId(String newGuestId, LocalDate today);

	void updateCart(GuestCartDTO cart);

	void insertCart(GuestCartDTO cart);

	void deleteByCustomerIdAndProductNumber(String string, String productNumber);

	int isInCart(String productNumber, String guestId);

	Optional<GuestCartDTO> findByCustomerIdAndProductId(String guestId, String productNumber);

	void updateCartItem(GuestCartDTO cart);

	OrderDTO getGuestByOrderNumberAndName(String orderNumber);

	List<OrderDetailDTO> getOrderDetailsByOrderNumber(OrderDTO order);

	OrderStatusDTO getOrderStatusByOrderNumber(Long orderId);

	DeliveryDTO getDeliveryByOrderId(Long orderId);

}
