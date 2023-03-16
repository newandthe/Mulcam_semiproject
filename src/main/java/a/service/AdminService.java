package a.service;

import java.util.List;

import a.dto.BbsParam;
import a.dto.FreePostDto;
import a.dto.MemberDto;

public interface AdminService {
	
	//01.회원 목록 조회
	List<MemberDto> memberList();
	
	//02.(아이디 클릭 시) - 회원 정보 상세보기
	MemberDto viewMember(String user_id);
	
	//게시글 목록 조회
	List<FreePostDto> bbsList(BbsParam bbs);
	int getAllBbs(BbsParam bbs);
}

