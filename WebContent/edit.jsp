<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.Date"%>
    <%@ page import="dao.*" %>
<html>
<head>
<script type="text/javascript" src="regvalid.js">
function goBack() {
	  window.history.back();
	}
</script>
</head>
<body>

	<%	//Class.forName("com.mysql.jdbc.Driver");
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
	DbConnection db=new DbConnection();
Connection con=db.getConnection();
	Statement st=con.createStatement();
	String uid=(String)session.getAttribute("userid");
	ResultSet rs=st.executeQuery("select * from public.user_master  where user_id='"+uid+"'");
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
	
	<form action="UpdateProfile"  method="post" onsubmit="return tests()" >
		  <div class="container">
			<table align="center" class="table table-bordered">
				<tr>
					 <th> Name *</th>
					 <td><input type="text" name="fn" maxlength="15"  value="<%=name%>"/></td>
					 <p id="f1"></p>
				</tr>
				<%-- <tr>
				        <td>lastname *</td>
					<td><input type="text" name="ln" maxlength="15" value="<%=ln%>"/></td>
					<td><p id="f2"></p></td>
				</tr> --%>
				<tr>
					<th>userid *</th>
					<td><input type="text" name="uid" maxlength="10" disabled="disabled" value="<%=user%>"/></td>
				        <p id="f3"></p>
				</tr>
				
				<tr>
				        <th> Email*</th>
					<td><input type="text" name="eid" maxlength="20" value="<%=eid%>"/></td>
					<p id="f5"></p>
				</tr>
				<tr>
					<th> Designation *</th>
					<td><input type="text" name="city" maxlength="10" value="<%=desig%>" /></td>
					<p id="f6"></p>
				</tr>
				<tr>
					<th> Contact Info * +</th>
					<td><input type="text" name="phone" maxlength="12" value="<%=phno%>"/></td>
					<p id="f7"></p>
				</tr>
				
				<tr>
					<th>Department</th>
					<td><input type="text" name="ans" value="<%=dept%>"></td>
					<p id="f9"></p>
				</tr>
				<tr>
				        <td align="center" colspan="2" ><!-- <input type="submit" value="update"/> -->
				        <button type="submit" value="update" >update</button>
				 <!-- <input type="submit" id="SUBMIT" value="" name="Back" class="submitBtn" onclick="goBack()"> -->
				 <button type="button" onclick="goBack()" >Cancel</button>
				</tr>
				</table>	
			</div>			
		</form>
	
	</body>
