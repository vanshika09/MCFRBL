<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
 <%@ page import="dao.DbConnection" %> 
<% String contextpath=request.getContextPath();%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <link rel="stylesheet" href="/resources/demos/style.css"/>
    
<script src="<%=contextpath %>/newdashboard/html2pdf.bundle.min.js"></script>



</head>
<body>
<%
String railway=request.getParameter("railway_type");
String coachType=request.getParameter("Coach_type");
String year=request.getParameter("year");
String month=request.getParameter("months");

DbConnection db=new DbConnection();
Connection connection = null;
connection=db.getConnection(); 
Statement stFirstYear=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
Statement stSecondYear=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
Statement stSelectedYear=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

String sqlQueryFirstYear=null;
String sqlQuerySecondYear=null;
String sqlQuerySelectedYear=null;

Calendar cal = Calendar.getInstance();
int yy= cal.get(Calendar.YEAR);
int mm=cal.get(Calendar.MONTH);
if (mm<3)
{
	yy=yy-1;
}
String firstYear=yy+"-"+(yy+1);
String secondYear=(yy+1)+"-"+(yy+2);

if(railway.equals("All"))
{
   if(coachType.equals("All"))
      {
	  if(year.equals("All"))
	     {
		 if(month.equals("All"))
		    {
sqlQueryFirstYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+firstYear+"' group by dispatch_rly,year";
sqlQuerySecondYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+secondYear+"' group by dispatch_rly,year";	

		    }
		 else
		    {
sqlQueryFirstYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+firstYear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year";
sqlQuerySecondYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+secondYear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year";			

		    }
		 }
	  else
         {
		 if(month.equals("All"))
		    {
			 
sqlQuerySelectedYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+year+"' group by dispatch_rly,year";
			
		    }
		 else
		    {
sqlQuerySelectedYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+year+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year";
		    }
         }		 
	  }
   else
     {
	    if(year.equals("All"))
	     {
		 if(month.equals("All"))
		    {
sqlQueryFirstYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master)  and coach_type ='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+firstYear+"' group by dispatch_rly,year";
sqlQuerySecondYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type ='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+secondYear+"' group by dispatch_rly,year";			

			}
		 else
		    {
sqlQueryFirstYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master)  and coach_type ='"+coachType+"' and crnt_mon(coach_dispatch_date) ='"+month+"' and crnt_fin_year(coach_dispatch_date)='"+firstYear+"' group by dispatch_rly,year";
sqlQuerySecondYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type ='"+coachType+"' and crnt_mon(coach_dispatch_date) ='"+month+"' and crnt_fin_year(coach_dispatch_date)='"+secondYear+"' group by dispatch_rly,year";			
			
			}
		 }
	  else
         {
		 if(month.equals("All"))
		    {

sqlQuerySelectedYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type ='"+coachType+"' and crnt_fin_year(coach_dispatch_date) ='"+year+"'  group by dispatch_rly,year";			
			}
		 else
		    {
sqlQuerySelectedYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type ='"+coachType+"' and crnt_mon(coach_dispatch_date) ='"+month+"' and crnt_fin_year(coach_dispatch_date)='"+year+"' group by dispatch_rly,year";			
			}
         }
	 }
   
}

