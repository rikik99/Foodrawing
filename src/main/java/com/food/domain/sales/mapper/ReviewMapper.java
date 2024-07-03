package com.food.domain.sales.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.sales.dto.ReviewFileDTO;
import com.food.domain.sales.dto.ReviewReplyDTO;
import com.food.domain.sales.dto.SalesReviewDTO;
import com.food.domain.user.dto.CustomerDTO;

@Mapper
public interface ReviewMapper {
	List<SalesReviewDTO> getReviews(@Param("salesPostId") Long salesPostId, @Param("offset") int offset, @Param("limit") int limit);
    
	int countReviews(@Param("salesPostId") Long long1);
	
	ReviewFileDTO getFileBySalesPostId(Long salesPostId);

	ReviewReplyDTO getReplyBySalesPostId(Long reviewId);

	CustomerDTO getCustomer(Long customerId);
	
    double getAverageRating(Long salesPostId);
    
    Map<Integer, Integer> getRatingDistribution(Long salesPostId);
    
    int[] getRatingDistributionArray(Long salesPostId);

	int getRatingPercentages(Long salesPostId, int i);
}
