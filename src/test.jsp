	<%@ page import="java.io.*"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="oracle.jdbc.*"%>
	<%@ page import="java.lang.System"%>
            <%
            String username = (String)session.getAttribute("loged_in");
            	if (username == null) {
			username = "";
			%>
	<p>Unauthorized access</p>
	<meta http-equiv="refresh" content="1; url = login.html">
	<%
		}
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";

		String m_userName = "c391g3";
		String m_password = "C1234567";

		Connection m_con = null;
		
            	String sql = "SELECT PHOTO_ID FROM POPULARITY WHERE COUNT_NUM IN (SELECT * FROM (SELECT DISTINCT COUNT_NUM FROM POPULARITY  ORDER BY COUNT_NUM DESC) WHERE ROWNUM <=5 )";
            	String sql2 = "SELECT SUBJECT FROM POPULARITY p,IMAGES i WHERE p.PHOTO_ID = i.PHOTO_ID AND COUNT_NUM IN (SELECT * FROM (SELECT DISTINCT COUNT_NUM FROM POPULARITY  ORDER BY COUNT_NUM DESC) WHERE ROWNUM <=5 )";
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
		}
		catch(Exception e){
			out.println(e.toString());
		}
            %>
               	<table border="1">
		<tr>
	<%
				/*User's Image ==START==*/
		Statement stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet result2 = stmt.executeQuery(sql);
				while (result2.next()) {
					String id = String.valueOf(result2.getLong(1));
			%>
			<td><a href="displaySinglePhoto.jsp?photo_id=<%=id%>"><img
					src="displayblob.jsp?photo_id=<%=id%>&type=thumbnail" WIDTH="50"
					HEIGHT="50"></a></td>
			<%
				}
						/*User's Image ==END==*/
			%>
		</tr><tr>
			<%
				/*User's subject ==START==*/
		Statement stmt2 = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet imgResult = stmt2.executeQuery(sql2);
				while (imgResult.next()) {
					String subject = imgResult.getString(1);
			%>
			<td><%=subject%></td>
			<%
				/*User's subject ==START==*/
						}
			%>
		</tr>



		<tr>
		</tr>
