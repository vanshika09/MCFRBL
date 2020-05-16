<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>

<body>
<%
	boolean flag=false;
	DbConnection db=new DbConnection();
	Connection con=db.getConnection(); 
	Statement st=con.createStatement();
	String s[]=request.getParameterValues("docs");
	
	if(s!=null)
		for(int i=0;i<s.length;i++)
		{	
			System.out.println(s[i]);
			st.executeUpdate("update public.documentload set status='deleted' where docid='"+s[i]+"'");
			flag=true;
		}
	if(flag==true){
		%>
		<h3 align="center" "color: red">Document deleted successfully.</h3>
		<% 
	}
%>


</body>
</html>