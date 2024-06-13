package com.food.domain.user.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "GUEST_TB", uniqueConstraints = {@UniqueConstraint(columnNames = "EMAIL")})
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Guest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "NAME", length = 50, nullable = false)
    private String name;

    @Column(name = "PHONE", length = 15)
    private String phone;

    @Column(name = "EMAIL", length = 200, nullable = false, unique = true)
    private String email;

    @Column(name = "PASSWORD", length = 255, nullable = false)
    private String password;

    @Column(name = "ADDRESS", length = 255)
    private String address;

    @Column(name = "ADDRESS_DETAIL", length = 255)
    private String addressDetail;

    @Column(name = "ZIPCODE", length = 10)
    private String zipcode;
}