else
 {
 if(coachType.equals("All"))
      {
	  if(year.equals("All"))
	     {
		 if(month.equals("All"))
		    {
sqlQueryFirstYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+firstYear+"' and dispatch_rly ='"+railway+"' group by dispatch_rly,year";
sqlQuerySecondYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+secondYear+"' and dispatch_rly ='"+railway+"' group by dispatch_rly,year";			

			}
		 else
		    {

sqlQueryFirstYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+firstYear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' and dispatch_rly ='"+railway+"' group by dispatch_rly,year";
sqlQuerySecondYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+secondYear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' and dispatch_rly ='"+railway+"' group by dispatch_rly,year";			

		    }
		 }
	  else
         {
		 if(month.equals("All"))
		    {
			
			 sqlQuerySelectedYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+year+"' and dispatch_rly ='"+railway+"' group by dispatch_rly,year";			
		    }
		 else
		    {
			 sqlQuerySelectedYear="select dispatch_rly, count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly in (select railway_code from railway_master) and coach_type in(select asset_subtype from asset_master where asset_type='Coach')  and crnt_fin_year(coach_dispatch_date)='"+year+"' and crnt_mon(coach_dispatch_date) ='"+month+"' and dispatch_rly ='"+railway+"' group by dispatch_rly,year";			
		    }
         }		 
	  }
   else
     {
	    if(year.equals("All"))
	     {
		 if(month.equals("All"))
		    {

sqlQueryFirstYear="select dispatch_rly,count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+firstYear+"'  group by dispatch_rly,year";	
sqlQuerySecondYear="select dispatch_rly,count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+secondYear+"'  group by dispatch_rly,year";		
		    }
		 else
		    {

sqlQueryFirstYear="select dispatch_rly,count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+firstYear+"' and crnt_mon(coach_dispatch_date) ='"+month+"'  group by dispatch_rly,year";	
sqlQuerySecondYear="select dispatch_rly,count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+secondYear+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year";		

		    }
		 }
	  else
         {
		 if(month.equals("All"))
		    {
sqlQuerySelectedYear="select dispatch_rly,count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date)='"+year+"'  group by dispatch_rly,year";
			}
		 else
		    {
sqlQuerySelectedYear="select dispatch_rly,count(dispatch_rly) as quantity, crnt_fin_year(coach_dispatch_date) as year as month from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type='"+coachType+"'  and crnt_fin_year(coach_dispatch_date) ='"+year+"' and crnt_mon(coach_dispatch_date) ='"+month+"' group by dispatch_rly,year";
			}
         }
	 }
 } 
