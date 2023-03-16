package a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import a.dao.AdminDao;
import a.dao.MemberDao;
import a.dto.BbsParam;
import a.dto.FreePostDto;
import a.dto.MemberDto;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	SqlSession sqlSession;
	
	//01.회원 목록 조회
	@Override
	public List<MemberDto> memberList() {
		return sqlSession.selectList("admin.memberList");
	}

	//02.회원 정보 상세 조회
	@Override
	public MemberDto viewMember(String user_id) {
		return sqlSession.selectOne("admin.viewMember",user_id);
	}
	
	//게시글 목록 조회
	@Override
	public List<FreePostDto> bbsList(BbsParam bbs) {
		return sqlSession.selectList("admin.bbsList",bbs);
	}

	@Override
	public int getAllBbs(BbsParam bbs) {
		return sqlSession.selectOne("admin.getAllBbs", bbs);
	}

}
