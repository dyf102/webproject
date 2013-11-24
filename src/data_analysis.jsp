<HTML>

<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<META name="GENERATOR" content="IBM WebSphere Studio">
<TITLE>DATA ANALYSIS PAGE</TITLE>
</HEAD>

<BODY bgcolor = "#eeeeee" text = "76550">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<center>
<%
	//security check
	String loged_in = null;
	loged_in = (String)session.getAttribute( "loged_in" );
	
	if(loged_in == null){
	    out.println("<h3>You have not logged in to the PhotoUploader. Please log in.</h3>");
	    %><br><a href="login.html">login</a>
	    <br>Don't have an account? <a href="register.html">Sign up</a><%
	    return;
	}
	String username = loged_in;
	//end of security check
	//clear the session
    session.removeAttribute("loged_in");
	//and renew the session
    session.setAttribute( "loged_in", loged_in );
	
%>
<form method="post" action="data_analysis_result.jsp">
<INPUT TYPE="HIDDEN" NAME="username" value=<%= username %>>
<table align="center" width="0%" height="0%">
<tbody>
<tr>
<th>By user:</th>
<td><input type="text" name="user" value="User Name" onFocus="if (value=='User Name'){value = ''}" onBlur="if(value==''){value='User Name'}"></td>
</tr>
<tr>
<th>By subject:</th>
<td><input type="text" name="subject" value="Image Subject" onFocus="if (value=='Image Subject'){value = ''}" onBlur="if(value==''){value='Image Subject'}"></td>
</tr>
<tr>
<th>By a period of time:</th>
</tr>
<tr>
<td>From  <input type="text" name="from" value="dd/mm/yyyy(i.e. 1/1/2012)" onFocus="if (value=='dd/mm/yyyy(i.e. 1/1/2012)'){value = ''}" onBlur="if(value==''){value='dd/mm/yyyy(i.e. 1/1/2012)'}"></td>
<td>To   <input type="text" name="to" value="dd/mm/yyyy(i.e. 1/1/2012)" onFocus="if (value=='dd/mm/yyyy(i.e. 1/1/2012)'){value = ''}" onBlur="if(value==''){value='dd/mm/yyyy(i.e. 1/1/2012)'}"></td>
</tr>
<tr>
<th>Roll up/Drill down:   </th>
<td><input type="radio" name="display" value="yearly">Yearly
<input type="radio" name="display" value="monthly">Monthly
<input type="radio" name="display" value="weekly">Weekly
<input type="radio" name="display" value="none" checked>None
</td>
</tr>
<tr align="center">
<td colspan="2">
<input name="bSubmit" value="Analyse" type="submit">
          
<input name="Reset" value="Reset" type="reset">
</td>
</tr>
</tbody>
</table>
</form>
</center>
You are logged in as <a href="personal_info.jsp?username=<%= username %>"><%= username %></a>
<br>
<a href="welcome.jsp?username=<%= username %>">Home</a>
<a href="logout.jsp?username=<%= username %>">logout</a>
</BODY>
</HTML>
