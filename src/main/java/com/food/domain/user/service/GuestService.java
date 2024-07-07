package com.food.domain.user.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.food.domain.order.dto.GuestCartDTO;
import com.food.domain.order.dto.GuestCartResponseDTO;
import com.food.domain.order.dto.GuestRequestDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.mapper.ProductMapper;
import com.food.domain.user.dto.GuestDTO;
import com.food.domain.user.mapper.CustomerMapper;
import com.food.domain.user.mapper.GuestMapper;

@Service
public class GuestService {

	@Autowired
	private GuestMapper guestMapper;
	@Autowired
	private ProductMapper productMapper;
	@Autowired
	private CustomerMapper customerMapper;

	@Transactional
	public String generateNewGuestId() {
		LocalDate today = LocalDate.now();
		String lastGuestId = guestMapper.findLastGuestIdByDate(today);

		String newGuestId;
		if (lastGuestId == null) {
			newGuestId = "GUEST" + today.format(DateTimeFormatter.ofPattern("yyyyMMdd")) + "1";
			guestMapper.insertGuestId(newGuestId, today);
		} else {
			int lastIdNumber = Integer.parseInt(lastGuestId.substring(13));
			newGuestId = "GUEST" + today.format(DateTimeFormatter.ofPattern("yyyyMMdd")) + (lastIdNumber + 1);
		}


		return newGuestId;
	}

	public GuestCartResponseDTO checkStock(GuestRequestDTO guestRequest) {
        ProductDTO product = productMapper.findById(guestRequest.getProductNumber());
        if (product == null) {
            return new GuestCartResponseDTO(false, false, false);
        }

        if (product.getQuantity() < guestRequest.getQuantity()) {
            return new GuestCartResponseDTO(false, false, false);
        }

        System.out.println("guestRequest: " + guestRequest);
        
        int inCart = guestMapper.isInCart(guestRequest.getProductNumber(), guestRequest.getGuestId());
        boolean cart = (inCart == 1) ? true : false; 
        return new GuestCartResponseDTO(true, true, cart);
    }

    public GuestCartResponseDTO addToCart(GuestRequestDTO guestRequest) {
        ProductDTO product = productMapper.findById(guestRequest.getProductNumber());
        if (product == null) {
            return new GuestCartResponseDTO(false, false, false);
        }

        int inCart = guestMapper.isInCart(guestRequest.getProductNumber(), guestRequest.getGuestId());
        if (inCart == 1) {
            GuestCartDTO cart = guestMapper.findByCustomerIdAndProductId(guestRequest.getGuestId(), guestRequest.getProductNumber()).get();
            cart.setQuantity(cart.getQuantity() + guestRequest.getQuantity());
            cart.setLastDate(LocalDateTime.now());
            guestMapper.updateCartItem(cart);
        } else {
            GuestCartDTO cart = GuestCartDTO.builder()
                .guestId(guestRequest.getGuestId())
                .productNumber(guestRequest.getProductNumber())
                .quantity((long) guestRequest.getQuantity())
                .lastDate(LocalDateTime.now())
                .build();
            guestMapper.insertCart(cart);
        }

        return new GuestCartResponseDTO(true, true, true);
    }

	public GuestCartResponseDTO updateCartItem(GuestRequestDTO guestRequest) {
		System.out.println("cartRequest = " + guestRequest);
		Optional<GuestCartDTO> cartOptional = guestMapper.findByCustomerIdAndProductId(guestRequest.getGuestId(),
				guestRequest.getProductNumber());
		if (cartOptional.isPresent()) {
			GuestCartDTO cart = cartOptional.get();
			cart.setQuantity((long) guestRequest.getQuantity());
			cart.setLastDate(LocalDateTime.now());
			guestMapper.updateCartItem(cart);
			return new GuestCartResponseDTO(true, true, true);
		} else {
			return new GuestCartResponseDTO(false, false, false);
		}
	}

	public void deleteCartItem(GuestRequestDTO guestRequest) {
		guestMapper.deleteByCustomerIdAndProductNumber(guestRequest.getGuestId(), guestRequest.getProductNumber());
	}

	public void deleteSelectedItems(GuestRequestDTO guestRequest) {
		for (String productNumber : guestRequest.getProductNumbers()) {
			guestMapper.deleteByCustomerIdAndProductNumber(guestRequest.getGuestId(), productNumber);
		}
	}

	public void checkoutSelectedItems(GuestRequestDTO guestRequest) {
		// 선택된 아이템을 주문 처리하는 로직 구현
		for (String productNumber : guestRequest.getProductNumbers()) {
			guestMapper.deleteByCustomerIdAndProductNumber(guestRequest.getGuestId(), productNumber);
		}
	}
}
