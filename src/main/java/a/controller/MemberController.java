package a.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import a.service.MemberService;
import a.service.MyPageService;
import a.util.BbsUtil;
import a.util.PdsUtil;
import a.aop.AopSkip;
import a.dto.FreeCommentVO;
import a.dto.FreePostDto;
import a.dto.MemberDto;
import a.dto.PetDto;

@Controller
public class MemberController {
		
	@Autowired
	MemberService memService;
		
	/* 메인화면으로 이동 */
	/*
	 * @AopSkip
	 * 
	 * @GetMapping(value = "main.do") public String main() { return "main"; }
	 */
	
	// 로그인 화면 이동
	@AopSkip
	@GetMapping(value = "login.do")
	public String login() {
		return "login";
	}
	
	// 회원가입 화면 이동
	@AopSkip
	@GetMapping(value = "register.do")
	public String register() {
		return "register";
	}
	// 동물병원 지도로 이동
	@AopSkip
	@GetMapping(value = "animalhospital.do")
	public String animalhospital() {
		return "animalhospital";
	}
	
	// 아이디 중복확인
	@AopSkip
	@ResponseBody
	@PostMapping(value = "idcheck.do")
	public String idcheck(String user_id) {
		
		boolean isS = memService.idCheck(user_id);
		if(isS) {
			return "NO";
		}else {
			return"YES";
		}
	}
	
	// 닉네임 중복확인
	@AopSkip
	@ResponseBody
	@PostMapping(value = "nicknamecheck.do")
	public String nicknamecheck(String nickname) {
		
		boolean isS = memService.nicknameCheck(nickname);
		if(isS ) {
			return "NO";
		}else {
			return"YES";
		}
	}
	
	
	// Stringpath와 filepath 총 2개 수정하셔야합니다.
	// 회원가입 처리 
	@AopSkip
	@PostMapping(value = "registerAf.do")
	public String registerAf(MemberDto memDto,							 
							@RequestParam(value = "memberImg", required = false)
							MultipartFile memberImg,
							HttpServletRequest req,
							Model model) {
	//	System.out.println("MemberController registerAf " + new Date());
		
		// 1. 사용자가 프로필 사진을 업로드 했는지 확인
		if(!memberImg.isEmpty()) { // 업로드한 파일이 존재
			
			// filename 취득 : 원본 파일명
			String filename = memberImg.getOriginalFilename();
			// System.out.println("original: " + filename);
			String newfilename = BbsUtil.getNewFileName(filename);
			System.out.println(newfilename);
			
			// upload의 경로 설정(2가지 : server / folder)
			// folder
			// String filepath = "c:\\memberImgs";	// 일단 절대경로로 설정했습니다. tiles 배치 후 상대경로 시도해보죠.
			
			
			// 여기에 저장된 filepath는 저장이 된후 찾아가기 위한 DB의 경로입니다!!! 헷갈리시면 안됩니다.
			String filepath = "../../../../spSample1/resources/memberImg/";
			memDto.setImg_path(filepath + newfilename);	// 여기서, 우리는 컬럼이 하나로 시작해서.. 무조건 경로와 파일명을 모두 가지고 있어야합니다.
			// memDto에 저장해놓았으니 밑에서 재할당해도 문제 X
			
			// 여기에 저장된 filepath는 당장 컨트롤러에서 파일을 생성하기위한 경로입니다!!!
			filepath = "C:\\Users\\kstur\\AppData\\Roaming\\SPB_Data\\git\\Mulcam_semiproject\\src\\main\\webapp\\resources\\memberImg\\";
			
			
			// 파일명을 충돌되지 않는 명칭(Date)으로 변경
			// String newfilename = PdsUtil.getNewFileName(filename);
			
			
			
			
			File file = new File(filepath + newfilename);
			System.out.println("다음의 경로에 유저 프로필 이미지 업로드 : " + filepath + newfilename);
			
			
			try {
				// 실제로 파일 생성 + 기입 = 업로드 (newFileName으로 변형되어 저장)
				FileUtils.writeByteArrayToFile(file, memberImg.getBytes());	
				
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}	// 파일 존재 로직 끝 
		else { // 업로드한 파일 미존재시 기본 사진 정보를 DB에 저장
			
			 // 기본 프로필이 있는 경로를 DB에 저장
			// String filepath = "C:" + File.separator + "memberImgs" + File.separator +"default_profile.png";
			String filepath = "../../../../spSample1/resources/memberImg/default_profile.png";
			memDto.setImg_path(filepath);
			
			 
		}
		
		boolean isS = memService.addMember(memDto);
		String msg = "";
		if(isS == true) {
			msg = "MEMBER_ADD_YES";
		}else {
			msg = "MEMBER_ADD_NO";
		}
		model.addAttribute("register", msg);	
		
		
		return "message";		
	}
	
	// 로그인 처리
	@AopSkip
	@PostMapping(value = "loginAf.do")
	public String loginAf(HttpServletRequest req, Model model, MemberDto memDto) {
		MemberDto mem = memService.login(memDto);
		PetDto pet = memService.getMyPet(memDto);
		List<FreePostDto> post = new ArrayList<>();
		List<FreeCommentVO> comment = new ArrayList<>();
		post = memService.getAllPost(memDto);
		comment = memService.getAllComment(memDto);
		
		String msg = "";
		if(mem != null && mem.getAuth() != 3) { // 로그인 성공
			req.getSession().setAttribute("login", mem); // 로그인 정보를 세션에 저장
			req.getSession().setAttribute("pet", pet); // 내 반려동물 정보 저장
			req.getSession().setAttribute("post", post); // 내 글 정보 저장
			req.getSession().setAttribute("comment", comment); // 내 댓글 정보 저장
			req.getSession().setMaxInactiveInterval(60 * 60 * 2); // 세션 만료 기한 설정 (2시간)
			msg = "LOGIN_OK";
		}else { // 로그인 실패
			msg = "LOGIN_FAIL";
		}
		model.addAttribute("login", msg);
		
		return "message";
	}
	
	// 로그아웃 : 세션에 저장된 사용자의 정보 지우기
	@AopSkip
	@GetMapping(value = "logout.do")
	public String logout(HttpServletRequest req) throws Exception{
		
		HttpSession session = req.getSession();	
		// 세션 전체를 무효화
		session.invalidate();

		return "main";
	}
	
}
