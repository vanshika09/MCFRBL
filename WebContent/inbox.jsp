<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>    
    <%@ page import="java.util.*" %>
    <%@ page import="java.text.*" %>
    <%@ page import="dao.*" %>
    <%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

  
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
// Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
DbConnection db=new DbConnection();
Connection con=db.getConnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from public.message where reciever='"+uid+"' and recieverstatus!='deleted' order by at desc ");
boolean z=rs.next();
if(z){
%>	<form action="nextStepMsg" method="post" onsubmit="return msgVal()" name="msgs">
	<h2 align="center">Inbox</h2>
	<table class="table table-striped">
	<thead>
		<tr>
			<th scope="col" >Sender</th>
			<th scope="col">Subject</th>
			<th scope="col">On</th>
		</tr>
  </thead>
  <tbody>	
		<tr>
<%while(z){
	session.setAttribute("status","recieverstatus");
%>
	
			<td><input type="checkbox" name="sub" value="<%=rs.getString("mid")%>"><%=rs.getString("sender") %></td>
			<td><a href="message?msg=<%=rs.getString("message")%>&sub=<%=rs.getString("subject")%>"><%=rs.getString("subject")%></a>
			     <%-- <input type="button" value="<%=rs.getString("subject")%>" onclick="openDialog('<%=rs.getString("message")%>','<%=rs.getString("subject")%>');"/> --%>
			
			</td>
			<td><%=rs.getString("at") %></td>
		</tr>			
<%	z=rs.next();
}
%>
		
			<!-- <input type="submit" value="delete" name="s" >
			<input type="submit" value="forward" name="s" > -->
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