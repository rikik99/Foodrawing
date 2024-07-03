package com.food.domain.sales.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.sales.dto.ProductInquiryDTO;
import com.food.domain.sales.mapper.InquiryMapper;

@Service
public class InquiryService {
		
	@Autowired
    private InquiryMapper inquiryMapper;

	public List<ProductInquiryDTO> getInquiries(Long salesPostId, int page, int size) {
        int offset = (page - 1) * size;
        List<ProductInquiryDTO> inquiries = inquiryMapper.getInquiries(salesPostId, offset, size);
        
        for(int i = 0; i < inquiries.size(); i++) {
        	if(inquiries.get(i).getResolvedYn().equals("Y")) {
        		inquiries.get(i).setResponses(inquiryMapper.getResponseByInquiriesId(inquiries.get(i).getId()));
        	}
        	
        	inquiries.get(i).setCustomer(inquiryMapper.getCustomer(inquiries.get(i).getCustomerId()));
        }
        
        System.out.println("inquiries: " + inquiries);
        
        return inquiries;
    }

    public int countInquiries(Long salesPostId) {
        return inquiryMapper.countInquiries(salesPostId);
    }
}
