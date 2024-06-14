package com.food.domain.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.user.dto.UserSocialLinksDTO;

@Mapper
public interface UserSocialLinksMapper {

	void insertLinks(UserSocialLinksDTO socialLink);

	UserSocialLinksDTO findByProviderAndProviderId(@Param("provider") String provider, @Param("providerId") String providerId);

	List<UserSocialLinksDTO> findByUserId(Long userId);

}
