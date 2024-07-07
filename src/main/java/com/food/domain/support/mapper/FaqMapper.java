package com.food.domain.support.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.support.dto.FaqDTO;

@Mapper
public interface FaqMapper {
	List<FaqDTO> search(@Param("query") String query, @Param("offset") int offset, @Param("size") int size);
    
	int count(@Param("query") String query);
}
