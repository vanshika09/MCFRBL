<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
 <%@ page import="dao.DbConnection" %> 
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% String contextpath=request.getContextPath();%>
<script src="<%=contextpath %>/js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="<%=contextpath %>/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
<link href="<%=contextpath %>/css/jquery-ui-1.10.3.custom.css" rel="stylesheet"type="text/css" /> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
#submitButtonid {

background: #0000A0;
color: #ffffff; 
/*color:;*/

border: 1px solid #eee;

/* //border-radius: 20px; */
margin-left: 10%;

box-shadow: 5px 5px 5px #eee;

text-shadow:none;

}
</style>
 <script type="text/javascript"> 
 $(document).ready(function() {
$( "#submitButtonid" ).click(function(){
	 $('input').attr('required', true); 
		 var url="<%=contextpath%>/example_condition.jsp?railway_type="+$("#railway_type" ).val()+"&Coach_type="+$( "#Coach_type" ).val()+"&year="+$( "#year" ).val()+"&months="+$( "#months" ).val();
	 //alert(url) ;
	// $('#para_selection').attr('action', url);
	// $( "#para_selection" ).submit();
	// e.preventDefault();
	 $("#new-pages").load(url);
	
});
 });
</script>
</head>
<body>

<% 
try {
	
/* Create string of connection url within specified format with machine
name, port number and database name. Here machine name id localhost and 
database name is student. */
//String connectionURL = "jdbc:postgresql://localhost/MCFRBL";

// declare a connection by using Connection interface
 DbConnection db=new DbConnection();

Connection connection = null;
connection=db.getConnection(); 
/* declare object of Statement interface that is used for executing sql 
statements. */
Statement st_rail_type=connection.createStatement();
Statement st_coach_type=connection.createStatement();
Statement st_from_date=connection.createStatement();
Statement st_to_date=connection.createStatement();

//declare a resultset that uses as a table for output data from tha table.
ResultSet r_rail_type;
ResultSet r_coach_type;
ResultSet r_from_date;
ResultSet r_to_date;
//for railway_type 
String queryString_railway_type ="select distinct railway_code from railway_master order by  railway_code asc";
/* System.out.println("Query :>"+queryString_railway_type); */

r_rail_type = st_rail_type.executeQuery(queryString_railway_type);

ResultSetMetaData rsmd = r_rail_type.getMetaData();
//System.out.println("querying SELECT * FROM XXX");
String[] ArrayNew= new String[20];
int columnsNumber = rsmd.getColumnCount();//no of columns
String columnValue=new String();
//int k=0;
//String str=",";
//String finalStr=new String();
int rowcount=0;
while (r_rail_type.next()) {
   
	for (int i = 1; i <= columnsNumber; i++)
	{
        if (i > 1) 
       	 System.out.print(",  ");
        columnValue = r_rail_type.getString(i);
    }
	
	if( columnValue!=null)
	{
		ArrayNew[rowcount]=columnValue;
	}
	
    rowcount++;
}

/* for(int i=0;i<rowcount;i++)
{
	System.out.println(ArrayNew[i]);
}
 */
//forCoachType

String queryString_coach_type ="select distinct asset_subtype from asset_master where asset_type='Coach' order by asset_subtype asc";
/* System.out.println("Query :>"+queryString_railway_type); */

r_coach_type = st_coach_type.executeQuery(queryString_coach_type);

ResultSetMetaData rsmd2 = r_coach_type.getMetaData();
//System.out.println("querying SELECT * FROM XXX");
String[] ArrayNewCoach= new String[30];
int columnsNumber2 = rsmd.getColumnCount();//no of columns
String columnValue2=new String();
//int k=0;
//String str=",";
//String finalStr=new String();
int rowcount2=0;
while (r_coach_type.next()) {
   
	for (int i = 1; i <= columnsNumber2; i++)
	{
        if (i > 1) 
       	 System.out.print(",  ");
        columnValue2 = r_coach_type.getString(i);
    }
	
	if( columnValue2!=null)
	{
		ArrayNewCoach[rowcount2]=columnValue2;
	}
	
    rowcount2++;
}

/* for(int i=0;i<rowcount2;i++)
{
	System.out.println(ArrayNewCoach[i]);
}
 */
//yearSelection
String queryString_year ="select distinct financial_year from coach_target order by financial_year desc";
/* System.out.println("Query :>"+queryString_railway_type); */

r_from_date = st_from_date.executeQuery(queryString_year);

ResultSetMetaData rsmd3 = r_from_date.getMetaData();
//System.out.println("querying SELECT * FROM XXX");
String[] ArrayNewYear= new String[20];
int columnsNumber3 = rsmd3.getColumnCount();//no of columns
String columnValue3=new String();
//int k=0;
//String str=",";
//String finalStr=new String();
int rowcount3=0;
while (r_from_date.next()) {
   
	for (int i = 1; i <= columnsNumber3; i++)
	{
        if (i > 1) 
       	 System.out.print(",  ");
        columnValue3 = r_from_date.getString(i);
    }
	
	if( columnValue3!=null)
	{
		ArrayNewYear[rowcount3]=columnValue3;
	}
	
    rowcount3++;
}

/* for(int i=0;i<rowcount3;i++)
{
	System.out.println(ArrayNewYear[i]);
} */

//monthSelection
String queryString_month ="select month_code from month_finance_year_master ";
/* System.out.println("Query :>"+queryString_railway_type); */

r_to_date = st_to_date.executeQuery(queryString_month);

ResultSetMetaData rsmd4 = r_to_date.getMetaData();
//System.out.println("querying SELECT * FROM XXX");
String[] ArrayNewMonth= new String[20];
int columnsNumber4 = rsmd4.getColumnCount();//no of columns
String columnValue4=new String();
//int k=0;
//String str=",";
//String finalStr=new String();
int rowcount4=0;
while (r_to_date.next()) {
   
	for (int i = 1; i <= columnsNumber4; i++)
	{
        if (i > 1) 
       	 System.out.print(",  ");
        columnValue4 = r_to_date.getString(i);
    }
	
	if( columnValue4!=null)
	{
		ArrayNewMonth[rowcount4]=columnValue4;
	}
	
    rowcount4++;
}

/* for(int i=0;i<rowcount4;i++)
{
	System.out.println(ArrayNewMonth[i]);
}
 */
//System.out.print(finalStr);
/* ResultSetMetaData rsmd = r_rail_type.getMetaData();
//System.out.println("querying SELECT * FROM XXX");
int columnsNumber = rsmd.getColumnCount();
String[] columnValue= new String[20];
//int len=columnValue.length;
//System.out.println(len);
while (r_rail_type.next()) {
    for (int i = 1; i <= columnsNumber; i++) {
        if (i > 1) System.out.print(",  ");
        for()
        {
         columnValue[j] = r_rail_type.getString(i);
        }
        
    }
    System.out.print(columnValue);
    //System.out.println("");
} */

%>

<div>
<p><b>Select Parameter</b>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#0000A0;">RAILWAYS&nbsp;&nbsp;</span>
		<select id="railway_type">
		  <%
		for(int i=0;i<rowcount;i++)
		{	
		%>
			<option value="<%=ArrayNew[i]%>"><%=ArrayNew[i]%></option>
		<%
		 }
		%>
 		<option value="All"  selected>All Railways</option>
		</select>
	<span style="color:#0000A0;margin-left:5px;">COACH TYPE&nbsp;&nbsp;</span>
		<select id="Coach_type">
		<option value="All"  selected>All Coach Type</option>
		 <%
		for(int i=0;i<rowcount2;i++)
		{
			
		%>
			<option value="<%=ArrayNewCoach[i]%>"><%=ArrayNewCoach[i]%></option>
		<%
		 }
		%>
		
		</select>

	<span style="color:#0000A0;">YEAR&nbsp;&nbsp;</span>
		<select id="year">
		<option value="All" selected>All Years </option> 
		
		 <%
		 for(int i=0;i<rowcount3;i++)
		{
			
		%>
			<option value="<%=ArrayNewYear[i]%>" ><%=ArrayNewYear[i]%></option>
		<%
		 }
		%>
		</select>
	<span style="color:#0000A0;margin-left:5px;">MONTH&nbsp;&nbsp;</span>
		<select id="months">
		<option value="All" selected>All Months </option>
		
		 <%
		 for(int i=0;i<rowcount4;i++)
		{
			
		%>
			<option value="<%=ArrayNewMonth[i]%>" ><%=ArrayNewMonth[i]%></option>
		<%
		 }
		%>
		</select>
		&nbsp;<input type="submit" value="submit" id="submitButtonid"/> 
	</p>
	
<% 
connection.close();
}
catch (Exception ex) 
{
	//out.println(ex.printStackTrace());
out.println("Unable to connect to database.");
}%>
</div>

<hr/>


<div id="new-pages"></div>
</body>
</html>