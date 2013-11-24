<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<META name="GENERATOR" content="IBM WebSphere Studio">
<title>Your data_analysis Result</title>
<STYLE>
table {
border:1px solid #999999;
border-collapse:collapse;
font-family:arial,sans-serif;
font-size:100%;
}
td,th{
border:1px solid #000;
border-collapse:collapse;
}
tbody td{
background:#eeeeee;
}
tbody th{
text-align:left;
background:#aaaaaa;
}
tfoot td{
text-align:center;
font-weight:bold;
background:#aaaaaa;
}
</STYLE>
</head>

<body bgcolor = "#eeeeee" text = "76550">
<center>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
if(request.getParameter("bSubmit") != null) {
	
  	//security check
  	String loged_in = null;
  	String username = request.getParameter("username");
  	loged_in = (String)session.getAttribute( "loged_in" );
  	if(loged_in == null){
  	    out.println("<h3>You have not logged in to the PhotoUploader. Please log in.</h3>");
  	    %><br><a href="login.html">login</a>
  	    <br>Don't have an account? <a href="register.html">Sign up</a><%
  	    return;
  	}
  	else if(loged_in.equals(username)){
  		//do nothing
  	}
  	else{
  	    out.println("<h3>You do not have permission to view this page.</h3>");
  	    %><br><a href="login.html">login</a>
  	    <br>Don't have an account? <a href="register.html">Sign up</a><%
  	    return;
  	}
  	//end of security check
  	//clear the session
    session.removeAttribute("loged_in");
  	//and renew the session
    session.setAttribute( "loged_in", loged_in );
    
	String user = (request.getParameter("user")).trim();
	String subject = (request.getParameter("subject")).trim();
	String from = (request.getParameter("from")).trim();
	String to = (request.getParameter("to")).trim();
	session.setAttribute("user", user);
	session.setAttribute("subject", subject);
	session.setAttribute("from", from);
	session.setAttribute("to", to);
	session.setAttribute("username", username);
	
  	if(request.getParameter("display").equals("none")) {
  		response.setHeader("Refresh", "0; URL=" +"data_analysis_none.jsp");
  	}
///////////WEEKLYWEEKLY////////////////////////////WEEKLY////////////////////////////WEEKLY////////////////////////////WEEKLY////////////////////////////WEEKLY////////////////////////////WEEKLY/////////////////
  	else if(request.getParameter("display").equals("weekly")) {
  		response.setHeader("Refresh", "0; URL=" +"data_analysis_week.jsp");
  	}
//////////MONTHLYMONTHLY//////////////////////MONTHLY//////////////////////MONTHLY//////////////////////MONTHLY//////////////////////MONTHLY//////////////////////MONTHLY//////////////////////MONTHLY//////////////////////MONTHLY////////////  	
  	else if(request.getParameter("display").equals("monthly")) {
  		response.setHeader("Refresh", "0; URL=" +"data_analysis_month.jsp");
  	}
//////////YEARLY/////////////////////YEARLY/////////////////////YEARLY/////////////////////YEARLY/////////////////////YEARLY/////////////////////YEARLY/////////////////////YEARLY/////////////////////YEARLY/////////////////////YEARLY/////////////////////YEARLY////////////  	
  	else if(request.getParameter("display").equals("yearly")) {
  		response.setHeader("Refresh", "0; URL=" +"data_analysis_year.jsp");
  	}
}
%>

</center>
</body>
</html>
