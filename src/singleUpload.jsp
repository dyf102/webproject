<%@ page import="java.util.*" %>
<%@ page import="java.servlet.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.servlet.http.*"%>
<%@ page import="oracle.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.awt.Image"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.lang.System" %> 

<center><h1>Your  image has been Uploaded</h1></center>
   
<table>
 <%
	String username = (String)session.getAttribute("loged_in");
	if(username == null){
%>
	<meta http-equiv="refresh" content="0; url = login.html">
<%
}
//String username = "hahaha";
	long id = System.currentTimeMillis();
	String place="";
	String time="";
	String subject="";
	String permit="private";
	String description="";

	String name = "c391g3";
	String password = "C1234567";
	String drivername = "oracle.jdbc.driver.OracleDriver";
	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	Boolean defult = false;

 %>

 <%
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 	if (!isMultipart) {
 	} 
	else {
   		FileItemFactory factory = new DiskFileItemFactory();
   		ServletFileUpload upload = new ServletFileUpload(factory);
   		List items = null;
   		try {
   		   items = upload.parseRequest(request);
   		} catch (FileUploadException e) {
   			e.printStackTrace();
   		}
   		Iterator itr = items.iterator();
   		Connection conn = getConnected(drivername,dbstring, name,password);
   		while (itr.hasNext()) 
          	{
   			FileItem item = (FileItem) itr.next();
   			if (item.isFormField())
           		{     
				String name1 = item.getFieldName();
                  		String value = item.getString();
                  		if(value == null){
                  			value = "";
                  		}
                  		if(name1.equals("place"))
                   		{
					place = value;
                           	}
                          	if(name1.equals("time"))
                          	{  
					if(value == null||value.equals("")){
						value ="sysdate";
					}
					time = value;
					defult = true;
                                }
                          	if(name1.equals("subject"))
                          	{  
					subject = value;
                                }
                          	if(name1.equals("permit"))
                          	{	
					permit = value;
                                }
				if(name1.equals("description"))
				{
					description = value;
				}
		                          
                       	} else
           		{
           			id++;
    			try {
  	        		//String itemName = item.getName();
				InputStream instream = item.getInputStream();		
				BufferedImage img = ImageIO.read(instream);
				BufferedImage thumbNail = shrink(img, 2);
				// Connect to the database and create a statement

				String getGroup = "select group_id from groups where group_name = '" + permit + "' and user_name = '" + username + "'" ;
          			
	    			Statement stmt = conn.createStatement();
				ResultSet rset;

				if (permit.equals("private"))
				{
					permit = "2";
				}
				else if (permit.equals("public"))
				{
					permit = "1";
				}
				else 
				{
					rset = stmt.executeQuery(getGroup);
					if (rset.next())
						permit = rset.getString(1);
				}
				out.println("insert into images values (" + id + ", '" + username + "' , " + permit + ", '" + subject + "' , '" + place + "' , '" + time + "', '" + description + "', empty_blob(), empty_blob())");
				if(defult == true){
				stmt.execute("insert into images values (" + id + ", '" + username + "' , " + permit + 
						", '" + subject + "' , '" + place + "' , " + time + ", '" + description + "', empty_blob(), empty_blob())");
				
				}
				else{
				stmt.execute("insert into images values (" + id + ", '" + username + "' , " + permit + 
						", '" + subject + "' , '" + place + "' , '" + time + "', '" + description + "', empty_blob(), empty_blob())");
				}
				String cmd = "SELECT * FROM images WHERE photo_id = " + id + " FOR UPDATE";
				rset = stmt.executeQuery(cmd);
	    			rset.next();
	    			BLOB myblob = ((OracleResultSet)rset).getBLOB(8);
				OutputStream outstream = myblob.getBinaryOutputStream();
	    			ImageIO.write(thumbNail, "png", outstream);

				myblob = ((OracleResultSet)rset).getBLOB(9);
				outstream = myblob.getBinaryOutputStream();
	    			ImageIO.write(img, "jpg", outstream);
				/*
				int size = msetContentTypeyblob.getBufferSize();
	   			byte[] buffer = new byte[size];
	    			int length = -1;
	    			while ((length = instream.read(buffer)) != -1)
					outstream.write(buffer, 0, length);
	    			*/
	    			String insertcounter = "INSERT INTO POPULARITY VALUES("+id+",0)";
				Statement tmp = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				tmp.executeQuery(insertcounter);

rset = stmt.executeQuery("select THUMBNAIL from images where photo_id = " + id);
rset.next();
//Blob aaa = rset.getBlob(9);
Blob bbb = rset.getBlob(1);			
byte[] pict = bbb.getBytes(1,(int)bbb.length());
response.setContentType("image/jpg");
OutputStream o = response.getOutputStream();
%>

<tr>Image</td><td><%o.write(pict);%></tr>
<%o.flush();%>
<tr><p>Image</td><td><%o.write(pict);%></tr>
<%o.flush();
o.close();
	    			instream.close();
	    			outstream.close();
            			stmt.executeUpdate("commit");
   			} catch (Exception e) {
   				out.println(e.getMessage());
   			}
  			 }
  		 }
		
  		 conn.close();
   }
%>

</table>
<meta http-equiv="refresh" content="3; url = CreateGroup.jsp">
<%!
public static Connection getConnected( String drivername,
					    String dbstring,
					    String username, 
					    String password  ) 
	throws Exception {
	Class drvClass = Class.forName(drivername); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	return( DriverManager.getConnection(dbstring,username,password));
    } 

    public static BufferedImage shrink(BufferedImage image, int n) {

        int w = image.getWidth() / n;
        int h = image.getHeight() / n;

        BufferedImage shrunkImage =
            new BufferedImage(w, h, image.getType());

        for (int y=0; y < h; ++y)
            for (int x=0; x < w; ++x)
                shrunkImage.setRGB(x, y, image.getRGB(x*n, y*n));

        return shrunkImage;
    }

   %>
     </td></tr></table></center>
