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
<%@ page import= "java.util.* "%>
<%@ page import= "java.util.Date" %>
<%@ page import= "java.util.Calendar" %>
<%@ page import= "java.text.* "%>
<%@ page import= "java.util.GregorianCalendar"%>
<%@ page import= "java.lang.System.* "%>
<%

	//security check
	String loged_in = null;
	String username = (String)session.getAttribute("username");
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
	session.removeAttribute("username");
	//and renew the session
	session.setAttribute( "loged_in", loged_in );
	

	//establish the connection to the underlying database
	
	File file = new File(request.getSession().getServletContext().getRealPath("/Installation.txt"));

	BufferedReader br = new BufferedReader(new FileReader(file));
	String db_user = (br.readLine()).trim();
	String db_pass = (br.readLine()).trim();
	String host_name = (br.readLine()).trim();
	String port_num = (br.readLine()).trim();
	br.close();
	
    //out.println("<center>");                            
	Connection conn = null;

	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

	try{
	//load and register the driver
	Class drvClass = Class.forName(driverName); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	}
	catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
	}

	try{
	//establish the connection
	conn = DriverManager.getConnection(dbstring,db_user,db_pass);
	conn.setAutoCommit(false);
	}
	catch(Exception ex){

	out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	Statement stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	Statement stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	ResultSet rset1 = null;
	ResultSet rset2 = null;
	ResultSet rset3 = null;
	String user = (String)session.getAttribute("user");
	String subject = (String)session.getAttribute("subject");
	String from = (String)session.getAttribute("from");
	String to = (String)session.getAttribute("to");
	String[] start;
	String[] end;
	String[] current;
	int start_y = -1;
	int end_y = -1;
	int from_i = -1;
	int to_i = -1;
	int diff = 0;
	int i = 0;
	int current_year = 0;
	int start_m = -1;
	int end_m = -1;
	int current_month = 0;
	int start_d = -1;
	int end_d = -1;
	int current_day = 0;
	int dayofweek = -1;
	int daystoweekend = -1;
	int weekfirst_y = 0;
	int weekfirst_m = 0;
	int weekfirst_d = 0;
	int weeklast_y = 0;
	int weeklast_m = 0;
	int weeklast_d = 0;
	Calendar cal1 = null;
	Calendar cal2 = null;
	Calendar cal3 = null;
	Calendar cal4 = null;
   		if(user.equals("User Name")){
      			if(subject.equals("Image Subject")) {
             			if(from.equals("dd/mm/yyyy(i.e. 1/1/2012)") && to.equals("dd/mm/yyyy(i.e. 1/1/2012)")) {
             			////for All Images limitation
             				out.println("USER = ALL; SUBJECT = ALL; NONE<br>");
             				%>
		 					<table align="center" width="300" height="100">
							<tbody>
							<tr>
							<th width="85">User:</th>
							<th width="85">Subject:</th>
							<th width="85">No. of Pics:</th>
							</tr>
							<%
             				rset1 = stmt1.executeQuery("select count(*),owner_name,subject from images GROUP BY owner_name, subject ORDER BY owner_name");
            	  			while(rset1.next() && rset1 != null && rset1.getInt(1) != 0) {
            	  				%>
								<tr>						
								<td width="60"><%=rset1.getString(2)%></td>	
								<td width="60"><%=rset1.getString(3)%></td>							
								<td width="60"><%=rset1.getInt(1)%></td>
								</tr>
								</tbody>
		     					<%	
	           	 			}
            	  			%>
            	  			</table>
            	  			<%
             			}
             				else {
               					////for time limitation only
            	 				out.println("USER = ALL; SUBJECT = ALL; TIME = "+from+"~"+to+"; NONE<br>");
		            	 		%>
			 					<table align="center" width="300" height="100">
								<tbody>
								<tr>
								<th width="85">Time:</th>
								<th width="85">User:</th>
								<th width="85">Subject:</th>
								<th width="85">No. of Pics:</th>
								</tr>
								<%
		            	 		rset1 = stmt1.executeQuery("select count(*),owner_name,subject from images where timing >= to_date('"+from+"','dd-mm-yy') and timing <= to_date('"+to+"','dd-mm-yy') GROUP BY owner_name, subject ORDER BY owner_name");
		            	 		while(rset1.next() && rset1 != null && rset1.getInt(1) != 0) {
		            	 			%>
									<tr>
									<td width="60"><%=from%> ~ <%=to %></td>						
									<td width="60"><%=rset1.getString(2)%></td>
									<td width="60"><%=rset1.getString(3)%></td>							
									<td width="60"><%=rset1.getInt(1)%></td>
									</tr>
									</tbody>
				     				<%	
								}
		            	 		%>
	            	  			</table>
	            	  			<%
			           	 	}
             	}
	      		else {
	             		if (from.equals("dd/mm/yyyy(i.e. 1/1/2012)") && to.equals("dd/mm/yyyy(i.e. 1/1/2012)")) {
	               			////for subject limitation only
	            	  		out.println("USER = ALL; SUBJECT = "+subject+"; NONE<br>");
	            	  		%>
		 					<table align="center" width="300" height="100">
							<tbody>
							<tr>
							<th width="85">Subject:</th>
							<th width="85">User:</th>
							<th width="85">No. of Pics:</th>
							</tr>
							<%
	            	  		rset1 = stmt1.executeQuery("select count(*),owner_name from images where subject='"+subject+"' GROUP BY owner_name ORDER BY owner_name");
	            	  		while(rset1.next() && rset1 != null && rset1.getInt(1) != 0) {
	            	  			%>
								<tr>						
								<td width="60"><%=subject%></td>	
								<td width="60"><%=rset1.getString(2)%></td>							
								<td width="60"><%=rset1.getInt(1)%></td>
								</tr>
								</tbody>
		     					<%	
		           	 		}
	            	  		%>
            	  			</table>
            	  			<%
	             		}
	             		else {
	               			////for subject and time limitation
	            	  		out.println("USER = ALL; SUBJECT = "+subject+"; TIME = "+from+"~"+to+"; NONE<br>");
	            	  		%>
		 					<table align="center" width="300" height="100">
							<tbody>
							<tr>
							<th width="85">Time:</th>
							<th width="85">Subject:</th>
							<th width="85">User:</th>
							<th width="85">No. of Pics:</th>
							</tr>
							<%
	            	  		rset1 = stmt1.executeQuery("select count(*), owner_name from images where subject='"+subject+"' and timing >= to_date('"+from+"','dd-mm-yy') and timing <= to_date('"+to+"','dd-mm-yy') GROUP BY owner_name");
	            	  		while(rset1.next() && rset1 != null && rset1.getInt(1) != 0) {
	            	  			%>
								<tr>
								<td width="60"><%=from%> ~ <%=to %></td>						
								<td width="60"><%=subject%></td>	
								<td width="60"><%=rset1.getString(2)%></td>							
								<td width="60"><%=rset1.getInt(1)%></td>
								</tr>
								</tbody>
		     					<%	
		           	 		}
	            	  		%>
            	  			</table>
            	  			<%
	             		}
	      		}
   		}
   		else {
	      		if(subject.equals("Image Subject")) {
	             		if(from.equals("dd/mm/yyyy(i.e. 1/1/2012)") && to.equals("dd/mm/yyyy(i.e. 1/1/2012)")) {
	               			////for user limitation only
		           	 		out.println("USER = "+user+"; SUBJECT = ALL; NONE<br>");
			           	 	%>
		 					<table align="center" width="300" height="100">
							<tbody>
							<tr>
							<th width="85">User:</th>
							<th width="85">Subject:</th>
							<th width="85">No. of Pics:</th>
							</tr>
							<%
		           	 		rset1 = stmt1.executeQuery("select count(*),subject from images where owner_name='"+user+"' GROUP BY subject");
		           	 		while(rset1.next() && rset1 != null && rset1.getInt(1) != 0) {
			           	 		%>
								<tr>
								<td width="60"><%=user%></td>						
								<td width="60"><%=rset1.getString(2)%></td>	
								<td width="60"><%=rset1.getInt(1)%></td>
								</tr>
								</tbody>
		     					<%	 
		           	 		}
			           	 	%>
	        	  			</table>
	        	  			<%
	              		}
	              		else {
	              			////for user and time limitation
	   		      			out.println("USER = "+user+"; SUBJECT = ALL; TIME = "+from+"~"+to+"; NONE<br>");
		          			rset1 = stmt1.executeQuery("select count(*), subject from images where owner_name='"+user+"' and timing >= to_date('"+from+"','dd-mm-yy') and timing <= to_date('"+to+"','dd-mm-yy') GROUP BY subject");
		          			%>
	     					<table align="center" width="300" height="100">
							<tbody>
							<tr>
							<th width="85">User:</th>
							<th width="85">Time:</th>
							<th width="85">Subject:</th>
							<th width="85">No. of Pics:</th>
							</tr>
							<%
		          			while(rset1.next() && rset1 != null && rset1.getInt(1) != 0) {
		          				 %>
								<tr>
								<td width="60"><%=user%></td>						
								<td width="60"><%=from%> ~ <%=to%></td>	
								<td width="60"><%=rset1.getString(2)%></td>							
								<td width="60"><%=rset1.getInt(1)%></td>
								</tr>
								</tbody>
		     					<%	           	 		
		     				}
							%>
            	  			</table>
            	  			<%
	              		}
	       		}
	       		else {
	             		if(from.equals("dd/mm/yyyy(i.e. 1/1/2012)") && to.equals("dd/mm/yyyy(i.e. 1/1/2012)")) {
	              			////for user and subject limitation
	  		      	 		out.println("USER = "+user+"; SUBJECT = "+subject+"; NONE<br>");
	  		      	 		%>
	  		      	 		<table align="center" width="300" height="100">
							<tbody>
							<tr>
							<th width="85">User:</th>
							<th width="85">Subject:</th>
							<th width="85">No. of Pics:</th>
							</tr>
							<%
	  		      	 		rset1 = stmt1.executeQuery("select count(*) from images where owner_name='"+user+"' and subject='"+subject+"'");
		          			while(rset1.next() && rset1 != null && rset1.getInt(1) != 0) {
		          				%>
								<tr>
								<td width="60"><%=user%></td>
								<td width="60"><%=subject%></td>							
								<td width="60"><%=rset1.getInt(1)%></td>
								</tr>
								</tbody>
		     					<%
		           	 		}
		          			%>
            	  			</table>
            	  			<%
	              		}
	              		else {
	              			////for all 3 conditions limitation
	          				out.println("USER = "+user+"; SUBJECT = "+subject+"; TIME = "+from+"~"+to+"; NONE<br>");
	          				rset1 = stmt1.executeQuery("select count(*) from images where owner_name='"+user+"' and subject='"+subject+"' and timing >= to_date('"+from+"','dd-mm-yy') and timing <= to_date('"+to+"','dd-mm-yy')");
	          				%>
	          				<table align="center" width="300" height="100">
							<tbody>
							<tr>
							<th width="85">User:</th>
							<th width="85">Subject:</th>
							<th width="85">Time:</th>
							<th width="85">No. of Pics:</th>
							</tr>
							<%
	          				while(rset1.next() && rset1 != null && rset1.getInt(1) != 0) {
		     					%>
								<tr>
								<td width="60"><%=user%></td>
								<td width="60"><%=subject%></td>							
								<td width="60"><%=from%> ~ <%=to%></td>							
								<td width="60"><%=rset1.getInt(1)%></td>
								</tr>
								</tbody>
		     					<%
		           	 		}
							%>
            	  			</table>
            	  			<%
	              		}
	
	      		}  
   		}
		stmt1.close();
		stmt2.close();
		stmt3.close();
		conn.close();
%>

<strong><h1><a style="color:#A9A9A9; text-decoration:none;" href="data_analysis.jsp?username=<%= username %>">BACK TO DATA ANALYSIS PAGE</a></h1></strong>
</center>
You are logged in as <a href="personal_info.jsp?username=<%= username %>"><%= username %></a>
<br>
<a href="welcome.jsp?username=<%= username %>">Home</a>
<a href="logout.jsp?username=<%= username %>">logout</a>
</body>
</html>