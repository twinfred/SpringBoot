package com.timwinfred.countries.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.timwinfred.countries.repositories.CountryRepository;

@Service
public class CountryService {
	private final CountryRepository cRepo;

	public CountryService(CountryRepository cRepo) {
		this.cRepo = cRepo;
	}
	
	// Query #1
	public List<Object[]> queryOne() {
		return cRepo.queryOne();
	}
	
	// Query #2
	public List<Object[]> queryTwo() {
		return cRepo.queryTwo();
	}
	
	// Query #3
	public List<Object[]> queryThree() {
		return cRepo.queryThree();
	}
	
	// Query #4
	public List<Object[]> queryFour() {
		return cRepo.queryFour();
	}
	
	// Query #5
	public List<Object[]> queryFive() {
		return cRepo.queryFive();
	}
	
	// Query #6
	public List<Object[]> querySix() {
		return cRepo.querySix();
	}
	
	// Query #7
	public List<Object[]> querySeven() {
		return cRepo.querySeven();
	}
	
	// Query #8
	public List<Object[]> queryEight() {
		return cRepo.queryEight();
	}
}
