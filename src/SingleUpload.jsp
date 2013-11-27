<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %>

<html>
<head><title>Upload photo</title></head>
<body>
<a href="main.jsp">Back to Main</a>
<%
		String username = (String)session.getAttribute("loged_in");
		if(username == null){%>
			<meta http-equiv="refresh" content="0; url = login.html">
		<%}
	%>
<p>Hi <%=username%> </p>
<%
		String getGroup = "select group_id, group_name from groups where user_name = '" + username +"'";		
		ArrayList<String> group_id = new ArrayList<String>();
		ArrayList<String> group_name = new ArrayList<String>();
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
              rset1 = stmt.executeQuery(getGroup);
	      while (rset1.next()){
			group_id.add(rset1.getString(1));	
			group_name.add(rset1.getString(2));	
	      }

       } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }
	%>
<center><h1>Upload photo</h1></center>
<form action="singleUpload.jsp" method="post" enctype
="multipart/form-data" name="form1" id="form1">

<center>
   <table border="2">
       <tr>
               <td align="right"><b>Place taken:</td>
                   <td ><input type="text" name="place"></td>
           </tr>
           <tr>
               <td align="right"><b>Time taken:</td>
                   <td ><input type="text" name="time" placeholder = "27-AUG-2013"></td>
                           </tr>
           <tr>
               <td align="right"><b>Subject:</td>
                   <td ><input type="text" name="subject"></td>
           </tr>
	   <tr>
               <td align="right"><b>Description:</td>
                   <td ><input type="text" name="description"></td>
           </tr>
       <tr>
               <td align="right"><b>Permitted:</td>
                   <td ><select name="permit">
	<option value= "private" > private </option>
	<option value= "public" > public </option>
    <%	for (int i=0; i<group_name.size(); i++)
	{	%>
		
		<option value= <%=group_name.get(i)%>> <%=group_name.get(i)%></option>
		
	<%
	}

	%>
  </select></td>
           </tr>
                  <tr>
               <td align="right"><b>Photo </td>
               <td>
                       <input name="file" type="file" id="file" multiple="multiple">
                   <td>
           </tr>
                 <tr>
                    <td align="center">
               <input type="submit" name="Submit" value="Submit"/>
                           <input type="reset" name="Reset" value="Reset"/>
                        </td>
                 </tr>
    </table>
        </center>


</form>
</body>
</html>
