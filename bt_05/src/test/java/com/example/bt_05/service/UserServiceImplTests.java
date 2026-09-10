package com.example.bt_05.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.bt_05.entity.User;
import com.example.bt_05.exception.DuplicateResourceException;
import com.example.bt_05.repository.UserRepository;
import com.example.bt_05.service.impl.UserServiceImpl;

@ExtendWith(MockitoExtension.class)
class UserServiceImplTests {

	@Mock
	private UserRepository userRepository;

	@Mock
	private PasswordEncoder passwordEncoder;

	private UserServiceImpl userService;

	@BeforeEach
	void setUp() {
		userService = new UserServiceImpl(userRepository, passwordEncoder);
	}

	@Test
	void saveEncodesPassword() {
		User user = validUser();
		when(passwordEncoder.encode("Admin@123")).thenReturn("bcrypt-hash");
		when(userRepository.save(user)).thenReturn(user);

		User savedUser = userService.save(user);

		assertSame(user, savedUser);
		assertEquals("bcrypt-hash", savedUser.getPassword());
		verify(passwordEncoder).encode("Admin@123");
	}

	@Test
	void saveRejectsDuplicateEmail() {
		User user = validUser();
		when(userRepository.existsByEmailIgnoreCase(user.getEmail())).thenReturn(true);

		assertThrows(DuplicateResourceException.class, () -> userService.save(user));
		verify(passwordEncoder, never()).encode(user.getPassword());
	}

	@Test
	void updateKeepsCurrentPasswordWhenNewPasswordIsBlank() {
		User existingUser = validUser();
		existingUser.setId(1L);
		existingUser.setPassword("current-hash");
		User changes = validUser();
		changes.setPassword("");
		when(userRepository.findById(1L)).thenReturn(Optional.of(existingUser));
		when(userRepository.save(existingUser)).thenReturn(existingUser);

		User updatedUser = userService.update(1L, changes);

		assertEquals("current-hash", updatedUser.getPassword());
		verify(passwordEncoder, never()).encode("");
	}

	private User validUser() {
		User user = new User();
		user.setUsername("admin");
		user.setPassword("Admin@123");
		user.setEmail("admin@shopbanhang.local");
		user.setRole("ADMIN");
		user.setStatus(true);
		return user;
	}
}
