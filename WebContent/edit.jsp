<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.Date"%>
     <%@ taglib prefix="s" uri="/struts-tags"%> 
    <%@ page import="dao.*" %>
<html>
<head>
<script>

/* function goBack() {
	  window.history.back();
	} */

function tests(){
	var val=true;
	var fn=document.forms[0].fn.value;
	//var ln=document.forms[0].ln.value;
	//var sq=document.forms[0].sq.value;
	var dept=document.forms[0].ans.value;
	//var cepwd=document.forms[0].cepwd.value;
	var eid=document.forms[0].eid.value;
	var desig=document.forms[0].city.value;
	var phnumber=document.forms[0].phone.value;
		
	if(fn==""){
		f1.innerText="first name required";
		val=false;
	}
	else
		f1.innerText="";
	if(ln==""){
		f2.innerText="last name required";
		val=false;
	}
	else
		f2.innerText="";
	/*if(sq==""){
			qu.innerText="security question required";
			val=false;
	}
	else
	 	qu.innerText=" ";*/
	 if(dept==""){
	 		f9.innerText="Department required";
			val=false;
	 }
	 else 
		 f9.innerText=" ";
	
	 
	/*if(uid==""){
		f3.innerText="userid required";
		val=false;
	}
	else{
		re=/^[0-9]/;
		word=new RegExp(re);
		if(word.exec(uid)){
			f3.innerText="userid should not start with a number";
			val=false;
		}
		else
			f3.innerText="";
	}
	if(pwd==""){
		f4.innerText="password required";
		val=false;
	}
	else if(pwd.length<6){
		f4.innerText="password should be minimum of 6 characters";
		val=false;
	}
	else if(pwd!=cepwd){
		f4.innerText="";
		f8.innerText="passwords do not match";
		val=false;
	}
	else
		f4.innerText="";
	*/
	if(eid==""){
		f5.innerText="email required";
		val=false;
	}
	else{
		re=/[A-Za-z0-9]+@+[A-Za-z]+.+[A-Za-z]/
		word=new RegExp(re);
		if(!re.exec(eid)){
			f5.innerText="invalid email";
			val=false;
		}
		else
		f5.innerText="";
	}
	if(desig=="")
	{
		f6.innerText="Designation required";
		val=false;
	}
	else
		f6.innerText="";	
	if(phnumber=="")
	{
		f7.innerText="phone number required";
		val=false;
	}
	else{
		re=/[A-Za-z]/
		word=new RegExp(re);
		
		if(re.exec(phnumber)||phnumber.length <12)
		{
			f7.innerText="invalid phone number";
			val=false;	
		}
		else

		f7.innerText="";
	 }		
	
	return val;
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
				    <!--  <input type="submit" id="SUBMIT" value="Back" name="Back" class="submitBtn" onclick="goBack()"> -->
				 <!-- <button type="button" onclick="goBack()" >Cancel</button> -->
				      <s:a href="profile"><button>Cancel</button></s:a>
				</tr>
				</table>	
			</div>			
		</form>
	
	</body>
