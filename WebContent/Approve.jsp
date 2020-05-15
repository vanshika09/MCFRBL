<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
	<%@ page import="dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
		function vals(){
			ln=document.myform.selec.length;
			if(ln==null)
				if(document.myform.selec.checked)
					return true;
			for(i=0;i<ln;i++)
				if(document.myform.selec[0].checked)
					return true;
			return false;
			
		}
</script>
</head>
<body>


<%
//Class.forName("com.mysql.jdbc.Driver");
DbConnection db=new DbConnection();
Connection con=db.getConnection();

Statement st=con.createStatement();
Statement st2=con.createStatement();
String uid=(String)session.getAttribute("userid");
//System.out.println(uid);
ResultSet rs3;
ResultSet rs=st.executeQuery("select * from public.approval where approvalby='"+uid+"' and status='Yet to'");
boolean z=rs.next();
if(z){
%>

<form action="judge" method="post" onsubmit="return vals()" name="myform">
<table class="table table-striped">
	<thead>
	<tr>
		<th>Document name</th>
		<th>Docid</th>
		<th>Sent by</th>
		<th>Remarks</th>
	</tr>
</thead>	

	<%while(z){ 
			
				rs3=st2.executeQuery("select * from public.documentload where docid='"+rs.getString("docid")+"' ");
				rs3.next();
		%>

	<tbody>

	<tr>

		<td><input type="checkbox" name="selec" value='<%=rs3.getString("docid")%>'> 
		<a href='DownloadFile.jsp?path=C:/dms/<%=rs3.getString("filepath")%>'><%=rs3.getString("docname")%></a>
		</td>
		<td><%=rs3.getString("docid")%></td>
		<td><%=rs.getString("userid") %></td>
        <td><input type="text" id="remarks" name="remarks"></td>
	</tr>
	<%	
		z=rs.next();}
		%>
	<tr>

		<td align="center" colspan="3"><!-- <input type="submit" value="approve" name="approval"> -->
		<button type="submit" value="approve" name="approval" class="btn btn-default btn-sm">
		     <span class="glyphicon glyphicon-ok"></span> Approve
                               </button>
                               
         <button type="submit" value="reject" name="approval" class="btn btn-default btn-sm">
		     <span class="glyphicon glyphicon-remove"></span> Reject
                               </button>                      
                </td>               
		<!-- <input type="submit" value="reject" name="approval"></td> -->
	</tr>
 </tbody>		

</table>
</form>
<%}
else{
%>

<h3 align="center">No documents to approve</h3>

<%	
}
%>
</body>
</html>