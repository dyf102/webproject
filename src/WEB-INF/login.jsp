<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<html>
<head></head>
<body>
	Your info has been received:
	<br><br>
	<%
		String userName = request.getParameter("user");
		String password = request.getParameter("pswd");
		String checkLogin = "select * from users where " + userName + " = user_name and password = " + password;
		//out.print(sName);

		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
     		String m_driverName = "oracle.jdbc.driver.OracleDriver";

      		String m_userName = "bqi";
       		String m_password = "celiajackjack77";

      		Connection m_con;
      		Statement stmt;

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

     /*  try
       {
              m_con = DriverManager.getConnection(m_url, m_userName,
              m_password);

              stmt = m_con.createStatement();
              stmt.executeUpdate(createString);
              stmt.close();
              m_con.close();

       } catch(SQLException ex) {
              System.err.println("SQLException: " +
              ex.getMessage());
       }  */
	 try
       {
	      m_con = DriverManager.getConnection(m_url, m_userName,
              m_password);
	      stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
              ResultSet rset1 = stmt.executeQuery(checkLogin);

	      out.println("hahaha" + "    " + rset1.getString(1));
	     
              stmt.close();

       } catch(SQLException ex) {

              System.err.println("SQLException: " +
              ex.getMessage());

       }
	%>
</body>
</html>
