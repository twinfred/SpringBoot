package com.timwinfred.licenses.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.licenses.models.Category;
import com.timwinfred.licenses.models.Product;
import com.timwinfred.licenses.repositories.CategoryRepository;
import com.timwinfred.licenses.repositories.ProductRepository;

@Service
public class CategoryService {
	private final ProductRepository productRepository;
	private final CategoryRepository categoryRepository;

	public CategoryService(ProductRepository productRepository, CategoryRepository categoryRepository) {
		this.productRepository = productRepository;
		this.categoryRepository = categoryRepository;
	}
	
	// get all products
	public List<Category> getAllCategories() {
		return categoryRepository.findAll();
	}
	
	// get a single category
	public Category getCategory(Long id) {
		Optional<Category> optionalCategory = categoryRepository.findById(id);
		if(optionalCategory.isPresent()) {
			return optionalCategory.get();
		} else {
			return null;
		}
	}
	
	// create a category
	public Category createCategory(Category category) {
		return categoryRepository.save(category);
	}
	
	// add a product to a category
	public Category addProductToCategory(Long categoryId, Long productID) {
		Optional<Category> optionalCategory = categoryRepository.findById(categoryId);
		if(optionalCategory.isPresent()) {
			Optional<Product> optionalProduct = productRepository.findById(productID);
			if(optionalProduct.isPresent()) {
				Category myCategory = optionalCategory.get();
				Product myProduct = optionalProduct.get();
				myProduct.addCategory(myCategory);
				return categoryRepository.save(myCategory);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
}
