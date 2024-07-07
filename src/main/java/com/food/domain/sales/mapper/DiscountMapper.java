package com.food.domain.sales.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import com.food.domain.sales.dto.Discount2DTO;

@Mapper
public interface DiscountMapper {

    @Select("SELECT * FROM DISCOUNT_TB WHERE ID = #{id}")
    Discount2DTO findDiscountById(Long id);

    @Select("SELECT * FROM DISCOUNT_TB WHERE CATEGORY_ID = #{categoryId}")
    List<Discount2DTO> findCategoryTargetDiscount(Long categoryId);

    @Select("SELECT * FROM DISCOUNT_TB WHERE PRODUCT_ID = #{productId}")
    List<Discount2DTO> findProductTargetDiscount(Long productId);

    @Select("SELECT D.*, P.NAME AS PRODUCT_NAME, P.DESCRIPTION AS PRODUCT_DESCRIPTION, " +
            "P.PRICE AS ORIGINAL_PRICE, ((P.PRICE * (100 - D.DISCOUNT_VALUE)) / 100.0) AS DISCOUNTED_PRICE, " +
            "PF.FILE_PATH AS PRODUCT_FILE_PATH " +
            "FROM DISCOUNT_TB D " +
            "JOIN DISCOUNT_TARGET_TB DT ON D.ID = DT.DISCOUNT_ID " +
            "JOIN PRODUCT_TB P ON DT.TARGET_ID = P.PRODUCT_NUMBER " +
            "JOIN PRODUCT_FILE_TB PF ON P.PRODUCT_NUMBER = PF.PRODUCT_NUMBER " +
            "WHERE DT.TARGET_TYPE = 'PRODUCT' AND SYSDATE BETWEEN D.START_DATE AND D.END_DATE")
    List<Discount2DTO> findDiscountProducts();
}
