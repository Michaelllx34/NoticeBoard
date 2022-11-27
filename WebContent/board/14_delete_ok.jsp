<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.koreait.db.Dbconn" %>

<%@ include file="../include/sessioncheck.jsp"%>

<%
	String b_idx = request.getParameter("b_idx");

	String userid = (String)session.getAttribute("userid");

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "delete from tb_board where b_idx=? and b_userid=?";		// 이렇게 안하면 아무나가 주소창에 delete입력해서 지우는 것이 가능하다	// http://localhost:9090/Day4/board/delete_ok.jsp?b_idx=1
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			pstmt.setString(2, userid);
			
			pstmt.executeUpdate();
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
	<script>
		alert('삭제되었습니다!');
		location.href='08_list.jsp';
	</script>