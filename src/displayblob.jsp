<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import= "java.util.* "%>
<%@ page import= "java.lang.System.* "%>
<% 
//String username = request.getParameter("username");
String photo_id = request.getParameter("photo_id");
String type = request.getParameter("type");
Blob image = null;
Connection con = null;
byte[ ] imgData = null ;
Statement stmt = null;
ResultSet rs = null;
	try {
    		String driverName = "oracle.jdbc.driver.OracleDriver";    
    		Class drvClass = Class.forName(driverName); 	
    		DriverManager.registerDriver((Driver) drvClass.newInstance());
		con = DriverManager.getConnection("jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS","c391g3","C1234567");	
		stmt = con.createStatement();	
		if(type.equals("thumbnail"))
			rs = stmt.executeQuery("select THUMBNAIL from images where photo_id = "+ photo_id);
		else	
			rs = stmt.executeQuery("select photo from images where photo_id = "+ photo_id);	
		if (rs.next()) {
			image = rs.getBlob(1);		
			imgData = image.getBytes(1,(int)image.length());	
		} 
		else {	
			out.println("Display Blob Example");		
			out.println("image not found for given id>");		
			return;	
		}	
		// display the image	
		response.setContentType("image/jpg");	
		OutputStream o = response.getOutputStream();	
		o.write(imgData);			
		o.flush();	
		o.close();
		
	}catch (Exception e) {
		out.println("Unable To Display image");	
		out.println("Image Display Error=" + e.getMessage());	
		}
		finally{
		con.close();
		} 
%> 
