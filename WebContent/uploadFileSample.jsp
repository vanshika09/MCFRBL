<%@ page language = "java" contentType = "text/html; charset = ISO-8859-1"
   pageEncoding = "ISO-8859-1"%>
<%@ taglib prefix = "s" uri = "/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
   "http://www.w3.org/TR/html4/loose.dtd">
	<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
 <%@ page import="dao.*" %>
<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript">
	
function validateForm(){

	dns=document.form1.dn.value;
	vers=document.form1.ver.value;
	doctype=document.form1.Doctype.value;
	file=document.form1.uploadfile.value;
	val=true;
	if(dns==""){
		alert("document name required");
		//f1.innerText="document name required";
		val=false;
	}
	else{
		f1.innerText="";
	}
	if(vers== ""){
		alert("version required");
		//f2.innerText="version required";
		val=false ;
	}
	else{
		re=/[0-9]/;
		word=new RegExp(re);
		if(!word.exec(vers)){
			alert("version should be a number");
			//f2.innerText="version should be a number";
			val=false;
		}
		
	
	if(doctype== "5"){
		alert("Select the DocType");
		//f7.innerText="Select the DocType";
		val=false ;
	}
	
	
	if(file==""){
		alert("select a document");
		//f3.innerText="select a document";
		val=false;
	}

	return val;
}

</script>	
</head>
<body >

<%
//Class.forName("com.mysql.jdbc.Driver");
//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
DbConnection db=new DbConnection();
	Connection con=db.getConnection(); 
Statement st2=con.createStatement();
ResultSet rs2=st2.executeQuery("select docid from public.docids");
int s=1; 
boolean z;
if(z=rs2.next()) 
	while(z){
		s=Integer.parseInt(rs2.getString("docid"))+1;
		z=rs2.next();
	}
session.setAttribute("docid",String.valueOf(s));
String user=session.getAttribute("userid").toString();
String doc=session.getAttribute("docid").toString();
%>

<table align="center">
	<tr>
		<td>
			  <form action = "upload" method = "post" enctype = "multipart/form-data" name="form1" onsubmit="return validateForm()">
			  <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center" >
			
			    <tr>
			    	<td><label for="Author">Author:</label></td>
			    	<td><input class="form-control" type="text" name="Author" id="Author" value=<%=user %>  readonly ></td>
			    </tr>
			    <tr>
			    	<td>Document id:</td>
			    	 <td><input class="form-control" type="text" name="docid" id="docid"  value=<%=doc %> readonly></td>
			    </tr>
			    <tr>
			    	<td>Document name</td>
			    	<td><input class="form-control" type="text" name="dn" id="dn"></td>
			    	<td><p id="f1"></p></td>
			    </tr>
			     <tr>
			    	<td>Document Type</td>
			    	<td>
			    	<select id="Doctype" name="Doctype">
			    	      <option value="5">Select:</option>
                         <option value="Circular">Circular</option>
                         <option value="LearningFile">LearningFile</option>
                         <option value="Letter">Letter</option>
                    </select>
                    </td>
			    	<td><p id="f7"></p></td>  
			    </tr>
			     <tr>
			    	<td>Description</td>
			    	<td><textarea name="des" id="des" rows="3" cols="20"></textarea></td>
			      </tr>
			    <tr>
			    	<td>Version:</td>
			    	<td><input class="form-control"  type="text" name="ver" id="ver"  ></td>
			    	<td><p id="f2"></p></td>
			    </tr>
			      <%
			      Date s1=new Date();
			   		SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
			   	  %>
			      <tr>
			    	<td>date:</td>
			    	<td><input class="form-control"  type="text" name="date" value="<%=f.format(s1) %>" readonly></td>
			   	 </tr> 
			   	  <tr>
   	 <td>
   	 	
         <label for = "myFile">Upload your file</label>
         <input type = "file" name = "myFile" />
         <input type = "submit" value = "Upload"/>
         <input type="reset" name="Reset" value="Cancel">
     </td>
 </tr>
			 </table> 
		 </form>
	  </td>
	</tr>
  

</table> 
</body>
</html>

      
   