<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Search Results</title>
</head>

<body bgcolor="#eeeeee" text="#765500">
<center>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import= "java.util.* "%>
<%@ page import= "java.lang.System.* "%>
<%
        if(request.getParameter("bSearch") != null)
        {
          	//security check
	    	String loged_in = null;
	
	    	loged_in = (String)session.getAttribute( "loged_in" );
	    	if(loged_in == null){
	    	    out.println("<h3>You have not logged in to the PhotoUploader. Please log in.</h3>");
	    	    %><br><a href="login.html">login</a>
	    	    <br>Don't have an account? <a href="login.html">Sign up</a><%
	    	    return;
	    	}
	    	String username = loged_in;
	    	//end of security check
	    	//clear the session
	        //get the keywords-->
	        Boolean keys = true;
        	String[] kwords = (request.getParameter("KEYWORDS")).trim().split(",");
        	if(kwords[0].equals(""))
        		keys = false;
        	//date intervals
        	Boolean dats = true;
	        String[] dates = (request.getParameter("TIMEPER")).trim().split(",");
        	if(dates[0].equals(""))
        		dats = false;
        	//search ordering
        	String ordering = (request.getParameter("ORDERING")).trim();
        	Boolean relevance = false;
        	Boolean mrf = false;
        	Boolean mrl = false;
        	if (ordering.equals("relevance"))
        		relevance = true;
        	else if (ordering.equals("mrf"))
        		mrf = true;
        	else if (ordering.equals("mrl"))
        		mrl = true;
        	
	        //establish the connection to the underlying database-->
	        
	        String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
      		String m_userName = "c391g3";
       		String m_password = "C1234567";
	        
        	Connection conn = null;
	        String driverName = "oracle.jdbc.driver.OracleDriver";	
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
		        conn = DriverManager.getConnection(m_url,m_userName,m_password);
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}	
	        //<--select the images which satisfy the search criterea, and rank according to given algorithm-->
        	Statement stmt = null;
	        ResultSet rset = null;
	        String sql = "";	       	        
	        //if there are keywords
	        if(keys) 
        		sql += "SELECT key0.photo_id, ";
	        //if there are only date intervals
        	else if(dats)
        		sql += "SELECT photo_id, timing FROM images WHERE ";
        	
	        for(int i=0; i<kwords.length && keys; i++){
	        	if(i != kwords.length -1)
	        		sql += "key"+i+".score"+i+ " + ";
	        	else
	        		sql += "key"+i+".score"+i+ " as rank, key0.timing FROM ";
	        }
	        
	        //for each keyword, find the image scores
        	for(int i=0; i<kwords.length && keys; i++){
        		sql += "(SELECT photo_id, 6*SCORE(1)/5 + 3*SCORE(2)/5 + SCORE(3)/5 as score"+i+", timing ";
        		sql += "FROM images ";
        		sql += "WHERE CONTAINS(subject, '"+ kwords[i].trim() +"', 1) > 0 ";
        		sql += 		"OR CONTAINS(place, '"+ kwords[i].trim() +"', 2) > 0 ";
        		if(i != kwords.length -1)
        			sql += 		"OR CONTAINS(description, '"+ kwords[i].trim() +"', 3) > 0) key"+i+", ";
        		else{
        			sql += 		"OR CONTAINS(description, '"+ kwords[i].trim() +"', 3) > 0) key"+i+" ";
        			sql += " WHERE ";
        		}
        	}        	
	        for(int i=0; i<kwords.length-1 && keys; i++){
	        	if(i != kwords.length -2)
	        		sql += "key"+i+".photo_id = key"+(i+1)+".photo_id AND ";
	        	else
	        		sql += "key"+i+".photo_id = key"+(i+1)+".photo_id ";
	        }	        
	        //select from the image scores images that are in the date interval
	        if(dats && keys){
	        	if (kwords.length>1)
	        		sql += "AND ( ";
	        	else
	        		sql += " ";	
	        	for (int i = 0; i < dates.length; i = i + 2){
	        		sql += "( key0.timing >= to_date('"+dates[i].trim()+"', 'DD-MON-YY') ";
	        		sql += "AND key0.timing <= to_date('"+dates[i+1].trim()+"', 'DD-MON-YY') ) ";
	        		if(i+2 < dates.length)
	        			sql += "OR ";
	        		else if (kwords.length>1)
	        			sql += ") ";
	        	}
	        }
	        //if only dates, get the photos in that interval
	        else if (dats){
	        	for (int i = 0; i < dates.length; i = i + 2){
	        		sql += "( timing >= to_date('"+dates[i].trim()+"', 'DD-MON-YY') ";
	        		sql += "AND timing <= to_date('"+dates[i+1].trim()+"', 'DD-MON-YY') ) ";
	        		if(i+2 < dates.length)
	        			sql += "OR ";
	        	}
	        }
	        if(!dats && keys && kwords.length==1){
	        	sql += "1>0 ";
	        }
			//ordering
	        if(relevance && keys) 
	        	sql += "ORDER BY rank";
	        else if(keys && mrf)
	        	sql += "ORDER BY key0.timing DESC";
	        else if(keys && mrl)
	        	sql += "ORDER BY key0.timing";
	        else if(dats && (relevance || mrf))
	        	sql += "ORDER BY timing DESC";	   
	        else if(dats && mrl)
	        	sql += "ORDER BY timing";
	        //out.println(sql+"dasdasdsadsadassda");	
        	
        	try{
	        	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, 
                                            ResultSet.CONCUR_READ_ONLY);
		        rset = stmt.executeQuery(sql);
		        out.println(sql);
        	}
        	catch(Exception ex){
    	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
			Boolean results = false;
			//check permissions on search results
	        String permit = ""; 
	        ResultSet rsetpermit = null;
        	while (rset != null && rset.next()){
		  String photo_id = (rset.getObject(1)).toString();
		  permit = "SELECT photo_id FROM images WHERE photo_id = " + photo_id + " AND " + "(permitted = 1 OR 'admin' ='"+username+"' OR owner_name ='"+username+"' " +"OR ('"+username+"', permitted) IN (SELECT gl.friend_id, gl.group_id "+"FROM group_lists gl)) ";
		  try{
		      stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);			        
		 	rsetpermit = stmt.executeQuery(permit);
	        	}
	        	catch(Exception ex){
			     out.println("<hr>" + ex.getMessage() + "<hr>");
	        	}
		  	    //displays the results user has permission to see
		  	    if (rsetpermit != null && rsetpermit.next()){
		  	 	results = true;
				%>
				<a href="displaySinglePhoto.jsp?photo_id=<%= photo_id %>">
				<img src="displayblob.jsp?photo_id=<%= photo_id %>&username=<%= username %>&type=thumbnail" WIDTH="50" HEIGHT="50"></a>	<%
		  	    }
	    	}
        	conn.close();
        	if(!results){
        		%><h3> Your search did not return any results. </h3>
	    		<h3> <a href="search.jsp?username=<%= username %>">search again</a> </h3>
	    		
</center>
You are logged in as <a href="personal_info.jsp?username=<%= username %>"><%= username %></a>
<br>
<a href="welcome.jsp?username=<%= username %>">Home</a>
</br>
<%
        }
        }
%>
</body>
</html>
