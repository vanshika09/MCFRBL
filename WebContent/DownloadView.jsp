<%@ page language="java"  import="java.sql.*" %>
 <%@ page import="dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <%String contextpath=request.getContextPath(); %>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
  <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
  <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css" />
 
  <!-- <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script> -->
 
<script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
  
  
  
  
 <%--  <link rel="stylesheet" href="<%=contextpath%>/css/bootstrap.min.css"> 
  <script src="<%=contextpath%>/js/bootstrap.min.js"></script>
  <script src="<%=contextpath%>/js/jquery.min.js"></script>--%>
  
<style>

table th,td {
   border: 1px solid black; 
/*  background-color:#1f5c7b;	 */
  color: black;
  font-size:15px;
}

body {font-family: Arial;}

/* Style the tab */
.tab {
  overflow: hidden;

 /*  background-color: #f1f1f1; */
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;


}

</style>
</head>
<body>


<script type="text/javascript">
	
function openDialog(finYear, railway1) {
	var fin=finYear;
	var rly =railway1;
	/* var title="Details for despatch Coach"; */
/* 	 alert(rly); */
	    $("#dialog").load("View.jsp?finYear="+fin)
	    .dialog({
	    	modal: true,
	    	width: 530,
	    	title:"HISTORY",
	    	
	    	buttons: {
	            Cancel: function() {
	              $(this).dialog("close");
	            }
	    }  	
	    
	   });
	    
	    }
	    /* buttons: {
	            Cancel: function() {
	              $(this).dialog("close");
	            }
	    }  
	    });*/
	    

$(document).ready(function() {
    $('#example').DataTable();
} );

$(document).ready(function() {
	    $('#lett').DataTable();
	} );
	$(document).ready(function() {
	    $('#learn').DataTable();
	} );
	
	var btn;
	function openCity(evt, cityName) {
		  var i, tabcontent, tablinks;
		   btn=evt.target.id;
		   //alert(btn);
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(cityName).style.display = "block";
		  evt.currentTarget.className += " active";
		}
	
       function valids1(){
			var len=document.form2.mine.length;
			if(len>0)
				for(i=0;i<len;i++){
					if(document.form2.mine[i].checked){
						//sendRequest();	
						return true;					}
				}
			else
				if(document.form2.mine.checked){
					//sendRequest();
					return true;
				}
			return false;
		}
		function valids2(){
			var len=document.form3.share.length;
			if(len>0)
				for(i=0;i<len;i++){
					if(document.form3.share[i].checked){
						//sendRequest();	
						return true;
					}
				}
			else
				if(document.form3.share.checked){
					//sendRequest();
					return true;
				}
			return false;
		}
	
		
		
		
		
		
		
		
	</script>








 
 <span id="dialog" class="dialogclass" style="z-index:9999;"></span>
 
<div class="tab">

	<table align="center">
	<tr>
	<td><button class="tablinks" id="1" onclick="openCity(event, 'Circular')">Circular</button></td>
   	<td><button class="tablinks" id="2" onclick="openCity(event, 'Letter')">Letter</button></td>
   	<td><button class="tablinks" id="3" onclick="openCity(event, 'LearningFile')">LearningFile</button></td>
  </tr>
</table>
 </div> 
  

	
  
	
	<%
	//Class.forName("com.mysql.jdbc.Driver");
	//Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"dms","root","root");
	DbConnection db=new DbConnection();
	Connection con=db.getConnection(); 
	Statement st1=con.createStatement();
	Statement st2=con.createStatement();
	String uid=(String)session.getAttribute("userid");
	ResultSet rs1=st1.executeQuery("select * from public.documentload where author='"+uid+"' and status='created' and doctype = 'Circular'");
	boolean z1=rs1.next(),z2;
	%>
	<div id="Circular" class="tabcontent">
	
	
		<%
		 	
		if(z1){ %>
		<!-- <h2>Your Documents</h2> -->
		<form  action="removedoc" onsubmit="return valids1()" name="form2">
		<table  id="example" class="table table-striped table-nowrap" style="width:100%">
			<thead>
			<tr>
				<th>Document Name</th>
				<th>Author</th>
				<th>Description</th>
				<th>Document id</th>
				<th>Created on</th>
				<th>Version</th>
				<th>Size in bytes</th>
				<th>Status</th>
			    <th>View History</th>
			</tr>
	      </thead>		
			<%	
			 
			//System.out.println(Doc);
			while(z1){ 
				   
				ResultSet rs2=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs1.getString("docid")+"'");
		
				%>
			<tbody>	
			<tr>
			    
				<td><input type="checkbox" name="mine" value="<%=rs1.getString("docid")%>">
			<a href="DownloadFile.jsp?path=C:/dms/<%=rs1.getString("filepath")%>"><%=rs1.getString("docname")%></a></td> 
				
                <td><%=rs1.getString("author")%></td>
				<td><%=rs1.getString("description")%></td>
				<td><%=rs1.getString("docid")%></td>
				<td><%=rs1.getString("createdon")%></td>
				<td><%=rs1.getString("version")%></td>
				<td><%=rs1.getString("size")%></td>
				
				<td>
					<%if(z2=rs2.next())
						while(z2){
						out.println(rs2.getString("status")+" by"+ rs2.getString("approvalby")); 
						z2=rs2.next();
						}
						else out.print("none");
					%> 
				</td>
			  <td align="center"><%-- <button value="<%=rs1.getString("docid")%>"  onClick="return sendValues(this)" >View</button> --%>
			  
			   <input type="button" value="View" onclick="openDialog('<%=rs1.getString("docid")%>','<%=rs1.getString("version")%>');" />
			  <%--  <button type="button" id="<%=rs1.getString("docid")%>" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal1">View</button> --%>
			  </td>
			  
			
  
  
			</tr>
			
			<% 
			 
			 z1=rs1.next();	
			}
			%>
			<tr>
				<td colspan="10">
					<input type="submit" value="delete" name="s" >
				    &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="share" name="s">
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="approval" name="s">
					
				</td>
			</tr>
		</tbody>
		  
			<%
			}%>
		</table>
	</form>
