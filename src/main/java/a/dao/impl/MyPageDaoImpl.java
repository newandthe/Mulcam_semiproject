package a.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import a.dao.MyPageDao;

@Repository
public class MyPageDaoImpl implements MyPageDao {
	
	@Autowired
	SqlSession session;
	
	String ns = "MyPage.";

}
