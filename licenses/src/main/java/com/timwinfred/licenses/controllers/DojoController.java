package com.timwinfred.licenses.controllers;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.timwinfred.licenses.models.Dojo;
import com.timwinfred.licenses.services.DojoService;
import com.timwinfred.licenses.services.NinjaService;

@Controller
@RequestMapping("/dojos")
public class DojoController {
	public final DojoService dojoService;
	public final NinjaService ninjaService;
	
	public DojoController(DojoService dojoService, NinjaService ninjaService) {
		this.dojoService = dojoService;
		this.ninjaService = ninjaService;
	}
	
	// add dojo page
	@RequestMapping("/new")
	public String newDojo(@ModelAttribute Dojo dojo) {
		return "newdojo.jsp";
	}
	
	// add person POST request
	@RequestMapping(value="/new", method=RequestMethod.POST)
	public String addDojo(@Valid @ModelAttribute("dojo") Dojo dojo, BindingResult result) {
		if(result.hasErrors()) {
			return "newdojo.jsp";
		} else {
			dojoService.createDojo(dojo);
			return "redirect:/ninjas/new";
		}
	}
	
	// dojo profile page
	@RequestMapping("/{id}")
	public String dojo(@PathVariable(value="id", required=true) Long id, Model model) {
		Dojo dojo = dojoService.findDojo(id);
		if(dojo == null) {
			return "redirect:/dojos/new";
		} else {
			model.addAttribute("dojo", dojo);
			return "dojos.jsp";
		}
	}
}
