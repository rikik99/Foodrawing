package com.food.domain.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.dto.VerificationTokenDTO;

@Mapper
public interface UserMapper {

	// 인증 토큰 관련 메서드
	void insertToken(VerificationTokenDTO token);

	VerificationTokenDTO findByToken(@Param("token") String token);

	void deleteToken(@Param("email") String email);

	Integer isEmailVerified(String email);

	void updateEmailVerified(@Param("email") String email, @Param("verified") String verified);

	void insertUser(UserDTO userDTO);

	UserDTO loadUser(String username);

	boolean isUserIdExists(String userName);

	UserDTO findByUsername(String userName);

	String findUsernameByEmail(String email);

	void updatePasswordByEmail(@Param("email") String email, @Param("password") String newPassword);

}
