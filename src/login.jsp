<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %> 
<html>
<head>Login-Photos Keeper</head>
<body>
	Your info has been received:
	<br><br>
	<%
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		String checkLogin = "select * from users where '" + userName + "' = user_name and password = '" + password + "'";
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
     		String m_driverName = "oracle.jdbc.driver.OracleDriver";

      		String m_userName = "c391g3";
       		String m_password = "C1234567";

      		Connection m_con = null;
      		Statement stmt = null;
      		ResultSet rset1 = null;
      		Boolean flag = false;
	

       try
       {
              Class drvClass = Class.forName(m_driverName);
              DriverManager.registerDriver((Driver)
              drvClass.newInstance());

       } catch(Exception e)
       {
              System.err.print("ClassNotFoundException: ");
              System.err.println(e.getMessage());

       }
	 try
	 {
	      m_con = DriverManager.getConnection(m_url, m_userName,
              m_password);
	      stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
              rset1 = stmt.executeQuery(checkLogin);
	    if (rset1 != null&&rset1.next()){
	    	flag = true;
	    
	    
	    
	      	
	     }
	     
              

       } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
//out.println(ex.getMessage());
       }
       finally{
       		try{
       			rset1.close();
       			stmt.close();
       			m_con.close();
       			}
       		catch(Exception  e){}
       }
       if(flag == true){
       	      session.setAttribute("loged_in",userName);
	      %>
	      <jsp:forward page="login_success.jsp">
	      	<jsp:param name="uname"value="<%=userName%>"/>
	      </jsp:forward>
	      <%
       }
       else{
	     %>
	      <jsp:forward page="login_failure.html"/>
	      <%
	     }
	%>
</body>
</html>
