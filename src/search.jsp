<http>
<head><title>Search </title><%String username = (String)session.getAttribute("loged_in");%></head>
<body>
<center>
<h3>Images Search</h3>
<h3>Search for images</h3>
<form method="post" action="search_process.jsp">
<INPUT TYPE="HIDDEN" NAME="username" value=<%= username %>>
<table align="center" width="0%" height="25%">
<tbody>
<tr>
<th>Keywords (separate by comma):</th>
<td><input name="KEYWORDS" maxlength="50" type="text"></td>
</tr>
<tr>
<th>Time Periods (06-NOV-2012, 09-NOV-2012, ...):</th>
<td><input name="TIMEPER" maxlength="50" type="text"></td>
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

