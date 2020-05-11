<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
.error-msg{
   background-color: #FF0000;
}
</style>
<% String contextpath=request.getContextPath();%>

<link href="css/jquery-ui-1.10.3.custom.css" rel="stylesheet"type="text/css" />
<script src="js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>

<script>
// $(document).ready(function() {
// 	$('#fromDate').datepicker({
//         //inline: true,
//         dateFormat: 'dd-mm-yy',
//         changeMonth: true,
//         maxDate: new Date(),
//         changeYear: true,
//         yearRange: '-1:+1',
//         constrainInput: true,
//         duration: '',
//         gotoCurrent: true,

//     }).datepicker("setDate", new Date()); 
// 	$('#toDate').datepicker({
//         //inline: true,
//         dateFormat: 'dd-mm-yy',
//         changeMonth: true,
//         maxDate: new Date(),
//         changeYear: true,
//         yearRange: '-1:+1',
//         constrainInput: true,
//         duration: '',
//         gotoCurrent: true,

//     }).datepicker("setDate", new Date()); 
	

$(document).ready(function() {
    $("#fromDate").datepicker({
        dateFormat: 'dd-mm-yy',
        numberOfMonths: 1,
        onSelect: function(selected) {
            $("#toDate").datepicker("option","minDate", selected)
          }
    });
    $("#toDate").datepicker({
        dateFormat: 'dd-mm-yy',
        numberOfMonths: 1,
        onSelect: function(selected) {
            $("#fromDate").datepicker("option","maxDate", selected)
          }
    });


	
	$( "#buttonId" ).click(function(){
		 $('input').attr('required', true);  
		
		var startDate = new Date($('#fromDate').val());
		var endDate = new Date($('#toDate').val());

		
		
			 $("#errorMessage").html("")
             .removeClass("error-msg");
		var url="<%=contextpath %>/shellDefectReport.jsp?startDate="+$( "#fromDate" ).val()+"&endDate="+$( "#toDate" ).val();
		 $( "#new-pages" ).load(url);
	
	});
	
});

</script>
</head>
<body>
<div id="errorMessage"></div>
<p><b>Select Date Range</b>&nbsp;&nbsp;&nbsp; From Date :&nbsp;&nbsp; <input type ="text" id="fromDate" name="fromDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date :&nbsp;&nbsp; <input type ="text" id="toDate" name="toDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="buttonId" value="Run Report"/></p>
 
<hr />

<div id="new-pages"></div>
</body>
</html>