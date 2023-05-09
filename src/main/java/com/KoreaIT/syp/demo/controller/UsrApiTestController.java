package com.KoreaIT.syp.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrApiTestController {
	
	@RequestMapping("/usr/home/ApiTest")
	public String showMain() {
		return "usr/home/ApiTest";
	}
}