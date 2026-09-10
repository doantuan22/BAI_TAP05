package com.example.bt_05.dto;

import com.example.bt_05.entity.Category;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CategoryForm {

	private Long id;

	@NotBlank(message = "Name is required")
	@Size(max = 255, message = "Name must not exceed 255 characters")
	private String name;

	@Size(max = 1000, message = "Description must not exceed 1000 characters")
	private String description;

	private boolean status = true;

	public static CategoryForm fromEntity(Category category) {
		CategoryForm form = new CategoryForm();
		form.setId(category.getId());
		form.setName(category.getName());
		form.setDescription(category.getDescription());
		form.setStatus(category.isStatus());
		return form;
	}

	public Category toEntity() {
		Category category = new Category();
		category.setId(id);
		category.setName(name);
		category.setDescription(description);
		category.setStatus(status);
		return category;
	}
}
