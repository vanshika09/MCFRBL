<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
DbConnection db=new DbConnection();
Connection con=db.getConnection();
Statement st=con.createStatement();
String s[]=request.getParameterValues("checkBoxName");
String ds=request.getParameter("s");
String uid=(String)session.getAttribute("userid");
if(ds.equals("delete contact")){
	for(int i=0;i<s.length;i++){	
		st.executeUpdate("delete from public.addressbook where userid='"+uid+"' and contactid='"+s[i]+"'");
	}
%>
	<jsp:forward page="AddressBook"></jsp:forward>
<%	
}
else{session.setAttribute("smlength",String.valueOf(s.length));
	for(int i=0;i<s.length;i++){
		session.setAttribute("sm"+i,s[i]);
	}
%>
	<jsp:forward page="ManyMsg"></jsp:forward>
<%
}
%>
</body>
</html>