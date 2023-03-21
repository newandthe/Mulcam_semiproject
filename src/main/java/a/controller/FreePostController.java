package a.controller;



import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import a.dto.FreePostDto;
import a.service.impl.FreePostServiceImpl;
import a.util.BbsUtil;
import a.dto.BbsImgVO;
import a.dto.BbsParam;
import a.dto.FpdImgDto;

@Controller
public class FreePostController {
	static int POST_PER_PAGE = 10;
	@Autowired
	FreePostServiceImpl freePostService;
	
    // 자유게시판 목록 페이지
	@GetMapping(value = "bbslist.do")
	public String bbslist(BbsParam param, Model model) {
		
		// 글의 시작과 끝
		int pn = param.getPageNumber();  // 0 1 2 3 4
		int start = 1 + (pn * 10);	// 1  11
		int end = (pn + 1) * 10;	// 10 20 
		
		param.setStart(start);
		param.setEnd(end);
		
		List<FreePostDto> list = freePostService.bbslist(param);
		int len = freePostService.getAllBbs(param);
		
		int pageBbs = len / 10;		// 25 / 10 -> 2
		if((len % 10) > 0) {
			pageBbs = pageBbs + 1;
		}
		
		model.addAttribute("bbslist", list);	// 게시판 리스트
		model.addAttribute("pageBbs", pageBbs);	// 총 페이지수
		model.addAttribute("pageNumber", param.getPageNumber()); // 현재 페이지
		model.addAttribute("choice", param.getChoice());	// 검색 카테고리
		model.addAttribute("search", param.getSearch());	// 검색어	
		
		return "bbslist";
	}
    
	
	@GetMapping(value = "bbswrite.do")
	public String bbswrite() {
		return "bbswrite";
	}
	
	
	
	@PostMapping(value = "bbswriteAf.do")
	public String bbswriteAf(Model model, @RequestParam(value="file", required = false) List<MultipartFile> files, FreePostDto dto) {
		
		
		// 문자열만 들어가도 파일이 들어가는 오류가 있음. 따라서 조건문 아래와 같이 작성했습니다.
		// System.out.println("files.get(0):" + files.get(0));
		// System.out.println("filename:" + files.get(0).getOriginalFilename());
		
		if(files.get(0).getOriginalFilename() != null && !files.get(0).getOriginalFilename().equals("")) {	// 파일이 있는경우
			// 임시 절대경로
			 String uploadPath = "C:\\Users\\kstur\\AppData\\Roaming\\SPB_Data\\git\\Mulcam_semiproject\\src\\main\\webapp\\resources\\upload\\";
			//String uploadPath = "..\\..\\resources\\upload\\"; // detail에서 찾아가기위한 경로(DB에 이렇게 저장)
			// fileName = 원본 파일 이름,
		    List<BbsImgVO> BbsImglist = new ArrayList<BbsImgVO>();
		    for (MultipartFile file : files) {
		    	BbsImgVO imgdto = new BbsImgVO();
		    	imgdto.setImg_name(BbsUtil.getNewFileName(file.getOriginalFilename()));
		    	imgdto.setImg_path(uploadPath);
		        String mimeType = file.getContentType();
		        imgdto.setImg_type(mimeType.substring(mimeType.lastIndexOf("/") + 1));
		        
		       // uploadPath = "..\\..\\..\\webapp\\resources\\upload\\";	// 컨트롤러에서 업로드폴더에 저장하기위한 경로..
		        // 파일을 지정한 경로에 저장하는 부분
		        try {
		            byte[] bytes = file.getBytes();
		            Path path = Paths.get(uploadPath + imgdto.getImg_name());
		            System.out.println(uploadPath + imgdto.getImg_name() + "에 저장.");
		            Files.write(path, bytes);
		        } catch (IOException e) {
		            e.printStackTrace();
		        }

		        System.out.println("파일 상세정보: "+ imgdto.toString());
		        BbsImglist.add(imgdto);
	    	} // for문의 끝 (모든 들어온 파일 list에 다 담기.)
	    	  // 
			// System.out.println(dto.getBbs_seq()); DB에서 자동설정..
			// model.addAttribute("bbswrite", bbswrite);
		    
		    boolean isS = freePostService.writeBbs(dto, BbsImglist);
			if(isS) {	
				return "redirect:/bbslist.do";
			}else {
				System.out.println("등록 실패");
			}
		} else {
			boolean isS = freePostService.writeBbs(dto);
			if(isS) {
				System.out.println("이미지 없는 글 작성 완료");	
			}
		}
		
		
		return "redirect:/bbslist.do";	// controller에서  controller로 이동시 == sendRedirect
		// return "forward:/bbslist.do";	// controller에서  controller로 이동시 == forward
	}
	
