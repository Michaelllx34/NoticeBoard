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

import com.koreait.db.Dbconn;
/**
 * Servlet implementation class MemberOk
 */
@WebServlet("/MemberOk")
public class MemberOk extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberOk() {
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
		request.setCharacterEncoding("UTF-8");		// 없을 경우, 웹 페이지상에서 ê¹ë°°(pear)님 회원가입이 완료되었습니다! 라고 글씨가 깨짐 
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter writer = response.getWriter();
		
		Connection conn = null;
		PreparedStatement pstmt = null;		// sql 쿼리 만들 때 쓰는것
		
		String userid = request.getParameter("userid");
		String userpw = request.getParameter("userpw");
		String name = request.getParameter("name");
		String hp = request.getParameter("hp");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String hobby[] = request.getParameterValues("hobby");
		String ssn1 = request.getParameter("ssn1");
		String ssn2 = request.getParameter("ssn2");
		String zipcode = request.getParameter("zipcode");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String address3 = request.getParameter("address3");
		
		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				//System.out.println("DB연결 성공!");
				String sql = "insert into tb_member(mem_userid, mem_userpw, mem_name, mem_hp, mem_email, mem_hobby, mem_ssn1, mem_ssn2, mem_zipcode, mem_address1, mem_address2, mem_address3, mem_gender) values (?, sha2(?, 256), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, userpw);
				pstmt.setString(3, name);
				pstmt.setString(4, hp);
				pstmt.setString(5, email);
				String hobbystr = "";
				for(int i=0; i<hobby.length; i++){
					hobbystr = hobbystr + hobby[i] + " ";
				}
				pstmt.setString(6, hobbystr);
				pstmt.setString(7, ssn1);
				pstmt.setString(8, ssn2);
				pstmt.setString(9, zipcode);
				pstmt.setString(10, address1);
				pstmt.setString(11, address2);
				pstmt.setString(12, address3);
				pstmt.setString(13, gender);
				
				pstmt.executeUpdate();
			}
		}catch(Exception e){
			e.printStackTrace();		
		}

		writer.println("<h2>회원가입 완료</h2><p>"+name+"("+userid+")님 회원가입이 완료되었습니다!</p><p><a href='01_login.jsp'>로그인 하러가기</a></p>");

	}
}