package com.timwinfred.licenses.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.licenses.models.Category;

public interface CategoryRepository extends CrudRepository<Category, Long> {
	List<Category> findAll();
}
