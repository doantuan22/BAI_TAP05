package com.example.bt_05.dto;

import com.example.bt_05.entity.User;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class UserForm {

	private Long id;

	@NotBlank(message = "Username is required")
	@Size(max = 100, message = "Username must not exceed 100 characters")
	private String username;

	@Pattern(regexp = "^$|.{8,72}$", message = "Password must contain between 8 and 72 characters")
	private String password;

	@Size(max = 255, message = "Full name must not exceed 255 characters")
	private String fullName;

	@NotBlank(message = "Email is required")
	@Email(message = "Email is not valid")
	@Size(max = 255, message = "Email must not exceed 255 characters")
	private String email;

	@Pattern(regexp = "^$|[0-9+(). -]{6,20}$", message = "Phone number is not valid")
	private String phone;

	@NotBlank(message = "Role is required")
	@Pattern(regexp = "ADMIN|USER", message = "Role must be ADMIN or USER")
	private String role = "ADMIN";

	private boolean status = true;

	public static UserForm fromEntity(User user) {
		UserForm form = new UserForm();
		form.setId(user.getId());
		form.setUsername(user.getUsername());
		form.setFullName(user.getFullName());
		form.setEmail(user.getEmail());
		form.setPhone(user.getPhone());
		form.setRole(user.getRole());
		form.setStatus(user.isStatus());
		return form;
	}

	public User toEntity() {
		User user = new User();
		user.setId(id);
		user.setUsername(username);
		user.setPassword(password);
		user.setFullName(fullName);
		user.setEmail(email);
		user.setPhone(phone);
		user.setRole(role);
		user.setStatus(status);
		return user;
	}
}
