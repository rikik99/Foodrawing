package com.food.domain.user.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.user.mapper.AdminMapper;

@Service
public class AdminService {

	@Autowired
	AdminMapper adminMapper;
	
	public Page<ProductDTO> findProductList(Pageable pageable) {
	    List<ProductDTO> products = adminMapper.findProductList();
	    List<ProductDTO> productList = new ArrayList<>();
	    
	    for(ProductDTO productDTO : products) {
	        String productNumber = productDTO.getProductNumber();
	        ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
	        ProductCategoryDTO category = adminMapper.findProductCategoryByProductNumber(productNumber);
	        productDTO.setProductFileDTO(file);
	        productDTO.setProductCategoryDTO(category);
	        productList.add(productDTO);
	    }
	    
	    // 페이지 객체 생성
	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), productList.size());
	    Page<ProductDTO> page = new PageImpl<>(productList.subList(start, end), pageable, productList.size());
	    
	    return page;
	}

	public List<ProductCategoryDTO> findCategoryList() {
		List<ProductCategoryDTO> categoryList = adminMapper.findCategoryList();
		return categoryList;
	}

}
