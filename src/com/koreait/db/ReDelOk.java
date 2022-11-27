package com.koreait.db;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ReDelOk")
public class ReDelOk extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public ReDelOk() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter writer = response.getWriter();
		
		String b_idx = request.getParameter("b_idx");
		String re_idx = request.getParameter("re_idx");

		String userid = (String)session.getAttribute("userid");

		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				String sql = "delete from tb_reply where re_idx=? and re_userid=?";		// 이렇게 안하면 아무나가 주소창에 delete입력해서 지우는 것이 가능하다	// http://localhost:9090/Day4/board/delete_ok.jsp?b_idx=1
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, re_idx);
				pstmt.setString(2, userid);
				
				pstmt.executeUpdate();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		writer.println("<script> alert('삭제되었습니다!'); location.href='./board/11_view.jsp?b_idx="+b_idx+"'; </script>");

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
