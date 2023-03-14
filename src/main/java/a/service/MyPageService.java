package a.service;

import a.dto.MemberDto;

public interface MyPageService {
	
	MemberDto login(MemberDto dto);
	String pwdCheck(String user_id);
	int nickCheck(String nickname);

}
