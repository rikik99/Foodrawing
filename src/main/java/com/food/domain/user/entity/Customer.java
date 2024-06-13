package com.food.domain.user.entity;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "CUSTOMER_TB", uniqueConstraints = {@UniqueConstraint(columnNames = "EMAIL")})
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Column(name = "NICKNAME", length = 50, nullable = false)
    private String nickname;

    @Column(name = "NAME", length = 50, nullable = false)
    private String name;

    @Column(name = "GENDER", length = 1, nullable = false)
    private char gender;

    @Column(name = "PHONE", length = 15)
    private String phone;

    @Column(name = "EMAIL", length = 200, nullable = false, unique = true)
    private String email;

    @Column(name = "BIRTHDATE", nullable = false)
    private LocalDate birthdate;

    @Column(name = "ADDRESS", length = 255, nullable = false)
    private String address;

    @Column(name = "ADDRESS_DETAIL", length = 255, nullable = false)
    private String addressDetail;

    @Column(name = "ZIPCODE", length = 10, nullable = false)
    private String zipcode;
}
