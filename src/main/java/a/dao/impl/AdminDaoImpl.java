package a.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.pagehelper.PageInfo;

import a.dao.AdminDao;
import a.dao.MemberDao;
import a.dto.BbsParam;
import a.dto.FpdImgDto;
import a.dto.FreeCommentVO;
import a.dto.FreePostDto;
import a.dto.MemberDto;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	SqlSession sqlSession;

	//회원 목록 - 조회
	@Override
	public List<MemberDto> memberList() {
		return sqlSession.selectList("admin.memberList");
	}
	
	//회원 목록 - 검색 
	@Override
	public PageInfo<MemberDto> searchByMemberList(String keyword,String choice) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("param1", choice);
		parameters.put("param2", keyword);
		return PageInfo.of(sqlSession.selectList("admin.searchByMemberList",parameters));
	}

	//회원 정보 상세 조회
	@Override
	public MemberDto viewMember(String user_id) {
		return sqlSession.selectOne("admin.viewMember",user_id);
	}
	
	@Override
	public void deleteUser(String userId) {
		sqlSession.update("admin.delete",userId);
	}
	
	//자유게시판 목록 조회
	@Override
	public List<FreePostDto> bbsList() {
		return sqlSession.selectList("admin.bbsList");
	}
	
	//자유게시판 목록 - 검색
	@Override
	public PageInfo<FreePostDto> searchByFreePostList(String keyword, String choice) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("param1", choice);
		parameters.put("param2", keyword);
		
		return PageInfo.of(sqlSession.selectList("admin.searchByFreePostList", parameters));
	}

	//자유게시판 댓글 목록
	@Override
	public List<FreeCommentVO> getComment() {
		return sqlSession.selectList("admin.getComment");
	}

	//자유게시판 댓글 목록 - 검색
	@Override
	public PageInfo<FreeCommentVO> searchByFreeCommentList(String keyword, String choice) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("param1", choice);
		parameters.put("param2", keyword);
		
		return PageInfo.of(sqlSession.selectList("admin.searchByFreeCommentList",parameters));
	}

	@Override
	public void deleteComment(List<Long> commentIds) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("commentIds", commentIds);
		sqlSession.update("admin.deleteComment", parameters);
		
	}

}
