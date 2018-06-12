package com.timwinfred.hellohuman;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@Controller
public class HellohumanApplication {

	public static void main(String[] args) {
		SpringApplication.run(HellohumanApplication.class, args);
	}
	
	@RequestMapping("/")
	public String index(@RequestParam(value="fname", required=false) String fname, @RequestParam(value="lname", required=false) String lname) {
		if(fname == null) {
			return "Hello Human";
		} else if(fname != null && lname != null) {
			return "Hello " + fname + " " + lname;
		} else {
			return "Hello " + fname;
		}
	}
	
	@RequestMapping("/home")
	public String home(@RequestParam(value="fname", required=false) String fname, Model model) {
		if(fname == null) {
			model.addAttribute("fname", "Human");
		}else {
			model.addAttribute("fname", fname);
		}
		return "index.jsp";
	}
}
