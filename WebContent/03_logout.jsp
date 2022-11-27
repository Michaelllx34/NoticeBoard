<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();		// 이러면 세션 변수가 다 날아가므로 로그아웃될 것임.
%>
<script>
	alert('로그아웃 되었습니다');
	location.href='01_login.jsp';
</script>