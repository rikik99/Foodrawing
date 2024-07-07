package com.food.domain.sales.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.sales.dto.ReviewFileDTO;
import com.food.domain.sales.dto.ReviewReplyDTO;
import com.food.domain.sales.dto.SalesReviewDTO;
import com.food.domain.sales.mapper.ReviewMapper;
import com.food.domain.user.dto.CustomerDTO;

@Service
public class ReviewService {

	@Autowired
	private ReviewMapper reviewMapper;
	
	public List<SalesReviewDTO> getReviews(Long salesPostId, int page, int size) {
        int offset = (page - 1) * size;
        
        List<SalesReviewDTO> reviewInfo = reviewMapper.getReviews(salesPostId, offset, size);
        
        for(int i = 0; i < reviewInfo.size(); i++) {
        	//회원 정보
        	CustomerDTO customer = reviewMapper.getCustomer(reviewInfo.get(i).getCustomerId());
        	reviewInfo.get(i).setCustomer(customer);
        	
        	//리뷰 파일
        	ReviewFileDTO file = reviewMapper.getFileBySalesPostId(reviewInfo.get(i).getId());
        	
        	if (file != null) {
        		reviewInfo.get(i).setFiles(file);
        	}
        	
        	//리뷰 답변
        	if (reviewInfo.get(i).getReplyYn().equals("Y")) {
        		ReviewReplyDTO reply = reviewMapper.getReplyBySalesPostId(reviewInfo.get(i).getId());
        		reviewInfo.get(i).setReply(reply);
        	}
        }
        
        return reviewInfo;
    }

    public int countReviews(Long salesPostId) {
        return reviewMapper.countReviews(salesPostId);
    }

}
