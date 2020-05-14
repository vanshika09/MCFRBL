<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="dao.*" %>
    <%@ taglib prefix="s" uri="/struts-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	function msgVal(){
		var ss=document.msgs.sub.length;
		if(ss>0)
			for(i=0;i<ss;i++){
				if(document.msgs.sub[i].checked)
				  		return true;
			}
			
		else
			if(document.msgs.sub.checked)
				return true;
	
		return false;
	}
</script>
</head>
<body>

<%
String uid=(String)session.getAttribute("userid");
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
DbConnection db=new DbConnection();
Connection con=db.getConnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from public.message where sender='"+uid+"' and senderstatus!='deleted' order by at desc");
boolean z=rs.next();
if(z){
%>	<form action="nextStepMsg" method="post" onsubmit="return msgVal()" name="msgs">
	<h2 align="center">outbox</h2>
	<table cellspacing="20" align="center">
		<tr>
			<td>sender</td>
			<td>subject</td>
			<td>on</td>
		</tr>
		<tr>
<%while(z){
	session.setAttribute("status","senderstatus");
%>
	
			<td><input type="checkbox" name="sub" value="<%=rs.getString("mid")%>"><%=rs.getString("reciever") %></td>
			<td><s:a href="message.jsp?msg=<%=rs.getString("message")%>&sub=<%=rs.getString("subject")%>"><%=rs.getString("subject")%></s:a></td>
			<td><%=rs.getString("at") %></td>
		</tr>			
<%	z=rs.next();
}
%>
		<tr>
			<td><input type="submit" value="delete" name="s" >
			<input type="submit" value="forward" name="s" >
			</td>
		</tr>
	</table>
	</form>
<%}
else {
%>
	<table align="center">
	<tr><td valign="middle"><h3 align="center">No messages to read</h3></td></tr></table>
<% 
}
%>
</body>
</html>