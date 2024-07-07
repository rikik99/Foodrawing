package com.food.domain.product.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.product.dto.BestDTO;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductCategoryMappingDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.mapper.BestMapper;
import com.food.domain.product.mapper.CategoryMapper;
import com.food.domain.product.mapper.ProductMainMapper;
import com.food.domain.sales.dto.Discount2DTO;
import com.food.domain.sales.mapper.DiscountMapper; // 추가된 부분

@Service
public class ProductMainService {
    private final ProductMainMapper productMainMapper;
    private final CategoryMapper categoryMapper;
    private final BestMapper bestMapper;
    private final DiscountMapper discountMapper; // 추가된 부분

    @Autowired
    public ProductMainService(ProductMainMapper productMainMapper, CategoryMapper categoryMapper, BestMapper bestMapper, DiscountMapper discountMapper) {
        this.productMainMapper = productMainMapper;
        this.categoryMapper = categoryMapper;
        this.bestMapper = bestMapper;
        this.discountMapper = discountMapper; // 추가된 부분
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

    public List<BestDTO> getBestSellingProducts() {
        return bestMapper.selectBestSellingProducts();
    }

    public List<Discount2DTO> getDiscountProducts() { // 추가된 메서드
        return discountMapper.findDiscountProductsQuery();
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
