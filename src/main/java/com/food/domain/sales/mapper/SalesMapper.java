package com.food.domain.sales.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.sales.dto.SalesPostDTO;

@Mapper
public interface SalesMapper {

	SalesPostDTO getSalesById(SalesPostDTO salesPost);

	Long getIdBySalesPostId(SalesPostDTO salesPost);

	String getIdByProductNumber(SalesPostDTO salesPost);

	SalesPostDTO findSalesPostById(Long id);

	//SalesPostFileDTO getSalesFileById(SalesPostDTO salesPost);

}
