package com.example.bt_05.service;

import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentMatchers;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import com.example.bt_05.entity.Category;
import com.example.bt_05.exception.DuplicateResourceException;
import com.example.bt_05.exception.ResourceNotFoundException;
import com.example.bt_05.repository.CategoryRepository;
import com.example.bt_05.service.impl.CategoryServiceImpl;

@ExtendWith(MockitoExtension.class)
class CategoryServiceImplTests {

	@Mock
	private CategoryRepository categoryRepository;

	private CategoryServiceImpl categoryService;

	@BeforeEach
	void setUp() {
		categoryService = new CategoryServiceImpl(categoryRepository);
	}

	@Test
	void searchUsesSpecificationWhenKeywordIsPresent() {
		Pageable pageable = PageRequest.of(0, 10);
		Page<Category> expectedPage = new PageImpl<>(java.util.List.of(new Category()));
		when(categoryRepository.findAll(ArgumentMatchers.<Specification<Category>>any(), any(Pageable.class)))
				.thenReturn(expectedPage);

		Page<Category> result = categoryService.search("phone", pageable);

		assertSame(expectedPage, result);
		verify(categoryRepository).findAll(ArgumentMatchers.<Specification<Category>>any(), any(Pageable.class));
	}

	@Test
	void saveRejectsDuplicateName() {
		Category category = new Category();
		category.setName("Electronics");
		when(categoryRepository.existsByNameIgnoreCase("Electronics")).thenReturn(true);

		assertThrows(DuplicateResourceException.class, () -> categoryService.save(category));
	}

	@Test
	void updateRejectsMissingCategory() {
		when(categoryRepository.findById(99L)).thenReturn(Optional.empty());

		assertThrows(ResourceNotFoundException.class, () -> categoryService.update(99L, new Category()));
	}
}
