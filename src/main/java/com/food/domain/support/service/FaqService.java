package com.food.domain.support.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.support.dto.FaqDTO;
import com.food.domain.support.entity.Faq;
import com.food.domain.support.mapper.FaqMapper;

@Service
public class FaqService {
	
	@Autowired
    private FaqMapper faqMapper;

	public List<FaqDTO> searchFaqs(String query, int offset, int size) {
        return faqMapper.search(query, offset, size);
    }

    public int countFaqs(String query) {
        return faqMapper.count(query);
    }
}