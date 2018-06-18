package com.timwinfred.licenses.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.timwinfred.licenses.models.Ninja;
import com.timwinfred.licenses.repositories.NinjaRepository;

@Service
public class NinjaService {
	private final NinjaRepository ninjaRepository;

	public NinjaService(NinjaRepository ninjaRepository) {
		this.ninjaRepository = ninjaRepository;
	}
	
	// get all ninjas
	public List<Ninja> getAllNinjas() {
		return ninjaRepository.findAll();
	}
	
	// create a ninja
	public Ninja createNinja(Ninja ninja) {
		return ninjaRepository.save(ninja);
	}
}
