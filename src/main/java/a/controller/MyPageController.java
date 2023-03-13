package a.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import a.service.MyPageService;

@Controller
public class MyPageController {
	
	@Autowired
	MyPageService service;
	
	@GetMapping(value = "main.do")
	public String goMain() {
		return "main";
	}
	
	@GetMapping("myPage.do")
	public String memberUpdate() {
		return "";
	}

}
