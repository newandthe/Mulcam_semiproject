<%@page import="a.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 페이지</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      /* Add your CSS styles here */
      body {
        font-family: Arial, sans-serif;
        background-color: #f1f1f1;
      }

      h1 {
        text-align: center;
        margin-top: 30px;
        color: #333;
      }

      .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0px 0px 5px #ccc;
      }
      ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
      }

      li {
        margin-bottom: 10px;
      }

      a {
        display: block;
        padding: 10px;
        border-radius: 5px;
        text-decoration: none;
        color: #333;
        background-color: #f1f1f1;
        transition: background-color 0.2s;
      }

      a:hover {
        background-color: #ccc;
      }
    </style>
  </head>
  <body>
<%
MemberDto member = (MemberDto)session.getAttribute("login"); 
%>
    <h1>관리자 페이지</h1>
    <div class="container">
    <div style="text-align: right;"><%=member.getUser_id()%>님 안녕하세요. 권한 : <%=member.getAuth()%></div>
      <div style="text-align: center; margin-top: 20px;">
      <ul>
       	  <a href="memberlist.do">회원 관리</a>
      </ul>
      <ul>
          <a href="freepostList.do">자유게시판 관리</a>
      </ul>
      <ul>
         <a href="commentList.do">자유게시판 댓글 관리</a>
        </ul>
      </div>
    </div>
  </body>
</html>




      