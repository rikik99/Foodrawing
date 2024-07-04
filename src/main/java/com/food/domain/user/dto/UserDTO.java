package com.food.domain.user.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
	
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");

    public String getFormattedCreatedDate() {
        if (createdDate != null) {
            return createdDate.format(formatter);
        }
        return "";
    }
}
