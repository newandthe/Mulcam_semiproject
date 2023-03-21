package a.dao;

import java.sql.Connection;

import java.util.List;

import org.springframework.jdbc.CannotGetJdbcConnectionException;

import a.dto.BbsParam;
import a.dto.FpdImgDto;
import a.dto.FreeCommentVO;
import a.dto.FreePostDto;
import a.dto.MemberDto;
import com.github.pagehelper.PageInfo;

public interface AdminDao {

	//회원 목록
	List<MemberDto> memberList();
	PageInfo <MemberDto> searchByMemberList(String keyword, String choice);
	
	//회원 정보 상세보기
	MemberDto viewMember(String user_id);
	
	//회원 추방
	void deleteUser(String userId);
	
	//게시글 목록 조회
	List<FreePostDto> bbsList();	
	PageInfo <FreePostDto> searchByFreePostList(String keyword, String choice);	
	
	//자유게시판 댓글 목록
	List<FreeCommentVO> getComment();
	PageInfo<FreeCommentVO> searchByFreeCommentList(String keyword, String choice);

	void deleteComment(List<Long> commentId);
	
}