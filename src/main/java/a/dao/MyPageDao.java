package a.dao;

import a.dto.MemberDto;

public interface MyPageDao {

	MemberDto login(MemberDto dto);
	String pwdCheck(String user_id);
	int nickCheck(String nickname);

}
