package com.timwinfred.licenses.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.licenses.models.Person;

public interface PersonRepository extends CrudRepository<Person, Long> {
	List<Person> findAll();
}
