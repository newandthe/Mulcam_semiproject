<%@page import="a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	MemberDto login = (MemberDto) session.getAttribute("login");
%>
<html>
<head>
<meta charset="UTF-8">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<title>회원정보 수정</title>
</head>
<body>
	<div>
		<div>
			<ul>
				<li>
					<a href="myPage.do">
						<span>회원정보 수정</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span>내 반려동물 관리</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span>내 활동 관리</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span>회원 탈퇴</span>
					</a>
				</li>
			</ul>
		</div>
		<div id="updateInputPwd">
			비밀번호를 입력하세요
			<br>
			<input type="password" id="pwd" placeholder="●●●●●●●●" />
			<button type="button" id="pwdChkBtn">확인</button>
		</div>
		<div style="display: none;" id="updateDetail">
			<form action="updateAf.do" method="post" id="frm">
				<table border="1" style="width: 500px; text-align: center;">
					<tr>
						<td>이름</td>
						<td>
							<%=login.getUsername() %>
							<input type="hidden" value="<%=login.getUsername() %>" name="username">
						</td>
					</tr>
					<tr>
						<td>ID</td>
						<td>
							<%=login.getUser_id()%>
							<input type="hidden" value="<%=login.getUser_id()%>" name="user_id">
						</td>					
					</tr>
					<tr>
						<td>닉네임</td>
						<td>
							<input type="text" value="<%=login.getNickname()%>" id="nickname" name="nickname">&nbsp;
							<button type="button" id="nickChkBtn">중복확인</button>
							<p id="nickCheck" />
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<input type="text" value="<%=login.getEmail()%>" name="email">
						</td>
					</tr>
					<tr>
						<td>새 비밀번호</td>
						<td>
							<input type="text" placeholder="●●●●●●●●">
						</td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td>
							<input type="text" placeholder="●●●●●●●●">
						</td>
					</tr>
					<tr style="height: 100px;">
						<td>프로필 사진</td>
						<td></td>
					</tr>
				</table>
				<br>
				<button type="submit">저장</button>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		// 정보 수정 메뉴 입장 시, 비밀번호 재입력 및 확인
		$("#pwdChkBtn").click(function() {
			$.ajax({
				type: "post",
				url: "pwdcheck.do",
				data: { "pwd":$("#pwd").val() },
				success: function(msg) {
					if (msg == "YES") {
						$("#updateInputPwd").hide();
						$("#updateDetail").show();
					} else {
						alert("비밀번호를 다시 확인해주세요");
					}
				},
				error : function() {
					alert("memberUpdate.jsp pwdChkBtn ajax error");
				}
			})
		})
		
		// 닉네임 중복확인
		$("#nickChkBtn").click(function() {
			
			// 빈칸 조사
			if ($("#nickname").val() == "" || $("#nickname").val() == null) {
				$("#nickCheck").css("color", "#ff0000");
				$("#nickCheck").text("닉네임을 입력해주세요");
				return;
			}
			
			$.ajax({
				type: "post",
				url: "nickcheck.do",
				data: { "nickname":$("#nickname").val() },
				success: function(msg) {
					if (msg == "YES") {
						$("#nickCheck").css("color", "#0000ff");
						$("#nickCheck").text("사용할 수 있는 닉네임입니다");
					} else {
						$("#nickCheck").css("color", "#ff0000");
						$("#nickCheck").text("사용중인 닉네임입니다");
						$("#nickname").val("");
					}
				},
				error : function() {
					alert("memberUpdate.jsp nickChkBtn ajax error");
				}
			})
		})
		
		// 변경된 값에 대해서만 수정 반영 되도록 해야 함
		// update Member2 set [column_name] = if([condition], [true case], [false case]) 이용
		// [false case]에 [column_name] 그대로 입력하면 false 시 원래 값 입력됨
	</script>
</body>
</html>