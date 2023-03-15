<%@page import="a.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<MemberDto> dto = (List<MemberDto>)request.getAttribute("dto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>회원 상세 정보</h2>
<form name="form1" method="post">
	<table border="1" width="post">
	<tr>
		<td>아이디</td>
		<!-- id는 수정이 불가능하도록 readonly속성 추가 -->
		<td><input name="userId" value="${dto.user_id}" readonly="readonly"></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="userName" value="${dto.username}"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="userEmail" value="${dto.email}"></td>
	</tr>
	<tr>
		<td>닉네임</td>
		<td><input type="nickName" value="${dto.nickname}"></td>
	</tr>
	<tr>
		<td>회원가입일자</td>
		<td>
			<fmt:formatDate value="${dto.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</td>
	</tr>
	<tr>
		<td>회원정보 수정 일자</td>
		<td>
			<fmt:formatDate value="${dto.modify_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</td>
	</tr>
	<tr>
		<td>권한</td>
		<td><input type="auth" value="${dto.auth}"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="수정" id="btnUpdate">
			<input type="button" value="삭제" id="btnDelete">
		</td>
	</tr>
	</table>
</form>
</body>
</html>