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
		out.println(username);
		String photo_id = (String) request.getParameter("photo_id");
		out.println(photo_id);
		session.setAttribute("photo_id",photo_id);
		
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
		ResultSet groupResult = null;
		ResultSet currentGroupResult = null;
		
		ArrayList<String> groupNames = new ArrayList<String>();

		/*SQL STATEMENTS*/
		String getImgSqlStmt = "SELECT PERMITTED,SUBJECT,PLACE,TIMING,DESCRIPTION FROM IMAGES WHERE PHOTO_ID =" +photo_id ;
		String getGroupName = "SELECT GROUP_NAME FROM GROUPS WHERE USER_NAME = '"+username+"'";
		
		String getCurrentGroup = "SELECT GROUP_NAME FROM IMAGES A,GROUPS B WHERE A.PERMITTED = B.GROUP_ID AND PHOTO_ID ="+photo_id;
		/*SQL STATEMENTS*/
		String permission_info ="";
		String subject_info = "";
		String place_info = "";
		String timing_info = "";
		String desc_info ="";

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
					
			currentGroupResult = stmt.executeQuery(getCurrentGroup);	
			groupResult = stmt.executeQuery(getGroupName);
			
			while(groupResult.next()){
				String name = groupResult.getString(1);
				groupNames.add(name);
			}
			
			imgResult = stmt.executeQuery(getImgSqlStmt);
			
			
			if(imgResult.next()) {
				long value = imgResult.getLong(1);
				
				if(value == 1){
					permission_info = "public";
				}else if (value == 2){
					permission_info = "private";
				}
				
				if(currentGroupResult.next()){
					permission_info = currentGroupResult.getString(1);
				}
				
				if(imgResult.getString(2) != null){
					subject_info = imgResult.getString(2);
				}
				if(imgResult.getString(3) != null){
					place_info = imgResult.getString(3);
				}
				if(imgResult.getDate(4) != null){
					timing_info = imgResult.getDate(4).toString();
				}
				if(imgResult.getString(5) != null){
					desc_info = imgResult.getString(5);
				}
				
		%>
			<img src="displayblob.jsp?photo_id=<%=photo_id%>&type=hd">
			<p><b>Current Permission:<%=permission_info%></b></p>
			<form action = "photoInfo.jsp?photo_id=<%=photo_id%>">
				Permission:
				<select name ="permission_info" >
					<option name = "private" value= "private" > private </option>
					<option name = "private" value= "public" > public </option>
				<%for(int i = 0;i < groupNames.size();i++){%>
					<option value ="<%=groupNames.get(i)%>"> <%=groupNames.get(i)%></option>
				<%}%>
				</select>
				Subject: <input type = "text" name = "subject_info" value =<%=subject_info%> ><br>
				Location: <input type = "text" name = "place_info" value =<%=place_info%> ><br>
				Time: <input type = "text" name = "timing_info" value =<%=timing_info%> ><br>
				Description: <input type = "text" name = "desc_info" value =<%=desc_info%> ><br>
				<input type="submit" value = "Update">
			</form>
							
		<%
			}
		
		
		
				
				
		} catch (SQLException e) {
			out.println("SQLException: DisplaySinglePhoto.jsp" + e.getMessage());
		}finally{
			stmt.close();
			m_con.close();	
		}
%>
</body>
</html>

			
		
		
