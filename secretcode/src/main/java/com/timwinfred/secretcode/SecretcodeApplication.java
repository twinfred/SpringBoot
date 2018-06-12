package com.timwinfred.secretcode;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@SpringBootApplication
@Controller
public class SecretcodeApplication {

	public static void main(String[] args) {
		SpringApplication.run(SecretcodeApplication.class, args);
	}
	
	@RequestMapping("/")
	public String index(Model model) {
		return "index.jsp";
	}
	
	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public String submit(@RequestParam(value="code") String code) {
		System.out.println(code);
		if(code.equals("bushido")) {
			return "redirect:/code";
		}else {
			return "redirect:/addError";
		}
	}
	
	@RequestMapping("/addError")
	public String flashMessages(RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("error", "The code you entered wasn't correct. Try again.");
		return "redirect:/";
	}
	
	@RequestMapping("/code")
	public String code() {
		return "code.jsp";
	}
}
