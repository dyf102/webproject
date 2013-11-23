<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.lang.System"%>
<%
String firstname,lastname,address,email,phone;
firstname = request.getParameter("firstname");
lastname = request.getParameter("lastname");
address = request.getParameter("address");
email = request.getParameter("email");
phone = request.getParameter("phone");
String profile_update = "UPDATE PERSONS SET FIRST_NAME=?,LAST_NAME=?,EMAIL=?,ADDRESS=?,PHONE=? WHERE USER_NAME =?";

String username = (String)session.getAttribute("loged_in");
if(username==null){
%>
	<meta http-equiv="refresh" content="0; url = login.html">
<%
}
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "c391g3";
String m_password = "C1234567";

	Connection m_con = null;
	Statement stmt = null;
	ResultSet imgResult = null;
try {
	Class drvClass = Class.forName(m_driverName);
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	drvClass.newInstance();
} catch (Exception e) {
	out.print("ClassNotFoundException: ");
	out.println(e.getMessage());
	}
	try {
	m_con = DriverManager.getConnection(m_url, m_userName,m_password);
	PreparedStatement pstmt = m_con.prepareStatement(profile_update);
	pstmt.setString(1,firstname);
	pstmt.setString(2,lastname);
	pstmt.setString(3,email);
	pstmt.setString(4,address);
	pstmt.setString(5,phone);
	pstmt.setString(6,username);
	if(pstmt.executeUpdate()==0){
		out.println("Error to update");
	}
	String password = request.getParameter("new password");
	if(password!=null&&!password.equals("")){
		String updateuser = "UPDATE USERS SET PASSWORD = ? WHERE USER_NAME=?";
		PreparedStatement pstmt2 = m_con.prepareStatement(updateuser);
		pstmt2.setString(1,password);
		pstmt2.setString(2,username);
		if(pstmt2.executeUpdate()==0){
			out.println("2.Error to update");
		}
		else{
			%>
			<p>Information change successfull,Please login again!</p>
			<jsp:forward page="logout.jsp"/>
			<%
		}
	}
	}
	catch(Exception e){
		out.println(e.getMessage());
	}finally{
		m_con.close();
	}
%>
