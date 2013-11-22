<%@ page contentType="text/html; charset=gbk" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<%@ page import="java.lang.*"%>

<html><head>
<title>Picture list</title>
</head>
<body bgcolor="#eeeeee" text="#765500">
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
	String photo_id = request.getParameter("photo_id");
	out.println(photo_id);	
	Connection con_d = null;
	Statement stmt = null;
	ResultSet rset = null;
	ResultSet rset_g = null;
	//set to true if the image is owned by the current user
	Boolean owned = false;
	try {
	    String driverName = "oracle.jdbc.driver.OracleDriver";    
	    Class drvClass = Class.forName(driverName); 	
	    DriverManager.registerDriver((Driver) drvClass.newInstance());
	    con_d = DriverManager.getConnection("jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS","c391g3","C1234567");	
		stmt = con_d.createStatement();
		//get image data
		rset = stmt.executeQuery("select permitted, subject, place, timing, description, owner_name from images where photo_id = "+photo_id);
		if (rset.next()){
		    int permitted = (rset.getInt(1));
		    String is_permitted = "permitted";
		    
		    //tests if value is null. if so, display and empty string
		    Object test = rset.getObject(2);
		    String subject = "";
		    if(test != null)
		        subject=test.toString();
		    
		    test = rset.getObject(3);
		    String place = "";
		    if(test != null)
		        place=test.toString();
		    
		    String timing = (rset.getObject(4)).toString();
		    
		    test = rset.getObject(5);
		    String description = "";
		    if(test != null)
		        description=test.toString();
		    
		    String owner = (rset.getObject(6)).toString();
		    rset.close();
			if(owner.equals(username) || username.equals("admin"))
				owned = true;
			%>
			<br><img src="displayblob.jsp?photo_id=<%= photo_id %>&username=<%= username %>"><br>
 			<%
 			out.println("<br>This photo is owned by: "+owner);
 			//if owned, it will present an edit option
 			if(owned){
 			    out.println("<br><a href=\"edit_image_info.jsp?image_info=delete&photo_id="+photo_id+"&username="+username+"\">delete this photo</a>");
 			}
			if (permitted == 1){
			    out.println("<br>Permission of the photo: Public");
			    if (owned)
			    	out.println("<a href=\"edit_image_info.jsp?image_info="+is_permitted+"&info_content="+permitted+
			    						"&photo_id="+photo_id+"&username="+username+"\">edit</a>");
			}
			else if (permitted == 2){
 			    out.println("<br>Permission of the photo: Private");
 			   if (owned)
			    	out.println("<a href=\"edit_image_info.jsp?image_info="+is_permitted+"&info_content="+permitted+
    						"&photo_id="+photo_id+"&username="+username+"\">edit</a>");
			}
			else {
			    rset_g = stmt.executeQuery("select group_name from groups where group_id = "+permitted);
			    if (rset_g!=null && rset_g.next()){
			    	String group_name = (rset_g.getObject(1)).toString();
			    	rset_g.close();
			   	 	out.println("<br>Permission of the photo: Group ("+group_name+" can access)");
	 				if (owned)
				    	out.println("<a href=\"edit_image_info.jsp?image_info="+is_permitted+"&info_content="+permitted+
	    						"&photo_id="+photo_id+"&username="+username+"\">edit</a>");
			    }
			}
			out.println("<br>Subject: "+subject+" ");
		   if (owned)
		    	out.println("<a href=\"edit_image_info.jsp?image_info=subject&info_content="+subject+
  						"&photo_id="+photo_id+"&username="+username+"\">edit</a>");			
			out.println("<br>Location: "+place+" ");
			   if (owned)
			    	out.println("<a href=\"edit_image_info.jsp?image_info=place&info_content="+place+
	  						"&photo_id="+photo_id+"&username="+username+"\">edit</a>");		
			out.println("<br>Time: "+timing+" ");
			   if (owned)
			    	out.println("<a href=\"edit_image_info.jsp?image_info=timing&info_content="+timing+
	  						"&photo_id="+photo_id+"&username="+username+"\">edit</a>");		
			out.println("<br>Description: "+description+" ");
			   if (owned)
			    	out.println("<a href=\"edit_image_info.jsp?image_info=description&info_content="+description+
	  						"&photo_id="+photo_id+"&username="+username+"\">edit</a>");		
			
			//update image_views table
			try{
				String check = "SELECT * FROM image_views WHERE photo_id = "+photo_id+ " AND user_name = '" +username+"'";
				ResultSet rsetcheck = stmt.executeQuery(check);
				if(rsetcheck==null || !rsetcheck.next()){
					String sql = "INSERT INTO image_views VALUES("+photo_id+ ", '" +username+"')";
					con_d.setAutoCommit(false);
					PreparedStatement pstmt = con_d.prepareStatement(sql);
					pstmt.executeUpdate();
					con_d.commit();
				}
			}
			catch (Exception e) {
				out.println("Unable to update image views <br>");	
				out.println(e.getMessage());	
			} 
		}
		con_d.close();
	}
	catch (Exception e) {
		out.println("Unable To get the photo_id");	
		out.println("Image Display Error=" + e.getMessage());	
		return;
	}
	%>  
    <p><a href="welcome.jsp?username=<%= username %>"> Return to the home page </a>
    
	

</center>
</body>
You are logged in as <a href="personal_info.jsp?username=<%= username %>"><%= username %></a>
<br>
<a href="welcome.jsp?username=<%= username %>">Home</a>
<a href="logout.jsp?username=<%= username %>">logout</a>
</html>
