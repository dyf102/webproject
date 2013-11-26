<http>
<head><title>Search </title><%String username = (String)session.getAttribute("loged_in");%></head>
<body>
<center>
<h3>Images Search Engine</h3>
<form method="post" action="search_process.jsp">
<INPUT TYPE="HIDDEN" NAME="username" value=<%= username %>>
<table align="center" width="50%" height="25%">
<tbody>
<tr>
<th>Keywords (separate by comma):</th>
<%
String key = (String)request.getParameter("key");
if (key == null)
key = "";
%>
<td><input name="KEYWORDS" maxlength="80" type="text" value=<%=key%>></td>
</tr>
<tr>
<th>Time Periods:</th>
<td><input name="TIMEPER" maxlength="80" type="text" width = "400" placeholder="01-JAN-2013 to 31-JAN-2013"></td>
</tr>
<tr>
<th>Order by:   </th>
<td>
<input type="radio" name="ORDERING" value="mrf">most-recent-first
<input type="radio" name="ORDERING" value="mrl">most-recent-last
<input type="radio" name="ORDERING" value="relevance" checked>relevance</td>
</tr>
<tr align="center">
<td colspan="2">
<input name="bSearch" value="Search" type="submit">
<input name="Reset" value="Reset" type="reset">
</td>
</tr>
</tbody>
</table>

</form>
</center>
</body>

