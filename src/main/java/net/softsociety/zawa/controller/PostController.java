package net.softsociety.zawa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PostController {

	@RequestMapping(value = "post", method = RequestMethod.GET)
	public String post() {
		return "postText";
	}
	
	@RequestMapping(value = "postText", method = RequestMethod.POST)
	public String postText() {
		return "home";
	}
}
