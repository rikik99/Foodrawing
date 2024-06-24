package com.food.domain.product.service;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductCategoryMappingDTO;
import com.food.domain.product.mapper.ProductMainMapper;
import com.food.domain.product.mapper.CategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductMainService {
	private final ProductMainMapper productMainMapper;
	private final CategoryMapper categoryMapper;

	@Autowired
	public ProductMainService(ProductMainMapper productMainMapper, CategoryMapper categoryMapper) {
		this.productMainMapper = productMainMapper;
		this.categoryMapper = categoryMapper;
	}

	public List<ProductDTO> getAllProducts() {
		List<ProductDTO> products = productMainMapper.selectAllProducts();
		return addFileInfoToProducts(products);
	}

	public List<ProductFileDTO> getAllProductFiles() {
		return productMainMapper.selectAllProductFiles();
	}

	public List<ProductDTO> getProductsByCategory(int categoryId) {
		List<ProductDTO> products = productMainMapper.findProductsByCategory(categoryId);
		return addFileInfoToProducts(products);
	}

	public List<ProductCategoryDTO> getAllCategories() {
		return categoryMapper.selectAllCategories();
	}

	public List<ProductCategoryMappingDTO> getCategoryMappingByProductNumber(String productNumber) {
		return categoryMapper.selectCategoryMappingByProductNumber(productNumber);
	}

	private List<ProductDTO> addFileInfoToProducts(List<ProductDTO> products) {
		List<ProductDTO> productList = new ArrayList<>();
		for (ProductDTO product : products) {
			String productNumber = product.getProductNumber();
			ProductFileDTO productFile = productMainMapper.fileByResults(productNumber);
			product.setProductFileDTO(productFile);
			productList.add(product);
		}
		return productList;
	}
}
