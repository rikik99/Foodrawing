package com.food.domain.user.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.StockTransactionDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.sales.dto.SalesPostFileDTO;
import com.food.domain.user.service.AdminService;
import com.food.global.util.SalesPostFile;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminController {

	@Autowired
	AdminService adminService;

	@Autowired
	private SalesPostFile salesPostFile;

	@GetMapping("/login")
	public ModelAndView login(Authentication authentication) {
		// 로그인된 사용자가 로그인 페이지로 접근할 경우 메인 페이지로 리다이렉트
		if (authentication != null && authentication.isAuthenticated()) {
			return new ModelAndView("redirect:/admin/mainContent");
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/login");
		return mv;
	}

	@GetMapping("/main")
	public ModelAndView admindashboard() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/adminMain");
		return mv;
	}

	@GetMapping("/mainContent")
	public ModelAndView adminMain() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/mainContent");
		return mv;
	}

	@GetMapping("/productManagement")
	public ModelAndView productManagement(@RequestParam Map<String, String> allParams) {
		log.info("allparams = {}", allParams);
		int page = Integer.parseInt(allParams.getOrDefault("page", "0"));
		int size = Integer.parseInt(allParams.getOrDefault("size", "5"));

		ModelAndView mv = new ModelAndView();

		// 페이지 정보와 사이즈 정보를 allParams에 추가
		allParams.put("page", String.valueOf(page));
		allParams.put("size", String.valueOf(size));

		// 검색 조건이 있는지 확인
		boolean hasSearchParams = allParams.keySet().stream().anyMatch(key -> !key.equals("page") && !key.equals("size")
				&& allParams.get(key) != null && !allParams.get(key).isEmpty());

		Page<ProductDTO> productList;
		if (hasSearchParams) {
			// 검색 조건이 있을 경우
			productList = adminService.findProductListWithSearch(convertEmptyStringsToNull(allParams));
		} else {
			// 검색 조건이 없을 경우
			productList = adminService.findProductList(PageRequest.of(page, size));
		}
		List<ProductCategoryDTO> categoryList = adminService.findCategoryList();
		mv.addObject("product", productList);
		mv.addObject("categoryList", categoryList);
		mv.addObject("currentPage", productList.getNumber());
		mv.addObject("pageCount", productList.getTotalPages());
		mv.addObject("totalElements", productList.getTotalElements());
		mv.addObject("size", size);
		mv.addAllObjects(allParams); // 전달된 검색 조건을 다시 뷰로 전달
		mv.setViewName("admin/productManagement");
		return mv;
	}

	@GetMapping("/insertProduct")
	public ModelAndView productInsert() {
		ModelAndView mv = new ModelAndView();
		List<ProductCategoryDTO> categoryList = adminService.findCategoryList();
		mv.addObject("categoryList", categoryList);
		mv.setViewName("admin/insertProduct");
		return mv;
	}

	@ResponseBody
	@GetMapping("/nextProductNumber")
	public ResponseEntity<Map<String, String>> getNextProductNumber(@RequestParam Long id) {
		String nextProductNumber = adminService.getNextProductNumber(id);
		Map<String, String> response = new HashMap<>();
		response.put("productCode", nextProductNumber);
		return ResponseEntity.ok(response);
	}

	@PostMapping("/insertProduct")
	@ResponseBody
	public ResponseEntity<?> registerProduct(@RequestParam Map<String, String> allParams,
			@RequestPart("file") MultipartFile file) {
		adminService.insertProduct(allParams, file);
		return ResponseEntity.ok("상품이 성공적으로 등록되었습니다.");
	}

	@DeleteMapping("/deleteProducts")
	@ResponseBody
	public ResponseEntity<String> deleteProducts(@RequestBody Map<String, List<String>> requestBody) {
		List<String> productNumbers = requestBody.get("productNumbers");
		if (productNumbers == null || productNumbers.isEmpty()) {
			return ResponseEntity.badRequest().body("삭제할 제품 번호가 없습니다.");
		}

		try {
			adminService.deleteProductsByProductNumbers(productNumbers);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ResponseEntity.ok("선택된 제품이 성공적으로 삭제되었습니다.");
	}

	@GetMapping("/stockManagement")
	public ModelAndView stockManagement(@RequestParam Map<String, String> allParams) {
		log.info("allparams = {}", allParams);
		int page = Integer.parseInt(allParams.getOrDefault("page", "0"));
		int size = Integer.parseInt(allParams.getOrDefault("size", "5"));

		ModelAndView mv = new ModelAndView();

		// 페이지 정보와 사이즈 정보를 allParams에 추가
		allParams.put("page", String.valueOf(page));
		allParams.put("size", String.valueOf(size));

		// 검색 조건이 있는지 확인
		boolean hasSearchParams = allParams.keySet().stream().anyMatch(key -> !key.equals("page") && !key.equals("size")
				&& allParams.get(key) != null && !allParams.get(key).isEmpty());

		Page<ProductDTO> productList;
		if (hasSearchParams) {
			// 검색 조건이 있을 경우
			productList = adminService.findStockListWithSearch(convertEmptyStringsToNull(allParams));
		} else {
			// 검색 조건이 없을 경우
			productList = adminService.findStockList(PageRequest.of(page, size));
		}
		List<ProductCategoryDTO> categoryList = adminService.findCategoryList();
		mv.addObject("product", productList);
		mv.addObject("categoryList", categoryList);
		mv.addObject("currentPage", productList.getNumber());
		mv.addObject("pageCount", productList.getTotalPages());
		mv.addObject("totalElements", productList.getTotalElements());
		mv.addObject("size", size);
		mv.addAllObjects(allParams); // 전달된 검색 조건을 다시 뷰로 전달
		mv.setViewName("admin/stockManagement");
		return mv;
	}

	@PostMapping("/updateStock")
	@ResponseBody
	public ResponseEntity<?> stockUpdate(@RequestBody Map<String, Object> allParams) {
		adminService.stockUpdate(allParams);
		return ResponseEntity.ok(Map.of("success", true, "message", "재고가 성공적으로 업데이트되었습니다."));
	}

	@GetMapping("/stockTransaction")
	public ModelAndView stockTransaction(@RequestParam Map<String, String> allParams) {
		log.info("Transaction allParams = {}", allParams);
		int page = Integer.parseInt(allParams.getOrDefault("page", "0"));
		int size = Integer.parseInt(allParams.getOrDefault("size", "5"));
		String sortParam = allParams.getOrDefault("sort", "TRANSACTION_DATE,desc");
		String[] sortParams = sortParam.split(",");

		List<Sort.Order> orders = new ArrayList<>();
		for (int i = 0; i < sortParams.length; i += 2) {
			orders.add(new Sort.Order(Sort.Direction.fromString(sortParams[i + 1]), sortParams[i]));
		}

		Pageable pageable = PageRequest.of(page, size, Sort.by(orders));
		Page<StockTransactionDTO> transactionList = adminService.findTransactionList(pageable);

		ModelAndView mv = new ModelAndView();
		mv.addObject("transaction", transactionList.getContent());
		mv.addObject("totalElements", transactionList.getTotalElements()); // 전체 레코드 수
		mv.addObject("currentPage", page);
		mv.addObject("pageCount", transactionList.getTotalPages()); // 전체 페이지 수 계산
		mv.addObject("size", size);
		mv.addObject("sort", sortParam);
		mv.setViewName("admin/stockTransaction");
		return mv;
	}

	@GetMapping("/salesPost")
	public ModelAndView salesPost(@RequestParam Map<String, String> allParams) {
		log.info("allparams = {}", allParams);
		int page = Integer.parseInt(allParams.getOrDefault("page", "0"));
		int size = Integer.parseInt(allParams.getOrDefault("size", "5"));

		ModelAndView mv = new ModelAndView();

		// 페이지 정보와 사이즈 정보를 allParams에 추가
		allParams.put("page", String.valueOf(page));
		allParams.put("size", String.valueOf(size));

		// 검색 조건이 있는지 확인
		boolean hasSearchParams = allParams.keySet().stream().anyMatch(key -> !key.equals("page") && !key.equals("size")
				&& allParams.get(key) != null && !allParams.get(key).isEmpty());

		Page<SalesPostDTO> postList;
		Pageable pageable = PageRequest.of(page, size);
		if (hasSearchParams) {
			// 검색 조건이 있을 경우
			postList = adminService.findPostListWithSearch(convertEmptyStringsToNull(allParams));
		} else {
			// 검색 조건이 없을 경우
			postList = adminService.findPostList(pageable);
		}
		List<ProductCategoryDTO> categoryList = adminService.findCategoryList();
		mv.addObject("post", postList);
		mv.addObject("currentPage", postList.getNumber());
		mv.addObject("pageCount", postList.getTotalPages());
		mv.addObject("totalElements", postList.getTotalElements());
		mv.addObject("size", size);
		mv.addAllObjects(allParams); // 전달된 검색 조건을 다시 뷰로 전달
		mv.setViewName("admin/salesPost");
		return mv;
	}

	@GetMapping("/salesInquiry")
	public ModelAndView salesInquiry() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/salesInquiry");
		return mv;
	}

	@GetMapping("/salesReview")
	public ModelAndView salesReview() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/salesReview");
		return mv;
	}

	@GetMapping("/discountList")
	public ModelAndView discountList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/discountList");
		return mv;
	}

	@GetMapping("/discountManagement")
	public ModelAndView discountManagement() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/discountManagement");
		return mv;
	}

	@GetMapping("/couponList")
	public ModelAndView couponList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/couponList");
		return mv;
	}

	@GetMapping("/couponManagement")
	public ModelAndView couponManagement() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/couponManagement");
		return mv;
	}

	@GetMapping("/orderList")
	public ModelAndView orderList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/orderList");
		return mv;
	}

	@GetMapping("/deliveryList")
	public ModelAndView deliveryList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/deliveryList");
		return mv;
	}

	@GetMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();

		// JWT 쿠키 삭제
		Cookie cookie = new Cookie("jwt", null);
		cookie.setHttpOnly(true);
		cookie.setSecure(true);
		cookie.setPath("/");
		cookie.setMaxAge(0); // 쿠키 삭제
		response.addCookie(cookie);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/login");
		return mv;
	}

	private Map<String, String> convertEmptyStringsToNull(Map<String, String> params) {
		Map<String, String> result = new HashMap<>();
		params.forEach((key, value) -> {
			result.put(key, value.isEmpty() ? null : value);
		});
		return result;
	}

	@GetMapping("/insertSalesPost")
	public ModelAndView salesPostInsert() {
		ModelAndView mv = new ModelAndView();
		List<ProductDTO> productList = adminService.findProducts();
		mv.addObject("productList", productList);
		mv.setViewName("admin/insertSalesPost");
		return mv;
	}

	@ResponseBody
	@GetMapping("/getProductDetails")
	public ResponseEntity<Map<String, String>> getProductDetails(@RequestParam String name) {
		Map<String, String> productDetails = adminService.getProductDetails(name);
		return ResponseEntity.ok(productDetails);
	}

	@PostMapping("/uploadImage")
	public ResponseEntity<SalesPostFileDTO> uploadImage(@RequestParam("upload") MultipartFile file) {
		try {
			SalesPostFileDTO fileDTO = adminService.uploadImage(file);

			// 로그 추가
			System.out.println("Uploaded fileDTO : " + fileDTO);

			return ResponseEntity.ok(fileDTO);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}
	@PostMapping("/insertSalesPost")
	@ResponseBody
	public ResponseEntity<?> registerSalesPost(@RequestBody Map<String, Object> allParams) {
	    try {
	        List<Map<String, Object>> fileDTOListRaw = (List<Map<String, Object>>) allParams.get("fileDTOList");
	        if (fileDTOListRaw == null) {
	            throw new IllegalArgumentException("fileDTOList is missing in request");
	        }

	        List<SalesPostFileDTO> fileDTOList = new ArrayList<>();
	        for (Map<String, Object> fileDTOMap : fileDTOListRaw) {
	            SalesPostFileDTO fileDTO = new SalesPostFileDTO();
	            fileDTO.setOriginalName(String.valueOf(fileDTOMap.get("originalName")));
	            fileDTO.setFilePath(String.valueOf(fileDTOMap.get("filePath")));
	            fileDTO.setFileType(String.valueOf(fileDTOMap.get("fileType")));
	            fileDTO.setUploadDate(LocalDateTime.parse(String.valueOf(fileDTOMap.get("uploadDate"))));
	            fileDTOList.add(fileDTO);
	        }

	        adminService.insertSalesPost(allParams, fileDTOList);
	        return ResponseEntity.ok("판매글이 성공적으로 등록되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace(); // Print the stack trace to see the error
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("판매글 등록에 실패했습니다.");
	    }
	}

}
