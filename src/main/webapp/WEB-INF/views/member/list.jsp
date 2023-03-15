<%@page import="a.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<MemberDto> list = (List<MemberDto>)request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript" src="./jquery/jquery.twbsPagination.min.js"></script>
<style type="text/css">
.table th, .table td {
	text-align: center;
	vertical-align: middle!important;
}
</style>
</head>
<body>
<h2>회원 목록</h2>
<div>
<table border="1" width="700px">
<tr>
	<th>번호</th>
	<th>아이디</th>
	<th>이름</th>
	<th>닉네임</th>
	<th>이메일</th>
	<th>가입일</th>
	<th>권한</th>
</tr>

<tbody>
<% 
for(int i = 0;i < list.size(); i++){
MemberDto dto = list.get(i);
	%>
	<tr>
		<th><%=i + 1 %></th>
		<td><a href="view.do"><%=dto.getUser_id() %></a></td>
		<td><%=dto.getUsername() %></td>
		<td><%=dto.getNickname() %></td>
		<td><%=dto.getEmail() %></td>
		<td><%=dto.getReg_date() %></td>
		<td><%=dto.getAuth() %></td>
	</tr>
<%
	}
%>
</tr>
</tbody>
</div>
</body>
</html>