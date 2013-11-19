<html><head>
<title>Logout page</title>
</head>
<body bgcolor="#eeeeee" text="#765500">
<center>
<%
	String username = request.getParameter("username");
	session.removeAttribute("loged_in");
	session.invalidate();
%>
<h1>Thank you for using PhotoUploader! Goodbye! <%= username %>!</h1>

<img src="goodbye.jpg">
<br>
<a href="login.html">login</a>
</center></body></html>
