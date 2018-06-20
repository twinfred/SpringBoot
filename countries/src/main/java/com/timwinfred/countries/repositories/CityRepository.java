package com.timwinfred.countries.repositories;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.countries.models.City;

public interface CityRepository extends CrudRepository<City, Long> {
	
	
}
