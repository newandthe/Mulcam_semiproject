package a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import a.dao.MemberDao;
import a.dto.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	SqlSession sqlSession;
	
	//01.전체 회원 목록 조회
	@Override
	public List<MemberDto> memberList() {
		return sqlSession.selectList("member.memberList");
	}

	//02.회원 정보 상세 조회
	@Override
	public MemberDto viewMember(String user_id) {
		return sqlSession.selectOne("member.viewMember",user_id);
	}

	
	/*
	 * @Override public List<MemberDto> getUserList() { return
	 * sqlSession.selectList("getUserList"); }
	 */
}