	// seq번호를 받아와서 글 dto들과 이미지 경로 받아서 불러오기. 
	@GetMapping(value = "bbsdetail.do")
	public String bbsdetail(Model model, int bbs_seq) {
		FpdImgDto dto = freePostService.getBbs(bbs_seq);
		model.addAttribute("bbsdto", dto);
		
		return "bbsdetail";
	}
	
	@GetMapping(value = "bbsupdate.do")
	public String bbsupdate(Model model, int bbs_seq) {
		model.addAttribute("bbs_seq", bbs_seq); 
		//System.out.println(bbs_seq);
		return "bbsupdate";
	}
	
	
	@PostMapping(value = "bbsupdateAf.do")
	public String bbsupdateAf(Model model, @RequestParam(value="file", required = false) List<MultipartFile> files, FreePostDto dto, int bbs_seq) {
		
		
		
		if(files.get(0).getOriginalFilename() != null && !files.get(0).getOriginalFilename().equals("")) {	// 파일이 있는경우
			// 임시 절대경로
			String uploadPath = "C:\\Users\\kstur\\AppData\\Roaming\\SPB_Data\\git\\Mulcam_semiproject\\src\\main\\webapp\\resources\\upload\\";
			//String uploadPath = "../../webapp/resources/upload/";
			// fileName = 원본 파일 이름,
		    List<BbsImgVO> BbsImglist = new ArrayList<BbsImgVO>();
		    for (MultipartFile file : files) {
		    	BbsImgVO imgdto = new BbsImgVO();
		    	imgdto.setImg_name(BbsUtil.getNewFileName(file.getOriginalFilename()));
		    	imgdto.setImg_path(uploadPath);
		        String mimeType = file.getContentType();
		        imgdto.setImg_type(mimeType.substring(mimeType.lastIndexOf("/") + 1));
		        
		        
		        // 파일을 지정한 경로에 저장하는 부분
		        try {
		            byte[] bytes = file.getBytes();
		            Path path = Paths.get(uploadPath + imgdto.getImg_name());
		            Files.write(path, bytes);
		        } catch (IOException e) {
		            e.printStackTrace();
		        }

		        System.out.println("파일 저장완료. 상세정보: "+ imgdto.toString());
		        BbsImglist.add(imgdto);
	    	} // for문의 끝 (모든 들어온 파일 list에 다 담기.)
	    	  // 
			// System.out.println(dto.getBbs_seq()); DB에서 자동설정..
			// model.addAttribute("bbswrite", bbswrite);
		    
		    boolean isS = freePostService.updateBbs(dto, BbsImglist, bbs_seq);
			if(isS) {	
				System.out.println("이미지 있는 글 수정 완료");	
				return "redirect:/bbslist.do";
			}else {
				System.out.println("등록 실패");
				return "redirect:/bbslist.do";
			}
		} else {
			boolean isS = freePostService.updateBbs(dto, bbs_seq);
			if(isS) {
				System.out.println("이미지 없는 글 수정 완료");	
				return "redirect:/bbslist.do";
			}
		}
		
		
		 return "redirect:/bbslist.do";	// controller에서  controller로 이동시 == sendRedirect
		// return "forward:/bbslist.do";	// controller에서  controller로 이동시 == forward
	}
	
	
	
	@GetMapping(value = "bbsdelete.do")
	public String bbsdelete(int bbs_seq) {
		
		// DB에서 삭제
		boolean isS = freePostService.deleteFreePost(bbs_seq);
		if(isS) {
			return "redirect:/bbslist.do";
		}else {
			System.out.println("삭제 실패");
		}
		
		// 실제 경로에서 이미지파일의 삭제는 DAO에서 처리하도록 했습니다.
		
		
		
		return "redirect:/bbslist.do";
	}
	

	@GetMapping(value="main.do")
	public String getMainBbs(Model model) {
		List<FreePostDto> bbslist = freePostService.getMainBbs();
		model.addAttribute("bbslist", bbslist);
		
		System.out.println("FreePostController getMainBbs() " + bbslist.toString());
		
		return "main";
	}
    
    
    
    
    

}
