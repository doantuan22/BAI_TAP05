package com.example.bt_05.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.example.bt_05.entity.Category;

public interface CategoryService {

	List<Category> findAll();

	Optional<Category> findById(Long id);

	Page<Category> search(String keyword, Pageable pageable);

	Category save(Category category);

	Category update(Long id, Category category);

	void delete(Long id);
}
