package com.timwinfred.mvc.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.timwinfred.mvc.models.Book;

@Repository	
public interface BookRepository extends CrudRepository<Book, Long> {
	List<Book> findAll();
	List<Book> findByDescriptionContaining(String search);
	void deleteById(Long id);
}
