package com.timwinfred.hellohuman;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
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
}
