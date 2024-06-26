package com.food.domain.sales.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.sales.dto.SalesPostFileDTO;

@Mapper
public interface SalesMapper {

	SalesPostDTO getSalesById(SalesPostDTO salesPost);

	Long getIdBySalesPostId(SalesPostDTO salesPost);

	String getIdByProductNumber(SalesPostDTO salesPost);

	//SalesPostFileDTO getSalesFileById(SalesPostDTO salesPost);

}
