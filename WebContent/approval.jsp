<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <%@ page import="java.util.Date" %>
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
	//Class.forName("com.mysql.jdbc.Driver");
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
	DbConnection db=new DbConnection();
Connection con=db.getConnection(); 
	Statement st2=con.createStatement();
	Statement st1=con.createStatement();
	Date s1=new Date();
    SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
	String uid=(String)session.getAttribute("userid");
	String appBy=request.getParameter("approvalby");
	String remarks=request.getParameter("remarks");
	
	//ResultSet rs2=st2.executeQuery("select noting_id from public.noting_ids");
	int su=1; 
	boolean z;
	
	//session.setAttribute("docid",String.valueOf(s));
	if(appBy!=null){
		int slength=Integer.parseInt(session.getAttribute("slength").toString());
		int vlength=Integer.parseInt(session.getAttribute("vlength").toString());
		try{
			for(int i=0;i<slength;i++)
			{	String s=(String)session.getAttribute("s"+i);
			ResultSet rs=st1.executeQuery("select * from public.documentload where docid='"+s+"'");
			rs.next();
			String Doctype=rs.getString(10);
		   
			/* ResultSet rs5=st1.executeQuery("select * from public.approval where docid='"+s+"'");
			rs.next();	
			
			String x1=rs5.getString("docid");
			System.out.println(x1);  */
  
				st2.executeUpdate("insert into public.approval values('documentload','"+s+"','"+uid+"','"+appBy+"','Yet to','"+Doctype+"','"+remarks+"')");	
			       
			     st2.executeUpdate("insert into public.noting_trans(docid,noting_detail,userid,createdate) values('"+s+"','"+remarks+"','"+uid+"','"+f.format(s1)+"')");
				// st2.executeUpdate("insert into public.noting_ids values('"+su+"')");
			       
			}
			
		 /* for(int i=0;i<vlength;i++)
			{	String s=(String)session.getAttribute("v"+i);
			ResultSet rs=st1.executeQuery("select * from public.documentload where docid='"+s+"'");
			rs.next();
			String Doctype=rs.getString(10);
				st2.executeUpdate("insert into public.approval values('documentshared','"+s+"','"+uid+"','"+appBy+"','Yet to','"+Doctype+"','"+remarks+"')");
				st2.executeUpdate("insert into public.noting_trans values('"+su+"','"+s+"','"+remarks+"','"+uid+"','"+f.format(s1)+"')");
				 st2.executeUpdate("insert into public.noting_ids values('"+su+"')");
			} 
		 */
		         
		
		
%>

<h3 style="color: red">Document is  sent for approval</h3>
		
<%
		}
		catch(Exception e){
	%>
			<h3 style="color: red">Document is already sent for approval</h3>
	<% 	
		}
	}
	%>
</body>
</html>