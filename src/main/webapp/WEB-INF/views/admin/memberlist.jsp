<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="a.dto.MemberDto" %>
<%@page import="java.util.List" %>
<%@ page import="com.github.pagehelper.PageInfo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

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
            vertical-align: middle !important;
        }
    </style>

</head>
<body bgcolor="#e9e9e9">
<%
    PageInfo<MemberDto> data = (PageInfo<MemberDto>)request.getAttribute("dto");
    List<MemberDto> list = data.getList();
    String choice = (String)request.getAttribute("choice");
    String search = (String)request.getAttribute("search");
%>
<br>
<div style="text-align:center;">
<h2>회원 목록</h2>
</div>

<div align="center" class="panel panel-default">
    <table class="table table-hover" style="width: 1300px; background-color: #f1f1f1;">
        <col width="100">
        <col width="150">
        <col width="150">
        <col width="150">
        <col width="100">
        <tr class="bg-primary" style="color: white;">
            <th>번호</th>
            <th>아이디</th>
            <th>이름</th>
            <th>닉네임</th>
<!--             <th>이메일</th> -->
<!--             <th>가입일</th> -->
            <th>권한</th>
        </tr>
        <tbody>
        <%
	if(list == null || list.size() == 0){
		%>
	<tr>
		<td colspan="5" style="text-align:center;">등록된 회원이 없습니다.</td>
	</tr>
        <%
	}else{
            for (int i = 0; i < list.size(); i++) {
                MemberDto dto = list.get(i);
        %>
        <tr>
            <th><%=i + 1 %>
            </th>
            <td><a href="memberview.do?user_id=<%=dto.getUser_id() %>">
				<%=dto.getUser_id() %>
            </a></td>
            <td><%=dto.getUsername() %>
            </td>
            <td><%=dto.getNickname() %>
            </td>
            <td><%=dto.getAuth() %>
            </td>
        </tr>
       <%
	}
}
%>
        </tr>
        </tbody>
    </table>

    <form method="get">
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
                        <input type="text" class="form-control" id="search" name="search" placeholder="검색어"
                               value="<%=search %>">
                    <td style="padding-left: 5px">
			<span>
				<!-- <button type="button" class="btn btn-primary" onclick="searchBtn()">검색</button> -->
				<input type="submit" value="검색">
			</span>
                    </td>
                </tr>


            </table>
    </form>
</div>
<div class="paging">
    <c:if test="${not empty search}">
        <c:set var="searchParam" value="&search=${search}"/>
    </c:if>
    <c:if test="${not empty choice}">
        <c:set var="choiceParam" value="&choice=${choice}"/>
    </c:if>

    <!-- 이전 버튼 -->
    <c:if test="${dto.hasPreviousPage}">
        <a href="${pageContext.request.contextPath}/admin/memberlist.do?page=${dto.previousPage}${searchParam}${choiceParam}">이전</a>
    </c:if>

    <!-- 페이지 번호 -->
    <c:forEach var="num" begin="${dto.navigateFirstPage}" end="${dto.navigateLastPage}" step="1">
        <c:choose>
            <c:when test="${num == dto.pageNum}">
                <b>${num}</b>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/admin/memberlist.do?page=${num}${searchParam}${choiceParam}">${num}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 버튼 -->
    <c:if test="${dto.hasNextPage}">
        <a href="${pageContext.request.contextPath}/admin/memberlist.do?page=${dto.nextPage}${searchParam}${choiceParam}">다음</a>
    </c:if>
</div>
</body>
</html>