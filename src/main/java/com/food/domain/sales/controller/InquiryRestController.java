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

import com.food.domain.sales.dto.ProductInquiryDTO;
import com.food.domain.sales.service.InquiryService;

@RestController
@RequestMapping("/inquiries")
public class InquiryRestController {

	@Autowired
    private InquiryService inquiryService;

	@GetMapping("/{salesPostId}")
    public Map<String, Object> getInquiries(@PathVariable Long salesPostId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        List<ProductInquiryDTO> inquiries = inquiryService.getInquiries(salesPostId, page, size);
        int totalInquiries = inquiryService.countInquiries(salesPostId);
        int totalPages = (int) Math.ceil((double) totalInquiries / size);

        Map<String, Object> response = new HashMap<>();
        response.put("inquiries", inquiries);
        response.put("totalInquiries", totalInquiries);
        response.put("totalPages", totalPages);
        response.put("currentPage", page);

        return response;
    }
}
