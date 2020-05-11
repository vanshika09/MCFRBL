<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@page import="java.util.Date" %>
<%@ page import="java.text.*" %>
 <%@ page import="dao.DbConnection" %> 

<html>
<head>
<title>Insert title here</title>
</head>
<body>

<%
System.out.println("Hi Navin");
	String finyear=request.getParameter("finYear");
	String railTpye=request.getParameter("railway");
	String coachType=request.getParameter("coachType");
	String month=request.getParameter("month");
	Connection connection=null;
	  try {
		  DbConnection db=new DbConnection();

	    	
	    	connection=db.getConnection(); 
	    	System.out.println("finyear="+finyear+"&railway="+railTpye+"&coachType="+coachType+"&month="+month);
	    	Statement st_new_result=connection.createStatement();
	    	
	    	ResultSet r_new_result;
	    	String queryString_new_result=new String();
	    	if(railTpye.equals("All"))
	    	{
	    	   if(coachType.equals("All"))
	    	    {
	    	      if(month.equals("All"))
	    	          {
queryString_new_result="select dispatch_rly ,coach_type,coach_number,dispatch_div,to_char(coach_dispatch_date,'DD-MM-YYYY'),count(dispatch_rly) as quantity,crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+finyear+"' group by dispatch_rly,year,coach_number,coach_type,coach_dispatch_date,dispatch_div";

	    	           }
	    	      else
	    	          {
	    		
queryString_new_result="select dispatch_rly ,coach_type,coach_number,dispatch_div,to_char(coach_dispatch_date,'DD-MM-YYYY'),count(dispatch_rly) as quantity,crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+finyear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year,coach_number,coach_type,coach_dispatch_date,dispatch_div";	    			
	    	          }
	    	}
	    	else
	    	{
	    		 if(month.equals("All"))
 	          {
queryString_new_result="select dispatch_rly ,coach_type,coach_number,dispatch_div,to_char(coach_dispatch_date,'DD-MM-YYYY'),count(dispatch_rly) as quantity,crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+finyear+"' group by dispatch_rly,year,coach_number,coach_type,coach_dispatch_date,dispatch_div";

 	           }
 	      else
 	          {
 		
queryString_new_result="select dispatch_rly ,coach_type,coach_number,dispatch_div,to_char(coach_dispatch_date,'DD-MM-YYYY'),count(dispatch_rly) as quantity,crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+finyear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year,coach_number,coach_type,coach_dispatch_date,dispatch_div";	    			
 	          }
	    		
	    	}
}
	    	
else
{
	if(coachType.equals("All"))
  {
    if(month.equals("All"))
        {
queryString_new_result="select dispatch_rly ,coach_type,coach_number,dispatch_div,to_char(coach_dispatch_date,'DD-MM-YYYY'),count(dispatch_rly) as quantity,crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly='"+railTpye+"' and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+finyear+"' group by dispatch_rly,year,coach_number,coach_type,coach_dispatch_date,dispatch_div";

         }
    else
        {
	
queryString_new_result="select dispatch_rly ,coach_type,coach_number,dispatch_div,to_char(coach_dispatch_date,'DD-MM-YYYY'),count(dispatch_rly) as quantity,crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly='"+railTpye+"' and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+finyear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year,coach_number,coach_type,coach_dispatch_date,dispatch_div";	    			
        }
}
else
{
	 if(month.equals("All"))
   {
queryString_new_result="select dispatch_rly ,coach_type,coach_number,dispatch_div,to_char(coach_dispatch_date,'DD-MM-YYYY'),count(dispatch_rly) as quantity,crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly='"+railTpye+"' and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+finyear+"' group by dispatch_rly,year,coach_number,coach_type,coach_dispatch_date,dispatch_div";

    }
else
   {

queryString_new_result="select dispatch_rly ,coach_type,coach_number,dispatch_div,to_char(coach_dispatch_date,'DD-MM-YYYY'),count(dispatch_rly) as quantity,crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly='"+railTpye+"' and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+finyear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year,coach_number,coach_type,coach_dispatch_date,dispatch_div";	    			
   }
	
}
	
}
	   System.out.println("Output query for dialog:  "+queryString_new_result);
	    r_new_result = st_new_result.executeQuery(queryString_new_result); 
	    	
	    %>	 
<table border='1' cellpadding='0' cellspacing='0' style="height:100%; width:500px;text-align: center;">
	<tr style="background-color:#d9d9d9;color:black; text-align: center; ">
		<td><b>Railway</b></td>
		<td><b>Coach Type</b></td>
		<td><b>Coach Number</b></td>
		<td><b>Dispatch Division</b></td>
		<td><b>Dispatch Date</b></td>
	</tr>
	<% while(r_new_result.next())
	{
		String Railway= r_new_result.getString(1);  
		if(Railway==null) {Railway="";}
		String coach=r_new_result.getString(2);
		if(coach==null){coach="";}
		String coachNo=r_new_result.getString(3);
		if(coachNo==null) {coachNo="";}
		String dispatchDiv=r_new_result.getString(4);
		if(dispatchDiv==null) {dispatchDiv="";}
		String assembly_dispatch_date= r_new_result.getString(5);
		if(assembly_dispatch_date==null) {assembly_dispatch_date="";}
		
		%>
		<tr style="color:#0000A0; text-align: center; ">
		<td><%=Railway%></td>
		<td><%=coach%></td>
		<td><%=coachNo%></td>
		<td><%=dispatchDiv%></td>
		<td><%=assembly_dispatch_date%></td>
		</tr>
	
	<% 
		}
	%>
</table>   	
<% 
    
	  
	  }
    catch (Exception ex) 
    {
    	//out.println(ex.printStackTrace());
       // out.println("Unable to connect to database.");
    }
	  finally
	  {
		  connection.close();
	  }
    %>

</body>
</html>