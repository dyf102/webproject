<html><head>
<title>Logout page</title>
</head>
<body bgcolor="#eeeeee" text="#765500">
<center>
<%
	String username = session.getAttribute("loged_in");
	session.removeAttribute("loged_in");
	session.invalidate();
%>
<h1>Thank you for using PhotoUploader! Goodbye! <%= username %>!</h1>

<img src="goodbye.jpg">
<br>
<a href="login.html">login</a>
</center></body></html>
