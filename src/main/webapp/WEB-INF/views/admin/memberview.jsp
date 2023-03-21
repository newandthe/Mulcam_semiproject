<%@page import="a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
MemberDto dto = (MemberDto)request.getAttribute("dto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</head>
<body>
<div class="card mx-auto" style="width: 400px;">
  <div class="card-header text-center">
    회원 정보 수정
  </div>
  <div class="card-body">
    <form name="form1" method="post">
      <table class="table">
        <tr>
          <td>아이디</td>
          <td><input name="userId" value="${dto.getUser_id()}" readonly="readonly" class="form-control"></td>
        </tr>
        <tr>
          <td>이름</td>
          <td><input type="userName" value="${dto.getUsername()}" class="form-control"></td>
        </tr>
        <tr>
          <td>이메일</td>
          <td><input type="userEmail" value="${dto.email}" class="form-control"></td>
        </tr>
        <tr>
          <td>닉네임</td>
          <td><input type="nickName" value="${dto.nickname}" class="form-control"></td>
        </tr>
        <tr>
          <td>회원가입일자</td>
          <td>
            <fmt:formatDate value="${dto.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
          </td>
        </tr>
        <%-- <tr>
          <td>회원정보 수정 일자</td>
          <td>
            <fmt:formatDate value="${dto.modify_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
          </td>
        </tr> --%>
        <tr>
          <td>권한</td>
          <td><input type="auth" value="${dto.auth}" class="form-control"></td>
        </tr>
      </table>
    </form>
    <form method="post" id="delete-form" onsubmit="return confirm( '추방하시겠습니까?');" action="${pageContext.request.contextPath}/admin/delete.do" class="text-center mt-3">
      <input type="hidden" name="userId" value="${dto.getUser_id()}">
      <input type="submit" value="추방하기" class="btn btn-danger">
    </form>
  </div>
</div>
</body>
</html>