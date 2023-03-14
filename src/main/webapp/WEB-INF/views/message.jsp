<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
String sessionOut = (String)request.getAttribute("sessionOut");
if(sessionOut != null && !sessionOut.equals("")){
		%>
		<script type="text/javascript">
		alert("세션이 만료되었습니다. 다시 로그인 해 주십시오");
		location.href = "login.do";
		</script>
		<%
}
%>




