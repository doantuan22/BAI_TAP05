package com.example.bt_05.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.example.bt_05.entity.Category;

public interface CategoryRepository
		extends JpaRepository<Category, Long>, JpaSpecificationExecutor<Category> {
}
