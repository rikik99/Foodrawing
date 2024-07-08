package com.food.domain.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.food.domain.user.dto.MemberRatingDTO;

@Mapper
public interface CustomerRatingMapper {
	  @Select("SELECT SUM(TOTAL_AMOUNT) " +
	            "FROM ORDER_TB " +
	            "WHERE IDENTIFIER_ID = #{customerId} " +
	            "AND IDENTIFIER_TYPE = 'CUSTOMER' " +
	            "AND ORDER_DATE >= ADD_MONTHS(SYSDATE, -3)")
	    Long getTotalAmountByCustomerId(Long customerId);

	    @Select("SELECT * " +
	            "FROM MEMBER_RATING_TB " +
	            "WHERE #{totalAmount} BETWEEN MIN_AMOUNT AND MAX_AMOUNT")
	    MemberRatingDTO getMemberRatingByTotalAmount(Long totalAmount);

	    @Select("SELECT CASE " +
	            "WHEN NVL(total.total_amount, 0) >= 300000 THEN 'VIP' " +
	            "WHEN NVL(total.total_amount, 0) >= 200000 THEN '프리미엄' " +
	            "WHEN NVL(total.total_amount, 0) >= 100000 THEN '우수회원' " +
	            "ELSE '일반회원' END AS rating " +
	            "FROM customer_tb c " +
	            "LEFT JOIN (SELECT identifier_id, SUM(total_amount) AS total_amount " +
	            "FROM order_tb GROUP BY identifier_id) total " +
	            "ON TO_CHAR(c.user_id) = total.identifier_id " +
	            "WHERE c.user_id = #{userId}")
	    String getCustomerRating(Long userId);
}
