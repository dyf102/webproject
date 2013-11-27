<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.lang.System"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
</head>
<a href="main.jsp">Back to Main</a>
<body>
<p><b>Data Analysis Center</b></p>
<%
		String username_session = (String) session.getAttribute("loged_in");
		String username,subject,from,to,frequency;
		
		username = request.getParameter("user");
		subject = request.getParameter("subject");
		from = request.getParameter("from");
		to = request.getParameter("to");
		frequency = request.getParameter("frequency");
		
	
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";

		String m_userName = "c391g3";
		String m_password = "C1234567";

		Connection m_con = null;
		Statement stmt =null ;
		ResultSet rs = null;



		try{
			if(from.length() == 0){
				from = "0/01/1970"
			}
		
		}
		
		/*SQL STATEMENTS*/
		
		
		String clear = "DROP VIEW HELPER";
		
		String view1 = "CREATE VIEW HELPER AS SELECT OWNER_NAME,SUBJECT FROM IMAGES WHERE OWNER_NAME='"+username
		+"' AND SUBJECT= '"+subject+"' AND TIMING <='"+to+"' AND TIMING >= '"+from+"'";
		
		String view2 = "SELECT OWNER_NAME,SUBJECT,COUNT(*) FROM HELPER GROUP BY OWNER_NAME,SUBJECT";
		
		String view3 = "SELECT COUNT(*), SUBJECT FROM IMAGES WHERE OWNER_NAME = '"+username+"' AND TIMING <= '"+to+"' AND TIMING>= '"+from+"' GROUP BY SUBJECT";
		
		String view4 = "SELECT COUNT(*), OWNER_NAME FROM IMAGES WHERE SUBJECT = '"+subject+"' AND TIMING <= '"+to+"' AND TIMING >= '"+from+"' GROUP BY OWNER_NAME";
		
		String view5 = "SELECT COUNT(*), OWNER_NAME FROM IMAGES WHERE SUBJECT = '"+subject+"' AND TIMING <= '"+to+"' AND TIMING >= '"+from+"' GROUP BY OWNER_NAME,SUBJECT";
		
		String view6 = "create view helper as select owner_name,subject,substr(timing,8) as new_date from images where timing <="+"'"+to+"'"+ "and timing >="+ "'"+from+"'";
		
		String view7 = "select owner_name,subject,new_date,count(*) from helper group by owner_name,subject,new_date";
		
		String view8 = "create view helper as select owner_name,to_char(timing,'mm-yyyy') as new_date from images where subject="+"'"+subject+"'" + "and timing <="+"'"+to+"'"+ "and timing >="+"'"+from+"'";
		String view9 = "select owner_name,new_date,count(*) from helper group by owner_name,new_date";
		
		String view10 = "create view helper as select subject,to_char(timing,'mm-yyyy') as new_date from images where owner_name="+"'"+username+"'"+ "and timing <="+"'"+to+"'"+ "and timing >="+"'"+from+"'";
		String view11 = "select subject,new_date,count(*) from helper group by subject,new_date";
		
		String view12 = "create view helper as select to_char(timing,'mm-yyyy') as new_date from images where owner_name="+"'"+username+"'"+"and subject="+"'"+subject+"'"+"and timing <="+"'"+to+"'"+ "and timing >="+"'"+from+"'";
		
		String view13 = "select new_date,count(*) from helper group by new_date";
		
		String view14 = "create view helper as select subject,to_char(timing,'WW-yyyy') as new_date from images where owner_name="+"'"+username+"'"+"and timing <="+"'"+to+"'"+ "and timing >="+"'"+from+"'";
		
		String view15 = "select subject,new_date,count(*) from helper group by subject,new_date";
		
		String view16 = "create view helper as select owner_name,to_char(timing,'WW-yyyy') as new_date from images where subject="+"'"+subject+"'"+"and timing <="+"'"+to+"'"+ "and timing >="+"'"+from+"'";
		String view17 = "select owner_name,new_date,count(*) from helper group by owner_name,new_date";
		
		String view18 = "create view helper as select owner_name,subject,to_char(timing,'WW-yyyy') as new_date from images where timing <="+"'"+to+"'"+ "and timing >="+"'"+from+"'";
		
		String view19 = ("select owner_name,subject,new_date,count(*) from helper group by owner_name,subject,new_date";
		
		/*SQL STATEMENTS*/
		
		
		
		
		
		
		
		
		try {
			Class drvClass = Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
			drvClass.newInstance();

		} catch (Exception e) {
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());

		}
		
		try{
			m_con = DriverManager.getConnection(m_url, m_userName,m_password);
			
			stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
		
			
			
			
		}catch(SQLException e){
		
		
		}		
%>	
</body>
</html>
