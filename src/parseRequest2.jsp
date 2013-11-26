<%@ page language="java" import="java.io.*, java.sql.*, java.util.*,java.nio.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%
  //Initialization for chunk management.
 for(Part p:request.getPart("file"){
  	out.println(p.getName());
 }
%>
