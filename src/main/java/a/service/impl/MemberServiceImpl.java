package a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import a.dao.MemberDao;
import a.dao.impl.MemberDaoImpl;
import a.dto.MemberDto;
import a.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDaoImpl dao;

	//01.회원 전체 조회
	@Override
	public List<MemberDto> memberList() {
		return dao.memberList();
	}

	//02.회원 정보 상세 조회
	@Override
	public MemberDto viewMember(String user_id) {
		return dao.viewMember(user_id);
	}
	
	
	/*
	 * @Override public List<MemberDto> getUserList(){ return userDao.getUserList();
	 * }
	 */
}
