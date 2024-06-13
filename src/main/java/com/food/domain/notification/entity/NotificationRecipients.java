package com.food.domain.notification.entity;

import java.time.LocalDateTime;

import com.food.domain.user.entity.User;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "NOTIFICATION_RECIPIENTS_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationRecipients {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "NOTIFICATION_ID", nullable = false)
	private Notification notification;

	@ManyToOne
	@JoinColumn(name = "USER_ID", nullable = false)
	private User user;

	@Column(name = "READ_YN", length = 1, nullable = false)
	@Builder.Default
	private char readYn = 'N';

	@Column(name = "READ_DATE")
	private LocalDateTime readDate;
}