if(year.equals("All"))
{
	ResultSet rsFirstYear=stFirstYear.executeQuery(sqlQueryFirstYear);
	ResultSetMetaData rs_first_md = rsFirstYear.getMetaData();
int	no_of_columnFirst=rs_first_md.getColumnCount();
int rows_first=0;
if (rsFirstYear.last()) {
	rows_first = rsFirstYear.getRow();
    // Move to beginning
    rsFirstYear.beforeFirst();
    
}

String [][] firstArray= new String[rows_first][no_of_columnFirst];
	int i=0;
	while(rsFirstYear.next())
	{
		for(int j=0; j<no_of_columnFirst; j++)
		{
			
			firstArray[i][j]=rsFirstYear.getString(j+1);
			
		}
		i++;	
	}
	ResultSet rsSecondYear=stSecondYear.executeQuery(sqlQuerySecondYear);
	
	ResultSetMetaData rs_second_md = rsSecondYear.getMetaData();
	

	int	no_of_columnSecond=rs_second_md.getColumnCount();
	int rows_second=0;
	if (rsSecondYear.last()) {
		rows_second = rsFirstYear.getRow();
	    // Move to beginning
	    rsSecondYear.beforeFirst();
	    
	}
		String [][] secondArray= new String[rows_second][no_of_columnSecond];
		int a=0;
		while(rsSecondYear.next())
		{
			for(int b=0; b<no_of_columnSecond; b++)
			{
				
				firstArray[a][b]=rsSecondYear.getString(b+1);
				
			}
			a++;	
		}  
		%>
		<table border='1' cellpadding='0' cellspacing='0' height=80% width=70% align=center style="margin-top:100px;">
		<tr><th colspan="<%=firstArray.length+1%>>" style="background-color:#0000A0; color:white; text-align: center;">Dispatch Position summary for all month for Financial Year <%=firstYear%></th></tr>
		<tr>
		<th style="color:#0000A0;  text-align: center;">Railway</th>
		<% for (int m=0; m<firstArray.length;m++)
		{ %>
			<td style="color:#0000A0;  text-align: center;"><b><%=firstArray[m][0]%></b></td>
	<% 	}  %>
	</tr>
	<tr>
		<th style="color:#0000A0;  text-align: center;">Coach Dispatched</th>
		<% for (int m=0; m<firstArray.length;m++)
		{  %>
			<td style="color:#0000A0;  text-align: center;">
			<a tabindex="1005" href="#"  onclick="openDialog('<%=firstYear%>','<%=firstArray[m][0]%>', '<%=coachType%>', '<%=month%>')" >
			<%=firstArray[m][1]%>
			</a>
			<span id="dialog" class="dialogclass" style="z-index:9999;"></span>
			</td>
	<% 	}
	%>
		</tr>
		</table>
		
	   <table border='1' cellpadding='0' cellspacing='0' height=80% width=70% align=center style="margin-top:100px;">
		<tr><th colspan="<%=secondArray.length+1%>>" style="background-color:#0000A0; color:white; text-align: center;">Dispatch Position summary for all month for Financial Year <%=secondYear%></th></tr>
		<tr>
		<th style="color:#0000A0;  text-align:center;">Railway</th>
		<% for (int m=0; m<secondArray.length;m++)
		{ %>
			<td style="color:#0000A0;  text-align: center;"><%=secondArray[m][0]%></td>
	<% 	}  %>
		</tr>
		<tr><th style="color:#0000A0;  text-align: center;">Coach Dispatched</th>
		<% for (int m=0; m<secondArray.length;m++)
		{  %>
			<td style="color:#0000A0;  text-align: center;">
			<a tabindex="1005" href="#"  onclick="openDialog('<%=secondYear%>','<%=secondArray[m][0]%>', '<%=coachType%>', '<%=month%>')" >
			<b><%=secondArray[m][1]%></b>
			</a>
			<span id="dialog" class="dialogclass" style="z-index:9999;"></span>
			</td>
	<% 	}
	%>
		</tr>
		</table>
	
	
	
<% }  // end of firs condition
else
{
	ResultSet rsSelectedYear=stSelectedYear.executeQuery(sqlQuerySelectedYear);
	ResultSetMetaData rs_selected_md = rsSelectedYear.getMetaData();
int	no_of_columnSelected=rs_selected_md.getColumnCount();
int rows_selected=0;
if (rsSelectedYear.last()) {
	rows_selected = rsSelectedYear.getRow();
    // Move to beginning
    rsSelectedYear.beforeFirst();
    
}

	String [][] selectedArray= new String[rows_selected][no_of_columnSelected];
	int i=0;
	while(rsSelectedYear.next())
	{
		for(int j=0; j<no_of_columnSelected; j++)
		{
			
			selectedArray[i][j]=rsSelectedYear.getString(j+1);
			
		}
		i++;	
	}
	%>
		<table border='1' cellpadding='0' cellspacing='0' height=80% width=70% align=center style="margin-top:100px;">
		<tr><th colspan="<%=selectedArray.length+1%>>" style="background-color:#0000A0; color:white; text-align: center;">Dispatch Position summary for all month for Financial Year <%=year%></th></tr>
		<tr>
		<th style="color:#0000A0;  text-align: center;">Railway</th>
		<% for (int m=0; m<selectedArray.length;m++)
		{ %>
			<td style="color:#0000A0;  text-align: center;"><%=selectedArray[m][0]%></td>
	<% 	}  %>
	</tr>
	<tr>
		<th style="color:#0000A0;  text-align: center;">Coach Dispatched</th>
		<% 
		
		for (int m=0; m<selectedArray.length;m++)
		{  %>
		
			<td style="color:#0000A0;text-align: center;">
			<a tabindex="1005" href="#"  onclick="openDialog('<%=year%>','<%=selectedArray[m][0]%>','<%=coachType%>', '<%=month%>')" >
			<b><%=selectedArray[m][1]%></b>
			</a>
			<span id="dialog" style="z-index:9999;"></span>
			</td>
	<% 	}  %>

		</tr>
		</table>
		<br />
		<br />
	
<% 
}
connection.close();
%>
<script>
function openDialog(fin,rail,coach_type,mon) {


var fin=fin;
var rly =rail;
var coach_type=coach_type;
var mon=mon;

var url="seconddemo.jsp?finYear="+fin+"&railway="+rly+"&coachType="+coach_type+"&month="+mon;

$("#dialog").load(url).dialog({modal: true,width: 530,title:"Details For Dispatch Coach"});



   }


</script>
</body>
</html>