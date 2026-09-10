package com.example.bt_05.security;

import java.util.Locale;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.bt_05.entity.User;
import com.example.bt_05.repository.UserRepository;

@Service
public class DatabaseUserDetailsService implements UserDetailsService {

	private final UserRepository userRepository;

	public DatabaseUserDetailsService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User appUser = userRepository.findByUsername(username)
				.orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

		String role = appUser.getRole().trim().toUpperCase(Locale.ROOT);
		String authority = role.startsWith("ROLE_") ? role : "ROLE_" + role;
		return org.springframework.security.core.userdetails.User.withUsername(appUser.getUsername())
				.password(appUser.getPassword())
				.authorities(authority)
				.disabled(!appUser.isStatus())
				.build();
	}
}
