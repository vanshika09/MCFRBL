<%@ page import="java.util.*" %>
<%@ page import ="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="dao.*" %>
<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
function repl(){
		document.location.replace("AddressBook.jsp");
	}
function valid(){
	var cn=document.ac.contactname.value;
	var cid=document.ac.contactid.value;
	if(cn=="")
		return false;
	else if(cid=="")
		return false;
	else return true;
}
</script>
</head>
<body>
<form action="storecontact" name="ac" onsubmit="return valid()">
<table align="center">
	<tr>
		<td>contact name:</td>
		<td><input type="text" name="contactname"></td>
	</tr>
	<tr>
		<td>contact id:</td>
		<td><select name="contactid">
	<% 
	String uid=(String)session.getAttribute("userid");
	String userid="", name="";
	DbConnection db=new DbConnection();
	Connection con=db.getConnection();
  Statement st=con.createStatement();
  ResultSet rs=st.executeQuery("select user_id ,name from public.user_master");
    while(rs.next())
    {
	 userid= rs.getString(1);
	 name=rs.getString(2); if(name==null) {name="";}
	
	 if(!userid.equals(uid))
	 { 
	 %>
	 <option value=<%=userid%>><%=name%></option>
<% 

	 }
    }
 %>	
		</select></td>
	</tr>
	<tr>
		<td><input type="submit" value="add"></td>
		<td><input type="button" value="cancel" onclick="repl()"></td>
	</tr>
</table> 
</form>
</body>
</html>