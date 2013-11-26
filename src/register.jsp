<html>
<head><title>Register-Photos Keeper</title></head>
<body>
<center>
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %> 
<%!
	String firstname,lastname,username,password,phonenumber,email,address;
%>
	<%
		String name = request.getParameter("fullname");
		String name_split[] = name.split(" ");
		if(name_split.length !=2){
			firstname = name_split[0];
			lastname = "";
		}else{
			firstname = name_split[0];
			lastname = name_split[1];
		}
		username = request.getParameter("username");
		password = request.getParameter("password");
		phonenumber = request.getParameter("phone");
		email = request.getParameter("email");
		address = request.getParameter("address");
		
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
     		String m_driverName = "oracle.jdbc.driver.OracleDriver";
		String checkusername = "SELECT * from USERS WHERE USER_NAME='"+username+"'";
      		String insertvalue = "INSERT INTO USERS VALUES(?,?,sysdate)";
      		String insertperson = "INSERT INTO persons VALUES(?,?,?,?,?,?)";
      		String checkemail = "SELECT * from persons where email ='"+email+"'";
      		String m_userName = "c391g3";
       		String m_password = "C1234567";

      		Connection m_con = null;
      		PreparedStatement p = null;
      		Statement stmt = null;
      		ResultSet rset1 = null;
      		Boolean exist_flag = false;
	

       try
       {
              Class drvClass = Class.forName(m_driverName);
              DriverManager.registerDriver((Driver)
              drvClass.newInstance());

       } catch(Exception e)       {
              System.err.print("ClassNotFoundException: ");
              System.err.println(e.getMessage());

       }
	 try
	 {
	      m_con = DriverManager.getConnection(m_url, m_userName,
              m_password);
              m_con.setAutoCommit(false);
	      stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
              rset1 = stmt.executeQuery(checkusername);
              m_con.commit();
	    if (rset1 != null&&rset1.next()){
	    	exist_flag = true ;
	     }
	     else{
	     	rset1 = stmt.executeQuery(checkemail);
	     	m_con.commit();
	     	if (rset1 != null&&rset1.next()){
	    		exist_flag = true ;
	     	}
	     	else{
	     		p = m_con.prepareStatement(insertvalue);
	     		p.setString(1,username);
	     		p.setString(2,password);
	     		p.executeUpdate();
	     		m_con.commit();
	     		p = m_con.prepareStatement(insertperson);
	     		p.setString(1,username);
	     		p.setString(2,firstname);
	     		p.setString(3,lastname);
	     		p.setString(4,address);
	     		p.setString(5,email);
	     		p.setString(6,phonenumber);
	     		p.executeUpdate();
	     		m_con.commit();
	     		out.println(p);
	     	}
	     }
	}
	catch(Exception e){
		out.println("SQLException: " +e.getMessage());
	}
	finally{
       		try{
       			rset1.close();
       			stmt.close();
       			m_con.close();
       			}
       		catch(Exception  e){}
       }  
       if(exist_flag == false){
       	      session.setAttribute("loged_in",username);
	      %>
	      <p><h1>Register successfully!!</h1></p>
	      <jsp:forward page="login_success.jsp">
	      	<jsp:param name="uname"value="<%=username%>"/>
	      </jsp:forward>
	      <%
       }
       else{
	     %>
	      <jsp:forward page="register_failure.jsp"/>
	      <%
	     }
	%> 
</h2>
</center>
</body>
</html>
