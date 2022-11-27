<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("userid") == null){
		response.sendRedirect("/NoticeBoardPage/01_login.jsp");//앞에/쓰면 맨 앞으로 옴
		return;
	}
%>