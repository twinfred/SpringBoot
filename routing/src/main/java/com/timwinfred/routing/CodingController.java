package com.timwinfred.routing;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
@RequestMapping("/coding")
public class CodingController {

	public static void main(String[] args) {
		SpringApplication.run(RoutingApplication.class, args);
	}
	
	@RequestMapping("")
	public String index() {
		return "Hello Coding Dojo!";
	}
	
	@RequestMapping("/python")
	public String python() {
		return "Python/Django was awesome!";
	}
	
	@RequestMapping("java")
	public String java() {
		return "Java/Spring is better!";
	}
}