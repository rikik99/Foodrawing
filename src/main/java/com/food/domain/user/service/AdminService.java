package com.food.domain.user.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.StockDTO;
import com.food.domain.product.dto.StockTransactionDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.sales.dto.SalesPostFileDTO;
import com.food.domain.support.dto.InquiriesDTO;
import com.food.domain.user.dto.AdminDTO;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.mapper.AdminMapper;
import com.food.global.auth.CustomUserDetails;
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
		int page = Integer.parseInt(String.valueOf(allParams.get("page")));
		int size = Integer.parseInt(String.valueOf(allParams.get("size")));
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
	    System.out.println("type = ?"+type);
	    // 재고 업데이트
	    allParams.put("updatedQuantity", updatedQuantity);
	    adminMapper.updateStock(allParams);
	    ProductDTO productDTO = adminMapper.findProductByProductNumber(productNumber);
	    Long productQuantity = productDTO.getQuantity();
	    if("OUT".equals(type)) {
	    	productQuantity += quantity;
	    	allParams.put("productQuantity", productQuantity);
	    	adminMapper.updateQuantity(allParams);	    	
	    }
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
	        return salesPostFileUtil.parseFileInfos(null, new MultipartFile[]{file}).stream()
	                .findFirst()
	                .orElseThrow(() -> new Exception("File upload failed"));
	    }
	    @Transactional
	    public void insertSalesPost(Map<String, Object> allParams, List<SalesPostFileDTO> fileDTOList) throws Exception {
	        Long userId = null;
	        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        if (authentication != null && authentication.getPrincipal() instanceof CustomUserDetails) {
	            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
	            userId = userDetails.getId();
	        }
	        Long adminId = adminMapper.findAdminByUserId(userId);

	        SalesPostDTO salesPost = new SalesPostDTO();
	        salesPost.setAdminId(adminId);
	        salesPost.setProductNumber((String) allParams.get("productNumber"));
	        salesPost.setTitle((String) allParams.get("title"));
	        salesPost.setDescription((String) allParams.get("description"));
	        salesPost.setCreatedDate(LocalDateTime.now());
	        salesPost.setLastPostDate(LocalDate.parse((String) allParams.get("lastPostDate"), DateTimeFormatter.ISO_DATE).atStartOfDay());
	        salesPost.setUpdatedDate(LocalDateTime.now());
	        salesPost.setStartPostDate(LocalDate.parse((String) allParams.get("startPostDate"), DateTimeFormatter.ISO_DATE).atStartOfDay());
	        salesPost.setStatus(Long.parseLong((String) allParams.get("status")));

	        // 판매글 저장
	        adminMapper.insertSalesPost(salesPost);

	        // 저장된 판매글의 ID 가져오기
	        Long salesPostId = salesPost.getId();
	        if (salesPostId == null) {
	            throw new RuntimeException("Failed to retrieve generated sales post ID");
	        }

	        // 파일 정보 업데이트 및 저장
	        for (SalesPostFileDTO fileDTO : fileDTOList) {
	            fileDTO.setSalesPostId(salesPostId);
	            adminMapper.insertSalesPostFile(fileDTO);
	        }
	    }

		public Page<InquiriesDTO> findInquiries(Pageable pageable, Map<String, String> allParams) {
			List<InquiriesDTO> inquiries = adminMapper.findSalesInquiries();
			List<InquiriesDTO> inquirieList = new ArrayList<>();
			for(InquiriesDTO Inquiry : inquiries) {
				Long salesPostId = Inquiry.getSalesPostId();
				SalesPostDTO salesPotDTO = adminMapper.findSalesPostById(salesPostId);
				String productNumber = salesPotDTO.getProductNumber();
				ProductDTO productDTO = adminMapper.findProductByProductNumber(productNumber);
				Long customerId = Inquiry.getCustomerId();
				CustomerDTO customerDTO = adminMapper.findCustomerByCustomerId(customerId);
				Inquiry.setSalesPotDTO(salesPotDTO);
				Inquiry.setProductDTO(productDTO);
				Inquiry.setCustomerDTO(customerDTO);
				inquirieList.add(Inquiry);
			}
						
			int start = (int) pageable.getOffset();
			int end = Math.min((start + pageable.getPageSize()), inquirieList.size());
			Page<InquiriesDTO> page = new PageImpl<>(inquirieList.subList(start, end), pageable, inquirieList.size());
			return page;
		}

		public Page<InquiriesDTO> findInquiriesWithSearch(Pageable pageable, Map<String, String> allParams) {
			List<InquiriesDTO> inquiries = adminMapper.findSalesInquiriesWithSearch(allParams);
			List<InquiriesDTO> inquirieList = new ArrayList<>();
			for(InquiriesDTO Inquiry : inquiries) {
				Long salesPostId = Inquiry.getSalesPostId();
				SalesPostDTO salesPotDTO = adminMapper.findSalesPostById(salesPostId);
				Inquiry.setSalesPotDTO(salesPotDTO);
				inquirieList.add(Inquiry);
			}
						
			int start = (int) pageable.getOffset();
			int end = Math.min((start + pageable.getPageSize()), inquirieList.size());
			Page<InquiriesDTO> page = new PageImpl<>(inquirieList.subList(start, end), pageable, inquirieList.size());
			return page;
		}
}
