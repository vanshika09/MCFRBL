<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
 <%@ page import="dao.DbConnection" %> 
<% String contextpath=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />

<!--     <script src="http://code.jquery.com/jquery-1.9.1.js"></script> -->
<!--     <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script> --> -->
    

<script src="<%=contextpath %>/js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="<%=contextpath %>/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
<link href="<%=contextpath %>/css/jquery-ui-1.10.3.custom.css" rel="stylesheet"type="text/css" /> 
    <link rel="stylesheet" href="/resources/demos/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="<%=contextpath %>/newdashboard/html2pdf.bundle.min.js"></script>
<script>
 function openDialog(finYear, railway1) {
	 var fin=finYear;
	var rly =railway1;
	/* var title="Details for despatch Coach"; */
	/* alert(rly); */
    $("#dialog").load("seconddemo.jsp?finYear="+fin+"&rail="+rly).dialog({modal: true,width: 530,title:"Details For Dispatch Coach"
    	/* buttons: {
            Cancel: function() {
              $(this).dialog("close");
            }
    	 } */
    	});
    }
</script>
<!-- <script>
function findPosition(obj) {
    var curleft = curtop = 0;
    if (obj.offsetParent) {
        do {
            curleft += obj.offsetLeft;
            curtop += obj.offsetTop;
        } while (obj = obj.offsetParent);
//      alert ('[' + curleft + ', ' + curtop + ']');
        return [curleft,curtop];
    }
}
</script> -->
<style>
span{
  display:block;
   z-index:9999;
   /* //position: element(#Target); */
  /* position:absolute; */
   
   /*  top: 50%;
    left: 50%; */
    /* margin-left: -400px; // 1/2 width
    margin-top: -40px; // 1/2 height */
   
   
}
 #downloadPdf
	{
		 background:black; 
		 color: #ffffff; 
		 /*color:;*/

		border: 1px solid #eee;

		 /* //border-radius: 20px; */ 
		margin-left: 80%;
		margin-top:55px;
		box-shadow: 5px 5px 5px #eee;

		text-shadow:none;
	} 

</style>
<title>Insert title here</title>
</head>
<body>
<div id="printAll">
<form>
 <!-- <button id="downloadPdf" onclick="printDiv()" >Print</button> -->
 <a href="#" id="downloadPdf" onclick="printDiv()" >Print</a> 
 
