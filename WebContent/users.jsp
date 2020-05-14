<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="dao.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript">
		function valids1(){
			var len=document.userform.users.length;
			if(len>0)
				for(i=0;i<len;i++){
					if(document.userform.users[i].checked)
					  		return true;
				}
			else
				if(document.userform.users.checked)
					return true;
		
			return false;
		}
	</script>
</head>
<body>

<%
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
DbConnection db=new DbConnection();
Connection con=db.getConnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from public.user_master");
boolean z=rs.next();
if(z){
%><form action="manageUsersinfo" method="get" name="userform"  onsubmit="return valids1()">
	<table align="center" border="1">
		<tr>
			
			<th>Name</th>
			<th>userid</th>
			<th>Designation</th>
			<th>phone number</th>
			<th>Department</th>
		
	
		</tr>
<%
	while(z){
%>
		<tr>
			<td><input type="checkbox" name="users" value="<%=rs.getString("user_id")%>"><%=rs.getString("name")%></td>
			<td><%=rs.getString("user_id") %></td>
			<td><%=rs.getString("designation")%></td>
			<td><%=rs.getString("phone")%></td>
			<td><%= rs.getString("department")%></td>
		</tr>
<%
	z=rs.next();
	}
%>
	<tr>
		<td colspan="5"><input type="submit" value="delete"></td>
	</tr>
	</table></form>
<% 
}
%>
</body>
</html>