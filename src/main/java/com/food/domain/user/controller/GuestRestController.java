package com.food.domain.user.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.order.dto.CheckoutRequestDTO;
import com.food.domain.order.dto.GuestCartResponseDTO;
import com.food.domain.order.dto.GuestRequestDTO;
import com.food.domain.user.service.GuestService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/guest")
public class GuestRestController {
	
	@Autowired
    private GuestService guestService;
	
	@RequestMapping("/id")
	public ResponseEntity<Map<String, String>> getGuestId() {
        String guestId = guestService.generateNewGuestId();
        System.out.println("guestId: " + guestId);
        Map<String, String> response = new HashMap<>();
        response.put("guestId", guestId);
        return ResponseEntity.ok(response);
    }
	
	@PostMapping("/cart/checkStock")
    public ResponseEntity<GuestCartResponseDTO> checkStock(@RequestBody GuestRequestDTO guestRequest) {
        try {
        	GuestCartResponseDTO response = guestService.checkStock(guestRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new GuestCartResponseDTO(false, false, false));
        }
    }

    @PostMapping("/cart/addToCart")
    public ResponseEntity<GuestCartResponseDTO> addToCart(@RequestBody GuestRequestDTO guestRequest) {
        try {
        	GuestCartResponseDTO response = guestService.addToCart(guestRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new GuestCartResponseDTO(false, false, false));
        }
    }

    @PostMapping("/cart/updateCartItem")
    public ResponseEntity<GuestCartResponseDTO> updateCartItem(@RequestBody GuestRequestDTO guestRequest) {
        try {
        	GuestCartResponseDTO response = guestService.updateCartItem(guestRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new GuestCartResponseDTO(false, false, false));
        }
    }

    @PostMapping("/cart/deleteCartItem")
    public ResponseEntity<Map<String, Object>> deleteCartItem(@RequestBody GuestRequestDTO guestRequest) {
        try {
            guestService.deleteCartItem(guestRequest);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "Internal server error");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/deleteSelectedItems")
    public ResponseEntity<Void> deleteSelectedItems(@RequestBody GuestRequestDTO guestRequest) {
        try {
            guestService.deleteSelectedItems(guestRequest);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
