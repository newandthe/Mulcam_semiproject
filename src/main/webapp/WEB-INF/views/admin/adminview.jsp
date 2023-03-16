<%@page import="a.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
        <link rel="stylesheet" href="../resources/css/admin-main.css">
<title>Insert title here</title>
</head>
<body>
<h1>관리자 페이지</h1>
<%-- <%
MemberDto dto = (MemberDto)request.getAttribute("dto");
%>
<h2><%=dto.getUser_id() %>님 환영합니다</h2>
<%=dto.getUsername() %> --%>
<!-- <div>
<input type="button" value="회원 목록 조회" onclick="location.href='memberlist.do'"><br>
<a>게시판 관리</a><br><br>
<input type="button" value="자유게시판 관리" onclick="location.href='freepostList.do'"><br>
<input type="button" value="Q&A 관리" onclick="location.href=''"><br>
<a href="">댓글 관리</a><br><br>
<input type="button" value="자유게시판 댓글 관리" onclick="location.href=''"><br>
<input type="button" value="Q&A 댓글 관리" onclick="location.href=''"><br>
</div> -->

<!-- 관리자일때만 확인 가능 -->
<c:if test="${not empty isAdmin}">
    <a href="memberlist.do">회원 관리</a><br><br>
    <a>게시판 관리</a><br><br>
    <li><a href="freepostList.do">자유게시판 관리</a></li><br>
    <li><a href="">Q&A 관리</a></li><br><br>
    <a>댓글 관리</a><br><br>
    <li><a href="">자유게시판 댓글 관리</a></li><br>
    <li><a href="">Q&A 댓글 관리</a></li><br><br>
</c:if>
</body>
</html>