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
String s[]=request.getParameterValues("sub");
String ds=request.getParameter("s");
String status=(String)session.getAttribute("status");
	if(ds.equals("delete")){
		for(int i=0;i<s.length;i++){	
			st.executeUpdate("update public.message set "+status+"='deleted' where mid='"+s[i]+"'");
		}
		if(status.equals("recieverstatus")){
%>
			<jsp:forward page="inbox.jsp"></jsp:forward>
<% 		}
		else{
%>
			<jsp:forward page="outbox.jsp"></jsp:forward>
<%			
		}
}
	else{
%>
	<form action="forward">
		<h3 align="center" >forward to
	<select name="user">
	<% 
	String uid=(String)session.getAttribute("userid");
	String userid="",Name="";
    
 Statement st1=con.createStatement();
 ResultSet rs=st1.executeQuery("select user_id,name from public.user_master");
    while(rs.next())
    {
	 userid= rs.getString(1);
	 Name=rs.getString(2); if(Name==null) {Name="";}
	 /* lastName=rs.getString(3); if(lastName==null) {lastName="";} */

	 if(!userid.equals(uid))
	 { 
	 %>
	 <option value=<%=userid%>><%=Name%></option>
<% 

	 }
    }
 %>
	</select>		

		<input type="submit" value="forward"></h3>
	</form>
<%
		session.setAttribute("mlength",String.valueOf(s.length));
		for(int i=0;i<s.length;i++){
			session.setAttribute("m"+i,s[i]);
		}
	}
%>
</body>
</html>