package com.KoreaIT.syp.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrApiTestController {
	
	@RequestMapping("/usr/home/ApiTest")
	public String APITest() {
		return "usr/home/ApiTest";
	}
	
	@RequestMapping("/usr/home/ApiTest2")
	public String APITest2() {
		return "usr/home/ApiTest2";
	}

	@RequestMapping("/usr/home/ApiTest3")
	public String APITest3() {
		return "usr/home/ApiTest3";
	}
	
	@RequestMapping("/usr/home/ApiTest4")
	public String APITest4() {
		return "usr/home/ApiTest4";
	}
}