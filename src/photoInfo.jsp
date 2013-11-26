<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.lang.System"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
</head>
<body>

<%		
		
		String username = (String) session.getAttribute("loged_in");
		String photo_id = (String) session.getAttribute("photo_id");
		
		String subject_info, place_info,timing_info,permission_info,desc_info;
		
		permission_info = request.getParameter("permission_info");
		subject_info = request.getParameter("subject_info");
		place_info = request.getParameter("place_info");
		timing_info = request.getParameter("timing_info");
		desc_info = request.getParameter("desc_info");
		
		String TABLE_NAME;
		//query fields initialization
		TABLE_NAME = "IMAGES";

		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";

		String m_userName = "c391g3";
		String m_password = "C1234567";

		Connection m_con = null;
		Statement stmt = null;
		ResultSet groupIdResult = null;

		/*SQL STATEMENTS*/
		
		String getGroupID = "SELECT GROUP_ID FROM GROUPS WHERE GROUP_NAME = '"+permission_info+"'";
		String updateInfo = "UPDATE IMAGES SET PERMITTED = ?,SUBJECT = ?, PLACE = ?, TIMING = ?,DESCRIPTION = ? WHERE PHOTO_ID ="+photo_id;
		
		
		/*SQL STATEMENTS*/
		String ownerNameValue = null;
		String subjectValue = null;
		String placeValue = null;
		String descriptionValue = null;
		int group_id ;

		try {
			Class drvClass = Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
			drvClass.newInstance();

		} catch (Exception e) {
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());

		}
		
		try {
		    
			m_con = DriverManager.getConnection(m_url, m_userName,m_password);
			
			stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			
			groupIdResult = stmt.executeQuery(getGroupID);
			
			if(groupIdResult.next()){
				group_id = (int)groupIdResult.getLong(1);
				
				PreparedStatement pstmt = m_con.prepareStatement(updateInfo);
				pstmt.setInt(1,group_id);
				pstmt.setString(2,subject_info);
				
				pstmt.setString(3,place_info);
				pstmt.setString(4,timing_info);
				pstmt.setString(5,desc_info);
				
				if(pstmt.executeUpdate()==0){
					out.println("Cannot Update");
					%>
					<meta http-equiv="refresh" content="1; url = displayAll.jsp">
					<%
				}else{
					out.println("Update Successfully");
					%>
					<meta http-equiv="refresh" content="1; url = displayAll.jsp">
					<%
				}
			}
			
			
		}catch (SQLException e){
				out.println("SQLException: " + e.getMessage());
		}finally{
			
				if(groupIdResult != null){
					groupIdResult.close();
				}
				
				stmt.close();
				m_con.close();	
			
			
		}
%>
		
		
		
		
		
		
		
		
