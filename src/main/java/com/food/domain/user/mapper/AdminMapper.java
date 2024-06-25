package com.food.domain.user.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.StockDTO;
import com.food.domain.product.dto.StockTransactionDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.sales.dto.SalesPostFileDTO;
import com.food.domain.user.dto.AdminDTO;

@Mapper
public interface AdminMapper {

	List<ProductDTO> findProductList();

	ProductFileDTO findProductFileByProductNumber(String productNumber);

	ProductCategoryDTO findProductCategoryByProductNumber(String productNumber);

	List<ProductCategoryDTO> findCategoryList();

	List<ProductDTO> findProductListByKeyword(Map<String, String> allParams);

	SalesPostDTO findSalesPostByProductNumber(String productNumber);

	ProductCategoryDTO getCategoryById(Long id);

	void insertProduct(Map<String, String> allParams);

	void insertProductFile(ProductFileDTO productFile);

	void updateCategoryById(Long categoryId);

	void insertProductCategoryMapping(String productNumber, Long categoryId);

	void deleteProductByProductNumber(String productNumber);

	StockDTO findStockListByProductNumber(String productNumber);

	List<ProductDTO> finddStockListByKeyword(Map<String, String> allParams);

	StockDTO findStockByProductNumber(String productNumber);

	void updateStock(Map<String, Object> params);

	void insertTransaction(Map<String, Object> allParams);

	StockTransactionDTO findTransactionByProductNumber(String productNumber);

	List<StockTransactionDTO> findTransaction();

	ProductDTO findProductByProductNumber(String productNumber);

	List<StockTransactionDTO> findTransactionList(String orderByClause, int pageSize, int offset);

	int countTransactionList();

	List<SalesPostDTO> findPostList();

	List<SalesPostDTO> findPostListWithSearch(Map<String, String> allParams);

	AdminDTO findAdminByAdminId(Long adminId);

	String findProductByName(String name);

	void insertSalesPost(SalesPostDTO salesPost);

	void insertSalesPostFile(SalesPostFileDTO fileDTO);
}
