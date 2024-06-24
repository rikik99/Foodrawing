package com.food.domain.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;

@Service
public class AdminService {

	public Page<ProductDTO> findProductListWithSearch(Map<String, String> convertEmptyStringsToNull) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page<ProductDTO> findProductList(PageRequest of) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ProductCategoryDTO> findCategoryList() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getNextProductNumber(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	public void insertProduct(Map<String, String> allParams, MultipartFile file) {
		// TODO Auto-generated method stub
		
	}

	public void deleteProductsByProductNumbers(List<String> productNumbers) {
		// TODO Auto-generated method stub
		
	}

}
