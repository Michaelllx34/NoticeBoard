<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ include file="../include/sessioncheck.jsp" %>

<%	
//	request.setCharacterEncoding("UTF-8");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	int totalCount = 0;			// 추가
	int pagePerCount = 10;		// 페이지당 글 개수
	int start = 0;				// MySQL 시작 글번호
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum != null && !pageNum.equals("")){		// null아니면서 아무값도 없는 것이 아니면
		start = (Integer.parseInt(pageNum) - 1) * pagePerCount;
	}else{
		pageNum = "1";
		start = 0;
	}

	try{
		conn = Dbconn.getConnection();
		
		if(conn != null){
			String sql = "select count(b_idx) as total from tb_board";		// 변경
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			sql = "select * from tb_board order by b_idx desc limit ?, ?";	// 변경
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, pagePerCount);
			rs = pstmt.executeQuery();
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
	table{
		width: 800px;
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td{
		border: 1px solid black;
		padding: 10px;	
	}
	img {
		width: 16px;
	}
</style>
</head>
<body>
	<h2>리스트</h2>
	<p>총 게시글 : <%=totalCount%> 개</p>		<!-- Day5 과제할 때의 형식 -->
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>조회수</th>
			<th>날짜</th>
			<th>좋아요</th>
		</tr>
<%
		while(rs.next()){
			String b_idx = rs.getString("b_idx");
			String b_title = rs.getString("b_title");	// 추가
			String b_userid = rs.getString("b_userid");
			String b_name = rs.getString("b_name");
			String b_regdate = rs.getString("b_regdate");
			String b_hit = rs.getString("b_hit");
			String b_like = rs.getString("b_like");
			
			// Date date = new Date(b_regdate.substring(0, 10));
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = transFormat.parse(b_regdate);
			long now = System.currentTimeMillis();		// 타임스탬프 시간 
			long inputDate = date.getTime();			// 차를 계산해서 하루인지 이틀인지 계산할 예정
			
			// while문 안에 있어야 각각의 글에 대해 가능 
			String sql = "select count(re_idx) as cnt from tb_reply where re_boardidx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			ResultSet rs_reply = pstmt.executeQuery();		// rs와 같은 변수를 못 쓰는 이유:
			
			String replyCnt = "";
			
			if(rs_reply.next()){
				int cnt = rs_reply.getInt("cnt");
				if(cnt > 0){
					replyCnt = "[" + cnt + "]";
				}
			}			// 86째줄			<!-- <% if(rs_reply.next()) out.print("[" + rs_reply.getInt("cnt") + "]"); -->		
%>
		<tr>
			<td><%=b_idx%></td>
			<td><a href="11_view.jsp?b_idx=<%=b_idx%>"><%=b_title%></a><%=replyCnt%>	<!-- </a>[2]</td> 이런식으로  출력-->
<%
				if(now - inputDate < (1000*60*60*24*1)){		// 시간 조정
%>
					<img src="./new.png" alt="새글">		<!-- 여기에 style="height:15px" 스타일속성 줘도 됨 -->
<%
				}
%>
			</td>
			<td><%=b_userid%>(<%=b_name%>)</td>
			<td><%=b_hit%></td>
			<td><%=b_regdate%></td>
			<td><%=b_like%></td>
		</tr>
<%
		}		// while문 끝남

		int pageNums = 0;		// 총 페이지 수
		if(totalCount % pagePerCount == 0){
			pageNums = (totalCount / pagePerCount);
		}else{
			pageNums = (totalCount / pagePerCount) + 1;
		}
%>
		<tr>
			<td colspan="6">
<%
				for(int i=1; i<=pageNums; i++){
					out.print("<a href='08_list.jsp?pageNum=" + i + "'>[" + i + "]</a>&nbsp;&nbsp;&nbsp;");
				}
%>
			</td>
		</tr>
	</table>
	<p><a href="09_write.jsp">글쓰기</a> <a href="../01_login.jsp">돌아가기</a></p>
</body>
</html>