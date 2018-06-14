package com.timwinfred.languages.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.languages.models.Language;

public interface LanguageRepository  extends CrudRepository<Language, Long> {
	List<Language> findAll();
	void deleteById(Long id);
}
