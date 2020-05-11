<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html>
<head>
<% String contextpath=request.getContextPath();%>
<script src="<%=contextpath %>/js/jquery-2.1.4.min.js" type="text/javascript"></script>
<link href="<%=contextpath %>/css/metro/blue/jtable.css" rel="stylesheet" type="text/css" />
<link href="<%=contextpath %>/css/jquery-ui-1.10.3.custom.css" rel="stylesheet"type="text/css" />


<script src="<%=contextpath %>/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
<script src="<%=contextpath %>/js/jquery.jtable.js" type="text/javascript"></script>
<script src="<%=contextpath %>/js/moment.js" type="text/javascript"></script>

<style>

.jtable-input-readonly {
	background-color: lightgray;
}

#overlay{
	/* margin:0px auto;							
	
  display:block; z-index:15;
  width:47px; height:48px;  */
        position: fixed; 
        width: 20%; /* Set your desired with */
        z-index: 2; /* Make sure its above other items. */
        top: 50%;
        left: 50%;
        margin-top: -10%; /* Changes with height. */
        margin-left: -10%; /* Your width divided by 2. */
        /* You will not need the below, its only
           for styling   purposes.*/
        padding: 10px;
        border: 2px solid #555555;
        background-color: #ccc; 
/*        background-color: #4C4CFF; */
}


.hide-calendar .ui-datepicker-calendar {
	display: none;
}
/* button.ui-datepicker-current { display: none; } */
.jtable-child-table-container {
	border: 2px solid blue;
	width: 650px;
}
</style>





<style>
.no-titlebar .ui-dialog-titlebar {
    display: none;
}

.ui-datepicker .ui-datepicker-title select {
    color: #000;
}

.jtable-input-readonly {
	background-color: lightgray;
}

div.jtable-column-header-container {
	height: auto !important;
}

.col1
{
float:left;
padding: 5px 10px 5px 5px;
width: 45%;
}
.col2
{
float:right;
padding: 5px 5px 5px 10px;
width: 45%;
}


#jtable-create-form {
	
	display: block;
	width: 650px;
	
}

#jtable-edit-form {
	display: block;
	width: 650px;
	
}
</style>
<body>
<div id="filter">
<form>
<b>Set Memo Date</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<i>From Date :</i><input type="text" id="datepickerfrom"/>&nbsp;&nbsp;&nbsp;
<i>To Date   :</i><input type="text" id="datepickerto"/>&nbsp;&nbsp;&nbsp;
<button type="submit" id="LoadRecordsButton">Load records</button>
</form>
</div>
<div id="detailDialog" style="height: 200%; width:50%; display:none;z-index: 9;" ></div>
<div id="DispatchMemoTableContainer"></div>

