<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,java.util.Date,java.text.SimpleDateFormat"%>
    <%@ page import="dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Share</title>
</head>
<body>


<%
try{
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
DbConnection db=new DbConnection();
Connection con=db.getConnection(); 
Statement st1=con.createStatement();	
Statement st2=con.createStatement();
String uid=(String)session.getAttribute("userid");
String sharedto=request.getParameter("share");
String remarks=request.getParameter("remarks");
//ResultSet rs2=st2.executeQuery("select noting_id from public.noting_ids");
int su=1; 
boolean z;

	if(sharedto!=null){
	Date dt=new Date();
	SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd");
	int slength=Integer.parseInt(session.getAttribute("slength").toString());
	int vlength=Integer.parseInt(session.getAttribute("vlength").toString());
	
		for(int i=0;i<slength;i++)
		{	String s=(String)session.getAttribute("s"+i);
			ResultSet rs=st1.executeQuery("select * from public.documentload where docid='"+s+"'");
			rs.next();
			String Doctype=rs.getString(10);
		// System.out.println("breaodud ey e"+Doctype);
			st2.executeUpdate("insert into public.documentshared values('"+s+"','"+sharedto +"','"+uid+"','"+ sdt.format(dt)+"','shared','"+Doctype+"','"+remarks+"')");	
			st2.executeUpdate("insert into public.noting_trans(docid,noting_detail,userid,createdate) values('"+s+"','"+remarks+"','"+uid+"','"+sdt.format(dt)+"')");
			// st2.executeUpdate("insert into public.noting_ids values('"+su+"')");
			
		}
		for(int i=0;i<vlength;i++)
		{	String s=(String)session.getAttribute("v"+i);
			ResultSet rs=st1.executeQuery("select * from public.documentshared where docid='"+s+"' and sharedto='"+uid+"'");
			rs.next();
			String Doctype=rs.getString(10);
			st2.executeUpdate("insert into documentshared values(insert into public.documentshared values('"+s+"','"+sharedto +"','"+uid+"','"+ sdt.format(dt)+"','shared','"+Doctype+"','"+remarks+"')");
			st2.executeUpdate("insert into public.noting_trans values(docid,noting_detail,userid,createdate) ('"+s+"','"+remarks+"','"+uid+"','"+sdt.format(dt)+"')");
		// st2.executeUpdate("insert into public.noting_ids values('"+su+"')");
		}
		  
	
	
%>      
	<h3 align="center" style="color: red">file shared</h3>	<%-- <jsp:forward page="DownloadView.jsp"></jsp:forward> --%>
<%		
	}
	else{
%>
<%-- 	<jsp:forward page="removedoc.jsp"></jsp:forward>
 --%><%	}
	
}
catch(Exception e){
	System.out.println(e);
%>
		<h3 align="center" style="color: red">user does not exists or file already shared to this user</h3>
<%
}
%>
	
</body>
</html>