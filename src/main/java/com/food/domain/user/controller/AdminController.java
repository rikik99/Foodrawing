package com.food.domain.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.user.service.AdminService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminController {
	/*
	 * @Autowired AdminService adminService;
	 * 
	 * @GetMapping("/login") public ModelAndView login(Authentication
	 * authentication) { // 로그인된 사용자가 로그인 페이지로 접근할 경우 메인 페이지로 리다이렉트 if
	 * (authentication != null && authentication.isAuthenticated()) { return new
	 * ModelAndView("redirect:/admin/mainContent"); } ModelAndView mv = new
	 * ModelAndView(); mv.setViewName("admin/login"); return mv; }
	 * 
	 * @GetMapping("/main") public ModelAndView admindashboard() { ModelAndView mv =
	 * new ModelAndView(); mv.setViewName("admin/adminMain"); return mv; }
	 * 
	 * @GetMapping("/mainContent") public ModelAndView adminMain() { ModelAndView mv
	 * = new ModelAndView(); mv.setViewName("admin/mainContent"); return mv; }
	 * 
	 * @GetMapping("/productManagement") public ModelAndView
	 * productManagement(@RequestParam Map<String, String> allParams) {
	 * log.info("allparams = {}", allParams); int page =
	 * Integer.parseInt(allParams.getOrDefault("page", "0")); int size =
	 * Integer.parseInt(allParams.getOrDefault("size", "5"));
	 * 
	 * ModelAndView mv = new ModelAndView();
	 * 
	 * // 페이지 정보와 사이즈 정보를 allParams에 추가 allParams.put("page", String.valueOf(page));
	 * allParams.put("size", String.valueOf(size));
	 * 
	 * // 검색 조건이 있는지 확인 boolean hasSearchParams =
	 * allParams.keySet().stream().anyMatch(key -> !key.equals("page") &&
	 * !key.equals("size") && allParams.get(key) != null &&
	 * !allParams.get(key).isEmpty());
	 * 
	 * Page<ProductDTO> productList; if (hasSearchParams) { // 검색 조건이 있을 경우
	 * productList =
	 * adminService.findProductListWithSearch(convertEmptyStringsToNull(allParams));
	 * } else { // 검색 조건이 없을 경우 productList =
	 * adminService.findProductList(PageRequest.of(page, size)); }
	 * List<ProductCategoryDTO> categoryList = adminService.findCategoryList();
	 * mv.addObject("product", productList); mv.addObject("categoryList",
	 * categoryList); mv.addObject("currentPage", productList.getNumber());
	 * mv.addObject("pageCount", productList.getTotalPages());
	 * mv.addObject("totalElements", productList.getTotalElements());
	 * mv.addObject("size", size); mv.addAllObjects(allParams); // 전달된 검색 조건을 다시 뷰로
	 * 전달 mv.setViewName("admin/productManagement"); return mv; }
	 * 
	 * @GetMapping("/insertProduct") public ModelAndView productInsert() {
	 * ModelAndView mv = new ModelAndView(); List<ProductCategoryDTO> categoryList =
	 * adminService.findCategoryList(); mv.addObject("categoryList", categoryList);
	 * mv.setViewName("admin/insertProduct"); return mv; }
	 * 
	 * @ResponseBody
	 * 
	 * @GetMapping("/nextProductNumber") public ResponseEntity<String>
	 * getNextProductNumber(@RequestParam Long id) { String nextProductNumber =
	 * adminService.getNextProductNumber(id); return
	 * ResponseEntity.ok(nextProductNumber); }
	 * 
	 * @PostMapping("/insertProduct")
	 * 
	 * @ResponseBody public ResponseEntity<?> registerProduct(@RequestParam
	 * Map<String, String> allParams, @RequestPart("file") MultipartFile file) {
	 * adminService.insertProduct(allParams, file); return
	 * ResponseEntity.ok("상품이 성공적으로 등록되었습니다."); }
	 * 
	 * @DeleteMapping("/deleteProducts")
	 * 
	 * @ResponseBody public ResponseEntity<String> deleteProducts(@RequestBody
	 * Map<String, List<String>> requestBody) { List<String> productNumbers =
	 * requestBody.get("productNumbers"); if (productNumbers == null ||
	 * productNumbers.isEmpty()) { return
	 * ResponseEntity.badRequest().body("삭제할 제품 번호가 없습니다."); }
	 * 
	 * try { adminService.deleteProductsByProductNumbers(productNumbers); } catch
	 * (Exception e) { // TODO Auto-generated catch block e.printStackTrace(); }
	 * return ResponseEntity.ok("선택된 제품이 성공적으로 삭제되었습니다."); }
	 * 
	 * @GetMapping("/stockManagement") public ModelAndView stockManagement() {
	 * ModelAndView mv = new ModelAndView();
	 * mv.setViewName("admin/stockManagement"); return mv; }
	 * 
	 * @GetMapping("/stockTransaction") public ModelAndView stockTransaction() {
	 * ModelAndView mv = new ModelAndView();
	 * mv.setViewName("admin/stockTransaction"); return mv; }
	 * 
	 * @GetMapping("/salesPost") public ModelAndView salesPost() { ModelAndView mv =
	 * new ModelAndView(); mv.setViewName("admin/salesPost"); return mv; }
	 * 
	 * @GetMapping("/salesInquiry") public ModelAndView salesInquiry() {
	 * ModelAndView mv = new ModelAndView(); mv.setViewName("admin/salesInquiry");
	 * return mv; }
	 * 
	 * @GetMapping("/salesReview") public ModelAndView salesReview() { ModelAndView
	 * mv = new ModelAndView(); mv.setViewName("admin/salesReview"); return mv; }
	 * 
	 * @GetMapping("/discountList") public ModelAndView discountList() {
	 * ModelAndView mv = new ModelAndView(); mv.setViewName("admin/discountList");
	 * return mv; }
	 * 
	 * @GetMapping("/discountManagement") public ModelAndView discountManagement() {
	 * ModelAndView mv = new ModelAndView();
	 * mv.setViewName("admin/discountManagement"); return mv; }
	 * 
	 * @GetMapping("/couponList") public ModelAndView couponList() { ModelAndView mv
	 * = new ModelAndView(); mv.setViewName("admin/couponList"); return mv; }
	 * 
	 * @GetMapping("/couponManagement") public ModelAndView couponManagement() {
	 * ModelAndView mv = new ModelAndView();
	 * mv.setViewName("admin/couponManagement"); return mv; }
	 * 
	 * @GetMapping("/orderList") public ModelAndView orderList() { ModelAndView mv =
	 * new ModelAndView(); mv.setViewName("admin/orderList"); return mv; }
	 * 
	 * @GetMapping("/deliveryList") public ModelAndView deliveryList() {
	 * ModelAndView mv = new ModelAndView(); mv.setViewName("admin/deliveryList");
	 * return mv; }
	 * 
	 * @GetMapping("/logout") public ModelAndView logout(HttpServletRequest request,
	 * HttpServletResponse response) { HttpSession session = request.getSession();
	 * session.invalidate();
	 * 
	 * // JWT 쿠키 삭제 Cookie cookie = new Cookie("jwt", null);
	 * cookie.setHttpOnly(true); cookie.setSecure(true); cookie.setPath("/");
	 * cookie.setMaxAge(0); // 쿠키 삭제 response.addCookie(cookie);
	 * 
	 * ModelAndView mv = new ModelAndView(); mv.setViewName("redirect:/login");
	 * return mv; }
	 * 
	 * private Map<String, String> convertEmptyStringsToNull(Map<String, String>
	 * params) { Map<String, String> result = new HashMap<>(); params.forEach((key,
	 * value) -> { result.put(key, value.isEmpty() ? null : value); }); return
	 * result; }
	 */
}
