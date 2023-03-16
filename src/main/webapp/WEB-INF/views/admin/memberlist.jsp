<%@page import="a.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
<body bgcolor="#e9e9e9">
<%
List<MemberDto> list = (List<MemberDto>)request.getAttribute("list");
/* int pageMember = (Integer)request.getAttribute("pageMember");
int pageNumber = (Integer)request.getAttribute("pageNumber"); */
String choice = (String)request.getAttribute("choice");
String search = (String)request.getAttribute("search");
%>

<h2>회원 관리</h2>
<a href="freepostList.do">게시판 관리</a>
<div align="center">
<table class="table table-hover table-sm" style="width: 1000px">
<col width="70"><col width="200"><col width="100"><col width="150"><col width="150"><col width="200"><col width="150">
<tr class="bg-primary" style="color: white;">
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
		<td><a href="memberview.do"><%=dto.getUser_id() %></a></td>
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
</table>

<div align="center">
<table style="margin-left: auto; margin-right: auto; margin-top: 3px; margin-bottom: 3px">
	<tr>
		<td style="padding-left: 5px">
			<select class="custom-select" id="choice" name="choice">
				<option selected>선택</option>
				<option value="user_id">아이디</option>
				<option value="username">이름</option>
				<option value="nickname">닉네임</option>
			</select>
		</td>
		<td style="padding-left: 5px" class="align-middle">
			<input type="text" class="form-control" id="search" name="search" placeholder="검색어" value="<%=search %>">
		<td style="padding-left: 5px">
			<span>
				<!-- <button type="button" class="btn btn-primary" onclick="searchBtn()">검색</button> -->
				<input type="submit" value="검색">
			</span>
		</td>
	</tr>
</table> 
</div>
</div>
</body>
</html>