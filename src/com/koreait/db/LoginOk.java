package com.koreait.db;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.db.Dbconn;

/**
 * Servlet implementation class OK
 */
@WebServlet("/LoginOk")
public class LoginOk extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public LoginOk() {
        super();
        // TODO Auto-generated constructor stub
    }

	/** 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");		// response가 없으면 alert창에서 ???? ????? 뜸
		
		String userid = request.getParameter("userid");
		String userpw = request.getParameter("userpw");
		
		Connection conn = null;		// 만들어놓은 Dbconn.java 사용
		PreparedStatement pstmt;
		ResultSet rs = null;
		
		HttpSession session = request.getSession();
		PrintWriter writer = response.getWriter();
		
		try {
			conn = Dbconn.getConnection();
			if(conn != null){
				String sql = "select mem_idx, mem_name from tb_member where mem_userid=? and mem_userpw=sha2(?, 256)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, userpw);
				rs = pstmt.executeQuery();
				if(rs.next()){
					session.setAttribute("userid", userid);					// userid와 name을 메모리에 올려놓기
					session.setAttribute("idx", rs.getInt("mem_idx"));
					session.setAttribute("name", rs.getString("mem_name"));

					writer.println("<script> alert('로그인 되었습니다.'); location.href='01_login.jsp'; </script>");
					
				}else{
					
					writer.println("<script> alert('아이디 또는 비밀번호를 확인하세요'); 	history.back(); </script>");
				
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		/*	임시로 apple의 비밀번호가 1234 일 경우 로그인되도록 설정
		if(userid.equals("apple") && userpw.equals("1234")){		// ip/pw 같으면 로그인시킬 때 쓰던 if문
			// 로그인 성공!
			session.setAttribute("userid", userid);		// 추가된 부분. 들어오자마자 생겼을 거니까 이것만 확인하면 됨.

			writer.println("<script> alert('로그인 되었습니다'); location.href='01_login.jsp'; </script>");

		}else{
			// 로그인 실패!
			writer.println("<script> alert('아이디 또는 비밀번호를 확인하세요..'); history.back(); </script>");
		}*/
	}
}
