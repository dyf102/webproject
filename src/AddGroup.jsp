<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %> 
<html>
<body>
	<br><br>
	<%
		long id = System.currentTimeMillis();    
		String username = (String)session.getAttribute("loged_in");
		String groupName = request.getParameter("AddName");
//String username="hahaha";
		String checkName = "select * from groups where '" + groupName + "' = group_name and user_name = '" + username + "'";
		String addGroup = "insert into groups values(" + id + " , '" + username + "' , '" + groupName + "' , sysdate)";
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
     		String m_driverName = "oracle.jdbc.driver.OracleDriver";

      		String m_userName = "bqi";
       		String m_password = "celiajackjack77";

      		Connection m_con = null;
      		Statement stmt = null;
      		ResultSet rset1 = null;
      		Boolean flag1 = false;
	

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
              rset1 = stmt.executeQuery(checkName);
	    if (rset1.next() || groupName.isEmpty()){
	    	 flag1=true;
	     }
	   else	
	     	rset1 = stmt.executeQuery(addGroup);
      
       } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }
       finally{
       		try{
       			rset1.close();
       			stmt.close();
       			m_con.close();
       			}
       		catch(Exception  e){}
       }
       if(flag1 == true){
	      %>
			<H1><CENTER>Adding Failed</CENTER></H1>
			<H1><CENTER>Group Name already existed</CENTER></H1>
	      		<meta http-equiv="refresh" content="3; url = CreateGroup.jsp">
			
	      <%
       }
       else{
	     %>
			<H1><CENTER>Adding Success</CENTER></H1>
			<H1><CENTER>Group id is <%=id%></CENTER></H1>
			<meta http-equiv="refresh" content="3; url = CreateGroup.jsp">
	      <%
	     }
	%>
</body>
</html>