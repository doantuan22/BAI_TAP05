package com.example.bt_05.service.impl;

import java.util.Locale;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.example.bt_05.entity.Category;
import com.example.bt_05.exception.DuplicateResourceException;
import com.example.bt_05.exception.ResourceNotFoundException;
import com.example.bt_05.repository.CategoryRepository;
import com.example.bt_05.service.CategoryService;

@Service
@Transactional(readOnly = true)
public class CategoryServiceImpl implements CategoryService {

	private final CategoryRepository categoryRepository;

	public CategoryServiceImpl(CategoryRepository categoryRepository) {
		this.categoryRepository = categoryRepository;
	}

	@Override
	public Optional<Category> findById(Long id) {
		return categoryRepository.findById(id);
	}

	@Override
	public Page<Category> search(String keyword, Pageable pageable) {
		if (!StringUtils.hasText(keyword)) {
			return categoryRepository.findAll(pageable);
		}

		String normalizedKeyword = keyword.trim().toLowerCase(Locale.ROOT);
		Specification<Category> specification = (root, query, criteriaBuilder) -> criteriaBuilder.like(
				criteriaBuilder.lower(root.get("name")), "%" + normalizedKeyword + "%");
		return categoryRepository.findAll(specification, pageable);
	}

	@Override
	@Transactional
	public Category save(Category category) {
		if (categoryRepository.existsByNameIgnoreCase(category.getName())) {
			throw new DuplicateResourceException("name", "Category name already exists: " + category.getName());
		}
		return categoryRepository.save(category);
	}

	@Override
	@Transactional
	public Category update(Long id, Category category) {
		Category existingCategory = getRequiredCategory(id);
		if (categoryRepository.existsByNameIgnoreCaseAndIdNot(category.getName(), id)) {
			throw new DuplicateResourceException("name", "Category name already exists: " + category.getName());
		}

		existingCategory.setName(category.getName());
		existingCategory.setDescription(category.getDescription());
		existingCategory.setStatus(category.isStatus());
		return categoryRepository.save(existingCategory);
	}

	@Override
	@Transactional
	public void delete(Long id) {
		categoryRepository.delete(getRequiredCategory(id));
	}

	private Category getRequiredCategory(Long id) {
		return categoryRepository.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("Category not found with id: " + id));
	}
}
