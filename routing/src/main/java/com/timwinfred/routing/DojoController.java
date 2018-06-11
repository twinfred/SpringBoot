package com.timwinfred.routing;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DojoController {

	public static void main(String[] args) {
		SpringApplication.run(RoutingApplication.class, args);
	}
	
	@RequestMapping("/dojo")
	public String dojo() {
		return "The dojo is awesome!";
	}
	
	@RequestMapping("/burbank-dojo")
	public String burbank() {
		return "Burbank Dojo is located in Southern California.";
	}
	
	@RequestMapping("san-jose")
	public String java() {
		return "SJ dojo is the headquarters.";
	}
}