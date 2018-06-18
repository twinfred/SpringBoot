package com.timwinfred.licenses.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.timwinfred.licenses.models.License;
import com.timwinfred.licenses.models.Person;
import com.timwinfred.licenses.services.LicenseService;
import com.timwinfred.licenses.services.PersonService;

@Controller
public class LicenseController {
	public final LicenseService licenseService;
	public final PersonService personService;

	public LicenseController(LicenseService licenseService, PersonService personService) {
		this.licenseService = licenseService;
		this.personService = personService;
	}
	
	// add license page
	@RequestMapping("/licenses/new")
	public String newLicense(@ModelAttribute License license, Model model) {
		List<Person> people = personService.allPersons();
		model.addAttribute("people", people);
		return "newlicense.jsp";
	}
	
	// add license POST request
	@RequestMapping(value="/licenses/new", method=RequestMethod.POST)
	public String addLicense(@Valid @ModelAttribute("license") License license, BindingResult result, @RequestParam("expiration_date") String expiration_date) {
		if(result.hasErrors()) {
			return "newlicense.jsp";
		} else {
			License last = licenseService.findLast();
			String licenseString;
			if(last == null) {
				license.setSecret(1);
				licenseString = "1";
			}else {
				license.setSecret(last.getSecret() + 1);
				licenseString = Integer.toString(last.getSecret() + 1);
			}
			String number = ("00000000" + licenseString).substring(licenseString.length());
			license.setNumber(number);
			licenseService.createLicense(license);
			return "redirect:/persons/new";
		}
	}
}
