<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %>

<HTML>
<HEAD>
<TITLE>Create Group</TITLE>
</HEAD>

<BODY>
<%
		//String username = (String)session.getAttribute("loged_in");
String username ="hahaha";
		String getGroup = "select group_id, group_name from groups where user_name = '" + username +"'";
		String getUser = "select user_name from users where user_name <> '" + username + "'";		
		ArrayList<String> group_id = new ArrayList<String>();
		ArrayList<String> group_name = new ArrayList<String>();
		ArrayList<String> user_name = new ArrayList<String>();
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
     		String m_driverName = "oracle.jdbc.driver.OracleDriver";
		
      		String m_userName = "bqi";
       		String m_password = "celiajackjack77";

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
	      rset1 = stmt.executeQuery(getUser);
	      while (rset1.next()){
			user_name.add(rset1.getString(1));	
	      }
              

       } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }
	%>
<!--This is the login page-->
<H1><CENTER>Create Group</CENTER></H1>

<FORM NAME="LoginForm" ACTION="AddGroup.jsp" METHOD="post" >

<P>Please input your group's name</P>
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>GroupName:</I></B></TD>
<TD><INPUT TYPE="text" NAME="AddName" VALUE="Group Name"><BR></TD>
</TR>
</TABLE>

<INPUT TYPE="submit" NAME="Submit" VALUE="Add">
</FORM>

</p>
<p>
<HR>

<H1><CENTER>Delete Group</CENTER></H1>

<FORM NAME="LoginForm" ACTION="DeleteGroup.jsp" METHOD="post" >

<P>Please input your group's name</P>
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Group Name:</I></B></TD>
<!--<TD><INPUT TYPE="text" NAME="DeleteName" VALUE="Group Name"><BR></TD>-->
<TD><select name="DeleteName">
    <%	for (int i=0; i<group_name.size(); i++)
	{	%>
		
		<option value= <%=group_name.get(i)%>> <%=group_name.get(i)%></option>
		
	<%
	}

	%>
  </select>
</TD>
</TR>
</TABLE>

<INPUT TYPE="submit" NAME="Submit" VALUE="Delete">
</FORM>

</p>
<p>
<HR>

<H1><CENTER>Add Group Member</CENTER></H1>

<FORM NAME="LoginForm" ACTION="AddMember.jsp" METHOD="post" >

<P>Please input your group's name</P>
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Group ID:</I></B></TD>
<TD><INPUT TYPE="text" NAME="GroupName" VALUE="Group Name"><BR></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Friend Name:</I></B></TD>
<TD><INPUT TYPE="text" NAME="FriendName" VALUE="User Name"><BR></TD>
</TR>
</TABLE>

<INPUT TYPE="submit" NAME="Submit" VALUE="Add">
</FORM>

</p>
<p>
<HR>

<P><b>Existing Group ID and Group Name</b></P>
<table border = "5">
<tr>
<td>Group ID</td>
<td>Group Name</td>
</tr>
<%	for (int i=0; i<group_id.size(); i++)
	{	%>
		<tr>
		<td><%=group_id.get(i)%></td>
		<td><%=group_name.get(i)%></td>
		</tr>
	<%
	}

	%>
</table>

<P><b>Existing Users</b></P>
<table border = "5">
<tr>
<td>User Name</td>
</tr>
<%	for (int i=0; i<user_name.size(); i++)
	{	%>
		<tr>
		<td><%=user_name.get(i)%></td>
		</tr>
	<%
	}

	%>
</table>
</BODY>
</HTML>
