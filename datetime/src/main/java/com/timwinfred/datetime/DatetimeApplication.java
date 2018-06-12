package com.timwinfred.datetime;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@SpringBootApplication
@Controller
public class DatetimeApplication {

	public static void main(String[] args) {
		SpringApplication.run(DatetimeApplication.class, args);
	}
	
	@RequestMapping("/")
	public String index() {
		return "index.jsp";
	}
	
	@RequestMapping("/date")
	public String date(Model model) {
		Date date = new Date();
		SimpleDateFormat dayOfWeek = new SimpleDateFormat("EEEEEEEEEEEEEEEE");
		model.addAttribute("dayOfWeek", dayOfWeek.format(date));
		SimpleDateFormat day = new SimpleDateFormat("dd");
		model.addAttribute("day", day.format(date));
		SimpleDateFormat month = new SimpleDateFormat("MMMMMMMMMMMMM");
		model.addAttribute("month", month.format(date));
		SimpleDateFormat year = new SimpleDateFormat("yyyy");
		model.addAttribute("year", year.format(date));
		return "date.jsp";
	}
	
	@RequestMapping("/time")
	public String time(Model model) {
		Date date = new Date();
		SimpleDateFormat hour = new SimpleDateFormat("KK");
		model.addAttribute("hour", hour.format(date));
		SimpleDateFormat minutes = new SimpleDateFormat("mm");
		model.addAttribute("minutes", minutes.format(date));
		SimpleDateFormat marker = new SimpleDateFormat("aa");
		model.addAttribute("marker", marker.format(date));
		return "time.jsp";
	}
}
