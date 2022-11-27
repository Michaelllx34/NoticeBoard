package com.koreait.db;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.db.Dbconn;

@WebServlet("/InfoOk")
public class InfoOk extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InfoOk() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");					// 글자가 깨진채로 저장되는 것 방지	
		response.setContentType("text/html;charset=UTF-8");		// alert 창의 글씨가 깨지는 것 방지
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		HttpSession session = request.getSession();
		PrintWriter writer =response.getWriter();
		
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
				sql = "select mem_idx from tb_member where mem_userid=? and mem_userpw=sha2(?,256)";
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
					
					writer.println("<script>alert('변경되었습니다'); location.href='01_login.jsp';</script>");
					
				}else{
					
					writer.println("<script>alert('비밀번호를 확인하세요'); history.back();</script>");
				
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
