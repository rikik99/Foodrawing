package com.food.domain.user.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.sales.dto.SalesPostDTO;
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
	        SalesPostDTO salesPost = adminMapper.findSalesPostByProductNumber(productNumber);
	        productDTO.setProductFileDTO(file);
	        productDTO.setProductCategoryDTO(category);
	        productDTO.setSalesPostDTO(salesPost);
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

	public Page<ProductDTO> findProductListWithSearch(Map<String, String> allParams) {
        int page = Integer.parseInt((String) allParams.get("page"));
        int size = Integer.parseInt((String) allParams.get("size"));
        Pageable pageable = PageRequest.of(page, size);
        
	    List<ProductDTO> products = adminMapper.findProductListByKeyword(allParams);
	    System.out.println("allParams = " + allParams);
	    System.out.println("products = " + products);
	    List<ProductDTO> productList = new ArrayList<>();
	    
	    for(ProductDTO productDTO : products) {
	        String productNumber = productDTO.getProductNumber();
	        ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
	        ProductCategoryDTO category = adminMapper.findProductCategoryByProductNumber(productNumber);
	        SalesPostDTO salesPost = adminMapper.findSalesPostByProductNumber(productNumber);
	        productDTO.setProductFileDTO(file);
	        productDTO.setProductCategoryDTO(category);
	        productDTO.setSalesPostDTO(salesPost);
	        productList.add(productDTO);
	    }
	    System.out.println("productList = " + productList);
	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), productList.size());
	    return new PageImpl<>(productList.subList(start, end), pageable, productList.size());
	}

}
