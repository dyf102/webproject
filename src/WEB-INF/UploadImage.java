package com.cmp391.uploadimage;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
 * Servlet implementation class UploadImage
 */
@WebServlet("/UploadImage")
public class UploadImage extends HttpServlet {
    public String response_message;
    public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException, IOException {
	//  change the following parameters to connect to the oracle database
	String username = "******";
	String password = "******";
	String drivername = "oracle.jdbc.driver.OracleDriver";
	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	int pic_id;

	try {
	    //Parse the HTTP request to get the image stream
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(2*1024*1024);
		@SuppressWarnings("unchecked")
		List<FileItem> li= (List<FileItem>)upload.parseRequest(request);
	    // Process the uploaded items, assuming only 1 image file uploaded
	    Iterator<FileItem> i = li.iterator();
	    FileItem item = (FileItem) i.next();
	    while (i.hasNext() && item.isFormField()) {
	    	item = (FileItem) i.next();
	    }
	    //Get the image stream
	    String filename = item.getName();
	    String type = item.getContentType();
	    long sizeinbyte= item.getSize();
	    
	    InputStream instream = item.getInputStream();
	    BufferedImage img = ImageIO.read(instream);
	    BufferedImage thumbNail = shrink(img, 10);
	    File outputfile = new File(filename);
	    ImageIO.write(img, "jpg", outputfile);
	    
	    PrintWriter out = response.getWriter();
	    out.println(outputfile.getAbsolutePath());
	    out.println("HI");
        // Connect to the database and create a statement
        //Connection conn = getConnected(drivername,dbstring, username,password);
	    //Statement stmt = conn.createStatement();
	    
	    /*
	     *  First, to generate a unique pic_id using an SQL sequence
	     */
	    //ResultSet rset1 = stmt.executeQuery("SELECT pic_id_sequence.nextval from dual");
	    //rset1.next();
	    pic_id = (int) System.currentTimeMillis();
/*
	    //Insert an empty blob into the table first. Note that you have to 
	    //use the Oracle specific function empty_blob() to create an empty blob
	    stmt.execute("INSERT INTO pictures VALUES("+pic_id+",'test',empty_blob())");
 
	    // to retrieve the lob_locator 
	    // Note that you must use "FOR UPDATE" in the select statement
	    String cmd = "SELECT * FROM pictures WHERE pic_id = "+pic_id+" FOR UPDATE";
	    ResultSet rset = stmt.executeQuery(cmd);
	    rset.next();
	    BLOB myblob = ((OracleResultSet)rset).getBLOB(3);

	    //Write the image to the blob object
	    OutputStream outstream = myblob.getBinaryOutputStream();
	    ImageIO.write(thumbNail, "jpg", outstream);
	    
	    /*
	    int size = myblob.getBufferSize();
	    byte[] buffer = new byte[size];
	    int length = -1;
	    while ((length = instream.read(buffer)) != -1)
		outstream.write(buffer, 0, length);
	    *//*
	    instream.close();
	    outstream.close();

            stmt.executeUpdate("commit");
	    response_message = " Upload OK!  ";
            conn.close();
*/
	} catch( Exception ex ) {
	    //System.out.println( ex.getMessage());
	    response_message = ex.getMessage();
	}

	//Output response to the client
	response.setContentType("text/html");
	PrintWriter out = response.getWriter();
	out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
		    "Transitional//EN\">\n" +
		    "<HTML>\n" +
		    "<HEAD><TITLE>Upload Message</TITLE></HEAD>\n" +
		    "<BODY>\n" +
		    "<H1>" +
		            response_message +
		    "</H1>\n" +
		    "</BODY></HTML>");
    }

    /*
      /*   To connect to the specified database
    */
    private static Connection getConnected( String drivername,
					    String dbstring,
					    String username, 
					    String password  ) 
	throws Exception {
	Class drvClass = Class.forName(drivername); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	return( DriverManager.getConnection(dbstring,username,password));
    } 

    //shrink image by a factor of n, and return the shrinked image
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
}