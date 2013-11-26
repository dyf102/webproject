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
		String photo_id = (String) request.getParameter("photo_id");
		
		String subject_info, place_info,timing_info,permission_info;
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
		ResultSet imgResult = null;

		/*SQL STATEMENTS*/
		
		String getGroupID = "";
		"UPDATE USERS SET PERMITTED = ?,SUBJECT = ?, PLACE = ?, TIMING = ?,DESCRIPTION = ? WHERE PHOTO_ID ="+photo_id;
		/*SQL STATEMENTS*/
		String ownerNameValue = null;
		String subjectValue = null;
		String placeValue = null;
		String descriptionValue = null;

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
			PreparedStatement pstmt = m_con.prepareStatement(updateInfo);
			if(){
					
			}
			if(){
				
			}
			pstmt.setInt(1,permission_info);
			pstmt.setString(2,subject_info);
			pstmt.setString(3,)
			
			
		%>
		
		
		
		
		
		
		
		
