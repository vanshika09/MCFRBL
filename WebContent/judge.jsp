<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page language="java"  import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%

DbConnection db=new DbConnection();
Connection con=db.getConnection();
Statement st=con.createStatement();
Statement st1=con.createStatement();
Statement st2=con.createStatement();
Date s1=new Date();
SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
String uid=(String)session.getAttribute("userid");
String s[]=request.getParameterValues("selec");
String app=request.getParameter("approval");
String  remarks=request.getParameter("remarks");
System.out.println("heloi");

/* ResultSet rs2=st2.executeQuery("select noting_id from public.noting_ids");
int su=1; 
boolean z;
if(z=rs2.next()) 
	while(z){
		su=Integer.parseInt(rs2.getString("noting_id"))+1;
		z=rs2.next();
	} */
if(app.equals("approve")){
	for(int i=0;i<s.length;i++){
		ResultSet rs=st1.executeQuery("select * from public.documentload where docid='"+s[i]+"'");
		rs.next();
		String Doctype=rs.getString(10);
		String author=rs.getString(5);      
		
		st.executeUpdate("update public.approval set status='approved' , remarks='"+remarks+"' where approvalby='"+uid+"' and docid='"+s[i]+"'");
		st2.executeUpdate("insert into public.documentshared values('"+s[i]+"','All','"+author+"','"+ f.format(s1)+"','shared','"+Doctype+"','"+remarks+"')");
		st2.executeUpdate("insert into public.noting_trans (docid,noting_detail,userid,createdate)  values('"+s[i]+"','"+remarks+"','"+uid+"','"+f.format(s1)+"')");
		 /* st2.executeUpdate("insert into public.noting_ids values('"+su+"')"); */
		
	}	
}
else{
	for(int i=0;i<s.length;i++){
		st.executeUpdate("update public.approval set status='discarded' ,remarks='"+remarks+"' where approvalby='"+uid+"' and docid='"+s[i]+"' ");
		st2.executeUpdate("insert into public.noting_trans (docid,noting_detail,userid,createdate)  values('"+s[i]+"','"+remarks+"','"+uid+"','"+f.format(s1)+"')");
	}
}
%>
 
<jsp:forward page="Approve"></jsp:forward>
</body>
</html>