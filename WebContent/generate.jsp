<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String str=request.getParameter("start");
String end=request.getParameter("end");
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
DbConnection db=new DbConnection();
Connection con=db.getConnection();
Statement st2=con.createStatement();
String type=request.getParameter("report");
if(type.equals("user")){
	ResultSet rs=st2.executeQuery("select * from public.user_master where regon between '"+str+"' and '"+end+"' and status!='deleted'");
%>
	<table align="center" border="2">
		<tr>
			<th>first name</th>
			<th>last name</th>
			<th>userid</th>
			<th>city</th>
			<th>phonenumber</th>
			<th>registered on</th>
		</tr>
<%
	while(rs.next()){
%>
		<tr>
			<td><%=rs.getString("firstname") %></td>
			<td><%=rs.getString("lastname") %></td>
			<td><%=rs.getString("userid") %></td>
			<td><%=rs.getString("city") %></td>
			<td><%=rs.getString("phonenumber") %></td>
			<td><%=rs.getString("regon")%></td>
		</tr>
<%
	}	
%>
	</table>
<%
			
	}	

else{
ResultSet rs=st2.executeQuery("select * from public.documentload where createdon  between '"+str+"' and '"+end+"' and status!='deleted'");
%>
	<table align="center" border="2">
		<tr>
			<th>documentid</th>
			<th>document name</th>
			<th>author</th>
			<th>size</th>
		</tr>
<%
while(rs.next()){
%>
		<tr>
			<td><%=rs.getString("docid") %></td>
			<td><%=rs.getString("docname") %></td>
			<td><%=rs.getString("author") %></td>
			<td><%=rs.getString("size") %></td>
		</tr>

<%} %>	
</table>
<%} %>	
</body>
</html>