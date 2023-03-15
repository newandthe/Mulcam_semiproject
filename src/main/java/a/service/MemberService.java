package a.service;

import java.util.List;

import a.dto.MemberDto;

public interface MemberService {
	
	//회원 목록
	List<MemberDto> memberList();
	
	//회원 정보 상세보기
	MemberDto viewMember(String user_id);
	

}
