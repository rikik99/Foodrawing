package com.food.domain.user.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CustomerDTO {
    private Long id;
    private Long userId;
    private String nickname;
    private String name;
    private String gender;
    private String phone;
    private String email;
    private Date birthDate;
    private String address;
    private String addressDetail;
    private String zipcode;
    private String refundAccount;
    private String refundBank;

    public Date getBirthDate() {
        return birthDate != null ? birthDate : new Date(); // 기본값 설정, 필요에 따라 변경
    }
}
