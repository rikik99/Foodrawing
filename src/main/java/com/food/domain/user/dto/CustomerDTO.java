package com.food.domain.user.dto;

import java.util.Date;

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

    // Default Constructor
    public CustomerDTO() {
    }

    // All Arguments Constructor
    public CustomerDTO(Long id, Long userId, String nickname, String name, String gender, String phone, String email, Date birthDate, String address, String addressDetail, String zipcode, String refundAccount, String refundBank) {
        this.id = id;
        this.userId = userId;
        this.nickname = nickname;
        this.name = name;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.birthDate = birthDate;
        this.address = address;
        this.addressDetail = addressDetail;
        this.zipcode = zipcode;
        this.refundAccount = refundAccount;
        this.refundBank = refundBank;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getRefundAccount() {
        return refundAccount;
    }

    public void setRefundAccount(String refundAccount) {
        this.refundAccount = refundAccount;
    }

    public String getRefundBank() {
        return refundBank;
    }

    public void setRefundBank(String refundBank) {
        this.refundBank = refundBank;
    }
}
