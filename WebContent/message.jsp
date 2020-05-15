<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@ taglib prefix="s" uri="/struts-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>

<style>
.names { 
font-weight: bold; }
</style>

<body>

<%
	String status=(String)session.getAttribute("status");
%>
<br>
<table class="table table-striped">
<thead>
<tr>
	<td ><span class="names">Subject:</span></td><td><%=request.getParameter("sub") %></td>
</tr>
</thead>
<tbody>
<tr>
	<td><span class="names">Description:</span></td>
	<td>
	<%
		out.println(request.getParameter("msg"));
	%>
	</td>
    </tr>
</tbody>
</table>
<%
      if(status.equals("recieverstatus")){
%>
<h3 align="center"><a href="inbox">
 <button type="submit" class="btn btn-default btn-sm">
		     <span class="glyphicon glyphicon-arrow-left"></span> Back
                               </button>          
 </a></h3>
<%}else{ %>

<h3 align="center"><a href="outbox">
 <button type="submit" class="btn btn-default btn-sm">
		     <span class="glyphicon glyphicon-arrow-left"></span> Back
                               </button>          
 </a></h3>
<%} %>
</body>
</html>