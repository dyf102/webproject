<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.System"%>

<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>
	<%
		String username = (String) session.getAttribute("loged_in");
		String thumbnail_id = request.getParameter("thumbnail_id");

		String PHOTO_ID = thumbnail_id;
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

		byte[] thumbnail = null; 
		/*SQL STATEMENTS*/
		String getImgSqlStmt = "SELECT * FROM " + TABLE_NAME
				+ "WHERE PHOTO_ID = '" + PHOTO_ID + "'";
		/*SQL STATEMENTS*/
		
		/*Declarations for two images */
		OutputStream os = null;
		Blob thumbnail_blob = null;
		/*Declarations for two images */

		/*Declarations for each descriptive infomation 
		  that will be displayed during the session*/

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
			m_con = DriverManager.getConnection(m_url, m_userName,
					m_password);
			stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);

			imgResult = stmt.executeQuery(getImgSqlStmt);
			if(imgResult.next()) {
				thumbnail_blob = imgResult.getBlob(8);
				thumbnail = thumbnail_blob.getBytes(1,(int)thumbnail_blob.length());
				response.setContentType("image/jpg");
				os = response.getOutputStream();
				os.write(thumbnail);
				os.flush();
				os.close();
			}else{
				out.println("image not found ");
			}

		} catch (SQLException e) {
			out.println("SQLException: " + e.getMessage());
		}
	%>
</body>
</html>