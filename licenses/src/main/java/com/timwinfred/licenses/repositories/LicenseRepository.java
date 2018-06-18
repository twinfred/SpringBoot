package com.timwinfred.licenses.repositories;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.licenses.models.License;

public interface LicenseRepository extends CrudRepository<License, Long> {
	License findFirstByOrderBySecretDesc();
}