</div>

  <!-- <!-- modal1
			  
			  <div class="modal fade" id="modal1" role="dialog">
    <div class="modal-dialog">
    
      Modal content
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

 -->








 
  <div id="Letter" class="tabcontent">
	  
	 
	  <%
	  ResultSet rs3=st1.executeQuery("select * from public.documentload where author='"+uid+"' and status='created' and doctype = 'Letter'");
		boolean z3=rs3.next(),z4;
		if(z3){ %>
		<!-- <h2>Your Documents</h2> -->
		<form  action="removedoc" onsubmit="return valids1()" name="form2">
		<table  id="lett" class="display" style="width:100%">
			<thead>	
			<tr>
				<th>Document Name</th>
				<th>Author</th>
				<th>Description</th>
				<th>Document id</th>
				<th>Created on</th>
				<th>Version</th>
				<th>Size in bytes</th>
				<th>Status</th>
			    <th>View History</th>
			</tr>
			</thead>
			<%	
			 
			//System.out.println(Doc);
			while(z3){ 
				   
				ResultSet rs4=st2.executeQuery("select status,sharedto from public.documentshared where docid='"+rs3.getString("docid")+"'");
		
				%>
			<tbody>
			<tr>
				<td><input type="checkbox" name="mine" value="<%=rs3.getString("docid")%>">
			<a href="DownloadFile.jsp?path=C:/dms/<%=rs3.getString("filepath")%>"><%=rs3.getString("docname")%></a></td> 
				
                <td><%=rs3.getString("author")%></td>
				<td><%=rs3.getString("description")%></td>
				<td><%=rs3.getString("docid")%></td>
				<td><%=rs3.getString("createdon")%></td>
				<td><%=rs3.getString("version")%></td>
				<td><%=rs3.getString("size")%></td>
				
				<td>
					<%if(z4=rs4.next())
						while(z4){
						out.println(rs4.getString("status")+" to"+ rs4.getString("sharedto")); 
						z4=rs4.next();
						}
						else out.print("none");
					%> 
				</td>
			  <td align="center"><%-- <input type="submit" value="<%=rs3.getString("docid")%>" "> --%>
			  <input type="button" value="View" onclick="openDialog('<%=rs3.getString("docid")%>','<%=rs3.getString("version")%>');" /></td>
			</tr>
			<% 
			 
			 z3=rs3.next();	
			}
			%>
			<tr>
					<td colspan="10"><input type="submit" value="delete" name="s" >
					 &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="share" name="s">
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Approval" name="s"> -->
					
					</td>
		  </tr>
		 </tbody> 	
					
	<%        
			}%>
		
		</table>
		
		</form>
</div>

  <div id="LearningFile" class="tabcontent">
    
	  <%
	  ResultSet rs5=st1.executeQuery("select * from public.documentload where author='"+uid+"' and status='created' and doctype = 'LearningFile'");
		boolean z5=rs5.next(),z6;
		if(z5){ %>
		<!-- <h2>Your Documents</h2> -->
		<form  action="removedoc" onsubmit="return valids1()" name="form2">
		<table  id="learn" class="display" style="width:100%">
		<thead>
			<tr>
				<th>Document Name</th>
				<th>Author</th>
				<th>Description</th>
				<th>Document id</th>
				<th>Created on</th>
				<th>Version</th>
				<th>Size in bytes</th>
				<th>Status</th>
			    <th>View History</th>
			</tr>
		</thead>	
			<%	
			 
			//System.out.println(Doc);
			while(z5){ 
				   
				ResultSet rs7=st2.executeQuery("select status,approvalby from public.approval where docid='"+rs5.getString("docid")+"'");
		
				%>
		<tbody>
			<tr>
				<td><input type="checkbox" name="mine" value="<%=rs5.getString("docid")%>">
			<a href="DownloadFile.jsp?path=C:/dms/<%=rs5.getString("filepath")%>"><%=rs5.getString("docname")%></a></td> 
				
                <td><%=rs5.getString("author")%></td>
				<td><%=rs5.getString("description")%></td>
				<td><%=rs5.getString("docid")%></td>
				<td><%=rs5.getString("createdon")%></td>
				<td><%=rs5.getString("version")%></td>
				<td><%=rs5.getString("size")%></td>
				
				<td>
					<%if(z6=rs7.next())
						while(z6){
						out.println(rs7.getString("status")+" by"+ rs7.getString("approvalby")); 
						z6=rs7.next();
						}
						else out.print("none");
					%> 
				</td>
			  <td align="center" ><%-- <button  value="<%=rs5.getString("docid")%>">View</button> --%>
			  <input type="button" value="View" onclick="openDialog('<%=rs5.getString("docid")%>','<%=rs5.getString("version")%>');" /></td>
			</tr>
			<% 
			 
			 z5=rs5.next();	
			}
			%>
			<tr>
					<td colspan="10"><input type="submit" value="delete" name="s" >
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Forward" name="s"> -->
					</td>
				</tr>
			</tbody>		    
	<%        
			}%>
		</table>
		
		</form>
  </div> 
  
	
	</body>
</html>