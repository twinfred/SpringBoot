package com.timwinfred.licenses.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.licenses.models.Category;
import com.timwinfred.licenses.models.Product;
import com.timwinfred.licenses.repositories.CategoryRepository;
import com.timwinfred.licenses.repositories.ProductRepository;

@Service
public class ProductService {
	private final ProductRepository productRepository;
	private final CategoryRepository categoryRepository;

	public ProductService(ProductRepository productRepository, CategoryRepository categoryRepository) {
		this.productRepository = productRepository;
		this.categoryRepository = categoryRepository;
	}
	
	// get all products
	public List<Product> getAllProducts() {
		return productRepository.findAll();
	}
	
	// get a single product
	public Product getProduct(Long id) {
		Optional<Product> optionalProduct = productRepository.findById(id);
		if(optionalProduct.isPresent()) {
			return optionalProduct.get();
		} else {
			return null;
		}
	}
	
	// create a product
	public Product createProduct(Product product) {
		return productRepository.save(product);
	}
	
	// add a category to a product
	public Product addCategoryToProduct(Long productID, Long categoryId) {
		Optional<Product> optionalProduct = productRepository.findById(productID);
		if(optionalProduct.isPresent()) {
			Optional<Category> optionalCategory = categoryRepository.findById(categoryId);
			if(optionalCategory.isPresent()) {
				Product myProduct = optionalProduct.get();
				Category myCategory = optionalCategory.get();
				myCategory.addProduct(myProduct);
				return productRepository.save(myProduct);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
}
