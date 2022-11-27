<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = null;
	if(session.getAttribute("userid")!=null){
		userid = (String)session.getAttribute("userid");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h2>로그인</h2>
<%
	if(userid == null){
%>
		<form method="post" action="./LoginOk">		<!-- jsp:"02_login_ok.jsp"	/	servlet:"./LoginOk" -->
			<p>아이디: <input type="text" name="userid"></p>
			<p>비밀번호: <input type="password" name="userpw"></p>
			<p><button>로그인</button></p>
		</form>
		<p>아직 회원이 아니신가요?<a href="04_member.jsp">회원가입</a></p>
<%
	}else{
%>
		<h3><%=userid%>님 환영합니다!</h3>
		<p><a href="./Logout">로그아웃</a> | <a href="06_info.jsp">정보수정</a> | <a href="./board/08_list.jsp">게시판</a></p>
		<!-- jsp:"03_logout.jsp"	/	servlet:"./Logout" -->
<%
	}
%>
</body>
</html>