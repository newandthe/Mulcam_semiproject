package a.service.impl;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import a.dao.MemberDao;
import a.dao.impl.AdminDaoImpl;
import a.dao.impl.MemberDaoImpl;
import a.dto.BbsParam;
import a.dto.FreePostDto;
import a.dto.MemberDto;
import a.service.AdminService;
import a.service.MemberService;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDaoImpl dao;

	//01.회원목록 조회
	@Override
	public List<MemberDto> memberList() {
		return dao.memberList();
	}
	
	//02.회원 정보 상세 조회
	@Override
	public MemberDto viewMember(String user_id) {
		return dao.viewMember(user_id);
	}

	//게시글 목록 조회
	@Override
	public List<FreePostDto> bbsList(BbsParam bbs) {
		return dao.bbsList(bbs);
	}

	@Override
	public int getAllBbs(BbsParam bbs) {
		return dao.getAllBbs(bbs);
	}

		
}

