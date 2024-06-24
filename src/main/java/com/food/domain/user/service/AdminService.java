package com.food.domain.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.StockDTO;
import com.food.domain.product.dto.StockTransactionDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.user.mapper.AdminMapper;
import com.food.global.util.ProductFile;

import jakarta.transaction.Transactional;

@Service
public class AdminService {

	@Autowired
	AdminMapper adminMapper;

	@Autowired
	ProductFile productFileUtil;

	public Page<ProductDTO> findProductList(Pageable pageable) {
		List<ProductDTO> products = adminMapper.findProductList();
		List<ProductDTO> productList = new ArrayList<>();

		for (ProductDTO productDTO : products) {
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

		for (ProductDTO productDTO : products) {
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

	public String getNextProductNumber(Long id) {
		ProductCategoryDTO category = adminMapper.getCategoryById(id);
		Long nextVal = category.getNextVal();
		return category.getCategoryCode() + String.format("%03d", nextVal);
	}

	@Transactional
	public void insertProduct(Map<String, String> allParams, MultipartFile file) {
		Long categoryId = Long.valueOf(allParams.get("category"));
		String productNumber = allParams.get("productNumber");
		adminMapper.insertProduct(allParams);
		try {
			// 파일 정보 파싱 및 삽입
			ProductFileDTO productFile = productFileUtil.parseFileInfo(productNumber, file);
			if (productFile != null) {
				adminMapper.insertProductFile(productFile);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		adminMapper.insertProductCategoryMapping(productNumber, categoryId);
		adminMapper.updateCategoryById(categoryId);

	}

    public void deleteProductsByProductNumbers(List<String> productNumbers) throws Exception {
        for (String productNumber : productNumbers) {
        	adminMapper.deleteProductByProductNumber(productNumber);
        }
    }

	public Page<ProductDTO> findStockListWithSearch(Map<String, String> allParams) {
		int page = Integer.parseInt((String) allParams.get("page"));
		int size = Integer.parseInt((String) allParams.get("size"));
		Pageable pageable = PageRequest.of(page, size);

		List<ProductDTO> products = adminMapper.finddStockListByKeyword(allParams);
		System.out.println("allParams = " + allParams);
		System.out.println("products = " + products);
		List<ProductDTO> productList = new ArrayList<>();

		for (ProductDTO productDTO : products) {
			String productNumber = productDTO.getProductNumber();
			ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
			ProductCategoryDTO category = adminMapper.findProductCategoryByProductNumber(productNumber);
			SalesPostDTO salesPost = adminMapper.findSalesPostByProductNumber(productNumber);
			StockDTO stock = adminMapper.findStockListByProductNumber(productNumber);
			productDTO.setProductFileDTO(file);
			productDTO.setProductCategoryDTO(category);
			productDTO.setSalesPostDTO(salesPost);
			productDTO.setStockDTO(stock);
			productList.add(productDTO);
		}
		System.out.println("productList = " + productList);
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), productList.size());
		return new PageImpl<>(productList.subList(start, end), pageable, productList.size());
	}

	public Page<ProductDTO> findStockList(Pageable pageable) {
		
		List<ProductDTO> products = adminMapper.findProductList();
		List<ProductDTO> productList = new ArrayList<>();

		for (ProductDTO productDTO : products) {
			String productNumber = productDTO.getProductNumber();
			ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
			ProductCategoryDTO category = adminMapper.findProductCategoryByProductNumber(productNumber);
			SalesPostDTO salesPost = adminMapper.findSalesPostByProductNumber(productNumber);
			StockDTO stock = adminMapper.findStockListByProductNumber(productNumber);
			productDTO.setProductFileDTO(file);
			productDTO.setProductCategoryDTO(category);
			productDTO.setSalesPostDTO(salesPost);
			productDTO.setStockDTO(stock);
			productList.add(productDTO);
		}

		// 페이지 객체 생성
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), productList.size());
		Page<ProductDTO> page = new PageImpl<>(productList.subList(start, end), pageable, productList.size());

		return page;
	}
	
	@Transactional
	public void stockUpdate(Map<String, Object> allParams) {
	    String productNumber = (String) allParams.get("productNumber");
	    String type = (String) allParams.get("type");
	    Long quantity = Long.valueOf((String) allParams.get("quantity"));

	    // 현재 재고 조회
	    StockDTO currentStock = adminMapper.findStockByProductNumber(productNumber);
	    Long updatedQuantity = currentStock.getQuantity();

	    if ("IN".equals(type)) {
	        updatedQuantity += quantity;
	    } else if ("OUT".equals(type)) {
	        updatedQuantity -= quantity;
	        // 재고가 0 이하가 되지 않도록 처리
	        if (updatedQuantity < 0) {
	            updatedQuantity = 0L;
	        }
	    }

	    // 재고 업데이트
	    allParams.put("updatedQuantity", updatedQuantity);
	    adminMapper.updateStock(allParams);
	    adminMapper.insertTransaction(allParams);
	}

	public Page<StockTransactionDTO> findTransactionList(Pageable pageable) {
	    List<StockTransactionDTO> transactions = adminMapper.findTransaction();
	    List<StockTransactionDTO> transactionList = new ArrayList<>();
	    for(StockTransactionDTO transaction : transactions) {
	        String productNumber = transaction.getProductNumber();
	        ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
	        ProductDTO product = adminMapper.findProductByProductNumber(productNumber);
	        transaction.setProductFileDTO(file);
	        transaction.setProductDTO(product);
	        transactionList.add(transaction);
	    }
	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), transactionList.size());
	    Page<StockTransactionDTO> page = new PageImpl<>(transactionList.subList(start, end), pageable, transactionList.size());
	    return page;
	}



}
