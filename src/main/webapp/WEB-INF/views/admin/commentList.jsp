<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.github.pagehelper.PageInfo" %>
<%@page import="a.dto.FreeCommentVO" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
            vertical-align: middle !important;
        }
    </style>
</head>

<body bgcolor="#e9e9e9">
<%
    PageInfo<FreeCommentVO> data = (PageInfo<FreeCommentVO>)request.getAttribute("dto");
    List<FreeCommentVO> list = data.getList();
    String choice = (String)request.getAttribute("choice");
    String search = (String)request.getAttribute("search");
%>

<br>
<div style="text-align:center;">
<h2>댓글 관리</h2>
</div>
<div align="center" class="container">
    <table class="table table-hover table-primary" style="width: 1300px; background-color: #f1f1f1; margin: 0 auto;">
        <col width="100">
        <col width="150">
        <col width="150">
        <col width="150">
        <col width="250">
        <col width="150">
        <col width="100">
        <tr class="bg-primary" style="color: white;">
            <th><label class="checkbox-inline"><input type="checkbox" id="ck_all"></label></th>
            <th>번호</th>
            <th>댓글번호</th>
            <th>작성자(아이디)</th>
            <th>댓글내용</th>
            <th>등록일</th>
            <th>삭제여부</th>
            <tbody>
            <tr>
                    <%
if(list == null || list.size() == 0){
	%>
            <tr>
                <td colspan="7">등록된 회원이 없습니다.</td>
            </tr>
            <%
            } else {
                for (int i = 0; i < list.size(); i++) {
                    FreeCommentVO vo = list.get(i);
            %>
            <tr>
                <td><input type="checkbox" class="checkbox" value="<%=vo.getComment_seq() %>"/></td>
                <th><%=i + 1 %>
                </th>
                <td>
                        <%=vo.getComment_seq() %>
                    </a>
                </td>
                <td><a><a href="memberview.do?user_id=<%=vo.getUser_id() %>">
                <%=vo.getUser_id() %>
                </a></td>
                <%
                    if (vo.getDel_cmt() == 0) {
                %>
                <td>
                    <a href="bbsdetail2.do?bbs_seq=<%=vo.getBbs_seq() %>">
                        <%=vo.getCmt_content() %>
                    </a>
                </td>
                <%
                } else if (vo.getDel_cmt() == 1) {
                %>
                <td>
                	<a href="bbsdetail2.do?bbs_seq=<%=vo.getBbs_seq() %>">
                    <font color="#ff0000">*** 이 댓글은 작성자 또는 관리자에의해 삭제되었습니다 ***</font>
                </td>
                <%
                    }
                %>
                <td><%=vo.getReg_cmtdate() %>
                </td>
                <%
                    if (vo.getDel_cmt() == 0) {
                %>
                <td><%=vo.getDel_cmt() %>
                </td>
                <%
                } else if (vo.getDel_cmt() == 1) {
                %>
                <td><%=vo.getDel_cmt() %>
                </td>
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
    <div style="display: flex; justify-content: flex-end;">
  <button id="deleteButton" class="btn btn-danger" onclick="deleteChecked();" type="button">삭제</button>
	</div>
    <br>
    <form method="get">
        <div align="center">
            <table style="margin-left: auto; margin-right: auto; margin-top: 3px; margin-bottom: 3px">
                <tr>
                    <td style="padding-left: 5px">
                        <select class="custom-select" id="choice" name="choice">
                            <option selected>선택</option>
                            <option value="user_id">아이디(작성자)</option>
                        </select>
                    </td>

                    <td style="padding-left: 5px" class="align-middle">
                        <input type="text" class="form-control" id="search" name="search" placeholder="검색어"
                               value="<%=search %>">
                    <td style="padding-left: 5px">
			<span>
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
        <a href="${pageContext.request.contextPath}/admin/commentList.do?page=${dto.prePage}${searchParam}${choiceParam}">이전</a>
    </c:if>

    <!-- 페이지 번호 -->
    <c:forEach var="num" begin="${dto.navigateFirstPage}" end="${dto.navigateLastPage}" step="1">
        <c:choose>
            <c:when test="${num == dto.pageNum}">
                <b>${num}</b>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/admin/commentList.do?page=${num}${searchParam}${choiceParam}">${num}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <!-- 다음 버튼 -->
    <c:if test="${dto.hasNextPage}">
        <a href="${pageContext.request.contextPath}/admin/commentList.do?page=${dto.nextPage}${searchParam}${choiceParam}">다음</a>
    </c:if>
</div>
<script type="text/javascript">

    window.onload = function () {
        var deleteButton = document.getElementById('deleteButton');


//전체 선택 체크박스
        function chk_all() {
            var chk_all = document.getElementById('ck_all');
            var chk_list = document.getElementsByName('checkbox');

            if (chk_all.checked) {
                for (var i = 0; i < chk_list.length; i++) {
                    chk_list[i].checked = true;
                }
            } else {
                for (var i = 0; i < chk_list.length; i++) {
                    chk_list[i].checked = false;
                }
            }
        }

// 체크된 항목 삭제
        document.getElementById('ck_all').addEventListener('click', chk_all());
    }

    function deleteChecked() {
        var chk_list = document.getElementsByClassName('checkbox');
        var deleteList = [];

        for (var i = 0; i < chk_list.length; i++) {
            if (chk_list[i].checked) {
                var id = chk_list[i].value;
                deleteList.push(id);
            }
        }

        if (deleteList.length == 0) {
            alert('삭제할 항목을 선택해주세요.');
            return false;
        } else {
            if (confirm('정말로 삭제하시겠습니까?')) {
                var xhr = new XMLHttpRequest();
                var url = "${pageContext.request.contextPath}/admin/deleteComment.do";
                xhr.open("POST", url, true);
                xhr.setRequestHeader("Content-Type", "application/json");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            alert('삭제되었습니다.');
                            location.reload();
                        } else {
                            alert('삭제 중 오류가 발생했습니다.');
                        }
                    }
                };
                xhr.send(JSON.stringify(deleteList));
            }
        }
    }
</script>
</body>
</html>