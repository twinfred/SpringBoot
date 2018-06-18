package com.timwinfred.licenses.controllers;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.timwinfred.licenses.models.Person;
import com.timwinfred.licenses.services.PersonService;

@Controller
public class PersonController {
	public final PersonService personService;

	public PersonController(PersonService personService) {
		this.personService = personService;
	}
	
	// add person page
	@RequestMapping("/persons/new")
	public String newPerson(@ModelAttribute Person person) {
		return "newperson.jsp";
	}
	
	// add person POST request
	@RequestMapping(value="/persons/new", method=RequestMethod.POST)
	public String addPerson(@Valid @ModelAttribute("person") Person person, BindingResult result) {
		if(result.hasErrors()) {
			return "newperson.jsp";
		}else {
			personService.createPerson(person);
			return "redirect:/licenses/new";
		}
	}
	
	// person profile
	@RequestMapping("/persons/{id}")
	public String person(@PathVariable(value="id", required=true) Long id, Model model) {
		Person person = personService.findPerson(id);
		model.addAttribute("person", person);
		return "person.jsp";
	}
}