<%
	//out.println("inside demo2");
    String railway=request.getParameter("railway_type");
    String coachtype=request.getParameter("Coach_type");
    String query_year=request.getParameter("year");
    String query_month=request.getParameter("months");
    
     /*  out.println(railway);
    out.println(coachtype);
    out.println(year);
    out.println(month);  */
     
    try {
    	
    	 DbConnection db=new DbConnection();

    	Connection connection = null;
    	connection=db.getConnection(); 
    	
    	Statement st_new_result=connection.createStatement();
    	
    	ResultSet r_new_result;
  		//String query_month=new String();
  		/* switch(month)
  		{
  			case "JAN" :
  				query_month="01";
  				break;
  				
  			case "FEB" :
  				query_month="02";
  				break;
  				
  			case "MAR" :
  				query_month="03";
  				break;
  			case "APR" :
  				query_month="04";
  				break;
  			case "MAY" :
  				query_month="05";
  				break;
  			case "JUN" :
  				query_month="06";
  				break;
  			case "JUL" :
  				query_month="07";
  				break;
  			case "AUG" :
  				query_month="08";
  				break;	
  			case "SEP" :
  				query_month="09";
  				break;
  			case "OCT" :
  				query_month="10";
  				break;
			case "NOV" :
  				query_month="11";
  				break;
  			case "DEC" :
  				query_month="12";		
  			
  		} 
  		String query_year=new String();
  		if(!year.equals("All Years"))
  		{
  		String stry1=year.substring(0,4);
  		String stry2=year.substring(5,9);
  		
  		//System.out.println(stry1);
  		//System.out.println(stry2);
  	    if(query_month=="01" || query_month=="02"|| query_month=="03" )
  	    {
  	    	query_year=stry2;
  	    	System.out.println(query_year);
  	    }
  	    else
  	    {
  	    	query_year=stry1;
  	    	System.out.println(query_year);
  	    }
  		System.out.println(query_month);
  		}
  		String rail1= new String();
  		String rail2= new String();
  		if(railway.equals("All Railways"))
  		{
  			 rail1="All Railways";
  		}
  		else 
  		{
  			rail2=railway;
  		}
  		System.out.println(rail1);
  		System.out.println(rail2);
  		*/
  	/*  String query1="select  extract(year from assembly_dispatch_date)as year,extract(month from assembly_dispatch_date)as month,dispatch_rly , coach_type , count(dispatch_rly) as quantity, from furnishing_tran where query2= if railway= 'All Railway' dispatch_rly in ('CR', 'WR','ECoR','ECR','ER','NCR','NER','NFR','NR','NWR','SCR','SECR','SER','SR','SWR','WCR')else query2=dispatch_rly in('railway')  query3=dispatch_rly not in('null',' ') query4= if coachtype='All Coach Type' coach_type in ('HBC','HUMSAFAR','LDSLR','LSDD','LWACCN','LWACCW','LWCBAC','LWLRRM','LWLRRM-750KV','LWSCN','LWSCZ','LWSCZAC',	'SLRD','TRC')	else query4= coach_type ='"+coachtype+"' query5=coach_type not in('null',' ') query6=if month='All month'(extract(month from assembly_dispatch_date)) in ('01','02','03','04','05','06','07','08','09','10','11','12')else query6=(extract(month from assembly_dispatch_date))="'+query_month+'" query7=(extract(month from assembly_dispatch_date)) not in('null',' ') query8=if year='All Year' extract(year from assembly_dispatch_date) in ('2018',2019)elsequery8=extract(year from assembly_dispatch_date) in('query_year')query9= extract(year from assembly_dispatch_date) not in ('null',' ') group by  year,month, dispatch_rly,coach_type query1=query1+query2 and query3 +query4 and query5+query6 and query7+query8 and query9;"

   ( (coachtype.equals("ALL Coach Type")) && (!railway.equals("All Railways"))  )
    */
   
  		

  		String queryString_new_result=new String();
  	if((railway.equals("All Railways")) && (coachtype.equals("ALL Coach Type")) && (query_year.equals("All Years")) && (query_month.equals("All Months")))
  	{
  		System.out.println("INSIDE all");
  		queryString_new_result="select dispatch_rly ,crnt_fin_year(assembly_dispatch_date) as year  ,count(dispatch_rly) as quantity from furnishing_tran where dispatch_rly in ('CR', 'WR','ECoR','ECR','ER','NCR','NER','NFR','NR','NWR','SCR','SECR','SER','SR','SWR','WCR') and coach_type in('HBC','HUMSAFAR','LDSLR','LSDD','LWACCN','LWCCW','LWCBAC','LWLRRM','LWLRRM-750KV','LWSCN','LWSCZ','LWSCZAC','SLRD','TRC')  and crnt_fin_year(assembly_dispatch_date) in ('2018-2019','2019-2020') group by dispatch_rly,year";
  		System.out.println("Done");
  	}
  	
   else if((query_year.equals("All Years")) || (query_month.equals("All Months")))
  		{
  			if( (query_year.equals("All Years")) && (query_month.equals("All Months")))
  			{
  				if((railway.equals("All Railways")) && (!coachtype.equals("ALL Coach Type")))
  				{
  					System.out.println("Done2");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly in ('CR', 'WR','ECoR','ECR','ER','NCR','NER','NFR','NR','NWR','SCR','SECR','SER','SR','SWR','WCR') and coach_type ='"+coachtype+"'   and crnt_fin_year(assembly_dispatch_date) in ('2018-2019','2019-2020') group by dispatch_rly,month,year, coach_type";
  				}
  				else if((!railway.equals("All Railways")) && (coachtype.equals("ALL Coach Type")))
  				{
  					System.out.println("Done3");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type in('HBC','HUMSAFAR','LDSLR','LSDD','LWACCN','LWCCW','LWCBAC','LWLRRM','LWLRRM-750KV','LWSCN','LWSCZ','LWSCZAC','SLRD','TRC') and crnt_fin_year(assembly_dispatch_date) in ('2018-2019','2019-2020') group by dispatch_rly,month,year, coach_type";
  				}
  				
  				else//  all railways  all coach not 
  				{
  					System.out.println("Done4");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type='"+coachtype+"' and crnt_fin_year(assembly_dispatch_date) in ('2018-2019','2019-2020') group by dispatch_rly,month,year, coach_type";
  				}
  			}
  	 	else if( (query_year.equals("All Years")) && (!query_month.equals("All Months")))
  			{
  				if((railway.equals("All Railways")) && (!coachtype.equals("ALL Coach Type")))
  				{
  					System.out.println("Done5");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly in ('CR', 'WR','ECoR','ECR','ER','NCR','NER','NFR','NR','NWR','SCR','SECR','SER','SR','SWR','WCR') and coach_type='"+coachtype+"' and crnt_mon(assembly_dispatch_date)='"+query_month+"'  and crnt_fin_year(assembly_dispatch_date) in ('2018-2019','2019-2020') group by dispatch_rly,month,year, coach_type";
  				}
  				else if((!railway.equals("All Railways")) && (coachtype.equals("ALL Coach Type")))
  				{
  					System.out.println("Done6");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type in('HBC','HUMSAFAR','LDSLR','LSDD','LWACCN','LWCCW','LWCBAC','LWLRRM','LWLRRM-750KV','LWSCN','LWSCZ','LWSCZAC','SLRD','TRC') and crnt_mon(assembly_dispatch_date) ='"+query_month+"'  and crnt_fin_year(assembly_dispatch_date) in ('2018-2019','2019-2020') group by dispatch_rly,month,year, coach_type";
  				}
  				
  				else//  all railways  all coach not all month only all years.
  				{
  					System.out.println("Done7");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly='"+railway+"'  and coach_type ='"+coachtype+"' and crnt_mon(assembly_dispatch_date)='"+query_month+"'  and crnt_fin_year(assembly_dispatch_date) in ('2018-2019','2019-2020') group by dispatch_rly,month,year, coach_type";
  				}
  				
  			}
  			 
  	else	
  			{
  				if((railway.equals("All Railways")) && (!coachtype.equals("ALL Coach Type")))
  				{
  					System.out.println("Done8");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly in ('CR', 'WR','ECoR','ECR','ER','NCR','NER','NFR','NR','NWR','SCR','SECR','SER','SR','SWR','WCR') and coach_type='"+coachtype+"'   and crnt_fin_year(assembly_dispatch_date)='"+query_year+"'  group by dispatch_rly,month,year, coach_type";
  				}
  				else if((!railway.equals("All Railways")) && (coachtype.equals("ALL Coach Type")))
  				{
  					System.out.println("Done9");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly ='"+railway+"' and coach_type in('HBC','HUMSAFAR','LDSLR','LSDD','LWACCN','LWCCW','LWCBAC','LWLRRM','LWLRRM-750KV','LWSCN','LWSCZ','LWSCZAC','SLRD','TRC') and  crnt_fin_year(assembly_dispatch_date)='"+query_year+"'  group by dispatch_rly,month,year, coach_type";
  				}
  				else if((railway.equals("All Railways")) && (coachtype.equals("ALL Coach Type")))
  				{
  					System.out.println("Done10");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly in ('CR', 'WR','ECoR','ECR','ER','NCR','NER','NFR','NR','NWR','SCR','SECR','SER','SR','SWR','WCR') and coach_type in('HBC','HUMSAFAR','LDSLR','LSDD','LWACCN','LWCCW','LWCBAC','LWLRRM','LWLRRM-750KV','LWSCN','LWSCZ','LWSCZAC','SLRD','TRC') and  crnt_fin_year(assembly_dispatch_date)='"+query_year+"'  group by dispatch_rly,month,year, coach_type";
  					
  					
  				}
  				
  				else// not all railways   not all coach   all month  not all years.
  				{
  					System.out.println("Done11");
  					queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly='"+railway+"'  and coach_type='"+coachtype+"'  and  crnt_fin_year(assembly_dispatch_date)='"+query_year+"'  group by dispatch_rly,month,year, coach_type";
  				}
  				
  			}
  	
  			
  		}
  	
   else if((!query_year.equals("All Years")) && (!query_month.equals("All Months")) && ((railway.equals("All Railways")) || (coachtype.equals("ALL Coach Type"))  ))
		{
			if((railway.equals("All Railways")) && (coachtype.equals("ALL Coach Type")) )
			{
				queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly in ('CR', 'WR','ECoR','ECR','ER','NCR','NER','NFR','NR','NWR','SCR','SECR','SER','SR','SWR','WCR') and coach_type in('HBC','HUMSAFAR','LDSLR','LSDD','LWACCN','LWACCW','LWCBAC','LWLRRM','LWLRRM-750KV','LWSCN','LWSCZ','LWSCZAC','SLRD','TRC')	and crnt_mon(assembly_dispatch_date)='"+query_month+"' and crnt_fin_year(assembly_dispatch_date)='"+query_year+"' group by dispatch_rly,month,year, coach_type";
			}
			
			else if((railway.equals("All Railways")) && (!coachtype.equals("ALL Coach Type")) )
			{
				 queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly in ('CR', 'WR','ECoR','ECR','ER','NCR','NER','NFR','NR','NWR','SCR','SECR','SER','SR','SWR','WCR') and coach_type='"+coachtype+"' and crnt_mon(assembly_dispatch_date)='"+query_month+"' and crnt_fin_year(assembly_dispatch_date)='"+query_year+"' group by dispatch_rly,month,year, coach_type";
			}
			
			else 
			 {
				 queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly='"+railway+"' and coach_type in('HBC','HUMSAFAR','LDSLR','LSDD','LWACCN','LWACCW','LWCBAC','LWLRRM','LWLRRM-750KV','LWSCN','LWSCZ','LWSCZAC','SLRD','TRC')	and crnt_mon(assembly_dispatch_date)='"+query_month+"' and crnt_fin_year(assembly_dispatch_date)='"+query_year+"' group by dispatch_rly,month,year, coach_type";
			 }
			 
		} 
  		
  	  else
	   { 
			 queryString_new_result="select dispatch_rly , coach_type , count(dispatch_rly) as quantity,crnt_fin_year(assembly_dispatch_date) as year,crnt_mon(assembly_dispatch_date)as month from furnishing_tran where dispatch_rly='"+railway+"' and  coach_type='"+coachtype+"' and crnt_mon(assembly_dispatch_date)='"+query_month+"' and crnt_fin_year(assembly_dispatch_date)='"+query_year+"' group by dispatch_rly,month,year, coach_type";
		}
  		
		
  	System.out.println("final query:"+queryString_new_result);
		 
		
  		
  		
 		 r_new_result = st_new_result.executeQuery(queryString_new_result); 
    	
    	ResultSetMetaData rsmd = r_new_result.getMetaData();
    	String[][] ArrayNew= new String[20][20];
    	int rowcount11=0;
    	int columnsNumber = rsmd.getColumnCount();
    	System.out.println(columnsNumber);
    	while (r_new_result.next()) {
    	    for (int i =1; i <= columnsNumber; i++) {
    	         
    	        //System.out.print(",  ");
    	        
    	      	  String columnValue = r_new_result.getString(i);
    	      	//if(columnValue!=null)  
    	      		ArrayNew[rowcount11][i-1]=columnValue;
    	      	  
    	        }
    	        //System.out.print(columnValue + " " + rsmd.getColumnName(i));
    	    rowcount11++;
    	    }
    	System.out.println(rowcount11);
    	/* for(int i=0;i<rowcount11;i++)
    	{
    		for(int j=0;j<columnsNumber;j++)
    		{
    			System.out.print(ArrayNew[i][j]+",");
    			
    		}
    		System.out.println("");
    		
    	} */
    	int notnullcount=0;
    	 String[] ArrQuant= new String[20];
    	ArrQuant[0]="CR";
    	ArrQuant[1]="ECoR";
    	ArrQuant[2]="ECR";
    	ArrQuant[3]="ER";
    	ArrQuant[4]="NCR";
    	ArrQuant[5]="NER";
    	ArrQuant[6]="NFR";
    	ArrQuant[7]="NR";
    	ArrQuant[8]="NWR";
    	ArrQuant[9]="SCR";
    	ArrQuant[10]="SECR";
    	ArrQuant[11]="SER";
    	ArrQuant[12]="SR";
    	ArrQuant[13]="SWR";
    	ArrQuant[14]="WCR";
    	ArrQuant[15]="WR";
    	int c=0;
    	String[] ArrayCheck= new String[20];
    	for(int i=0;i<16;i++)
    	{
    		for(int j=0;j<rowcount11;j++)
    		{
    			if(ArrayNew[j][0].equals(ArrQuant[i]) && ArrayNew[j][1].equals("2018-2019"))
    			{
    				c=1;
    				//System.out.println(ArrQuant[i]);
    				break;
    			}
    		}
    		if(c==0)
    		{
    			ArrayCheck[i]=ArrQuant[i];
    			//System.out.println(ArrayCheck[i]);
    		}
    		
    		c=0;
    	}
    	
    	int c1=0;
    	String[] ArrayCheck1= new String[20];
    	for(int i=0;i<16;i++)
    	{
    		for(int j=0;j<rowcount11;j++)
    		{
    			if(ArrayNew[j][0].equals(ArrQuant[i]) && ArrayNew[j][1].equals("2019-2020"))
    			{
    				c1=1;
    				//System.out.println(ArrQuant[i]);
    				break;
    			}
    		}
    		if(c1==0)
    		{
    			ArrayCheck1[i]=ArrQuant[i];
    			//System.out.println(ArrayCheck1[i]);
    		}
    		
    		c1=0;
    	}
    	
    	
    	String zero="0";
    	int notnullcount1=0;
    	 for(int i=0;i<16;i++)
    	{
    		System.out.println(ArrayCheck[i]);
    	}
    	 System.out.println(">>>>>>>>>>>>>>>");
    	 for(int i=0;i<16;i++)
     	{
     		System.out.println(ArrayCheck1[i]);
     	}
    	 /*	Integer[] Quant= new Integer[20];
    	
    	 for(int i=0;i<16;i++)
    	{
    		 Quant[i]=0;
    	} 
    	 int l=0;
    	 int j=0;
    	 
    	while(j<16)//no of rows in arrquant
    	{
    		//Quant[j]=0;
    		while(l<rowcount11)
    		{	//
    			
    			if(ArrayNew[l][0].equals(ArrQuant[j]) && ArrayNew[l][3].equals("2018-2019"))
    			{
    				Quant[j]=Quant[j]+(Integer.parseInt(ArrayNew[l][2]));
    				
    				System.out.println("Year:"+ArrayNew[l][3]);
    				
    			}
    			System.out.println(Quant[j]);
    			l++;
    		}
    		//System.out.println(ArrQuant[j]);
    		System.out.println(Quant[j]);
    		j++;
    	}
    	System.out.println(".........................................");
    	 for(int k=0;k<16;k++)
    	{
    		System.out.println(Quant[k]);
    	}
    	 */
    	 String sty1="2018-2019";
    	 String sty2="2019-2018";
    	int totrail=17;
 
    	
    %>
    
    <% 
    if((railway.equals("All Railways")) && (coachtype.equals("ALL Coach Type")) && (query_year.equals("All Years")) && (query_month.equals("All Months")))
    {%>
    	<center><h2 style="margin-top:30px; color:red;">Year-Wise Dispatch summary Report</h2></center>
    	<table border='1' cellpadding='0' cellspacing='0' height=80% width=70% align=center style="margin-top:50px;">
   		<tr><td colspan='<%=totrail%>' style="background-color:#0000A0; color:white; text-align: center;"><b>Dispatch position summary for<%=' '+query_month+'/'+sty1%></b></td></tr>
   		<tr>
   		<td style="color:#0000A0; text-align: center;"><b>Railway</b>
   		</td>
   			<%
   			String finYear=null;
   			String  railway1=null;
   				for(int i=0;i<rowcount11;i++)
   				{
   					finYear=ArrayNew[i][1];
   					if(ArrayNew[i][1].equals("2018-2019"))
   					{
   						railway1=ArrayNew[i][0];
   			%>
   			<td style="color:#0000A0;  text-align: center; ">
   			 <b><%=ArrayNew[i][0]%></b>
  		
   			</td>
   			
   			<% 		
   			}
   					}
   			
   				for(int l=0;l<16;l++)
   				if(ArrayCheck[l]!=null)
   			{	notnullcount++;
   				%>
   				
   				<td style="color:#0000A0;  text-align: center; "><b><%=ArrayCheck[l]%></b></td>
   			<% 	}
  		  
   			%>
   		</tr>
   		<tr>
   		<td style="color:#0000A0; text-align: center; "><b>Coaches Dispatched</b>
   		</td>
   			<%
   		
   			
   			   
   				for(int i=0;i<rowcount11;i++)
   				{
   					if(ArrayNew[i][1].equals("2018-2019"))
   					{
   			%>
   			
   			<td style="color:#0000A0;  text-align: center;" >
   			<a tabindex="1005" href="#"  onclick="openDialog('<%=ArrayNew[i][1]%>','<%=ArrayNew[i][0]%>');"  >
   				<b><%=ArrayNew[i][2]%></b>
   				</a>
   				<span id="dialog" class="dialogclass" style="z-index:9999;"></span>
   			</td>
   			<% 
   					}
   				}
   			%>
   			<% for(int m=0;m<notnullcount;m++)
   			{
   			%>
   			<td style="color:#0000A0;  text-align: center;">
   			<b><%=zero%></b>
   			</td>
   			<% } %>
   		</tr>
   </table> 
   
    <table border='1' cellpadding='0' cellspacing='0' height=80% width=70% align=center style="margin-top:45px;">
   		<tr><td colspan='<%=totrail%>' style="background-color:#0000A0; color:white; text-align: center;"><b>Dispatch position summary for<%=' '+query_month+'/'+sty2%></b></td></tr>
   		<tr>
   		<td style="color:#0000A0; text-align: center;"><b>Railway</b>
   		</td>
   			<%
   			String finYear2=null;
   			String  railway2=null;
   				for(int i=0;i<rowcount11;i++)
   				{
   					if(ArrayNew[i][1].equals("2019-2020"))
   					{
   						railway2=ArrayNew[i][0];
   			%>
   			<td style="color:#0000A0;  text-align: center; ">
   				 <b><%=ArrayNew[i][0]%></b>
   			</td>
   			<% 		
   			}
   					}
   			
   				for(int l=0;l<16;l++)
   				if(ArrayCheck1[l]!=null)
   			{	notnullcount1++;
   				%>
   				
   				<td style="color:#0000A0;  text-align: center; "><b><%=ArrayCheck1[l]%></b></td>
   			<% 	}
  		  
   			%>
   		</tr>
   		<tr>
   		<td style="color:#0000A0; text-align: center; "><b>Coaches Dispatched</b>
   		</td>
   			<%
   				for(int i=0;i<rowcount11;i++)
   				{
   					if(ArrayNew[i][1].equals("2019-2020"))
   					{
   			%>
   			<td style="color:#0000A0;  text-align: center;" >
   			<a tabindex="1005" href="#"  onclick="openDialog('<%=ArrayNew[i][1]%>','<%=ArrayNew[i][0]%>');" >
   			<b><%=ArrayNew[i][2]%></b>
   			</a>
   			<span id="dialog" class="dialogclass" style="z-index:9999;"></span>
   			</td>
   			
   			<% 
   					}
   				}
   			%>
   			<% for(int m=0;m<notnullcount1;m++)
   			{
   			%>
   			<td style="color:#0000A0;  text-align: center;">
   			<b><%=zero%></b>
   			</td>
   			<%} %>
   		</tr>
   </table> 
   
    	
   <%  
   		
    }
    else
    {
    %>
   <table border='1' cellpadding='0' cellspacing='0' height=80% width=70% align=center style="margin-top:100px;">
   		<tr><td colspan='<%=rowcount11+1%>' style="background-color:#0000A0; color:white; text-align: center;"><b>Dispatch position summary for<%=' '+query_month+'/'+query_year%></b></td></tr>
   		<tr>
   		<td style="color:#0000A0; text-align: center;"><b>Railway</b>
   		</td>
   			<%
   				for(int i=0;i<rowcount11;i++)
   				{
   			%>
   			<td style="color:#0000A0;  text-align: center; ">
  			
    		  <b><%=ArrayNew[i][0]%></b>
  		
   			
   			</td>
   			<% 
   				}
   			%>
   		</tr>
   		<tr>
   		<td style="color:#0000A0; text-align: center; "><b>Coaches Dispatched</b>
   		</td>
   			<%
   				for(int i=0;i<rowcount11;i++)
   				{
   			%>
   			<td style="color:#0000A0;  text-align: center;" ><b>
   				<%=ArrayNew[i][2]%></b>
   			</td>
   			<% 
   				}
   			%>
   		</tr>
   </table> 
   	    
   <% 	    
    }

    connection.close();
  }
    catch (Exception ex) 
    {
    	//out.println(ex.printStackTrace());
    out.println("Unable to connect to database.");
    }%>
  
</form>

<script> 
        function printDiv() { 
            
        	var element = document.getElementById('printAll');
        	var opt = {
        	  margin:       1,
        	  filename:     'ReportPdf.pdf',
        	  image:        { type: 'jpeg', quality: 1 },
        	  html2canvas:  { scale: 4 },
        	  jsPDF:        { unit: 'px', format: [1400,800], orientation: 'landscape' }
        	};

        	
        	html2pdf(element, opt);

            
        } 
    </script>

 </div>
 
</body>
</html>