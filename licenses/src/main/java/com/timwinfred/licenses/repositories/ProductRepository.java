package com.timwinfred.licenses.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.licenses.models.Product;

public interface ProductRepository extends CrudRepository<Product, Long> {
	List<Product> findAll();
}
