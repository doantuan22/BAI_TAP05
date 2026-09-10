package com.example.bt_05.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bt_05.dto.UserForm;
import com.example.bt_05.entity.User;
import com.example.bt_05.exception.DuplicateResourceException;
import com.example.bt_05.exception.ResourceNotFoundException;
import com.example.bt_05.service.UserService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin/users")
public class UserController {

	private static final String REDIRECT_TO_LIST = "redirect:/admin/users";
	private static final int PAGE_SIZE = 10;

	private final UserService userService;

	public UserController(UserService userService) {
		this.userService = userService;
	}

	@GetMapping
	public String list(@RequestParam(required = false) String keyword,
			@RequestParam(defaultValue = "0") int page, Model model) {
		Pageable pageable = PageRequest.of(Math.max(page, 0), PAGE_SIZE, Sort.by("id").descending());
		Page<User> userPage = userService.search(keyword, pageable);
		model.addAttribute("userPage", userPage);
		model.addAttribute("users", userPage.getContent());
		model.addAttribute("keyword", keyword == null ? "" : keyword.trim());
		return "admin/user/list";
	}

	@GetMapping("/new")
	public String createForm(Model model) {
		model.addAttribute("userForm", new UserForm());
		return "admin/user/form";
	}

	@PostMapping
	public String create(@Valid @ModelAttribute("userForm") UserForm userForm,
			BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		if (!StringUtils.hasText(userForm.getPassword())) {
			bindingResult.rejectValue("password", "required", "Password is required");
		}
		if (bindingResult.hasErrors()) {
			return "admin/user/form";
		}

		try {
			userService.save(userForm.toEntity());
			redirectAttributes.addFlashAttribute("message", "User created successfully");
		} catch (DuplicateResourceException exception) {
			rejectDuplicateField(bindingResult, exception);
			return "admin/user/form";
		}
		return REDIRECT_TO_LIST;
	}

	@GetMapping("/{id}/edit")
	public String editForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
		try {
			User user = userService.findById(id)
					.orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + id));
			model.addAttribute("userForm", UserForm.fromEntity(user));
			return "admin/user/form";
		} catch (ResourceNotFoundException exception) {
			redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
			return REDIRECT_TO_LIST;
		}
	}

	@PostMapping("/{id}")
	public String update(@PathVariable Long id, @Valid @ModelAttribute("userForm") UserForm userForm,
			BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		userForm.setId(id);
		if (bindingResult.hasErrors()) {
			return "admin/user/form";
		}

		try {
			userService.update(id, userForm.toEntity());
			redirectAttributes.addFlashAttribute("message", "User updated successfully");
		} catch (DuplicateResourceException exception) {
			rejectDuplicateField(bindingResult, exception);
			return "admin/user/form";
		} catch (ResourceNotFoundException exception) {
			redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
		}
		return REDIRECT_TO_LIST;
	}

	@PostMapping("/{id}/delete")
	public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			userService.delete(id);
			redirectAttributes.addFlashAttribute("message", "User deleted successfully");
		} catch (ResourceNotFoundException exception) {
			redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
		}
		return REDIRECT_TO_LIST;
	}

	private void rejectDuplicateField(BindingResult bindingResult, DuplicateResourceException exception) {
		String field = exception.getField() == null ? "username" : exception.getField();
		bindingResult.rejectValue(field, "duplicate", exception.getMessage());
	}
}
