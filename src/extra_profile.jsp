<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.lang.System"%>
<html><head><title>Chenge user information</title>
<script>
function validateForm()
{
var x=document.forms["myForm"]["new password"].value;
if (x==null || x=="")
  {
  alert("New Password must be filled out");
  return false;
  }
  var conf = confirm("Are you sure you want to change your information?");
    if(conf == false){
	return false;
    }
}
function formReset(){
	document.forms["myForm"].reset();
}
</script>
</head>
<body>
<center>
<p><h1>Please type your new personal information</h1></p>
<%
String username = (String)session.getAttribute("loged_in");
if(username == null){
%>
	<meta http-equiv="refresh" content="0; url = login.html">
<%
}
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "c391g3";
String m_password = "C1234567";
String getuserinformation = "SELECT * FROM PERSONS WHERE USER_NAME='"+username+"'";
Connection m_con = null;
Statement stmt = null;
ResultSet imgResult = null;
String firstname,lastname,address,email,phone;
firstname = lastname = address = email = phone ="";
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
		stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,					ResultSet.CONCUR_UPDATABLE);
			//out.println(getImgSqlStmt);
		imgResult = stmt.executeQuery(getuserinformation);
		if(imgResult.next()) {
			firstname= imgResult.getString(2);
			lastname = imgResult.getString(3);
			address = imgResult.getString(4);
			email = imgResult.getString(5);
			phone = imgResult.getString(6);
			}
	} catch (Exception e){
			out.println("SQLException: " + e.getMessage());
	}finally{
		//imgResult.close();
		stmt.close();
		m_con.close();	
	}
%>
<form name = "myForm" action="update_profile.jsp" method="post" onsubmit="return validateForm()">
First name: <input type="text" name="firstname" value = "<%=firstname%>"><br>
Last name: <input type="text" name="lastname"value = "<%=lastname%>"><br>
address name: <input type="text" name="address"value = "<%=address%>"><br>
email name: <input type="email" name="email"value = "<%=email%>"><br>
phone name: <input type="number" name="phone"value = "<%=phone%>"><br>
new password <input type="password" name="new password"><br>
<input type="submit" value="Submit">
<input type="button" onclick="formReset()" value="Reset">
</form>
</center> 
</body>
</html>
