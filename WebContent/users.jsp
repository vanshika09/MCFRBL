<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="dao.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
  <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
  <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css" />
 
  <!-- <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script> -->
 
<script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
  
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
		
		
		$(document).ready(function() {
		    $('#example').DataTable();
		} );
		
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
	<table  id="example" class="table table-striped table-nowrap" style="width:100%">
	<thead>
		<tr>
			
			<th>Name</th>
			<th>userid</th>
			<th>Designation</th>
			<th>phone number</th>
			<th>Department</th>
		
	
		</tr>
	</thead>	
	  <tbody>
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
 </tbody>
	<tr>
		<td align="center" colspan="5"><!-- <input type="submit" value="delete"> -->
		 <button type="submit" value="delete" class="btn btn-default btn-sm">
		 <span class="glyphicon glyphicon-remove"></span> Delete
                               </button></td>
	</tr>
	</table></form>
<% 
}
%>
</body>
</html>