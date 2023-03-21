package a.controller;

import java.lang.reflect.Member;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import a.dto.BbsParam;
import a.dto.Choice;
import a.dto.FreeCommentVO;
import a.dto.FreePostDto;
import a.dto.MemberDto;
import a.service.AdminService;
import a.service.MemberService;

@Controller
public class AdminController {
	@Autowired
	private AdminService service;

	//로깅
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	//adminview(관리자 메인 페이지) mapping
	@GetMapping("admin/adminview.do")
	public String adminMain(Model model, HttpSession session) {
	    //로그인한 회원의 정보를 세션에서 받아와서 member객체 초기화
	    MemberDto member = (MemberDto) session.getAttribute("login");
	    
	    // member 객체의 auth 필드 값이 2가 아닌 경우에는 접근할 수 없도록 처리
	    if (member == null || member.getAuth() != 2) {
    	 System.out.println("member" +member.getAuth() + member.toString());
	        return "redirect:/main.do";
	    }else {	    
	    System.out.println("AdminController adminMain()" + new Date());
	    // 모델에 member 객체를 담아 JSP 페이지로 전달
	    model.addAttribute("member", member);
	    return "admin/adminview";
	}
}
	
	//회원목록 조회
	@RequestMapping(value = "admin/memberlist.do", method = RequestMethod.GET)
	public String memberList(Model model, @RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "user_id") String choice, @RequestParam(defaultValue = "") String search) {
	        System.out.println("AdminController memberList " + new Date());
	        //logger.info("MemberController memberList....");
			choice = validation(choice);

			PageHelper.startPage(page, 10);
	        PageInfo<MemberDto> memberDtoPageInfo = service.searchByMemberList(search, choice);
	        model.addAttribute("dto", memberDtoPageInfo);
	        model.addAttribute("choice", choice);
	        model.addAttribute("search", search);
	        System.out.println("memberDtoPageInfo = " + memberDtoPageInfo);
        return "admin/memberlist";
    }

	private static String validation(String choice) {
		try {
			Choice.valueOf(choice);
		} catch (Exception e) {
			choice = "user_id";
		}
		return choice;
	}
	
	//아이디를 누르면 그 회원의 상세 정보 조회
	@RequestMapping("admin/memberview.do")
	public String memberView(String user_id, Model model) {
		System.out.println("AdminController memberView " + new Date());

		// 회원 정보 model에 저장
		model.addAttribute("dto", service.viewMember(user_id));

		// memberview.jsp로 포워드
		return "admin/memberview";
	}
	
	@RequestMapping(value = "admin/delete.do",method=RequestMethod.POST)
    public String deleteUser(@RequestParam String userId, Model model, HttpServletRequest request) {
        service.deleteUser(userId);

        return "redirect:/admin/memberlist.do";
    }
		
	//게시글 목록 - 자유게시판
	@GetMapping(value="admin/freepostList.do")
	public String freepostList(Model model, @RequestParam(defaultValue ="1")int page, 
			@RequestParam(defaultValue = "user_id")String choice, @RequestParam(defaultValue = "") String search) {
		System.out.println("AdminController freepostList" + new Date());
		
		choice = validation(choice);
		
		PageHelper.startPage(page,10);
		PageInfo<FreePostDto> freepostDtoPageInfo = service.searchByFreePostList(search, choice);
		
		model.addAttribute("dto", freepostDtoPageInfo);
		model.addAttribute("choice", choice);
		model.addAttribute("search", search);
		System.out.println("AdminController freepostDtoPageInfo=" + freepostDtoPageInfo);
		
		return "admin/freepostList";
	}
	
	//자유게시판 - title클릭 시 상세 게시글 보여줌(bbs_seq)
	@RequestMapping(value="/admin/bbsdetail2.do", method=RequestMethod.GET)
    public String bbsdetail2(Model model, @RequestParam("bbs_seq") int bbs_seq) {
		System.out.println("AdminController bbsdetail2" + new Date());
		
        return "redirect:/bbsdetail.do?bbs_seq=" + bbs_seq;
    }

	//자유게시판 댓글 목록 - 검색, 페이징
	@GetMapping(value="admin/commentList.do")
	public String commentList(Model model, @RequestParam(defaultValue ="1")int page, 
			@RequestParam(defaultValue = "user_id")String choice, @RequestParam(defaultValue = "") String search) {
		System.out.println("AdminController commentList" + new Date());
		
		choice = validation(choice);
		
		PageHelper.startPage(page,10);
		PageInfo<FreeCommentVO> freecommentVOPageInfo = service.searchByFreeCommentList(search, choice);
		
		model.addAttribute("dto", freecommentVOPageInfo);
		model.addAttribute("choice", choice);
		model.addAttribute("search", search);
		System.out.println("AdmiinController freecommentVOPageInfo=" + freecommentVOPageInfo);
		
		return "admin/commentList";
	}
	
	@PostMapping("admin/deleteComment.do")
		public ModelAndView commentDelete(@RequestBody List<Long> deleteList) {
	
	        service.deleteComment(deleteList);
	
	    ModelAndView mv = new ModelAndView("redirect:/admin/commentList.do");
	    return mv;
	}
	
}
