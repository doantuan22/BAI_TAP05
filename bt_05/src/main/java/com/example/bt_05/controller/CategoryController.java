package com.example.bt_05.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bt_05.dto.CategoryForm;
import com.example.bt_05.entity.Category;
import com.example.bt_05.exception.DuplicateResourceException;
import com.example.bt_05.exception.ResourceNotFoundException;
import com.example.bt_05.service.CategoryService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

	private static final String REDIRECT_TO_LIST = "redirect:/admin/categories";
	private static final int PAGE_SIZE = 10;

	private final CategoryService categoryService;

	public CategoryController(CategoryService categoryService) {
		this.categoryService = categoryService;
	}

	@GetMapping
	public String list(@RequestParam(required = false) String keyword,
			@RequestParam(defaultValue = "0") int page, Model model) {
		Pageable pageable = PageRequest.of(Math.max(page, 0), PAGE_SIZE, Sort.by("id").descending());
		Page<Category> categoryPage = categoryService.search(keyword, pageable);
		model.addAttribute("categoryPage", categoryPage);
		model.addAttribute("categories", categoryPage.getContent());
		model.addAttribute("keyword", keyword == null ? "" : keyword.trim());
		return "admin/category/list";
	}

	@GetMapping("/new")
	public String createForm(Model model) {
		model.addAttribute("categoryForm", new CategoryForm());
		return "admin/category/form";
	}

	@PostMapping
	public String create(@Valid @ModelAttribute("categoryForm") CategoryForm categoryForm,
			BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		if (bindingResult.hasErrors()) {
			return "admin/category/form";
		}

		try {
			categoryService.save(categoryForm.toEntity());
			redirectAttributes.addFlashAttribute("message", "Category created successfully");
		} catch (DuplicateResourceException exception) {
			bindingResult.rejectValue("name", "duplicate", exception.getMessage());
			return "admin/category/form";
		}
		return REDIRECT_TO_LIST;
	}

	@GetMapping("/{id}/edit")
	public String editForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
		try {
			Category category = categoryService.findById(id)
					.orElseThrow(() -> new ResourceNotFoundException("Category not found with id: " + id));
			model.addAttribute("categoryForm", CategoryForm.fromEntity(category));
			return "admin/category/form";
		} catch (ResourceNotFoundException exception) {
			redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
			return REDIRECT_TO_LIST;
		}
	}

	@PostMapping("/{id}")
	public String update(@PathVariable Long id,
			@Valid @ModelAttribute("categoryForm") CategoryForm categoryForm,
			BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		categoryForm.setId(id);
		if (bindingResult.hasErrors()) {
			return "admin/category/form";
		}

		try {
			categoryService.update(id, categoryForm.toEntity());
			redirectAttributes.addFlashAttribute("message", "Category updated successfully");
		} catch (DuplicateResourceException exception) {
			bindingResult.rejectValue("name", "duplicate", exception.getMessage());
			return "admin/category/form";
		} catch (ResourceNotFoundException exception) {
			redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
		}
		return REDIRECT_TO_LIST;
	}

	@PostMapping("/{id}/delete")
	public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			categoryService.delete(id);
			redirectAttributes.addFlashAttribute("message", "Category deleted successfully");
		} catch (ResourceNotFoundException exception) {
			redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
		}
		return REDIRECT_TO_LIST;
	}
}
