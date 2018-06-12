package com.timwinfred.sessioncounter;

import javax.servlet.http.HttpSession;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@SpringBootApplication
@Controller
public class SessioncounterApplication {

	public static void main(String[] args) {
		SpringApplication.run(SessioncounterApplication.class, args);
	}
	
	@RequestMapping("/")
	public String index(HttpSession session) {
		if(session.getAttribute("count") == null) {
			session.setAttribute("count", 0);
		}else {
			int count = (int) session.getAttribute("count") + 1;
			session.setAttribute("count", count);
		}
		return "index.jsp";
	}
	
	@RequestMapping("/counter")
	public String counter(HttpSession session, Model model) {
		if(session.getAttribute("count") == null) {
			model.addAttribute("count", "0");
		}else {
			model.addAttribute("count", session.getAttribute("count"));
		}
		return "counter.jsp";
	}
}
