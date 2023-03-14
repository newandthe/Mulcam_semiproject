package a.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import a.dto.MemberDto;
import a.service.MyPageService;

@Controller
public class MyPageController {
	
	@Autowired
	MyPageService service;
	
	// 로그인 해야만 메인 볼 수 있게 임시 세팅해 둠. 나중에 바꿔야 함
	@GetMapping("login.do")
	public String login() {
		return "login";
	}
	
	@PostMapping("loginAf.do")
	public String loginAf(HttpServletRequest req, MemberDto dto) {
		MemberDto mem = service.login(dto);
		if (mem != null) {
			req.getSession().setAttribute("login", mem); // session에 저장
			req.getSession().setMaxInactiveInterval(60 * 60 * 2);
			return "main";
		} else {
			return "";
		}
	}
	
	@GetMapping("sessionOut.do")
	public String sessionOut(Model model) {
		String sessionOut = "logout";
		model.addAttribute("sessionOut", sessionOut);
		
		return "message";
	}
	
	@GetMapping("myPage.do")
	public String memberUpdate(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("login") != null) { 
			return "memberUpdate";
		} else {
			model.addAttribute("sessionOut" , "logout");
			return "message";
		}
	}
	
	@ResponseBody
	@PostMapping("pwdcheck.do")
	public String pwdCheck(HttpServletRequest req, String pwd) {
		MemberDto dto = (MemberDto) req.getSession().getAttribute("login");
		String pwdFromDb = service.pwdCheck(dto.getUser_id());
		
		if (pwd.equals(pwdFromDb) || pwd == pwdFromDb)
			return "YES";
		else
			return "NO";
	}
	
	@ResponseBody
	@PostMapping("nickcheck.do")
	public String nickCheck(String nickname) {
		int n = service.nickCheck(nickname);
		
		if (n > 0)
			return "NO";
		else
			return "YES";
	}

}
