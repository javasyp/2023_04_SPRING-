package com.KoreaIT.syp.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrAjaxTestController {
	
	@RequestMapping("/usr/home/plus")
	public String showTestPage() {
		return "usr/home/AjaxTest";
	}
	
	@RequestMapping("/usr/home/doPlus")
	@ResponseBody
	public Object doPlus(int num1, int num2) {
		String msg = "더하기 성공!";
		
		int sum = num1 + num2;
		
		return sum + "/" + msg + "/S-1";
	}
	
	@RequestMapping("/usr/home/doPlusJson")
	@ResponseBody
	public Map<String, Object> doPlusJson(int num1, int num2) {
		Map<String, Object> rs = new HashMap<>();

		rs.put("rs", num1 + num2);
		rs.put("msg", "더하기 성공!");
		rs.put("code", "S-1");

		return rs;
	}
}