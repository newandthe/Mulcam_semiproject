<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.github.pagehelper.PageInfo"%>
<%@page import="a.dto.FreePostDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Free Post List</title>
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
    PageInfo<FreePostDto> data = (PageInfo<FreePostDto>)request.getAttribute("dto");
    List<FreePostDto> list = data.getList();
    String choice = (String)request.getAttribute("choice");
    String search = (String)request.getAttribute("search");
%>

<br>
<div style="text-align:center;">
<h2>게시판 관리</h2>
</div>

<div align="center">
<table class="table table-hover table-sm" style="width: 1300px; background-color: #f1f1f1;">
<col width="70"><col width="100"><col width="100"><col width="150"><col width="70">
<col width="70"><col width="100"><col width="300"><col width="300">
<tr class="bg-primary" style="color: white;">
	<th>번호</th>
	<th>게시글 번호</th>
	<th>아이디</th>
	<th>제목</th>
	<th>조회수</th>
	<th>좋아요 수</th>
	<th>댓글 수</th>
	<th>등록일(게시글 등록일)</th>
	<th>삭제 여부</th>
</tr>
<tbody>
<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="9">작성된 글이 없습니다</td>
	</tr>
	<%
}else{
	for(int i =0; i <list.size(); i++)
		{
			FreePostDto dto = list.get(i);
	%>
	<tr>			
		<th><%=i + 1 %></th>
		<td><%=dto.getBbs_seq() %></td>
		<td><a href="memberview.do?user_id=<%=dto.getuser_id() %>"><%=dto.getuser_id() %></a></td>
		 <%
                if(dto.isDel() == 0){
                    %>
		<td>
			<a href="bbsdetail2.do?bbs_seq=<%=dto.getBbs_seq() %>">
				<%=dto.getTitle() %>
			</a>
		</td>
		<%
               }else if(dto.isDel() == 1){
                    %>
              <td><a href="bbsdetail2.do?bbs_seq=<%=dto.getBbs_seq() %>">
                  <font color="#ff0000">*** *** 이 글은 작성자 또는 관리자에 의해 삭제되었습니다 *** ***</font>  
                  <a href="bbsdetail2.do?bbs_seq=<%=dto.getBbs_seq() %>">
			</a>  
              </td>
               <%
                }   
                %>
		<td><%=dto.getReadcount() %></td>
		<td><%=dto.getLikecount() %></td>
		<td><%=dto.getCmtcount() %></td>
		<td><%=dto.getWdate() %></td>
		<%
            if(dto.isDel() == 1){
         %>
		<td><%=dto.isDel() %></td>
		   <%
                }else if(dto.isDel() == 0){ 
             %>
             <td><%=dto.isDel() %></td>
		   <%
                }   
                %>
	</tr>
<%
	}
}
%>
	</tr>
	</tbody>
</table>
<br>

<form method="get">
        <div align="center">
            <table style="margin-left: auto; margin-right: auto; margin-top: 3px; margin-bottom: 3px">
                <tr>
                    <td style="padding-left: 5px">
                        <select class="custom-select" id="choice" name="choice">
                        	<option selected>선택</option>
                            <option value="user_id">아이디(작성자)</option>
                            <option value="title">제목</option>
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
        <a href="${pageContext.request.contextPath}/admin/freepostList.do?page=${dto.prePage}${searchParam}${choiceParam}">이전</a>
    </c:if>

    <!-- 페이지 번호 -->
    <c:forEach var="num" begin="${dto.navigateFirstPage}" end="${dto.navigateLastPage}" step="1">
        <c:choose>
            <c:when test="${num == dto.pageNum}">
                <b>${num}</b>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/admin/freepostList.do?page=${num}${searchParam}${choiceParam}">${num}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <!-- 다음 버튼 -->
    <c:if test="${dto.hasNextPage}">
        <a href="${pageContext.request.contextPath}/admin/freepostList.do?page=${dto.nextPage}${searchParam}${choiceParam}">다음</a>
    </c:if>
</div>

<script type="text/javascript">
$(document).on('click', 'a', function(e) {
  e.preventDefault();
  
  const url = $(this).attr('href');
  location.href = url;
});
</script>

</body>
</html>