package com.food.domain.sales.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.sales.dto.ProductInquiryDTO;
import com.food.domain.support.dto.InquiriesDTO;
import com.food.domain.support.dto.ResponseDTO;
import com.food.domain.user.dto.CustomerDTO;

@Mapper
public interface InquiryMapper {
	List<ProductInquiryDTO> getInquiries(@Param("salesPostId") Long salesPostId, @Param("offset") int offset, @Param("limit") int limit);
	
    int countInquiries(@Param("salesPostId") Long salesPostId);

	ResponseDTO getResponseByInquiriesId(Long inquiriesId);

	CustomerDTO getCustomer(Long customerId);
	
	void insertInquiry(InquiriesDTO inquiry);
}
