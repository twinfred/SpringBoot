package com.timwinfred.licenses.services;

import org.springframework.stereotype.Service;

import com.timwinfred.licenses.models.License;
import com.timwinfred.licenses.repositories.LicenseRepository;

@Service
public class LicenseService {
	private final LicenseRepository licenseRepository;

	public LicenseService(LicenseRepository licenseRepository) {
		this.licenseRepository = licenseRepository;
	}
	
	// create a license
	public License createLicense(License license) {
		return licenseRepository.save(license);
	}

	public License findLast() {
		return licenseRepository.findFirstByOrderBySecretDesc();
	}
}
