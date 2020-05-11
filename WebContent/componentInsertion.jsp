<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="dao.*" %>
<%@ page import="model.User" %>

<%@ page import="java.util.Map" %>
<%@ page import="org.apache.struts2.dispatcher.SessionMap" %>
<%@ page import="com.opensymphony.xwork2.ActionSupport" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="org.apache.struts2.dispatcher.SessionMap" %>
<%@ page import="org.apache.struts2.interceptor.SessionAware" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bogie Component insert</title>
</head>
<body>
<%

String username= null;

HttpSession session_http = ServletActionContext.getRequest().getSession(true);
username = (String) session_http.getAttribute("userid");

DbConnection db=new DbConnection();
Connection con=db.getConnection(); 
try
{
String componentSubType=request.getParameter("component_sub_type");
Integer componentId= Integer.parseInt(request.getParameter("component_id")) ;
Integer assetId= Integer.parseInt(request.getParameter("assetId"));   //
String inputValue=request.getParameter("qty");	
String column_name =(String)request.getParameter("FIELD");
Statement st_qty, st_row, st_insert, st_update, st_delete;
ResultSet rs_qty, rs_row;
String sql_qty, sql_bogieset_tran,sql_insert, sql_update, sql_delete, sql_row;
st_qty= con.createStatement();
st_insert= con.createStatement();
st_update=con.createStatement();
st_delete=con.createStatement();
Statement st_update_bogieset=con.createStatement();
 sql_row= "select * from public.component_transaction where component_id="+componentId+" and asset_id="+assetId+" and component_sub_type='"+componentSubType+"' " ;

rs_row=st_qty.executeQuery(sql_row);

if(rs_row.next())
{
	
	if(inputValue.isEmpty())
	{
		sql_delete=	"delete from public.component_transaction where component_id="+componentId+" and asset_id="+assetId+" and component_sub_type='"+componentSubType+"' " ;
		int i=st_delete.executeUpdate(sql_delete);
		if(i>0)
	    {
	        out.println("<b>Delete Successsfully</b>");
	       
	    }
	    else
	    {
	        out.println("Error While Deleting<br>");
	       
	    }
		
		
	}
	else {
	
		sql_update="update public.component_transaction set "+column_name+"= '"+inputValue+"', entry_by='"+username+"' , system_entry_time= now() where component_id="+componentId+" and asset_id="+assetId+" and component_sub_type='"+componentSubType+"' " ;		
		if(componentId==21 && componentSubType.equals("LDS") && column_name.equals("asset_number"))	
		{
		 sql_bogieset_tran="update public.bogieset_trans set sec_air_spring_no1 ='"+inputValue+"' where bogie_asset_id="+assetId+" ";
		}
		else if(componentId==21 && componentSubType.equals("NLDS") && column_name.equals("asset_number"))
		{
			 sql_bogieset_tran="update public.bogieset_trans set sec_air_spring_no2 ='"+inputValue+"' where bogie_asset_id="+assetId+" ";	
		}
		else if(componentId==21 && componentSubType.equals("LDS") && column_name.equals("make"))
		{
			 sql_bogieset_tran="update public.bogieset_trans set sec_air_spring_make1 ='"+inputValue+"' where bogie_asset_id="+assetId+" ";	
		}
		else if(componentId==21 && componentSubType.equals("NLDS") && column_name.equals("make"))
		{
		 sql_bogieset_tran="update public.bogieset_trans set sec_air_spring_make2 ='"+inputValue+"' where bogie_asset_id="+assetId+" ";	
		}
		else
		{
		 sql_bogieset_tran=null;
		}
		System.out.println("componentId="+componentId+ "and componentSubType" +componentSubType+ "and column_name: ="+column_name+ "and Query: "+sql_bogieset_tran);
	System.out.println(sql_update);
	int i=st_update.executeUpdate(sql_update);
	if(sql_bogieset_tran!=null){ int j=st_update_bogieset.executeUpdate(sql_bogieset_tran);}
    if(i>0)
    {
        out.println("<b>Updated Successsfully</b>");
       
    }
    else
    {
        out.println("Error While Updating<br>");
       
    }
	}
}
else
{
sql_insert="insert into public.component_transaction (component_id, asset_id, component_sub_type, "+column_name+", entry_by, system_entry_time) values("+componentId+" , "+assetId+", '"+componentSubType+"' ,'"+inputValue+"',  '"+username+"', now() )" ;	
if(componentId==21 && componentSubType.equals("LDS") && column_name.equals("asset_number"))	
{
 sql_bogieset_tran="update public.bogieset_trans set sec_air_spring_no1 ='"+inputValue+"' where bogie_asset_id="+assetId+" ";
}
else if(componentId==21 && componentSubType.equals("NLDS") && column_name.equals("asset_number"))
{
	 sql_bogieset_tran="update public.bogieset_trans set sec_air_spring_no2 ='"+inputValue+"' where bogie_asset_id="+assetId+" ";	
}
else if(componentId==21 && componentSubType.equals("LDS") && column_name.equals("make"))
{
	 sql_bogieset_tran="update public.bogieset_trans set sec_air_spring_make1 ='"+inputValue+"' where bogie_asset_id="+assetId+" ";	
}
else if(componentId==21 && componentSubType.equals("NLDS") && column_name.equals("make"))
{
 sql_bogieset_tran="update public.bogieset_trans set sec_air_spring_make2 ='"+inputValue+"' where bogie_asset_id="+assetId+" ";	
}
else
{
 sql_bogieset_tran=null;
}
System.out.println("componentId="+componentId+ "and componentSubType" +componentSubType+ "and column_name: ="+column_name+ "and Query: "+sql_bogieset_tran);
	System.out.println(sql_insert);
	int i=st_insert.executeUpdate(sql_insert);
	if(sql_bogieset_tran!=null){ int j=st_update_bogieset.executeUpdate(sql_bogieset_tran);}
    if(i>0)
    {
        out.println("<b>Saved Successsfully</b>");
       
    }
    else
    {
        out.println("Error While Saving<br>");
        out.println(sql_insert);
    }	

}

con.close();
}

catch(Exception e)
{
out.println("Exception in do file "+e);
con.rollback();
}
finally{
	if(con!=null) {con.close();}
}
%>
</body>
</html>