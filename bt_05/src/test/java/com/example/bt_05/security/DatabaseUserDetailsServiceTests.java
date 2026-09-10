package com.example.bt_05.security;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.example.bt_05.entity.User;
import com.example.bt_05.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
class DatabaseUserDetailsServiceTests {

	@Mock
	private UserRepository userRepository;

	private DatabaseUserDetailsService userDetailsService;

	@BeforeEach
	void setUp() {
		userDetailsService = new DatabaseUserDetailsService(userRepository);
	}

	@Test
	void activeAdminReceivesAdminAuthority() {
		User user = new User();
		user.setUsername("admin");
		user.setPassword("bcrypt-hash");
		user.setRole("ADMIN");
		user.setStatus(true);
		when(userRepository.findByUsername("admin")).thenReturn(Optional.of(user));

		UserDetails details = userDetailsService.loadUserByUsername("admin");

		assertTrue(details.isEnabled());
		assertTrue(details.getAuthorities().stream()
				.anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN")));
	}

	@Test
	void inactiveUserIsDisabled() {
		User user = new User();
		user.setUsername("disabled");
		user.setPassword("bcrypt-hash");
		user.setRole("USER");
		user.setStatus(false);
		when(userRepository.findByUsername("disabled")).thenReturn(Optional.of(user));

		UserDetails details = userDetailsService.loadUserByUsername("disabled");

		assertFalse(details.isEnabled());
	}

	@Test
	void unknownUsernameIsRejected() {
		when(userRepository.findByUsername("missing")).thenReturn(Optional.empty());

		assertThrows(UsernameNotFoundException.class,
				() -> userDetailsService.loadUserByUsername("missing"));
	}
}
