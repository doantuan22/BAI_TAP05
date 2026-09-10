package com.example.bt_05.service.impl;

import java.util.List;
import java.util.Locale;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.example.bt_05.entity.User;
import com.example.bt_05.exception.DuplicateResourceException;
import com.example.bt_05.exception.ResourceNotFoundException;
import com.example.bt_05.repository.UserRepository;
import com.example.bt_05.service.UserService;

@Service
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

	@Override
	public Optional<User> findById(Long id) {
		return userRepository.findById(id);
	}

	@Override
	public Page<User> search(String keyword, Pageable pageable) {
		if (!StringUtils.hasText(keyword)) {
			return userRepository.findAll(pageable);
		}

		String normalizedKeyword = keyword.trim().toLowerCase(Locale.ROOT);
		Specification<User> specification = (root, query, criteriaBuilder) -> criteriaBuilder.or(
				criteriaBuilder.like(criteriaBuilder.lower(root.get("username")), "%" + normalizedKeyword + "%"),
				criteriaBuilder.like(criteriaBuilder.lower(root.get("email")), "%" + normalizedKeyword + "%"));
		return userRepository.findAll(specification, pageable);
	}

	@Override
	@Transactional
	public User save(User user) {
		validateUniqueFieldsForCreate(user);
		if (user.getPassword() == null || user.getPassword().isBlank()) {
			throw new IllegalArgumentException("Password must not be blank");
		}
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		return userRepository.save(user);
	}

	@Override
	@Transactional
	public User update(Long id, User user) {
		User existingUser = getRequiredUser(id);
		validateUniqueFieldsForUpdate(id, user);

		existingUser.setUsername(user.getUsername());
		existingUser.setFullName(user.getFullName());
		existingUser.setEmail(user.getEmail());
		existingUser.setPhone(user.getPhone());
		existingUser.setRole(user.getRole());
		existingUser.setStatus(user.isStatus());
		if (user.getPassword() != null && !user.getPassword().isBlank()) {
			existingUser.setPassword(passwordEncoder.encode(user.getPassword()));
		}
		return userRepository.save(existingUser);
	}

	@Override
	@Transactional
	public void delete(Long id) {
		userRepository.delete(getRequiredUser(id));
	}

	private void validateUniqueFieldsForCreate(User user) {
		if (userRepository.existsByUsernameIgnoreCase(user.getUsername())) {
			throw new DuplicateResourceException("username", "Username already exists: " + user.getUsername());
		}
		if (userRepository.existsByEmailIgnoreCase(user.getEmail())) {
			throw new DuplicateResourceException("email", "Email already exists: " + user.getEmail());
		}
	}

	private void validateUniqueFieldsForUpdate(Long id, User user) {
		if (userRepository.existsByUsernameIgnoreCaseAndIdNot(user.getUsername(), id)) {
			throw new DuplicateResourceException("username", "Username already exists: " + user.getUsername());
		}
		if (userRepository.existsByEmailIgnoreCaseAndIdNot(user.getEmail(), id)) {
			throw new DuplicateResourceException("email", "Email already exists: " + user.getEmail());
		}
	}

	private User getRequiredUser(Long id) {
		return userRepository.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + id));
	}
}
