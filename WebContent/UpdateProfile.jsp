<%@ page language="java"  import="java.sql.*" %>
<%@ page import="dao.*" %>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Business Website Template - Free CSS Templates</title>
<!-- <meta name="keywords" content="free css templates, business template, HTML CSS" />
<meta name="description" content="Business Template - Free CSS Templates by TemplateMo.com" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" /> -->
</head>
<body>
<
<%try{
	//Class.forName("com.mysql.jdbc.Driver");
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
	DbConnection db=new DbConnection();
Connection con=db.getConnection();
	Statement st=con.createStatement();
	String uid=(String)session.getAttribute("userid");
	String fn=request.getParameter("fn");
	//String ln=request.getParameter("ln");
	String eid=request.getParameter("eid");
	String designation=request.getParameter("city");
	String phone=request.getParameter("phone");
	//String sq=request.getParameter("sq");
	String dept=request.getParameter("ans");
	
	st.executeUpdate("update public.user_master set name='"+fn+"',email='"+eid+"',designation='"+designation+"',phone='"+phone+"',department='"+dept+"' where user_id='"+uid+"'");
%>
      	 <h2 align="center"  style="color:#808080;">Updated successfully</h2>
<%}
catch(Exception e){
 %>
 	<h2 align="center"  style="color:#808080;">Error "404" Not found</h2>
 <% 	
}
%>	
	
       

</body>

</html>