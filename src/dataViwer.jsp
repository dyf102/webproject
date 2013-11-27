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
<a href="main.jsp">Back to Main</a>
<body>
<p><b>Data Analysis Center</b></p>
<%
		String username = (String) session.getAttribute("loged_in");
		
		String TABLE_NAME;
		//query fields initialization
		TABLE_NAME = "IMAGES";

		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";

		String m_userName = "c391g3";
		String m_password = "C1234567";

		Connection m_con = null;
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet userRs = null;
		ResultSet subjectRs = null;
		
		
		ArrayList<String> userNames = new ArrayList<String>();
		ArrayList<String> subjectNames = new ArrayList<String>();

		/*SQL STATEMENTS*/
		String getGroups = "SELECT USER_NAME FROM USERS GROUP BY USER_NAME";
		String getUsers = "SELECT SUBJECT FROM IMAGES GROUP BY SUBJECT";
		
		/*SQL STATEMENTS*/

		try {
			Class drvClass = Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
			drvClass.newInstance();

		} catch (Exception e) {
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());

		}
		
		try{
			m_con = DriverManager.getConnection(m_url, m_userName,m_password);
			
			stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
					
			stmt2 = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
					
			userRs = stmt.executeQuery(getGroups);
			subjectRs = stmt2.executeQuery(getUsers);
			
			while(userRs.next()){
				userNames.add(userRs.getString(1));
			}
			
			while(subjectRs.next()){
				subjectNames.add(subjectRs.getString(1));
			}
					
		%>	
			<form action = "dataAnalysis.jsp">
				User:		
				<select name ="user_info" >
					<%for(int i = 0;i < userNames.size();i++){%>
						<option value ="<%=userNames.get(i)%>"> <%=userNames.get(i)%></option>
					<%}%>
				</select>
				Subject:
				<select name ="subject_info" >
					<%for(int i = 0;i < subjectNames.size();i++){%>
						<option value ="<%=subjectNames.get(i)%>"> <%=subjectNames.get(i)%></option>
					<%}%>
				</select>
				From:
				<input type = "text" name = "from">
				To:
				<input type = "text" name = "to">
				<input type = "submit" value = "submit" name = "submit">
			</form>
		<%			
		}catch(SQLException e){
		
		
		}finally{
			stmt.close();
			m_con.close();
		}
%>
</body>
</html>