</body>
<script type="text/javascript">
		$(document).ready(function() {
			$('#datepickerfrom').datepicker({       
		        dateFormat: 'dd-mm-yy',
		        changeMonth: true,
		        changeYear: true,
		        yearRange: '-2:+2',
		        constrainInput: false,
		        duration: '',
		        gotoCurrent: true,		        
		    }).datepicker("setDate", "-30");
			$('#datepickerto').datepicker({
		        inline: true,
		        dateFormat: 'dd/mm/yy',
		        changeMonth: true,
		        changeYear: true,
		        yearRange: '-5:+5',
		        constrainInput: false,
		        duration: '',
		        gotoCurrent: true,
		    }).datepicker("setDate", new Date());
			
	
	$('#DispatchMemoTableContainer').jtable({
		title : 'Generate Report for Dispatch Memo',
			
			paging:true,
            sorting: true,
            defaultSorting: 'dispatchMemoDate ASC',
            selecting: false, //Enable selecting
            multiselect: false, 
            multiSorting: true,
            animationsEnabled : true,
     
	actions : {
 			//listAction: 'availableBogieAction',
 			listAction: 'availableDispatchMemoReportAction',
 			  },
			
 			 fields : {
 				
 				sno:{
 					title : 'SNo',
 					create: false,
 					edit : false,
 					width: '3%',
 					display: function(data)
 					{
 						
 						srno++;
 						return srno;
 					}
 				},
 				
 				dispatchMemoId : {
 					title : '',
 					width: '0%',
 					key: true,
 					list : false,
 					edit : false,
 					create : false
 									
 					},
 					
 					docno:{
 							title :'Doc No',
 							width: '15%',
 							list: true,
 							create: false,
 							edit: false		
 							},
 							dispatchMemoDate: {
 		 					   title: 'Memo Date',
 		 					   width : '8%',
 		 					   type: 'date',
 		 					  displayFormat: 'dd-mm-yy',
 		 						edit : false,
 		 						create: false 
 		 					},	
 					
 		 					dispatchMemoFileNo: {
 							title :'File No',
 							width: '8%', 							
 							list: true,
 							create: false,
 							edit: false		
 							},
 							dispatchMemoNo: {
 	 							title :'Memo No',
 	 							width: '6%', 							
 	 							list: true,
 	 							create: false,
 	 							edit: false		
 	 							},
 	 							coachno: {
 	 	 							title :'Coach No',
 	 	 							width: '15%', 							
 	 	 							list: true,
 	 	 							create: false,
 	 	 							edit: false		
 	 	 							},		
 	 	 						coachtype: {
 	 	 	 						title :'Coach Type',
 	 	 	 						width: '15%', 							
 	 	 	 						list: true,
 	 	 	 						create: false,
 	 	 	 						edit: false		
 	 	 	 						},
 	 	 	 					furno: {
 	 	 	 						title :'Furnishing No',
 	 	 	 						width: '15%', 							
 	 	 	 						list: true,
 	 	 	 						create: false,
 	 	 	 						edit: false		
 	 	 	 						},
 	 	 	 					shellno: {
 	 	 	 						title :'Shell No',
 	 	 	 						width: '15%', 							
 	 	 	 						list: true,
 	 	 	 						create: false,
 	 	 	 						edit: false		
 	 	 	 						},
 	 	 	 					report:
								{
							title: 'Report',
		                    width: '3%',
		                    edit: false,
		                    create: false,	
		                    display: function (data) {
		                 var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Dispatch Memo Report" />');	
		                 $img.click(function () {

                        	var wWidth = $(window).width();
                			var dWidth = wWidth * 0.9;
                			var wheight = $(window).height();
                			var dheight = wheight * 0.9;
                			var dispatchMemoId=data.record.dispatchMemoId;
                			
        var URL="open-dispatch-memo-report?dispatchMemoId="+dispatchMemoId;
         					
        var diagtitle="Dispatch Memo Report";
                					$( "#detailDialog" ).load( URL ).dialog({
                															title: diagtitle,
                															modal:true,
                															height:dheight, 
                															width: '60%', 
                															}).prev(".ui-dialog-titlebar").css("background","blue");
                		
                        	
		                 });
		                    	
		                    	return $img;	
		                    }
								},
 					 			},
 			formCreated: function(event, data)
 			{
				$('[id=datepickerfrom]').datepicker({
					
					dateFormat: 'dd-mm-yy',
				    onSelect: function(selected) {
				      $('[id=datepickerto]').datepicker("option","minDate", selected)
 				    }
				}).datepicker("option", "maxDate", new Date);

				$('[id=datepickerto]').datepicker({ 
					
					dateFormat: 'dd-mm-yy',
				    onSelect: function(selected) {
				        $('[id=datepickerfrom]').datepicker("option","maxDate", selected)
					    }
					}); 	
 				
 				
 			},
 			loadingRecords: function(event,data)
 			{
 				srno=0;
 			},
							formSubmitting: function (event, data) {
			             
			            },
			    
				//Dispose validation logic when form is closed
				formClosed: function (event, data) {
			            //    data.form.validationEngine('hide');
			            //    data.form.validationEngine('detach');
				}
	              
			});
	
	 $('#LoadRecordsButton').click(function (e) {
         e.preventDefault();
		
$('#DispatchMemoTableContainer').jtable('load', {datefrom: $('#datepickerfrom').val(),dateto: $('#datepickerto').val()});

	    });
	       $('#LoadRecordsButton').click();

		});
		
		
	</script>
	 
	
	