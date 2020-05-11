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
		function val(){
				var sub=document.ss.sub.value;
				if(sub==""){
					return false;
				}
				return true;
		}
	</script>
</head>
<body>

<form action="pass" name="ss" onsubmit="return val()">
<table align="center">
	<tr>
	<td><b>To:</b><select name="to">
	<% 
	String uid=(String)session.getAttribute("userid");
	String userid="", firstName, lastName, name="";
DbConnection db=new DbConnection();
Connection con=db.getConnection();   
 Statement st=con.createStatement();
 ResultSet rs=st.executeQuery("select user_id, name from public.user_master");
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
	</select>	
		<b>Subject:</b><input type="text" name="sub" size="50" ></td>
	</tr>
	<tr>	
		<td><textarea rows="10" cols="70" name="msg" required></textarea>
		<input type="submit" value="Send"></td>
	</tr>
</table>
</form>

</body>
</html>