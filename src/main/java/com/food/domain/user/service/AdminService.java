package com.food.domain.user.service;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderDetailDTO;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.StockDTO;
import com.food.domain.product.dto.StockTransactionDTO;
import com.food.domain.sales.dto.CouponIssuanceDTO;
import com.food.domain.sales.dto.DiscountDTO;
import com.food.domain.sales.dto.DiscountTargetDTO;
import com.food.domain.sales.dto.ReviewDTO;
import com.food.domain.sales.dto.ReviewFileDTO;
import com.food.domain.sales.dto.ReviewsReplyDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.sales.dto.SalesPostFileDTO;
import com.food.domain.support.dto.InquiriesDTO;
import com.food.domain.support.dto.ResponseDTO;
import com.food.domain.user.dto.AdminDTO;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.MemberRatingDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.mapper.AdminMapper;
import com.food.global.auth.CustomUserDetails;
import com.food.global.util.ProductFile;
import com.food.global.util.SalesPostFile;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class AdminService {

	@Autowired
	AdminMapper adminMapper;

	@Autowired
	ProductFile productFileUtil;

	@Autowired
	PasswordEncoder passwordEncoder;
	
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
		int categoryId = Integer.valueOf(allParams.get("category"));
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
		adminMapper.insertStockByProductNumber(productNumber);
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
		System.out.println("type = ?" + type);
		// 재고 업데이트
		allParams.put("updatedQuantity", updatedQuantity);
		adminMapper.updateStock(allParams);
		ProductDTO productDTO = adminMapper.findProductByProductNumber(productNumber);
		Long productQuantity = productDTO.getQuantity();
		if ("OUT".equals(type)) {
			productQuantity += quantity;
			allParams.put("productQuantity", productQuantity);
			adminMapper.updateQuantity(allParams);
		}
		adminMapper.insertTransaction(allParams);
	}

	public Page<StockTransactionDTO> findTransactionList(Pageable pageable) {
		String orderByClause = pageable.getSort().stream().map(order -> {
			String property = order.getProperty();
			String direction = order.getDirection().name();
			if ("productNumber".equals(property)) {
				return "TO_NUMBER(REGEXP_SUBSTR(PRODUCT_NUMBER, '[0-9]+')) " + direction;
			} else {
				return property + " " + direction;
			}
		}).collect(Collectors.joining(", "));

		int pageSize = pageable.getPageSize();
		int offset = (int) pageable.getOffset() + 1; // Oracle에서는 1부터 시작
		System.out.println("orderByClause = " + orderByClause);
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
		System.out.println("getProductDetails productCode = "+productCode);
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
		return salesPostFileUtil.parseFileInfos(null, new MultipartFile[] { file }).stream().findFirst()
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
		salesPost.setLastPostDate(
				LocalDate.parse((String) allParams.get("lastPostDate"), DateTimeFormatter.ISO_DATE).atStartOfDay());
		salesPost.setUpdatedDate(LocalDateTime.now());
		salesPost.setStartPostDate(
				LocalDate.parse((String) allParams.get("startPostDate"), DateTimeFormatter.ISO_DATE).atStartOfDay());
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
		for (InquiriesDTO Inquiry : inquiries) {
			Long InquiryId = Inquiry.getId();
			Long salesPostId = Inquiry.getSalesPostId();
			SalesPostDTO salesPotDTO = adminMapper.findSalesPostById(salesPostId);
			String productNumber = salesPotDTO.getProductNumber();
			ProductDTO productDTO = adminMapper.findProductByProductNumber(productNumber);
			Long customerId = Inquiry.getCustomerId();
			CustomerDTO customerDTO = adminMapper.findCustomerByCustomerId(customerId);
			ResponseDTO responseDTO = adminMapper.findResponseByInquiryId(InquiryId);
			Inquiry.setSalesPotDTO(salesPotDTO);
			Inquiry.setProductDTO(productDTO);
			Inquiry.setCustomerDTO(customerDTO);
			Inquiry.setResponseDTO(responseDTO);
			inquirieList.add(Inquiry);
		}
		System.out.println(" inquirieList = " + inquirieList);
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), inquirieList.size());
		Page<InquiriesDTO> page = new PageImpl<>(inquirieList.subList(start, end), pageable, inquirieList.size());
		return page;
	}

	public Page<InquiriesDTO> findInquiriesWithSearch(Pageable pageable, Map<String, String> allParams) {
		List<InquiriesDTO> inquiries = adminMapper.findSalesInquiriesWithSearch(allParams);
		List<InquiriesDTO> inquirieList = new ArrayList<>();
		for (InquiriesDTO Inquiry : inquiries) {
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

	@Transactional
	public void salesResponse(Map<String, Object> allParams) {
		Long userId = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.getPrincipal() instanceof CustomUserDetails) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			userId = userDetails.getId();
		}
		Long adminId = adminMapper.findAdminByUserId(userId);
		allParams.put("adminId", adminId);
		adminMapper.insertResponse(allParams);
		adminMapper.updateResolvedYn(allParams);
	}

	public Page<ReviewDTO> findReviews(Pageable pageable, Map<String, String> allParams) {
		List<ReviewDTO> reviews = adminMapper.findReviews();
		List<ReviewDTO> reviewList = new ArrayList<>();
		for (ReviewDTO review : reviews) {
			Long reviewId = review.getId();
			Long salesPostId = review.getSalesPostId();
			SalesPostDTO salesPotDTO = adminMapper.findSalesPostById(salesPostId);
			String productNumber = salesPotDTO.getProductNumber();
			ProductDTO productDTO = adminMapper.findProductByProductNumber(productNumber);
			Long customerId = review.getCustomerId();
			CustomerDTO customerDTO = adminMapper.findCustomerByCustomerId(customerId);
			ReviewsReplyDTO reviewsReplyDTO = adminMapper.findReplyByReviewId(reviewId);
			ReviewFileDTO reviewFileDTO = adminMapper.findReviewFileByReviewId(reviewId);
			review.setSalesPotDTO(salesPotDTO);
			review.setProductDTO(productDTO);
			review.setCustomerDTO(customerDTO);
			review.setReviewsReplyDTO(reviewsReplyDTO);
			review.setReviewFileDTO(reviewFileDTO);
			reviewList.add(review);
		}

		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), reviewList.size());
		Page<ReviewDTO> page = new PageImpl<>(reviewList.subList(start, end), pageable, reviewList.size());
		return page;
	}

	public Page<ReviewDTO> findReviewsWithSearch(Pageable pageable, Map<String, String> allParams) {
		List<ReviewDTO> reviews = adminMapper.findReviewsWithSearch(allParams);
		List<ReviewDTO> reviewList = new ArrayList<>();
		for (ReviewDTO review : reviews) {
			Long reviewId = review.getId();
			Long salesPostId = review.getSalesPostId();
			SalesPostDTO salesPotDTO = adminMapper.findSalesPostById(salesPostId);
			String productNumber = salesPotDTO.getProductNumber();
			ProductDTO productDTO = adminMapper.findProductByProductNumber(productNumber);
			Long customerId = review.getCustomerId();
			CustomerDTO customerDTO = adminMapper.findCustomerByCustomerId(customerId);
			ReviewsReplyDTO reviewsReplyDTO = adminMapper.findReplyByReviewId(reviewId);
			ReviewFileDTO reviewFileDTO = adminMapper.findReviewFileByReviewId(reviewId);
			review.setSalesPotDTO(salesPotDTO);
			review.setProductDTO(productDTO);
			review.setCustomerDTO(customerDTO);
			review.setReviewsReplyDTO(reviewsReplyDTO);
			review.setReviewFileDTO(reviewFileDTO);
			reviewList.add(review);
		}

		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), reviewList.size());
		Page<ReviewDTO> page = new PageImpl<>(reviewList.subList(start, end), pageable, reviewList.size());
		return page;
	}

	public void reviewReply(Map<String, Object> allParams) {
		Long userId = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.getPrincipal() instanceof CustomUserDetails) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			userId = userDetails.getId();
		}
		Long adminId = adminMapper.findAdminByUserId(userId);
		allParams.put("adminId", adminId);
		adminMapper.insertReply(allParams);
		adminMapper.updateReplyYn(allParams);
	}

	public Page<DiscountDTO> findDiscounts(Pageable pageable, Map<String, String> allParams) {
		List<DiscountDTO> discounts = adminMapper.findDisconts();
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), discounts.size());
		Page<DiscountDTO> page = new PageImpl<>(discounts.subList(start, end), pageable, discounts.size());
		return page;
	}

	public Page<DiscountDTO> findDiscountsWithSearch(Pageable pageable, Map<String, String> allParams) {
		List<DiscountDTO> discounts = adminMapper.findDiscountsWithSearch(allParams);
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), discounts.size());
		Page<DiscountDTO> page = new PageImpl<>(discounts.subList(start, end), pageable, discounts.size());
		return page;
	}

	@Transactional
	public void discountUpdate(List<Map<String, Object>> allParams) {
		for (Map<String, Object> params : allParams) {
			if ("P".equals(params.get("discountType"))) {
				Number discountValue = (Number) params.get("discountValue");
				if (discountValue.longValue() > 100) {
					throw new IllegalArgumentException("할인율은 100 이하로 설정해야 합니다.");
				}
			}
			adminMapper.updateDiscount(params);
		}
	}

	public void insertDiscount(Map<String, Object> allParams) {
		adminMapper.insertDiscount(allParams);
	}

	public void deleteDiscountsById(List<Long> discountIds) {
		for (Long discountId : discountIds) {
			adminMapper.deleteDiscountsById(discountId);
		}
	}

	public Page<DiscountTargetDTO> findDiscountTargetList(Pageable pageable, Map<String, String> allParams) {
		List<DiscountTargetDTO> discountTargets = adminMapper.findDiscountTargets();
		List<DiscountTargetDTO> resultList = new ArrayList<>();

		for (DiscountTargetDTO discountTarget : discountTargets) {
			Long discountId = discountTarget.getDiscountId();
			DiscountDTO discount = adminMapper.findDiscountById(discountId);
			String target = discountTarget.getTargetType().trim().toUpperCase();
			String targetId = discountTarget.getTargetId();
			String targetName = getTargetName(target, targetId);

			discountTarget.setTargetName(targetName);
			discountTarget.setDiscountDTO(discount);
			resultList.add(discountTarget);
		}

		return getPage(resultList, pageable);
	}

	public Page<DiscountTargetDTO> findDiscountTargetListWithSearch(Pageable pageable, Map<String, String> allParams) {
		List<DiscountTargetDTO> discountTargets = adminMapper.findDiscountTargetListWithSearch(allParams);
		List<DiscountTargetDTO> resultList = new ArrayList<>();

		for (DiscountTargetDTO discountTarget : discountTargets) {
			Long discountId = discountTarget.getDiscountId();
			DiscountDTO discount = adminMapper.findDiscountById(discountId);
			String target = discountTarget.getTargetType().trim().toUpperCase();
			String targetId = discountTarget.getTargetId();
			String targetName = getTargetName(target, targetId);

			discountTarget.setTargetName(targetName);
			discountTarget.setDiscountDTO(discount);
			resultList.add(discountTarget);
		}

		return getPage(resultList, pageable);
	}

	private String getTargetName(String target, String targetId) {
		String targetName = "";
		switch (target) {
		case "ALL":
			targetName = "모두";
			break;
		case "PRODUCT":
			ProductDTO product = adminMapper.findProductByProductNumber(targetId);
			if (product != null) {
				targetName = product.getName();
			} else {
				targetName = "Unknown Product";
			}
			break;
		case "MEMBER_RATING":
			Long memberId = Long.valueOf(targetId);
			MemberRatingDTO member = adminMapper.findMemberRatingById(memberId);
			if (member != null) {
				targetName = member.getRating();
			} else {
				targetName = "Unknown Member Rating";
			}
			break;
		case "CUSTOMER":
			Long customerId = Long.valueOf(targetId);
			CustomerDTO customer = adminMapper.findCustomerByCustomerId(customerId);
			if (customer != null) {
				String userName = adminMapper.findUserNameById(customer.getUserId());
				targetName = userName != null ? userName : "Unknown User";
			} else {
				targetName = "Unknown Customer";
			}
			break;
		case "CATEGORY":
			Long categoryId = Long.valueOf(targetId);
			ProductCategoryDTO category = adminMapper.findProductCategoryById(categoryId);
			if (category != null) {
				targetName = category.getName();
			} else {
				targetName = "Unknown Category";
			}
			break;
		}
		return targetName;
	}

	private Page<DiscountTargetDTO> getPage(List<DiscountTargetDTO> list, Pageable pageable) {
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), list.size());
		return new PageImpl<>(list.subList(start, end), pageable, list.size());
	}

	public List<DiscountDTO> findDiscountList() {

		return adminMapper.findDisconts();
	}

	public Page<?> findTargetsByTypeAndQuery(String targetType, String keyword, Pageable pageable) {
		if (keyword == null || keyword.isEmpty()) {
			keyword = "%"; // 검색어가 없을 경우 모든 항목을 반환
		} else {
			keyword = "%" + keyword + "%"; // SQL LIKE 연산자를 위한 검색어 포맷
		}

		switch (targetType) {
		case "PRODUCT":
			List<ProductDTO> products = adminMapper.findProductsByQuery(keyword, pageable);
			long productTotal = adminMapper.countProductsByQuery(keyword);
			return new PageImpl<>(products, pageable, productTotal);
		case "CUSTOMER":
			List<CustomerDTO> customers = adminMapper.findCustomersByQuery(keyword, pageable);
			customers.forEach(customer -> {
				UserDTO user = adminMapper.findUserById(customer.getUserId());
				customer.setUserDTO(user);
			});
			long customerTotal = adminMapper.countCustomersByQuery(keyword);
			return new PageImpl<>(customers, pageable, customerTotal);
		default:
			return new PageImpl<>(Collections.emptyList(), pageable, 0);
		}
	}

	public void insertDiscountTarget(Map<String, Object> allParams) {
		String discountIdStr = (String) allParams.get("discountId");
		Long discountId = Long.valueOf(discountIdStr);
		List<Map<String, String>> targets = (List<Map<String, String>>) allParams.get("targets");

		// 디버깅 로그 추가
		System.out.println("Discount ID: " + discountId);
		System.out.println("Targets: " + targets);
		System.out.println("allParams: " + allParams);
		DiscountTargetDTO discountTargetDTO = new DiscountTargetDTO();
		discountTargetDTO.setDiscountId(discountId);
		// 비즈니스 로직 수행
		if (targets != null) {
			for (Map<String, String> target : targets) {
				System.out.println("Target ID: " + target.get("id") + ", Type: " + target.get("type"));
				discountTargetDTO.setTargetType(target.get("type"));
				discountTargetDTO.setTargetId(target.get("id"));
				adminMapper.insertDiscountTarget(discountTargetDTO);
			}
		} else {
			System.out.println("Targets is null");
		}
	}

	public void deleteDiscountTargetById(List<Long> discountTargetIds) {
		for (Long discountTargetId : discountTargetIds) {
			System.out.println("discountTargetIds = " + discountTargetIds);
			System.out.println("discountTargetId = " + discountTargetId);

			adminMapper.deleteDiscountTargetById(discountTargetId);
		}
	}

	public List<DiscountTargetDTO> getDiscountTargetsByType(String targetType) {

		List<DiscountTargetDTO> targets = new ArrayList<>();
		System.out.println("targetType = " + targetType);
		targets = adminMapper.findDiscountTargetByType(targetType);
		System.out.println("targets = " + targets);
		for (DiscountTargetDTO target : targets) {
			Long discountId = target.getDiscountId();
			DiscountDTO discount = adminMapper.findDiscountById(discountId);
			System.out.println("discount = " + discount);
			target.setDiscountDTO(discount);
		}

		return targets;
	}

	public List<Map<String, String>> getAllProducts() {
		return adminMapper.findProductList().stream().map(product -> {
			Map<String, String> map = new HashMap<>();
			map.put("id", product.getProductNumber());
			map.put("name", product.getName());
			return map;
		}).collect(Collectors.toList());
	}

	public List<Map<String, String>> getAllCategories() {
		return adminMapper.findCategoryList().stream().map(category -> {
			Map<String, String> map = new HashMap<>();
			map.put("id", String.valueOf(category.getId()));
			map.put("name", category.getName());
			return map;
		}).collect(Collectors.toList());
	}

	public List<Map<String, String>> getAllMemberRatings() {
		return adminMapper.findAllMemberRatings().stream().map(rating -> {
			Map<String, String> map = new HashMap<>();
			map.put("id", rating.getId().toString());
			map.put("name", rating.getRating());
			return map;
		}).collect(Collectors.toList());
	}

	public List<?> getTargetOptionsByType(String targetType) {
		switch (targetType) {
		case "PRODUCT":
			return adminMapper.findProductList();
		case "MEMBER_RATING":
			return adminMapper.findAllMemberRatings();
		case "CATEGORY":
			return adminMapper.findCategoryList();
		default:
			return Collections.emptyList();
		}
	}

	public void updateDiscountTarget(Long discountId, String targetType, String targetId) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", discountId);
		params.put("targetType", targetType);
		params.put("targetId", targetType.equals("PRODUCT") ? targetId : Long.valueOf(targetId));

		adminMapper.updateDiscountTarget(params);
	}

	public Page<CouponIssuanceDTO> findCouponIssuancesWithSearch(Pageable pageable, Map<String, String> allParams) {
		List<CouponIssuanceDTO> couponIssuances = adminMapper.findCouponIssuancesWithSearch(allParams);
		System.out.println("findCouponIssuancesWithSearch = " + couponIssuances);
		List<CouponIssuanceDTO> resultList = new ArrayList<>();

		for (CouponIssuanceDTO couponIssuance : couponIssuances) {
			Long discountId = couponIssuance.getDiscountId();
			DiscountDTO discount = adminMapper.findDiscountById(discountId);
			Long customerId = couponIssuance.getCustomerId();
			CustomerDTO customer = adminMapper.findCustomerByCustomerId(customerId);
			Long userId = customer.getUserId();
			String userName = adminMapper.findUserNameById(userId);
			couponIssuance.setDiscountDTO(discount);
			couponIssuance.setCustomerDTO(customer);
			couponIssuance.setUsername(userName);
			resultList.add(couponIssuance);
		}
		int start = (int) pageable.getOffset();
		int end = Math.min((start + pageable.getPageSize()), resultList.size());
		Page<CouponIssuanceDTO> page = new PageImpl<>(resultList.subList(start, end), pageable, resultList.size());
		return page;
	}

	public Page<CouponIssuanceDTO> findCouponIssuances(Pageable pageable, Map<String, String> allParams) {
	    List<CouponIssuanceDTO> couponIssuances = adminMapper.findCouponIssuances();
	    List<CouponIssuanceDTO> resultList = new ArrayList<>();

	    for (CouponIssuanceDTO couponIssuance : couponIssuances) {
	        Long discountId = couponIssuance.getDiscountId();
	        DiscountDTO discount = adminMapper.findDiscountById(discountId);

	        Long customerId = couponIssuance.getCustomerId();
	        CustomerDTO customer = adminMapper.findCustomerByCustomerId(customerId);
	        
	        // 고객이 없는 경우 예외 처리
	        if (customer == null) {
	            log.error("Customer not found for customerId: {}", customerId);
	            continue;
	        }

	        Long userId = customer.getUserId();
	        String userName = adminMapper.findUserNameById(userId);

	        couponIssuance.setDiscountDTO(discount);
	        couponIssuance.setCustomerDTO(customer);
	        couponIssuance.setUsername(userName);

	        resultList.add(couponIssuance);
	    }

	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), resultList.size());
	    Page<CouponIssuanceDTO> page = new PageImpl<>(resultList.subList(start, end), pageable, resultList.size());

	    return page;
	}


	public void deleteCouponIssuancesById(List<Long> couponIssuanceIds) {
		for (Long couponIssuanceId : couponIssuanceIds) {
			adminMapper.deleteCouponIssuancesById(couponIssuanceId);
		}
	}

	public List<DiscountDTO> findDiscountListWithType() {
		// TODO Auto-generated method stub
		return adminMapper.findDiscountListWithType();
	}

	public List<CustomerDTO> findCustomerList() {
		List<CustomerDTO> customerList = adminMapper.findCustomerList();
		System.out.println("service customerList = " + customerList);
		for (CustomerDTO customer : customerList) {
			Long userId = customer.getUserId();
			UserDTO user = adminMapper.findUserById(userId);
			Long customerId = customer.getId();
			Long totalAmount = adminMapper.getTotalAmountByCustomerId(customerId);
			if (totalAmount == null) {
				return null;
			}
			MemberRatingDTO member = adminMapper.getMemberRatingByTotalAmount(totalAmount);
			customer.setUserDTO(user);
			customer.setMember(member);
		}
		return customerList;
	}

	@Transactional
	public void issueCoupons(List<Long> couponIds, String targetType, String customerIds, int issueCount) {
		List<Long> targetCustomerIds;

		switch (targetType) {
		case "customers":
			targetCustomerIds = List.of(customerIds.split(",")).stream().map(Long::parseLong).toList();
			break;
		case "rating":
			targetCustomerIds = getCustomersByRatings(
					List.of(customerIds.split(",")).stream().map(Long::parseLong).toList());
			break;
		case "all":
			targetCustomerIds = adminMapper.findAllCustomerIds();
			break;
		default:
			throw new IllegalArgumentException("Invalid targetType: " + targetType);
		}

		for (Long customerId : targetCustomerIds) {
			for (Long couponId : couponIds) {
				for (int i = 0; i < issueCount; i++) {
					String couponNumber = generateCouponNumber();
					adminMapper.insertCouponToCustomer(couponId, customerId, couponNumber);
				}
			}
		}
	}

	public List<Long> getCustomersByRatings(List<Long> ratings) {
		List<Long> customerIds = new ArrayList<>();
		List<CustomerDTO> customerList = adminMapper.findCustomerList();
		for (CustomerDTO customer : customerList) {
			Long customerId = customer.getId();
			Long totalAmount = adminMapper.getTotalAmountByCustomerId(customerId);
			if (totalAmount != null) {
				MemberRatingDTO member = adminMapper.getMemberRatingByTotalAmount(totalAmount);
				if (ratings.contains(member.getId())) {
					customerIds.add(customerId);
				}
			}
		}
		return customerIds;
	}

	public String generateCouponNumber() {
		UUID uuid = UUID.randomUUID();
		BigInteger bigInt = new BigInteger(uuid.toString().replace("-", ""), 16);
		return bigInt.toString().substring(0, 12); // 숫자로 변환 후 원하는 길이로 자르기
	}

	public Page<OrderDTO> findOrders(Pageable pageable, Map<String, String> allParams) {
	    boolean hasSearchParams = allParams.keySet().stream()
	            .anyMatch(key -> !key.equals("page") && !key.equals("size") && allParams.get(key) != null && !allParams.get(key).isEmpty());
	    List<OrderDTO> orders = new ArrayList<>();
	    
	    if (hasSearchParams) {
	        orders = adminMapper.findOrdersWithSearch(allParams);
	    } else {
	        orders = adminMapper.findOrders();
	    }
	    
	    for (OrderDTO order : orders) {
	        Long identifierId;

	        if ("CUSTOMER".equals(order.getIdentifierType())) {
	            Long orderId = order.getId();
	            identifierId = Long.valueOf(order.getIdentifierId());
	            CustomerDTO customer = adminMapper.findCustomerByCustomerId(identifierId);
	            Long userId = customer.getUserId();
	            UserDTO user = adminMapper.findUserById(userId);
	            customer.setUserDTO(user);
	            OrderStatusDTO orderStatus = adminMapper.findOrderStatusByOrderId(orderId);
	            List<OrderDetailDTO> orderDetailList = adminMapper.findOrderDetailListByOrderId(orderId);
	            
	            for (OrderDetailDTO orderDetail : orderDetailList) {
	                Long salesPostId = orderDetail.getSalesPostId();
	                SalesPostDTO salesPostDto = adminMapper.findSalesPostById(salesPostId);
	                String productNumber = salesPostDto.getProductNumber();
	                ProductDTO product = adminMapper.findProductByProductNumber(productNumber);
	                salesPostDto.setProductDTO(product);
	                orderDetail.setSales(salesPostDto);
	            }
	            
	            order.setOrderDetailList(orderDetailList);
	            order.setOrderStatus(orderStatus);
	            order.setCustomer(customer);
	        }
	    }
	    
	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), orders.size());
	    return new PageImpl<>(orders.subList(start, end), pageable, orders.size());
	}

	public Page<OrderDTO> findPaymentCompletedOrders(Pageable pageable, Map<String, String> allParams) {
	    boolean hasSearchParams = allParams.keySet().stream()
	            .anyMatch(key -> !key.equals("page") && !key.equals("size") && allParams.get(key) != null && !allParams.get(key).isEmpty());
	    List<OrderDTO> orders = new ArrayList<>();
	    
	    if (hasSearchParams) {
	        orders = adminMapper.findPaymentCompletedOrdersWithSearch(allParams);
	    } else {
	        orders = adminMapper.findPaymentCompletedOrders();
	    }
	    
	    for (OrderDTO order : orders) {
	        Long identifierId;

	        if ("CUSTOMER".equals(order.getIdentifierType())) {
	            Long orderId = order.getId();
	            identifierId = Long.valueOf(order.getIdentifierId());
	            CustomerDTO customer = adminMapper.findCustomerByCustomerId(identifierId);
	            Long userId = customer.getUserId();
	            UserDTO user = adminMapper.findUserById(userId);
	            customer.setUserDTO(user);
	            OrderStatusDTO orderStatus = adminMapper.findOrderStatusByOrderId(orderId);
	            List<OrderDetailDTO> orderDetailList = adminMapper.findOrderDetailListByOrderId(orderId);
	            
	            for (OrderDetailDTO orderDetail : orderDetailList) {
	                Long salesPostId = orderDetail.getSalesPostId();
	                SalesPostDTO salesPostDto = adminMapper.findSalesPostById(salesPostId);
	                String productNumber = salesPostDto.getProductNumber();
	                ProductDTO product = adminMapper.findProductByProductNumber(productNumber);
	                salesPostDto.setProductDTO(product);
	                orderDetail.setSales(salesPostDto);
	            }
	            
	            order.setOrderDetailList(orderDetailList);
	            order.setOrderStatus(orderStatus);
	            order.setCustomer(customer);
	        }
	    }
	    
	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), orders.size());
	    return new PageImpl<>(orders.subList(start, end), pageable, orders.size());
	}

	 public boolean updateOrderStatus(List<Long> orderIds, String progress) {
	        String status;
	        switch (progress) {
	            case "결제 완료":
	                status = "상품 준비";
	                break;
	            case "상품 준비":
	                status = "배송 준비";
	                break;
	            case "배송 준비":
	                status = "배송 중";
	                break;
	            case "배송 중":
	                status = "배송 완료";
	                break;
	            case "배송 완료":
	            	status = "구매 확정 대기";
	            	break;
	            case "취소":
	            	status = "취소 완료";
	            	break;
	            case "반품":
	            	status = "반품 완료";
	            	break;
	            case "교환":
	            	status = "교환 준비";
	            	break;
	            case "교환 준비":
	            	status = "배송 중";
	            	break;
	            default:
	                throw new IllegalArgumentException("Invalid progress: " + progress);
	        }
	        
	        try {
	            for (Long orderId : orderIds) {
	                log.info("Updating order ID: {} to status: {}", orderId, status);
	                int updatedRows = adminMapper.updateOrderStatus(orderId, status);
	                if (updatedRows == 0) {
	                    log.error("Failed to update order ID: {}", orderId);
	                    return false;
	                }
	            }
	            return true;
	        } catch (Exception e) {
	            log.error("Exception occurred while updating order status", e);
	            return false;
	        }
	    }

	// AdminService.java
	 public Map<String, String> getProductInfo(String name) {
	     Map<String, String> details = new HashMap<>();
	     String productNumber = adminMapper.findProductByName(name);
	     
	     // Check if productNumber is correctly retrieved
	     if (productNumber == null || productNumber.isEmpty()) {
	         throw new IllegalArgumentException("Product not found for name: " + name);
	     }
	     
	     SalesPostDTO sales = adminMapper.findSalesPostByProductNumber(productNumber);
	     String salesPostId = String.valueOf(sales.getId());
	     String title = sales.getTitle();
	     String description = sales.getDescription();
	     
	     // DateTimeFormatter to format the dates in yyyy-MM-dd
	     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	     
	     String lastPostDate = sales.getLastPostDate() != null ? sales.getLastPostDate().format(formatter) : "";
	     String startPostDate = sales.getStartPostDate() != null ? sales.getStartPostDate().format(formatter) : "";

	     ProductFileDTO productFileDTO = adminMapper.findProductFileByProductNumber(productNumber);
	     String filePath = productFileDTO.getFilePath();
	     
	     details.put("salesPostId", salesPostId);
	     details.put("productNumber", productNumber);
	     details.put("imagePath", filePath);
	     details.put("lastPostDate", lastPostDate);
	     details.put("startPostDate", startPostDate);
	     details.put("description", description);
	     details.put("title", title);
	     
	     return details;
	 }

	public void updateSalesPost(Map<String, Object> allParams, List<SalesPostFileDTO> fileDTOList) {
		Long userId = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.getPrincipal() instanceof CustomUserDetails) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			userId = userDetails.getId();
		}
		System.out.println("updateSalesPost userId = "+userId );
		Long adminId = adminMapper.findAdminByUserId(userId);
		System.out.println("updateSalesPost adminId = "+adminId );
		SalesPostDTO salesPost = new SalesPostDTO();
		salesPost.setId(Long.valueOf((String) allParams.get("salesPostId")));
		salesPost.setAdminId(adminId);
		salesPost.setProductNumber((String) allParams.get("productNumber"));
		salesPost.setTitle((String) allParams.get("title"));
		salesPost.setDescription((String) allParams.get("description"));
		salesPost.setCreatedDate(LocalDateTime.now());
		salesPost.setLastPostDate(
				LocalDate.parse((String) allParams.get("lastPostDate"), DateTimeFormatter.ISO_DATE).atStartOfDay());
		salesPost.setUpdatedDate(LocalDateTime.now());
		salesPost.setStartPostDate(
				LocalDate.parse((String) allParams.get("startPostDate"), DateTimeFormatter.ISO_DATE).atStartOfDay());
		salesPost.setStatus(Long.parseLong((String) allParams.get("status")));

		// 판매글 저장
		adminMapper.updateSalesPost(salesPost);

		// 저장된 판매글의 ID 가져오기
		Long salesPostId = salesPost.getId();
		if (salesPostId == null) {
			throw new RuntimeException("Failed to retrieve generated sales post ID");
		}

		// 파일 정보 업데이트 및 저장
		for (SalesPostFileDTO fileDTO : fileDTOList) {
			adminMapper.deleteSalesPostFile(salesPostId);
			fileDTO.setSalesPostId(salesPostId);
			adminMapper.insertSalesPostFile(fileDTO);
		}
	}

	public ProductDTO updateProductForm(String productNumber) {
		ProductDTO product = adminMapper.findProductByProductNumber(productNumber);
		ProductCategoryDTO category = adminMapper.findProductCategoryByProductNumber(productNumber);
		ProductFileDTO file = adminMapper.findProductFileByProductNumber(productNumber);
		product.setProductCategoryDTO(category);
		product.setProductFileDTO(file);
		return product;
	}
	
	@Transactional
	public void updateProduct(Map<String, String> allParams, MultipartFile file) {
	    String oldProductNumber = allParams.get("oldProductNumber");
	    String newProductNumber = allParams.get("productNumber");
	    int categoryId = Integer.parseInt(allParams.get("category"));

	    // 기존 제품이 존재하는지 확인
	    ProductDTO existingProduct = adminMapper.findProductByProductNumber(oldProductNumber);
	    if (existingProduct == null) {
	        throw new IllegalArgumentException("Product not found for product number: " + oldProductNumber);
	    }

	    // 기존 카테고리 ID 가져오기
	    Integer existingCategoryId = adminMapper.findCategoryIdByProductNumber(oldProductNumber);

	    // 기존 카테고리 ID와 새로운 카테고리 ID가 다른 경우에만 updateCategoryById 실행
	    if (existingCategoryId != categoryId) {
	        adminMapper.updateCategoryById(categoryId);
	    }

	    // 부모 테이블에서 제품 번호 업데이트
	    adminMapper.updateProductNumber(oldProductNumber, newProductNumber);

	    // 제품 정보 업데이트
	    adminMapper.updateProduct(allParams);

	    // 파일 정보 파싱 및 삽입
	    try {
	        ProductFileDTO productFile = productFileUtil.parseFileInfo(newProductNumber, file);
	        if (productFile != null) {
	            adminMapper.deleteProductFile(oldProductNumber);
	            adminMapper.insertProductFile(productFile);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	public Page<CustomerDTO> findCustomers(Pageable pageable, Map<String, String> allParams) {
	    List<CustomerDTO> customers = adminMapper.findCustomerList();
	    List<CustomerDTO> customerList = new ArrayList<>();

	    for (CustomerDTO customer : customers) {
	        Long userId = customer.getUserId();
	        UserDTO user = adminMapper.findUserById(userId);
	        Long customerId = customer.getId();
	        Long totalAmount = adminMapper.getTotalAmountByCustomerId(customerId);
	        if (totalAmount == null) {
	            totalAmount = 0L;
	        }
	        MemberRatingDTO member = adminMapper.getMemberRatingByTotalAmount(totalAmount);
	        List<CouponIssuanceDTO> couponIssuances = adminMapper.findCouponIssuancesByCustomerId(customerId);
	        List<OrderDTO> orders = adminMapper.findOrdersByCustomerId(customerId);
	        List<InquiriesDTO> inquiries = adminMapper.findInquiriesByCustomerId(customerId);
	        Long totalOrderAmount = adminMapper.findTotalOrderAmount(customerId);
	        Long totalReserves = adminMapper.findTotalReservesByCustomerId(customerId);

	        for (CouponIssuanceDTO couponIssuance : couponIssuances) {
	            Long discountId = couponIssuance.getDiscountId();
	            DiscountDTO discount = adminMapper.findDiscountById(discountId);
	            couponIssuance.setDiscountDTO(discount);
	        }

	        customer.setCouponIssuances(couponIssuances == null ? new ArrayList<>() : couponIssuances);
	        customer.setUserDTO(user == null ? new UserDTO() : user);
	        customer.setMember(member == null ? new MemberRatingDTO() : member);
	        customer.setOrders(orders == null ? new ArrayList<>() : orders);
	        customer.setInquiries(inquiries == null ? new ArrayList<>() : inquiries);
	        customer.setTotalOrderAmount(totalOrderAmount == null ? 0L : totalOrderAmount);
	        customer.setTotalReserves(totalReserves == null ? 0L : totalReserves);
	        customerList.add(customer);
	    }
	    System.out.println("customerList = " + customerList);
	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), customerList.size());
	    return new PageImpl<>(customerList.subList(start, end), pageable, customerList.size());
	}



	public Page<CustomerDTO> findCustomersWithSearch(Pageable pageable, Map<String, String> allParams) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<MemberRatingDTO> findAllMemberRatings() {
		List<MemberRatingDTO> memberRatings = adminMapper.findAllMemberRatings();
		return memberRatings;
	}

	public Page<AdminDTO> findAdmins(Pageable pageable, Map<String, String> allParams) {
		List<AdminDTO> admins  = adminMapper.findAdminList();
		List<AdminDTO> adminList = new ArrayList<>();
	    for (AdminDTO admin : admins) {
	        Long userId = admin.getUserId();
	        UserDTO user = adminMapper.findUserById(userId);
	  
	        admin.setUser(user == null ? new UserDTO() : user);
	        adminList.add(admin);
	    }
	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), adminList.size());
	    return new PageImpl<>(adminList.subList(start, end), pageable, adminList.size());
	}

	public Page<AdminDTO> findAdminsWithSearch(Pageable pageable, Map<String, String> allParams) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional
	public void createAdmin(Map<String, Object> allParams) {
	    // 비밀번호 인코딩
	    String rawPassword = (String) allParams.get("password");
	    String encodedPassword = passwordEncoder.encode(rawPassword);
	    allParams.put("password", encodedPassword);

	    // 유저 생성
	    adminMapper.createAdminUser(allParams);

	    // 생성된 유저 ID를 allParams에 추가
	    Long userId = ((BigDecimal) allParams.get("userId")).longValue();
	    allParams.put("userId", userId);

	    // 관리자 생성
	    adminMapper.createAdmin(allParams);
	}









	
}
