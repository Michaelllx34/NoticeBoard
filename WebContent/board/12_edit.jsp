<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.koreait.db.Dbconn" %>

<%@ include file="../include/sessioncheck.jsp"%>
<% 
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	String b_idx = request.getParameter("b_idx");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String b_title = "";
	String b_content = "";
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "select b_title, b_content from tb_board where b_idx=?;";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			rs= pstmt.executeQuery();
			
			if(rs.next()){
				b_title = rs.getString("b_title");
				b_content = rs.getString("b_content");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
</head>
<body>
	<h2>글수정</h2>
	<!-- <form method="post" action="13_edit_ok.jsp?b_idx=bi dx>"> -->
	<form method="post" action="../EditOk">		<!-- jsp:"13_edit_ok.jsp"	/	servlet:"../EditOk" -->
		<input type="hidden" name="b_idx" value="<%=b_idx %>">
		<p>작성자: <%=name %>(<%=userid %>)</p>
		<p>제목: <input type="text" name="b_title" value="<%=b_title %>"></p>
		<p>내용</p>
		<p><textarea style="width: 300px; height: 200px; resize: none;" name="b_content"><%=b_content %></textarea></p>
		<p>
			<button>수정</button>
			<button type="reset">재작성</button>
			<button type="button" onclick="history.back()">뒤로</button>
		</p>
	</form>
</body>
</html>