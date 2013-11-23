<html><head>
<title>Logout page</title>
<meta http-equiv="refresh" content="3; url = login.html">
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %> 
</head>
<center>
<%
	String username = (String)session.getAttribute("loged_in");
	if(username == null)
		username = "Guest";
	session.removeAttribute("loged_in");
	session.invalidate();
%>
<h4><%= username %> Successful Logout,redirect to login !</h4>
<img src="images/goodbye.jpg">
<br>
<a href="login.html">login</a>
</center></body></html>
