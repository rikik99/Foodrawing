package com.food.domain.user.dto;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
    private Long id;
    private String username;
    private String password;
    private Long role;
    private LocalDateTime createdDate;
    private String deletedYn;
    private Date birthDate; // birthDate 필드 추가

    // 기타 필드와 메서드들

    public Date getBirthDate() {
        return birthDate;
    }
}
