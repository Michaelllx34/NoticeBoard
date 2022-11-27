<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.koreait.db.Dbconn" %>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	request.setCharacterEncoding("UTF-8");
	String userid = (String)session.getAttribute("userid");
	String userpw = request.getParameter("userpw");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	String[] hobby = request.getParameterValues("hobby");
	String ssn1 = request.getParameter("ssn1");
	String ssn2 = request.getParameter("ssn2");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	
	String sql="";
	String hobbystr = "";
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			//System.out.println(" DB연결 성공! ");
			sql = "select mem_idx from tb_member where mem_userid=? and mem_userpw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			pstmt.setString(2,userpw);
			rs = pstmt.executeQuery();
			if(rs.next()){
				sql = "update tb_member set mem_name=?, mem_hp=?, mem_email=?, mem_hobby=?, mem_zipcode=?, mem_address1=?, mem_address2=?, mem_address3=?, mem_gender=? where mem_userid=?;";
				pstmt= conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, hp);
				pstmt.setString(3, email);
				for(int i=0; i<hobby.length; i++){
					hobbystr = hobbystr + hobby[i]+" ";
				}
				pstmt.setString(4, hobbystr);
				pstmt.setString(5, zipcode);
				pstmt.setString(6, address1);
				pstmt.setString(7, address2);
				pstmt.setString(8, address3);
				pstmt.setString(9, gender);
				pstmt.setString(10, userid);
				
				pstmt.executeUpdate();
				
%>
				<script>
					alert('변경되었습니다!');
					location.href='01_login.jsp';
				</script>
<%
				
			}else{
%>
				<script>
					alert('비밀번호를 확인하세요');
					history.back();
				</script>
<%
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
<title>정보수정 완료</title>
</head>
<body>
	<h2>정보수정 완료</h2>
	<p><%=name %>님 정보수정이 완료되었습니다</p>
	<p><a href="01_login.jsp">로그인 하러가기</a></p>
</body>
</html>