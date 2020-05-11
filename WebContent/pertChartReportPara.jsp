<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
.error-msg{
   background-color: #FF0000;
}
.ui-datepicker select.ui-datepicker-month,
.ui-datepicker select.ui-datepicker-year {
    color:black!important;
}
</style>
<% String contextpath=request.getContextPath();%>

<link href="css/jquery-ui-1.10.3.custom.css" rel="stylesheet"type="text/css" />
<script src="js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>

<script>
$(document).ready(function() {
	$('#fromDate').datepicker({
        //inline: true,
        dateFormat: 'dd-mm-yy',
        changeMonth: true,
        maxDate: new Date(),
        changeYear: true,
        yearRange: '-2:+1',
        constrainInput: true,
        duration: '',
        gotoCurrent: true,

    }).datepicker("setDate", "-60"); 
	$('#toDate').datepicker({
        //inline: true,
        dateFormat: 'dd-mm-yy',
        changeMonth: true,
        maxDate: new Date(),
        changeYear: true,
        yearRange: '-2:+1',
        constrainInput: true,
        duration: '',
        gotoCurrent: true,

    }).datepicker("setDate", new Date()); 
	
	
	$( "#buttonId" ).click(function(){
		 $('input').attr('required', true);  
		
		var startDate = new Date($('#fromDate').val());
		var endDate = new Date($('#toDate').val());

		if (startDate > endDate){
			 $("#errorMessage").html("From Date should be less than End Date")
             .addClass("error-msg");
	    return false;
		}
		
		var url="<%=contextpath %>/pert-chart-report?StartDate="+$( "#fromDate" ).val()+"&EndDate="+$( "#toDate" ).val();
	 $( "#new-pages" ).load(url);
	});
	
});

</script>
</head>
<body>
<div id="errorMessage"></div>
<p style="margin-left:30px;"><b>Select Date Range:</b>&nbsp;&nbsp;&nbsp; From:&nbsp;&nbsp; <input type ="text" id="fromDate" name="fromDate" readonly/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To:&nbsp;&nbsp; <input type ="text" id="toDate" name="toDate" readonly/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="buttonId" value="Run Report"/>
 <hr/>


<div id="new-pages"></div>
</body>
</html>