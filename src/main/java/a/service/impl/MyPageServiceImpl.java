package a.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import a.dao.MyPageDao;
import a.dto.MemberDto;
import a.service.MyPageService;

@Service
public class MyPageServiceImpl implements MyPageService {
	
	@Autowired
	MyPageDao dao;
	
	@Override
	public MemberDto login(MemberDto dto) {
		return dao.login(dto);
	}
	
	@Override
	public String pwdCheck(String user_id) {
		return dao.pwdCheck(user_id);
	}
	
	@Override
	public int nickCheck(String nickname) {
		return dao.nickCheck(nickname);
	}
	
}
