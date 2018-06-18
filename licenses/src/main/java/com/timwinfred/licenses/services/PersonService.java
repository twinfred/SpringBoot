package com.timwinfred.licenses.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.licenses.models.Person;
import com.timwinfred.licenses.repositories.PersonRepository;

@Service
public class PersonService {
	private final PersonRepository personRepository;

	public PersonService(PersonRepository personRepository) {
		this.personRepository = personRepository;
	}
	
	// get all persons
	public List<Person> allPersons() {
		return personRepository.findAll();
	}
	
	// create a person
	public Person createPerson(Person person) {
		return personRepository.save(person);
	}
	
	// returns a single person
	public Person findPerson(Long id) {
		Optional<Person> optionalPerson = personRepository.findById(id);
		if(optionalPerson.isPresent()) {
			return optionalPerson.get();
		} else {
			return null;
		}
	}
}
