package com.example.bt_05.entity;

import java.time.LocalDateTime;
import java.time.ZoneOffset;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

@Entity
@Table(name = "app_user", schema = "dbo")
@Getter
@Setter
@NoArgsConstructor
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false, unique = true, length = 100)
	@Nationalized
	private String username;

	@Column(nullable = false, length = 255)
	@Nationalized
	private String password;

	@Column(name = "full_name", length = 255)
	@Nationalized
	private String fullName;

	@Column(nullable = false, unique = true, length = 255)
	@Nationalized
	private String email;

	@Column(length = 20)
	@Nationalized
	private String phone;

	@Column(nullable = false, length = 20)
	@Nationalized
	private String role = "ADMIN";

	@Column(nullable = false)
	private boolean status = true;

	@Column(name = "created_at", nullable = false)
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	@PrePersist
	void prePersist() {
		if (createdAt == null) {
			createdAt = LocalDateTime.now(ZoneOffset.UTC);
		}
	}

	@PreUpdate
	void preUpdate() {
		updatedAt = LocalDateTime.now(ZoneOffset.UTC);
	}
}
