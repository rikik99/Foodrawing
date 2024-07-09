package com.food.domain.user.mapper;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderDetailDTO;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductCategoryMappingDTO;
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

	void updateCategoryById(int categoryId);

	void insertProductCategoryMapping(String productNumber, int categoryId);

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

	Long findAdminByUserId(Long userId);

	void updateQuantity(Map<String, Object> allParams);

	List<InquiriesDTO> findSalesInquiries();

	SalesPostDTO findSalesPostById(Long salesPostId);

	List<InquiriesDTO> findSalesInquiriesWithSearch(Map<String, String> allParams);

	CustomerDTO findCustomerByCustomerId(Long customerId);

	void insertResponse(Map<String, Object> allParams);

	ResponseDTO findResponseByInquiryId(Long inquiryId);

	void updateResolvedYn(Map<String, Object> allParams);

	List<ReviewDTO> findReviews();

	ReviewsReplyDTO findReplyByReviewId(Long reviewId);

	ReviewFileDTO findReviewFileByReviewId(Long reviewId);

	List<ReviewDTO> findReviewsWithSearch(Map<String, String> allParams);

	void insertReply(Map<String, Object> allParams);

	void updateReplyYn(Map<String, Object> allParams);

	List<DiscountDTO> findDisconts();

	List<DiscountDTO> findDiscountsWithSearch(Map<String, String> allParams);

	void updateDiscount(Map<String, Object> params);

	void insertDiscount(Map<String, Object> allParams);

	void deleteDiscountsById(Long discountId);

	MemberRatingDTO findMemberRatingById(Long memberId);

	String findUserNameById(Long userId);

	ProductCategoryDTO findProductCategoryById(Long categoryId);

	List<DiscountTargetDTO> findDiscountTargetListWithSearch(Map<String, String> allParams);

	List<ProductDTO> findProductsByQuery(String keyword, Pageable pageable);

	long countProductsByQuery(String keyword);

	List<CustomerDTO> findCustomersByQuery(String keyword, Pageable pageable);

	UserDTO findUserById(Long userId);

	long countCustomersByQuery(String keyword);

	void insertDiscountTarget(DiscountTargetDTO discountTargetDTO);

	DiscountDTO findDiscountById(Long discountId);

	List<DiscountTargetDTO> findDiscountTargets();

	List<DiscountTargetDTO> findDiscountTargetById(Long discountId);

	void deleteDiscountTargetById(Long discountTargetId);

	List<DiscountTargetDTO> findDiscountTargetByType(String targetType);

	List<MemberRatingDTO> findAllMemberRatings();

	void updateDiscountTarget(Map<String, Object> params);

	List<CouponIssuanceDTO> findCouponIssuancesWithSearch(Map<String, String> allParams);

	List<CouponIssuanceDTO> findCouponIssuances();

	void deleteCouponIssuancesById(Long couponIssuanceId);

	List<DiscountDTO> findDiscountListWithType();

	List<CustomerDTO> findCustomerList();

	Long getTotalAmountByCustomerId(Long customerId);

	MemberRatingDTO getMemberRatingByTotalAmount(Long totalAmount);

	void insertCouponToCustomer(Long couponId, Long customerId, String couponNumber);

	List<Long> findAllCustomerIds();

	OrderStatusDTO findOrderStatusByOrderId(Long orderId);

	List<OrderDetailDTO> findOrderDetailListByOrderId(Long orderId);

	List<OrderDTO> findOrders();

	List<OrderDTO> findOrdersWithSearch(Map<String, String> allParams);

	List<OrderDTO> findPaymentCompletedOrders();

	List<OrderDTO> findPaymentCompletedOrdersWithSearch(Map<String, String> allParams);

	int updateOrderStatus(Long orderId, String status);

	List<Long> findOrdersToConfirm(LocalDateTime oneWeekAgo);

	void updateSalesPost(SalesPostDTO salesPost);

	void deleteSalesPostFile(Long salesPostId);

	void updateProduct(Map<String, String> allParams);

	void deleteProductFile(String productNumber);

	void updateProductCategoryMapping(String productNumber, int categoryId);

	void updateProductCategoryMapping(ProductCategoryMappingDTO mapping);

	Integer findCategoryIdByProductNumber(String productNumber);

	void updateProductNumberInCategoryMapping(String oldProductNumber, String newProductNumber);

	void updateProductNumber(String oldProductNumber, String newProductNumber);

	void updateProductCategoryMappingNumber(String oldProductNumber, String newProductNumber);

	void updateProductFileNumber(String oldProductNumber, String newProductNumber);

	void insertStockByProductNumber(String productNumber);

	List<CouponIssuanceDTO> findCouponIssuancesByCustomerId(Long customerId);

	List<OrderDTO> findOrdersByCustomerId(Long customerId);

	List<InquiriesDTO> findInquiriesByCustomerId(Long customerId);

	Long findTotalOrderAmount(Long customerId);

	Long findTotalReservesByCustomerId(Long customerId);

	List<AdminDTO> findAdminList();

	void createAdmin(Map<String, Object> allParams);

	void createAdminUser(Map<String, Object> allParams);

	void updateDiscountStatus(Long discountId, String newStatus);

	List<InquiriesDTO> getInquiriesByCustomerId(Long customerId);

	List<AdminDTO> findAdminsWithSearch(Map<String, String> allParams);

	AdminDTO findAdminDTOByUserId(Long userId);

	CustomerDTO findCustomerByUserId(Long userId);

	List<UserDTO> findUserListWhereDeletedY();

	Long findMainTotalOrderAmount();

	List<UserDTO> findAllUsers();

	List<Map<String, Object>> findOrderStatusCounts();

	List<SalesPostDTO> findPopularProducts();

	List<Map<String, Object>> findRecentOrderStatusCounts();

	void deleteSalesPostsById(Long salesPostId);
}
