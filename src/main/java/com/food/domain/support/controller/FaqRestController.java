package com.food.domain.support.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.support.dto.FaqDTO;
import com.food.domain.support.service.FaqService;

@RestController
public class FaqRestController {
	
	@Autowired
    private FaqService faqService;

    @PostMapping("/cs/csMain")
    public Map<String, Object> getFaqs(@RequestBody Map<String, Object> params) {
        String query = (String) params.get("query");
        int page = (int) params.get("page");
        int size = 10; // 페이지당 항목 수

        List<FaqDTO> faqs = faqService.searchFaqs(query, (page - 1) * size, size);
        int totalFaqs = faqService.countFaqs(query);
        
        System.out.println("faqs" + faqs);
        System.out.println("totalFaqs" + totalFaqs);

        Map<String, Object> response = new HashMap<>();
        response.put("faqs", faqs);
        response.put("totalPages", (int) Math.ceil((double) totalFaqs / size));
        return response;
    }
}

