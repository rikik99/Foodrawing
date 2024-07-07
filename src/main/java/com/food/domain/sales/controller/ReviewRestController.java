package com.food.domain.sales.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.sales.dto.SalesReviewDTO;
import com.food.domain.sales.service.ReviewService;

@RestController
@RequestMapping("/reviews")
public class ReviewRestController {
	@Autowired
	private ReviewService reviewService;

	@GetMapping("/{salesPostId}")
	public Map<String, Object> getReviews(@PathVariable Long salesPostId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
		List<SalesReviewDTO> reviews = reviewService.getReviews(salesPostId, page, size);
		int totalReviews = reviewService.countReviews(salesPostId);
		int totalPages = (int) Math.ceil((double) totalReviews / size);
		
		System.out.println("reviews: " + reviews);
		
		Map<String, Object> response = new HashMap<>();
		response.put("reviews", reviews);
		response.put("totalReviews", totalReviews);
		response.put("totalPages", totalPages);
		response.put("currentPage", page);
		
		return response;
	}
}
