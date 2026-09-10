package com.example.bt_05.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.example.bt_05.entity.User;

public interface UserService {

	List<User> findAll();

	Optional<User> findById(Long id);

	Page<User> search(String keyword, Pageable pageable);

	User save(User user);

	User update(Long id, User user);

	void delete(Long id);
}
