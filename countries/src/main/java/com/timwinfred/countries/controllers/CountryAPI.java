package com.timwinfred.countries.controllers;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.timwinfred.countries.services.CountryService;

@RestController
public class CountryAPI {
	private final CountryService cService;

	public CountryAPI(CountryService cService) {
		this.cService = cService;
	}
	
	// Query #1
	@RequestMapping("/api/query1")
	public List<Object[]> queryOne() {
		return cService.queryOne();
	}
	
	// Query #2
	@RequestMapping("/api/query2")
	public List<Object[]> queryTwo() {
		return cService.queryTwo();
	}
	
	// Query #3
	@RequestMapping("/api/query3")
	public List<Object[]> queryThree() {
		return cService.queryThree();
	}
	
	// Query #4
	@RequestMapping("/api/query4")
	public List<Object[]> queryFour() {
		return cService.queryFour();
	}
	
	// Query #5
	@RequestMapping("/api/query5")
	public List<Object[]> queryFive() {
		return cService.queryFive();
	}
	
	// Query #6
	@RequestMapping("/api/query6")
	public List<Object[]> querySix() {
		return cService.querySix();
	}
	
	// Query #7
	@RequestMapping("/api/query7")
	public List<Object[]> querySeven() {
		return cService.querySeven();
	}
	
	//Query #8
	@RequestMapping("/api/query8")
	public List<Object[]> queryEight() {
		return cService.queryEight();
	}
}
