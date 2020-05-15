<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.Date"%>
    <%@ page import="dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
<head>
<script language="javascript" type="text/javascript" src="regvalid.js">
</script>

</head>
<body>

	<%
	//Class.forName("com.mysql.jdbc.Driver");  
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
	DbConnection db=new DbConnection();
    Connection con=db.getConnection();   
	Statement st=con.createStatement();
	String uid=(String)session.getAttribute("userid");
	ResultSet rs=st.executeQuery("select * from public.user_master where user_id='"+uid+"'");
	rs.next();
	String name=rs.getString("name");
	//String ln=rs.getString("lastname");
	String user=rs.getString("user_id");
	String  eid=rs.getString("email");
	String desig=rs.getString("designation");
	String  phno=rs.getString("phone");
	String usertype=rs.getString("user_type");
	String dept=rs.getString("department");
	%>
	
	<form action="edit"  method="post" onsubmit="return tests()" >
	  <div class="container">
			<table align="center" class="table table-bordered">
				<tr>
					 <th> Name *</th>
					 <td><%=name%></td>
					 <p id="f1"></p>
				</tr>
			<tr>
					<th>Userid *</th>
					<td><%=user%></td>
					<p id="f3"></p>
				</tr>
				
				<tr>
				        <th> Email*</th>
					<td><%=eid%></td>
					<p id="f5"></p>
				</tr>
				<tr>
					<th> Designation *</th>
					<td><%=desig%></td>
					<p id="f6"></p>
				</tr>
				<tr>
				        
				    <th> Department*</th>
					<td><%=dept%></td>
					<p id="f9"></p>
				</tr>
				
				<tr>
					<th> Contact Info * +</th>
					<td><%=phno%></td>
					<p id="f7"></p>
				</tr>
				
				<tr>
				        <td align="center" colspan="2" ><!-- <input type="submit" value="edit"/> -->
				         <button type="submit" class="btn btn-default btn-sm">
                          <span class="glyphicon glyphicon-edit"></span> Edit
                               </button>
				</td>
				</tr>
				</table>	
		</div>				
		</form>
	</body>
</html>