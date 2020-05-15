<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="dao.*" %>
   
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
	<table class="table table-striped">
	<thead>
		<tr>
			<th>Sender</th>
			<th>Subject</th>
			<th>On</th>
		</tr>
		</thead>
	<tbody>	
		<tr>
<%while(z){
	session.setAttribute("status","senderstatus");
%>
	
			<td><input type="checkbox" name="sub" value="<%=rs.getString("mid")%>"><%=rs.getString("reciever") %></td>
			<td><a href="message?msg=<%=rs.getString("message")%>&sub=<%=rs.getString("subject")%>"><%=rs.getString("subject")%></a></td>
			<td><%=rs.getString("at") %></td>
		</tr>			
<%	z=rs.next();
}
%>
		<tr>
			
			
			<td align="center" colspan="3">
		    <button type="submit" value="delete" name="s" class="btn btn-default btn-sm">
		     <span class="glyphicon glyphicon-remove"></span> Delete
                               </button>
                               
             <button type="submit" value="forward" name="s" class="btn btn-default btn-sm">
		     <span class="glyphicon glyphicon-share"></span> Forward
                               </button>                    
                               
           
			</td>
		</tr>
 </tbody>		
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