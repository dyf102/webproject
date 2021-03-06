<%@page import="org.apache.el.lang.ELSupport"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*" %>
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
		if(username_session == null){%>
			<meta http-equiv="refresh" content="0; url = login.html">
		<%}
		if(!username_session.equals("admin")){%>
			<meta http-equiv="refresh" content="0; url = main.jsp">
		<%}
	
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
		Statement stmt1 =null ;
		Statement stmt2 =null ;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		
		String start_time =null;
		String end_time = null;
		String time = null;
		String from_format = null;
		String to_format = null;
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		DateFormat oldFormat = new SimpleDateFormat("MM/dd/yyyy");
		DateFormat newFormat = new SimpleDateFormat("dd-MMM-yy");
		Calendar calendar = Calendar.getInstance();
		

		try{
			if(from.length() == 0){
				from = "0/01/1970";
			}
			if(to.length() == 0){
				Date now = new Date();
				to = sdf.format(now);
			}
			from_format = newFormat.format(oldFormat.parse(from));
			to_format = newFormat.format(oldFormat.parse(to));
		}catch(ParseException e){	
			out.println(e);	
		}
		
		time = from_format+"~"+to_format;
		/*SQL STATEMENTS*/
		
		
		String clear = "DROP VIEW HELPER";
		
		String V1 = "CREATE VIEW HELPER AS SELECT OWNER_NAME,SUBJECT FROM IMAGES WHERE OWNER_NAME='"+username
		+"' AND SUBJECT= '"+subject+"' AND TIMING <='"+to_format+"' AND TIMING >= '"+from_format+"'";
		
		String P2 = "SELECT OWNER_NAME,SUBJECT,COUNT(*) FROM HELPER GROUP BY OWNER_NAME,SUBJECT";
		
		String P3 = "SELECT COUNT(*), SUBJECT FROM IMAGES WHERE OWNER_NAME = '"+username+"' AND TIMING <= '"+to_format+"' AND TIMING>= '"+from_format+"' GROUP BY SUBJECT";
		
		String P4 = "SELECT COUNT(*), OWNER_NAME FROM IMAGES WHERE SUBJECT = '"+subject+"' AND TIMING <= '"+to_format+"' AND TIMING >= '"+from_format+"' GROUP BY OWNER_NAME";
		
		String P5 = "SELECT COUNT(*), OWNER_NAME,SUBJECT FROM IMAGES WHERE TIMING <= '"+to_format+"' AND TIMING >='"+from_format+"' GROUP BY OWNER_NAME, SUBJECT";
		
		String V6 = "create view helper as select owner_name,subject,substr(timing,8) as new_date from images where timing <="+"'"+to_format+"'"+ "and timing >="+ "'"+from_format+"'";
		
		String P7 = "select owner_name,subject,new_date,count(*) from helper group by owner_name,subject,new_date";
		
		String V8 = "create view helper as select owner_name substr(timing,8) as new_date from images where subject="+"'"+subject+"'" + "and timing <="+"'"+to_format+"'"+ "and timing >="+"'"+from_format+"'";
		String P9 = "select owner_name,new_date,count(*) from helper group by owner_name,new_date";
		
		String V10 = "create view helper as select subject,substr(timing,8) as new_date from images where owner_name="+"'"+username+"'"+ "and timing <="+"'"+to_format+"'"+ "and timing >="+"'"+from_format+"'";
		String P11 = "select subject,new_date,count(*) from helper group by subject,new_date";
		
		String V12 = "create view helper as select substr(timing,8) as new_date from images where subject="+"'"+subject+"'"+"and owner_name="+"'"+username+"'"+"and timing <="+"'"+to_format+"'"+ " AND timing >="+ "'"+from_format+"'";
		
		String P13 = "select new_date,count(*) from helper group by new_date";
		
		String V14 = "create view helper as select owner_name,subject,to_char(timing,'mm-yyyy') as new_date from images where timing <="+"'"+to_format+"'"+ " AND timing >="+"'"+from_format+"'";
		
		String P15 = "select owner_name,subject,new_date,count(*) from helper group by owner_name,subject,new_date";
		
		String V16 = "create view helper as select owner_name,to_char(timing,'mm-yyyy') as new_date from images where subject="+"'"+subject+"'"+"and timing <="+"'"+to_format+"'"+ "and timing >="+"'"+from_format+"'";
		
		String P17 = "select owner_name,new_date,count(*) from helper group by owner_name,new_date";
		
		String V18 = "create view helper as select owner_name,subject,to_char(timing,'mm-yyyy') as new_date from images where owner_name = '"+username+"' and timing <="+"'"+to_format+"'"+ "and timing >="+"'"+from_format+"'";
		
		String P19 = "select subject,new_date,count(*) from helper group by subject,new_date";
		
		String V20 = "create view helper as select to_char(timing,'mm-yyyy') as new_date from images where owner_name ='"+username+"' and subject = '"+subject+"' and timing <="+"'"+to_format+"'"+ " and timing >="+"'"+from_format+"'";
		
		String P21 = "select new_date,count(*) from helper group by new_date";
		
		String V22 = "create view helper as select to_char(timing,'WW-yyyy') as new_date from images where owner_name ='"+username+"' and subject = '"+subject+"' and timing <="+"'"+to_format+"'"+ "and timing >="+"'"+from_format+"'";
		
		String P23 = "select new_date,count(*) from helper group by new_date";
		
		String V24 = "create view helper as select subject,to_char(timing,'WW-yyyy') as new_date from images where  owner_name ='"+username+"' and timing <="+"'"+to_format+"'"+ "and timing >="+"'"+from_format+"'";
		
		String P25 = "select subject,new_date,count(*) from helper group by subject,new_date";
		
		String V26 = "create view helper as select owner_name,to_char(timing,'WW-yyyy') as new_date from images where subject = '"+subject+"' and timing <="+"'"+to_format+"'"+ "and timing >="+"'"+from_format+"'";
		
		String P27 = "select owner_name,new_date,count(*) from helper group by owner_name,new_date";
		
		String V28 = "create view helper as select owner_name,subject,to_char(timing,'WW-yyyy') as new_date from images where timing <="+"'"+to_format+"'"+ "and timing >="+"'"+from_format+"'";
		
		String P29 = "select owner_name,subject,new_date,count(*) from helper group by owner_name,subject,new_date";
		
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
			
			stmt1 = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			stmt2 = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			 /************************START************************/
			if(!username.equals("all") && !subject.equals("all") && frequency.equals("none")){
				stmt1.executeQuery(V1);
				rs2 = stmt2.executeQuery(P2);
				// inital_table_user
				%>
				<table border="1">
				<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
				<tbody>
				<%
				// inital_table_user
			while(rs2.next()){
				out.println("<TR><TD>"+username+"</TD><TD>"+rs2.getString(2)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD></TR>");
			}
				stmt1.executeQuery(clear);
			
			}else if (subject.equals("all") && !username.equals("all") && frequency.equals("none")){
				rs1 = stmt1.executeQuery(P3);
				// inital_table_user
				%>
				<table border="1">
				<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
				<tbody>
				<%
				// inital_table_user
				while(rs1.next()){
					out.println("<TR><TD>"+username+"</TD><TD>"+rs1.getString(2)+"</TD><TD>"+time+"</TD><TD>"+rs1.getString(1)+"</TD></TR>");
				}
				
			}else if(!subject.equals("all") && username.equals("all") && frequency.equals("none")){
				/*P4*/
				rs2 = stmt2.executeQuery(P4);
				// inital_table_SUBJECT
				%>
				<table border="1">
				<thead><tr><th>Subject</th><th>User</th><th>Time</th><th>Picture Upload</th></tr></thead>
				<tbody>
				<%
				// inital_table_SUBJECT
				while(rs2.next()){
					 out.println("<TR><TD>"+subject+"</TD><TD>"+rs2.getString(2)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(1)+"</TD></TR>");
				}
				
			}else if(subject.equals("all") && username.equals("all") && frequency.equals("none")){
				/*P5*/
				rs1 = stmt1.executeQuery(P5);
				// inital_table_user
				%>
				<table border="1">
				<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
				<tbody>
				<%
				// inital_table_user
				while(rs1.next()){
					 out.println("<TR><TD>"+rs1.getString(2)+"</TD><TD>"+rs1.getString(3)+"</TD><TD>"+time+"</TD><TD>"+rs1.getString(1)+"</TD></TR>");
				}	
			}else if (subject.equals("all")&& username.equals("all") && frequency.equals("year")){
				stmt1.executeQuery(V6);
				rs2 = stmt2.executeQuery(P7);
				// inital_table_user
				%>
				<table border="1">
				<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
				<tbody>
				<%
				// inital_table_user
				while(rs2.next()){
					int time_int = Integer.parseInt(rs2.getString(3));
					time = Integer.toString(time_int)+"~"+Integer.toString(time_int + 1);
					out.println("<TR>");
					out.println("<TD>"+rs2.getString(1)+"</TD><TD>"+rs2.getString(2)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(4)+"</TD>");
					out.println("</TR>");
				}
				stmt1.executeQuery(clear);
			}else if(!subject.equals("all")&& username.equals("all") && frequency.equals("year")){
					stmt1.executeQuery(V8);
					rs2 = stmt2.executeQuery(P9);
					int print_flag = 0;
					// inital_table_SUBJECT
					%>
					<table border="1">
					<thead><tr><th>Subject</th><th>User</th><th>Time</th><th>Picture Upload</th></tr></thead>
					<tbody>
					<%
					// inital_table_SUBJECT
					while(rs2.next()){
						int time_int= Integer.parseInt(rs2.getString(2));
						time=Integer.toString(time_int)+"~"+Integer.toString(time_int+1);
						out.println("<TR>");
						
						if(print_flag==0){
							out.println("<TD>"+subject+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
							print_flag=1;
						}else{
							out.println("<TD>"+"    "+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
						}
							out.println("</TR>");
						}
						stmt1.execute(clear);

			}else if(subject.equals("all")&& !username.equals("all") && frequency.equals("year")){
						stmt1.executeQuery(V10);
						rs2 = stmt2.executeQuery(P11);
						int print_flag = 0;
						// inital_table_user
						%>
						<table border="1">
						<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
						<tbody>
						<%
						// inital_table_user
						while(rs2.next()){ 
							int time_int= Integer.parseInt(rs2.getString(2));
							time=Integer.toString(time_int)+"~"+Integer.toString(time_int+1);
				           out.println("<TR>");
				           if(print_flag==0){
								out.println("<TD>"+username+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
								print_flag=1;
				           }else{
								out.println("<TD>"+"    "+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
				               
				           }
							out.println("</TR>");
						}
				          stmt1.execute(clear);
			}else if(!subject.equals("all")&& !username.equals("all") && frequency.equals("year")){
						stmt1.executeQuery(V12);
						rs2 = stmt2.executeQuery(P13);
						int print_flag = 0;
						// inital_table_user
						%>
						<table border="1">
						<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
						<tbody>
						<%
						// inital_table_user
					while(rs2.next()){ 
							int time_int= Integer.parseInt(rs2.getString(1));
				           time=Integer.toString(time_int)+"~"+Integer.toString(time_int+1);
				           out.println("<TR>");
				           if(print_flag==0){
				           out.println("<TD>"+username+"</TD><TD>"+subject+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(2)+"</TD>");
				           print_flag=1;
				           }else{
				           out.println("<TD>"+"    "+"</TD><TD>"+"     "+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(2)+"</TD>");
				               
				           }
				           out.println("</TR>");

					}
					stmt1.execute(clear);
				
			}else if(subject.equals("all")&& username.equals("all") && frequency.equals("month")){
					stmt1.executeQuery(V14);
					rs2 = stmt2.executeQuery(P15);
					// inital_table_user
					%>
					<table border="1">
					<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
					<tbody>
					<%
					// inital_table_user
			          while(rs2.next()){
					String string = rs2.getString(3);
					String[] parts = string.split("-");     
			              String month = parts[0]; 
			              String year = parts[1];         
			              calendar.clear();
			              int ri=1;
			              int yue=Integer.parseInt(month)-1;
			              int nian=Integer.parseInt(year);
			              calendar.set(nian, yue, ri);
			              int maxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
			              start_time = sdf.format(calendar.getTime());
			              ri=maxDay;
			              calendar.set(nian, yue, ri);
			              end_time= sdf.format(calendar.getTime());  
							time=start_time+"~"+end_time;
			           		out.println("<TR>");
			           		out.println("<TD>"+rs2.getString(1)+"</TD><TD>"+rs2.getString(2)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(4)+"</TD>");
			           		out.println("</TR>");
			          }
			          stmt1.execute(clear);		
			}else if(!subject.equals("all")&& username.equals("all") && frequency.equals("month")){
					stmt1.executeQuery(V16);
					rs2 = stmt2.executeQuery(P17);
					// inital_table_user
					%>
					<table border="1">
					<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
					<tbody>
					<%
					// inital_table_user
					while(rs2.next()){ 
						String string = rs2.getString(2);
						String[] parts = string.split("-");     
		             	 String month = parts[0]; 
		              	String year = parts[1];         
		              	calendar.clear();
		              	int ri=1;
		              	int yue=Integer.parseInt(month)-1;
		              	int nian=Integer.parseInt(year);
		              	calendar.set(nian, yue, ri);
		              	int maxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		              	start_time = sdf.format(calendar.getTime());
		              	ri=maxDay;
		              	calendar.set(nian, yue, ri);
		              	end_time= sdf.format(calendar.getTime());  
				          time=start_time+"~"+end_time;
				          
				           out.println("<TR>");
				           out.println("<TD>"+subject+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
				           out.println("</TR>");
				      }
				          stmt1.execute(clear);
			}else if(subject.equals("all")&& !username.equals("all") && frequency.equals("month")){
					stmt1.executeQuery(V18);
					rs2 = stmt2.executeQuery(P19);
					// inital_table_user
					%>
					<table border="1">
					<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
					<tbody>
					<%
					// inital_table_user
					 int print_flag=0;
          			while(rs2.next()){ 
           				String string = rs2.getString(2);
					String[] parts = string.split("-");     
				              String month = parts[0]; 
				              String year = parts[1];         
				              calendar.clear();
				              int ri=1;
				              int yue=Integer.parseInt(month)-1;
				              int nian=Integer.parseInt(year);
				              calendar.set(nian, yue, ri);
				              int maxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
				              start_time = sdf.format(calendar.getTime());
				              ri=maxDay;
				              calendar.set(nian, yue, ri);
				              end_time= sdf.format(calendar.getTime());  
						time=start_time+"~"+end_time;
           				out.println("<TR>");
           			if(print_flag==0){
           				out.println("<TD>"+username+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
          			 }else{
           				out.println("<TD>"+"    "+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
               
           			}
           				out.println("</TR>");
          			}
          				stmt1.execute(clear);
  
			}else if(!subject.equals("all")&& !username.equals("all") && frequency.equals("month")){
					stmt1.executeQuery(V20);
					rs2 = stmt2.executeQuery(P21);
					// inital_table_user
					%>
					<table border="1">
					<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
					<tbody>
					<%
					// inital_table_user
					 int print_flag=0;
					while(rs2.next()){ 
					           String string = rs2.getString(1);
								String[] parts = string.split("-");     
				              String month = parts[0]; 
				              String year = parts[1];         
				              calendar.clear();
				              int ri=1;
				              int yue=Integer.parseInt(month)-1;
				              int nian=Integer.parseInt(year);
				              calendar.set(nian, yue, ri);
				              int maxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
				              start_time = sdf.format(calendar.getTime());
				              ri=maxDay;
				              calendar.set(nian, yue, ri);
				              end_time= sdf.format(calendar.getTime());  
								time=start_time+"~"+end_time;
					           out.println("<TR>");
					           if(print_flag==0){
					           out.println("<TD>"+username+"</TD><TD>"+subject+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(2)+"</TD>");
					           }else{
					           out.println("<TD>"+"    "+"</TD><TD>"+"     "+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(2)+"</TD>");
					               
					           }
					           out.println("</TR>");
					          }
					          stmt1.execute(clear);

			}else if(!subject.equals("all")&& !username.equals("all") && frequency.equals("week")){
					stmt1.executeQuery(V22);
					rs2 = stmt2.executeQuery(P23);
					// inital_table_user
					%>
					<table border="1">
					<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
					<tbody>
					<%
					// inital_table_user
					int print_flag=0;
					 while(rs2.next()){
						 //..
				          String string = rs2.getString(1);    
				          String[] parts = string.split("-");     
				          String week = parts[0]; 
				          String year = parts[1]; 
				          calendar.clear();
				          calendar.set(Calendar.WEEK_OF_YEAR,Integer.parseInt(week));
				          calendar.set(Calendar.YEAR, Integer.parseInt(year));
				          String tou = from_format;
				          String wei = to_format;

				          Date transfer_tou=null;
				          Date transfer_wei=null;

				          try {
				          transfer_tou = newFormat.parse(tou);
				          transfer_wei = newFormat.parse(wei);
				          } catch (Exception ex) {
				          ex.printStackTrace();    
				          }
				          Date start_un = calendar.getTime();
				          if (transfer_tou.compareTo(start_un)>0){
				               start_un=transfer_tou;
				          }
				          start_time = sdf.format(start_un);
				          int currentDay = calendar.get(Calendar.DAY_OF_WEEK);
				          int leftDays= Calendar.SATURDAY - currentDay;
				          
				          if(calendar.getActualMaximum(Calendar.WEEK_OF_YEAR)==53){leftDays=leftDays+7;}
				          calendar.add(Calendar.DATE, leftDays);
				          
				          Date end_un=calendar.getTime();
				         
				          if (transfer_wei.compareTo(end_un)<0){
				               end_un=transfer_wei;
				          }
				          if(calendar.getActualMaximum(Calendar.WEEK_OF_YEAR)==53){
				               calendar.add(Calendar.DATE, -6);
				               start_un=calendar.getTime();
				               if (transfer_tou.compareTo(start_un)>0){
				               start_un=transfer_tou;
				                    }
				                  start_time=sdf.format(start_un);
				               }
				          
				          end_time=sdf.format(end_un);
				          //..
				          time=start_time+"~"+end_time;
				           out.println("<TR>");
				           if(print_flag==0){
				           out.println("<TD>"+username+"</TD><TD>"+subject+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(2)+"</TD>");
				           }else{
				           out.println("<TD>"+"    "+"</TD><TD>"+"     "+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(2)+"</TD>");
				               
				           }
				           out.println("</TR>");
				          }
				          stmt1.execute(clear);
			}else if(subject.equals("all")&& !username.equals("all") && frequency.equals("week")){
							stmt1.executeQuery(V24);
							rs2 = stmt2.executeQuery(P25);
							int print_flag=0;
							// inital_table_user
							%>
							<table border="1">
							<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
							<tbody>
							<%
							// inital_table_user
							 while(rs2.next()){ 
									 //..
						          String string = rs2.getString(2);    
						          String[] parts = string.split("-");     
						          String week = parts[0]; 
						          String year = parts[1]; 
						          calendar.clear();
						          calendar.set(Calendar.WEEK_OF_YEAR,Integer.parseInt(week));
						          calendar.set(Calendar.YEAR, Integer.parseInt(year));
						          String tou = from_format;
						          String wei = to_format;

						          Date transfer_tou=null;
						          Date transfer_wei=null;

						          try {
						          transfer_tou = newFormat.parse(tou);
						          transfer_wei = newFormat.parse(wei);
						          } catch (Exception ex) {
						          ex.printStackTrace();    
						          }
						          Date start_un = calendar.getTime();
						          if (transfer_tou.compareTo(start_un)>0){
						               start_un=transfer_tou;
						          }
						          start_time = sdf.format(start_un);
						          int currentDay = calendar.get(Calendar.DAY_OF_WEEK);
						          int leftDays= Calendar.SATURDAY - currentDay;
						          
						          if(calendar.getActualMaximum(Calendar.WEEK_OF_YEAR)==53){leftDays=leftDays+7;}
						          calendar.add(Calendar.DATE, leftDays);
						          
						          Date end_un=calendar.getTime();
						         
						          if (transfer_wei.compareTo(end_un)<0){
						               end_un=transfer_wei;
						          }
						          if(calendar.getActualMaximum(Calendar.WEEK_OF_YEAR)==53){
						               calendar.add(Calendar.DATE, -6);
						               start_un=calendar.getTime();
						               if (transfer_tou.compareTo(start_un)>0){
						               start_un=transfer_tou;
						                    }
						                  start_time=sdf.format(start_un);
						               }
						          
						          end_time=sdf.format(end_un);
						          //.. 
						          time=start_time+"~"+end_time;
						          
						           out.println("<TR>");
						           if(print_flag==0){
						           out.println("<TD>"+username+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
						           }else{
						           out.println("<TD>"+"    "+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
						               
						           }
						           out.println("</TR>");
						          }
						          stmt1.execute(clear);
						         
				
			}else if(!subject.equals("all")&& username.equals("all") && frequency.equals("week")){
					stmt1.executeQuery(V26);
					rs2 = stmt2.executeQuery(P27);
					int print_flag=0;
					// inital_table_SUBJECT
					%>
					<table border="1">
					<thead><tr><th>Subject</th><th>User</th><th>Time</th><th>Picture Upload</th></tr></thead>
					<tbody>
					<%
					// inital_table_SUBJECT
					while(rs2.next()){ 
						 //..
			          String string = rs2.getString(2);    
			          String[] parts = string.split("-");     
			          String week = parts[0]; 
			          String year = parts[1]; 
			          calendar.clear();
			          calendar.set(Calendar.WEEK_OF_YEAR,Integer.parseInt(week));
			          calendar.set(Calendar.YEAR, Integer.parseInt(year));
			          String tou = from_format;
			          String wei = to_format;

			          Date transfer_tou=null;
			          Date transfer_wei=null;

			          try {
			          transfer_tou = newFormat.parse(tou);
			          transfer_wei = newFormat.parse(wei);
			          } catch (Exception ex) {
			          ex.printStackTrace();    
			          }
			          Date start_un = calendar.getTime();
			          if (transfer_tou.compareTo(start_un)>0){
			               start_un=transfer_tou;
			          }
			          start_time = sdf.format(start_un);
			          int currentDay = calendar.get(Calendar.DAY_OF_WEEK);
			          int leftDays= Calendar.SATURDAY - currentDay;
			          
			          if(calendar.getActualMaximum(Calendar.WEEK_OF_YEAR)==53){leftDays=leftDays+7;}
			          calendar.add(Calendar.DATE, leftDays);
			          
			          Date end_un=calendar.getTime();
			         
			          if (transfer_wei.compareTo(end_un)<0){
			               end_un=transfer_wei;
			          }
			          if(calendar.getActualMaximum(Calendar.WEEK_OF_YEAR)==53){
			               calendar.add(Calendar.DATE, -6);
			               start_un=calendar.getTime();
			               if (transfer_tou.compareTo(start_un)>0){
			               start_un=transfer_tou;
			                    }
			                  start_time=sdf.format(start_un);
			               }
			          
			          end_time=sdf.format(end_un);
			          //.. 
			          time=start_time+"~"+end_time;
			          out.println("<TR>");
			           if(print_flag==0){
			           out.println("<TD>"+subject+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
			           }else{
			           out.println("<TD>"+"    "+"</TD><TD>"+rs2.getString(1)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(3)+"</TD>");
			               
			           }
			           out.println("</TR>");
			          }
			          stmt1.execute(clear);
			}else if(subject.equals("all")&& username.equals("all") && frequency.equals("week")){
						stmt1.executeQuery(V28);
						rs2 = stmt2.executeQuery(P29);
						// inital_table_user
						%>
						<table border="1">
						<thead><tr><th>User</th><th>Subject</th><th>Time</th><th>Picture Upload</th></tr></thead>
						<tbody>
						<%
						// inital_table_user
				          while(rs2.next()){ 
				        	  //..
					          String string = rs2.getString(3);    
					          String[] parts = string.split("-");     
					          String week = parts[0]; 
					          String year = parts[1]; 
					          calendar.clear();
					          calendar.set(Calendar.WEEK_OF_YEAR,Integer.parseInt(week));
					          calendar.set(Calendar.YEAR, Integer.parseInt(year));
					          String tou = from_format;
					          String wei = to_format;

					          Date transfer_tou=null;
					          Date transfer_wei=null;

					          try {
					          transfer_tou = newFormat.parse(tou);
					          transfer_wei = newFormat.parse(wei);
					          } catch (Exception ex) {
					          ex.printStackTrace();    
					          }
					          Date start_un = calendar.getTime();
					          if (transfer_tou.compareTo(start_un)>0){
					               start_un=transfer_tou;
					          }
					          start_time = sdf.format(start_un);
					          int currentDay = calendar.get(Calendar.DAY_OF_WEEK);
					          int leftDays= Calendar.SATURDAY - currentDay;
					          
					          if(calendar.getActualMaximum(Calendar.WEEK_OF_YEAR)==53){leftDays=leftDays+7;}
					          calendar.add(Calendar.DATE, leftDays);
					          
					          Date end_un=calendar.getTime();
					         
					          if (transfer_wei.compareTo(end_un)<0){
					               end_un=transfer_wei;
					          }
					          if(calendar.getActualMaximum(Calendar.WEEK_OF_YEAR)==53){
					               calendar.add(Calendar.DATE, -6);
					               start_un=calendar.getTime();
					               if (transfer_tou.compareTo(start_un)>0){
					               start_un=transfer_tou;
					                    }
					                  start_time=sdf.format(start_un);
					               }
					          
					          end_time=sdf.format(end_un);
					          //.. 
				          time=start_time+"~"+end_time; 
				           out.println("<TR>");
				           out.println("<TD>"+rs2.getString(1)+"</TD><TD>"+rs2.getString(2)+"</TD><TD>"+time+"</TD><TD>"+rs2.getString(4)+"</TD>");
				             out.println("</TR>");
				          }
				          stmt1.execute(clear);

			}
			%>
			</tbody>
			</table>
			<%
			
	        m_con.close();

			
		}catch(SQLException e){
			out.println(e);
		}		
%>	
</body>
</html>
