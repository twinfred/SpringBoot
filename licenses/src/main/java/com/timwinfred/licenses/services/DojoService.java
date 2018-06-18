package com.timwinfred.licenses.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.licenses.models.Dojo;
import com.timwinfred.licenses.repositories.DojoRepository;

@Service
public class DojoService {
	private final DojoRepository dojoRepository;

	public DojoService(DojoRepository dojoRepository) {
		this.dojoRepository = dojoRepository;
	}
	
	// get all dojos
	public List<Dojo> getAllDojos() {
		return dojoRepository.findAll();
	}
	
	// get a single dojo
	public Dojo findDojo(Long id) {
		Optional<Dojo> optionalDojo = dojoRepository.findById(id);
		if(optionalDojo.isPresent()) {
			return optionalDojo.get();
		} else {
			return null;
		}
	}
	
	// create a dojo
	public Dojo createDojo(Dojo dojo) {
		return dojoRepository.save(dojo);
	}
}
