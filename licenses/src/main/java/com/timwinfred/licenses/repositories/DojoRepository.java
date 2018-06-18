package com.timwinfred.licenses.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.licenses.models.Dojo;

public interface DojoRepository extends CrudRepository<Dojo, Long> {
	List<Dojo> findAll();
}
