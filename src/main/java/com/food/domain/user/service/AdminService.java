package com.food.domain.user.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import com.food.domain.sales.dto.SalesPostFileDTO;
import com.food.domain.user.dto.AdminDTO;
import com.food.domain.user.mapper.AdminMapper;
import com.food.global.util.ProductFile;
import com.food.global.util.SalesPostFile;

import jakarta.transaction.Transactional;

@Service
public class AdminService {

	@Autowired
	AdminMapper adminMapper;

	@Autowired
	ProductFile productFileUtil;

	@Autowired
	SalesPostFile salesPostFileUtil;

    @Value("${file.upload-dir}")
    private String uploadDir;
	
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
        String orderByClause = pageable.getSort().stream()
                .map(order -> {
                    String property = order.getProperty();
                    String direction = order.getDirection().name();
                    if ("productNumber".equals(property)) {
                        return "TO_NUMBER(REGEXP_SUBSTR(PRODUCT_NUMBER, '[0-9]+')) " + direction;
                    } else {
                        return property + " " + direction;
                    }
                })
                .collect(Collectors.joining(", "));

        int pageSize = pageable.getPageSize();
        int offset = (int) pageable.getOffset() + 1; // Oracle에서는 1부터 시작
        System.out.println("orderByClause = "+orderByClause);
        List<StockTransactionDTO> transactions = adminMapper.findTransactionList(orderByClause, pageSize, offset);
        int totalElements = adminMapper.countTransactionList(); // 전체 레코드 수 가져오기

        for (StockTransactionDTO transaction : transactions) {
            String productNumber = transaction.getProductNumber();
            ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
            ProductDTO product = adminMapper.findProductByProductNumber(productNumber);
            transaction.setProductFileDTO(file);
            transaction.setProductDTO(product);
        }

        Page<StockTransactionDTO> page = new PageImpl<>(transactions, pageable, totalElements);
        return page;
    }

	public Page<SalesPostDTO> findPostList(Pageable pageable) {
		List<SalesPostDTO> posts = adminMapper.findPostList();
		List<SalesPostDTO> postList = new ArrayList<>();

		for (SalesPostDTO salesPostDTO : posts) {
			String productNumber = salesPostDTO.getProductNumber();
			Long adminId = salesPostDTO.getAdminId();
			ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
			ProductDTO productDTO = adminMapper.findProductByProductNumber(productNumber);
			AdminDTO admin = adminMapper.findAdminByAdminId(adminId);
			productDTO.setProductFileDTO(file);
			salesPostDTO.setProductDTO(productDTO);
			salesPostDTO.setAdminDTO(admin);
			postList.add(salesPostDTO);
		}

		// 페이지 객체 생성
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), postList.size());
		Page<SalesPostDTO> page = new PageImpl<>(postList.subList(start, end), pageable, postList.size());

		return page;
	}

	public Page<SalesPostDTO> findPostListWithSearch(Map<String, String> allParams) {
		int page = Integer.parseInt((String) allParams.get("page"));
		int size = Integer.parseInt((String) allParams.get("size"));
		Pageable pageable = PageRequest.of(page, size);

		List<SalesPostDTO> posts = adminMapper.findPostListWithSearch(allParams);
		List<SalesPostDTO> postList = new ArrayList<>();

		for (SalesPostDTO salesPostDTO : posts) {
			String productNumber = salesPostDTO.getProductNumber();
			Long adminId = salesPostDTO.getAdminId();
			AdminDTO admin = adminMapper.findAdminByAdminId(adminId);
			ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
			ProductDTO productDTO = adminMapper.findProductByProductNumber(productNumber);
			productDTO.setProductFileDTO(file);
			salesPostDTO.setProductDTO(productDTO);
			salesPostDTO.setAdminDTO(admin);
			postList.add(salesPostDTO);
		}
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), postList.size());
		return new PageImpl<>(postList.subList(start, end), pageable, postList.size());
	}

	public List<ProductDTO> findProducts() {
		List<ProductDTO> products = adminMapper.findProductList();
		return products;
	}

	public Map<String, String> getProductDetails(String name) {
	    Map<String, String> details = new HashMap<>();
	    String productCode = adminMapper.findProductByName(name);
	    ProductFileDTO productFileDTO = adminMapper.findProductFileByProductNumber(productCode);
	    String filePath = productFileDTO.getFilePath();
	    details.put("productCode", productCode);
	    details.put("imagePath", filePath);
	    return details;
	}

	   public List<SalesPostFileDTO> uploadImages(Long salesPostId, MultipartFile[] files) throws Exception {
	        return salesPostFileUtil.parseFileInfos(salesPostId, files);
	    }

	    public SalesPostFileDTO uploadImage(MultipartFile file) throws Exception {
	        List<SalesPostFileDTO> fileDTOList = salesPostFileUtil.parseFileInfos(null, new MultipartFile[]{file});
	        System.out.println(fileDTOList.get(0));
	        return fileDTOList.get(0);
	    }

	    public void insertSalesPost(Map<String, String> allParams, List<SalesPostFileDTO> fileDTOList) throws Exception {
	        SalesPostDTO salesPost = new SalesPostDTO();
	        String statusString = allParams.get("status");
	        try {
	            Long status = Long.parseLong(statusString);
	            salesPost.setStatus(status);
	        } catch (NumberFormatException e) {
	            // 변환 실패 시의 처리 로직 (예: 기본값 설정 또는 예외 처리)
	        	salesPost.setStatus(null); // 또는 적절한 기본값 설정
	        }
	        salesPost.setAdminId(Long.parseLong(allParams.get("adminId")));
	        salesPost.setProductNumber(allParams.get("productNumber"));
	        salesPost.setTitle(allParams.get("title"));
	        salesPost.setDescription(allParams.get("description"));
	        salesPost.setCreatedDate(LocalDateTime.now());
	        salesPost.setLastPostDate(LocalDateTime.parse(allParams.get("lastPostDate")));
	        salesPost.setUpdatedDate(LocalDateTime.now());
	        salesPost.setStartPostDate(LocalDateTime.parse(allParams.get("startPostDate")));

	        // 판매글 등록
	        adminMapper.insertSalesPost(salesPost);

	        // 판매글 파일 정보 등록
	        for (SalesPostFileDTO fileDTO : fileDTOList) {
	            fileDTO.setSalesPostId(salesPost.getId());
	            adminMapper.insertSalesPostFile(fileDTO);
	        }
	    }
}