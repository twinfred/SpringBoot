package com.timwinfred.licenses.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.timwinfred.licenses.models.Dojo;
import com.timwinfred.licenses.models.Ninja;
import com.timwinfred.licenses.services.DojoService;
import com.timwinfred.licenses.services.NinjaService;

@Controller
@RequestMapping("/ninjas")
public class NinjaController {
	public final NinjaService ninjaService;
	public final DojoService dojoService;
	
	public NinjaController(NinjaService ninjaService, DojoService dojoService) {
		this.ninjaService = ninjaService;
		this.dojoService = dojoService;
	}
	
	// add ninja page
	@RequestMapping("/new")
	public String newNinja(@ModelAttribute Ninja ninja, Model model) {
		List<Dojo> dojos = dojoService.getAllDojos();
		model.addAttribute("dojos", dojos);
		return "newninja.jsp";
	}
	
	// add ninja page
	@RequestMapping(value="/new", method=RequestMethod.POST)
	public String addNinja(@Valid @ModelAttribute("ninja") Ninja ninja, BindingResult result, Model model) {
		System.out.println(ninja);
		if(result.hasErrors()) {
			System.out.println("Error!");
			List<Dojo> dojos = dojoService.getAllDojos();
			model.addAttribute("dojos", dojos);
			return "newninja.jsp";
		} else {
			ninjaService.createNinja(ninja);
			return "redirect:/dojos/new";
		}
	}

}
