package a.controller;

import java.lang.reflect.Member;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import a.dto.MemberDto;
import a.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired 
	 private MemberService service;

	  private static final Logger logger =LoggerFactory.getLogger(MemberController.class);
	  
	  //01.회원목록
	   @RequestMapping("member/list.do")
	   public String memberList(Model model) {
		   System.out.println("MemberController memberList " + new Date());
		   //logger.info("MemberController memberList....");
		   
		   List<MemberDto> list = service.memberList();
		   model.addAttribute("list",list);
		   
		   return "member/list";
	   }
	   
	   //02.회원 상세 목록 조회
	   @RequestMapping("member/view.do")
	   public String memberView(String user_id, Model model) {
		   System.out.println("MemberController memberView " + new Date());
		   
		   //회원 정보 model에 저장
		   model.addAttribute("dto", service.viewMember(user_id));
		   
		   //member_view.jsp로 포워드
		   return "member/view";
	   }
	  
	  //세션에 auth값이 2(=admin)인지 확인
	 
  }
