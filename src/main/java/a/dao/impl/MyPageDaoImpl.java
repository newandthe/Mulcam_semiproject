package a.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import a.dao.MyPageDao;
import a.dto.MemberDto;

@Repository
public class MyPageDaoImpl implements MyPageDao {
	
	@Autowired
	SqlSession session;
	
	String ns1 = "MyPage.";
	String ns2 = "Member.";
	
	@Override
	public MemberDto login(MemberDto dto) {
		return session.selectOne(ns2 + "login", dto);
	}

	@Override
	public String pwdCheck(String user_id) {
		return session.selectOne(ns2 + "pwdCheck", user_id);
	}
	
	@Override
	public int nickCheck(String nickname) {
		int n = session.selectOne(ns2 + "nickCheck", nickname);
		return n;
	}
	
}
