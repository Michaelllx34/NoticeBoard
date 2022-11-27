<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>		<!-- Connection, PreparedStatement, ResultSet 다 적용 -->
<%@ page import ="com.koreait.db.Dbconn" %>
<%	
	String userid = request.getParameter("userid");
	String userpw = request.getParameter("userpw");
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs = null;
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "select mem_idx, mem_name from tb_member where mem_userid=? and mem_userpw=sha2(?, 256)";		// 세션에 idx, name을 저장하기 위해
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, userpw);
			rs = pstmt.executeQuery();		// select 쓸 때는 executeQuery(), 삽입/수정/삭제 쓸 때는 executeUpdate()
			if(rs.next()){
				session.setAttribute("userid", userid);					// 세션 변수 만들기
				session.setAttribute("idx", rs.getInt("mem_idx"));		// 
				session.setAttribute("name", rs.getString("mem_name"));	// 
%>
				<script>
					alert('로그인 되었습니다.');
					location.href='01_login.jsp';	// 캐시가 남지 않음. (새로고침 한 것처럼 비워진다)
				</script>
<%	
			}else{
%>
				<script>
					alert('아이디 또는 비밀번호를 확인하세요.');
					history.back();					// 캐시가 남기 때문에 기록이 남아있음.
				</script>
<%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>