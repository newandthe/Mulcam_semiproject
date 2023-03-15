package a.dao;

import java.sql.Connection;
import java.util.List;

import org.springframework.jdbc.CannotGetJdbcConnectionException;

import a.dto.MemberDto;


public interface MemberDao {
	
	//회원 목록
	List<MemberDto> memberList();
	
	//회원 정보 상세보기
	MemberDto viewMember(String user_id);
	
	 
}
