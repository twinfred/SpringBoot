package com.timwinfred.licenses.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.licenses.models.Ninja;

public interface NinjaRepository extends CrudRepository<Ninja, Long> {
	List<Ninja> findAll();
}
