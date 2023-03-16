package a.dao;

import java.sql.Connection;

import java.util.List;

import org.springframework.jdbc.CannotGetJdbcConnectionException;

import a.dto.BbsParam;
import a.dto.FreePostDto;
import a.dto.MemberDto;


public interface AdminDao {
	
	//01.회원 목록
	List<MemberDto> memberList();
	
	//02.회원 정보 상세보기
	MemberDto viewMember(String user_id);
	
	//게시글 목록 조회
	List<FreePostDto> bbsList(BbsParam bbs);
	int getAllBbs(BbsParam bbs);
}