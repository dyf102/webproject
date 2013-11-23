<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.lang.System"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>lastname
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
</head>
<body>
<%		
		String username = (String) session.getAttribute("loged_in");
		ArrayList<String> thumbnailArray = new ArrayList<String>();
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
		String getImgSqlStmt = " SELECT PHOTO_ID,PERMITTED FROM IMAGES WHERE OWNER_NAME = '"+username+"'";
		/*SQL STATEMENTS*/
		
		/*Declarations for two images */
		//Blob thumbnail_blob = null;
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
			out.println(getImgSqlStmt);
			imgResult = stmt.executeQuery(getImgSqlStmt);
			while(imgResult.next()) {
				String id = String.valueOf(imgResult.getLong(1));
				//out.println(id);
				thumbnailArray.add(id);
			}

			for(int i = 0; i< thumbnailArray.size();i++){
				%>
			<p><img src="displayblob.jsp?photo_id =<%=thumbnailArray.get(i)%> WIDTH=50 HEIGHT=50>></p>
				<%
			}
		} catch (SQLException e) {
			out.println("SQLException: " + e.getMessage());
		}finally{
			imgResult.close();
			stmt.close();
			m_con.close();	
		}
 %>
</body>
</html>
