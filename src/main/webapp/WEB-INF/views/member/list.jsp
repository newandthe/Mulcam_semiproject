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
<title>Insert title here</title>
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
<%-- <c:set var="path" value="${pageContext.request.contextPath}"/> --%>
	<tr>
		<th><%=i + 1 %></th>
		<%-- <td><a href="${path}/member/view.do"><%=dto.getUser_id() %></a></td> --%>
		<td><a href="view.do"><%=dto.getUser_id() %></a></td>
		<%-- <td onclick="location.href='member/member_view.do?user_id=<%=dto.getUser_id()%>'"><%=dto.getUser_id() %></td> --%>
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

<%-- <c:forEach var="row" items="${list}">
<tr>
	<!-- 회원 정보 상세조회를 위해 a태그 추가 -->
	<td><a href="${path}/member/member_view.do?user_id=${row.user_id}">${row.user_id}</td>
	<td>${row.username}</td>
	<td>${row.nickname}</td>
	<td>${row.email}</td>
	<td>${row.reg_date}</td>
	<td>${row.auth}</td>
</tr>
</c:forEach> --%>
</table>

<%-- <br>
<table style="margin-left: auto; margin-right: auto; margin-top: 3px; margin-bottom: 3px">
	<tr>
		<td style="padding-left: 5px">
			<select class="custom-select" id="choice" name="choice">
				<option selected>선택</option>
				<option value="userId">아이디</option>
				<option value="userName">이름</option>
				<option value="nickName">닉네임</option>
			</select>
		</td>
		<td style="padding-left: 5px" class="align-middle">
			<input type="text" class="form-control" id="search" name="search" placeholder="검색어" value="<%= %>">
		<td style="padding-left: 5px">
			<span>
				<button type="button" class="btn btn-primary" onclick="searchBtn()">검색</button>
			</span>
		</td>
	</tr>
</table> --%>
</div>
</body>
</html>