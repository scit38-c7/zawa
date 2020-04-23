package com.sesoc.report;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
		
		return "index";
	}
	
	//about컨트롤러
	@RequestMapping(value = "about", method = RequestMethod.GET)
	public String about() {
		return "about";
	}
	
	//post컨트롤러
		@RequestMapping(value = "post", method = RequestMethod.GET)
		public String post() {
			return "post";
		}
		
	//contact컨트롤러
	@RequestMapping(value = "contact", method = RequestMethod.GET)
	public String contact() {
		return "contact";
	}
	

}
