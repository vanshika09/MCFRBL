<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.Calendar" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page import="org.hibernate.Criteria" %>
<%@page import="org.hibernate.Session" %>
<%@page import="org.hibernate.criterion.Restrictions" %>
<%@page import="hibernateConnect.HibernateConfig" %>
<%@page import="model.SubStagesMaster" %>
<html>
<head>
<title></title>
<% String contextpath=request.getContextPath();
String stageID= request.getParameter("stageId");
Session session1=HibernateConfig.getSession();
 Criteria cr1=session1.createCriteria(SubStagesMaster.class);
 cr1.add(Restrictions.eq("substageId", stageID));
 SubStagesMaster subStagesMaster =(SubStagesMaster)cr1.list().get(0);

String previousStage=subStagesMaster.getPreviousstageId();   //return either START or some value. Create option only applicable for where the value is START
String nextStages=subStagesMaster.getNextStageId();
 session1.close();
%>

<script src="<%=contextpath %>/js/jquery-2.1.4.min.js" type="text/javascript"></script>
<link href="<%=contextpath %>/css/metro/blue/jtable.css" rel="stylesheet" type="text/css" />
<link href="<%=contextpath %>/css/jquery-ui-1.10.3.custom.css" rel="stylesheet"type="text/css" />


<script src="<%=contextpath %>/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
<script src="<%=contextpath %>/js/jquery.jtable.js" type="text/javascript"></script>
<script src="<%=contextpath %>/js/moment.js" type="text/javascript"></script>

<link href="<%=contextpath %>/js/validationEngine/validationEngine.jquery.css" rel="stylesheet"type="text/css" />

<script src="<%=contextpath %>/js/validationEngine/jquery.validationEngine.js" type="text/javascript"></script>
<script src="<%=contextpath %>/js/validationEngine/jquery.validationEngine-en.js" type="text/javascript"></script>

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
#error_msg {
  color: red;
  text-align: center;
  margin: 10px auto;
}

.form_success span {
  width: 80%;
  height: 35px;
  margin: 3px 10%;
  font-size: 1.1em;
  color: green;
}
.form_success input {
  border: 1px solid green;
}

.disable{
   cursor: not-allowed;
   pointer-events: none;
   background-color: #cccccc;
  color: #666666;
}
</style>

<script>
function checkExist(){
    var xmlhttp = new XMLHttpRequest();
    var coachNumber = $('#coachNumber').val();
   
    var url = "existCoach.jsp?coachNumber=" +coachNumber; 
    xmlhttp.onreadystatechange = function(){
        if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
          
         
  if(xmlhttp.responseText=="false"){
        		
                document.getElementById("isE").style.color = "red";
                document.getElementById("isE").innerHTML="Coach Number already asigned";
                $("#my-button-submit").attr("disabled", true);
                $("#my-button-submit").addClass('disable');
        	}
            else
            	{
            document.getElementById("isE").style.color = "green";
            document.getElementById("isE").innerHTML = xmlhttp.responseText;
            $("#my-button-submit").attr("disabled", false);
            $("#my-button-submit").removeClass('disable');
            }
        }
        
    };
    try{
    xmlhttp.open("GET",url,true);
    xmlhttp.send();
}
    catch(e){alert("unable to connect to server");
}

}
</script>

<body>
<div id="FurnishingProductionTableContainer"></div>
    <div id="exitDialog" style="height:150%; width:200%; display:none;z-index: 9;" >
             Enter Completion Date: <br>
		     <input type="Text" id="datepickerCompletion" class='validate[required]' onchange="setMinDate()"/>
		     <br>
             <br>
		     Enter Dispatch Date for Quality Check: <br>
		     <input type="Text" id="datepickerExit" class='validate[required]' />
		     <br>
		      <br>
		     
		     Remarks: <br>
		     <textarea id="exitRemarks" class='validate[required]'> </textarea>
		     <br>
		       Delay, if any: <br>
		     <textarea id="delayReason" > </textarea>
		     <br>
		     Coach No.: <br>
		     <input type="Text" id="coachNumber" class='validate[required]'  onblur="checkExist()"/><span id="isE"></span>
		 
		   
		    
 </div>
 <div id="detailDialog" style="height:150%; width:200%; display:none;z-index: 9;" ></div>
</body>
<script type="text/javascript">
var shellArray=[];
		$(document).ready(function() {
			
			var prevStage='<%=previousStage%>';
		
			
			var first = new Option("select", null );
			
			$("#coachType").append(first);
			
			<c:forEach var="a" items="${coachType}">
			
			var o = new Option("${a}", "${a}");
		
			$(o).html("${a}");
			$("#coachType").append(o);
			
			
	    </c:forEach>
	    
	    
	   // end of code for bogie type
			//start: retrieving axle number in dropdown option
		    var bogieNumbers=[]; 

			var j=1;
			bogieNumbers[0]={ Value:null, DisplayText: "Select" };
			<c:forEach var="b" items="${bogieNumberList}">
			bogieNumbers[j]={ Value: "${b.key}", DisplayText: "${b.value}" };
				j++;
			    </c:forEach>
			  //end: retrieving axle number in dropdown option
			


// for date picker in dialog box
			$('#datepickerExit').datepicker({
		        //inline: true,
		        dateFormat: 'dd-mm-yy',
		        changeMonth: true,
		        changeYear: true,
		        yearRange: '-1:+1',
		        constrainInput: true,
		        duration: '',
		        gotoCurrent: true,
		        beforeShow: function() {
		            setTimeout(function(){
		                $('.ui-datepicker').css('z-index', 99999999999999);
		            }, 0);
		        }

		    }).datepicker("setDate", new Date());
			
		
			$('#datepickerCompletion').datepicker({
		        //inline: true,
		        dateFormat: 'dd-mm-yy',
		        changeMonth: true,
		        changeYear: true,
		        yearRange: '-1:+1',
		        
		        constrainInput: true,
		        duration: '',
		        gotoCurrent: true,
		        beforeShow: function() {
		            setTimeout(function(){
		                $('.ui-datepicker').css('z-index', 99999999999999);
		            }, 0);
		        }

		    }).datepicker("setDate", new Date());
			    
	$('#FurnishingProductionTableContainer').jtable({
			
			title : 'Furnishing Shop Production',
			
			paging:true,
            sorting: true,
            defaultSorting: 'assemblyStartDate ASC',
            selecting: true, //Enable selecting
            multiselect: false, 
            multiSorting: true,
            animationsEnabled : true,
      //Create toolbat
            toolbar: {
                items: [
                	{
                		
                	//toolbar first item
                    	icon: '<%=contextpath%>/images/rs_out.png',
                        text: 'Add Activity For Furnishing Shop',
                        click: function () {
                        	
                        	 var $selectedRows = $('#FurnishingProductionTableContainer').jtable('selectedRows');
                    	 	 if ($selectedRows.length<1)
                    		 alert("Please select a row for which you want to add activity");
                    	 	 else{
                    	 		var record;
                    	 		$selectedRows.each(function () {
                                    record = $(this).data('record');
                                    });
                    	 		if(record.bogiePpSideAssetId==null)
                    	 			{
                    	 			alert("PP Side Bogie Cannot be Empty");
                    	 			return false;
                    	 			}
                    	 		if(record.bogieNppSideAssetId==null)
                	 			{
                    	 			alert("NPP Side Bogie Cannot be Empty");
                	 			return false;
                	 			}
                        	var wWidth = $(window).width();
                			var dWidth = wWidth * 0.9;
                			var wheight = $(window).height();
                			var dheight = wheight * 0.9;
                			var furnishingAssetId=record.furnishingAssetId;
                		
                			var substageId='<%=stageID%>';
                				
                					var URL="add_activity_for_shell_stage?furnishingAssetId="+furnishingAssetId+"&substageId="+substageId;
                					var diagtitle="Add Activity for Furnishing Shop";
                					
                					$( "#detailDialog" ).load( URL ).dialog({
                															title: diagtitle,
                															modal:true,
                															height: dheight, 
                															width: dWidth, 
                															}).prev(".ui-dialog-titlebar").css("background","blue");
                			
                        	
                        	
                        	
                        	
                        	
                    	 	 }
    						 
                        }
                    },
                    //End of first toolbar item
                	           	 {
                		
                	//Second toolbar entry
                    	icon: '<%=contextpath%>/images/rs_out.png',
                        text: 'Add Component for Furnishing',
                        click: function () {
                        	
                        	 var $selectedRows = $('#FurnishingProductionTableContainer').jtable('selectedRows');
                    	 	 if ($selectedRows.length<1)
                    		 alert("Please select a row for which you want to add Component");
                    	 	 else{
                    	 		var record;
                    	 		$selectedRows.each(function () {
                                    record = $(this).data('record');
                                    });
                    	 		if(record.bogiePpSideAssetId==null)
                	 			{
                	 			alert("PP Side Bogie Cannot be Empty");
                	 			return false;
                	 			}
                	 		if(record.bogieNppSideAssetId==null)
            	 			{
                	 			alert("NPP Side Bogie Cannot be Empty");
            	 			return false;
            	 			}
                        	var wWidth = $(window).width();
                			var dWidth = wWidth * 0.6;
                			var wheight = $(window).height();
                			var dheight = wheight * 0.9;
                			var furnishingAssetId=record.furnishingAssetId;
                			var shellAssetId=record.shellAssetId;
                			var coachType=record.coachType;
                				
                					var URL="add_component_for_furnishing_shop?assetId="+furnishingAssetId+"&coachType="+coachType;
                					var diagtitle="Add Component for Shell No ="+search(shellAssetId);
                					
                					$( "#detailDialog" ).load( URL ).dialog({
                															title: diagtitle,
                															modal:true,
                															height: dheight, 
                															width: dWidth,
                															closeOnEscape:true,
                															close: function () {
                										                        	
                							                                        $(this).dialog('close');
                							                                        //$('#BogiesetProductionTableContainer').jtable('reload');
                							                                    }
                			 		 								  
                				                                    
                															}).prev(".ui-dialog-titlebar").css("background","blue");
                		                    	 	 }
    						 
                        }
                    },
                	
                	//Second Toolbar item for Exit/ Turnout
                  
                	{
                    	icon: '<%=contextpath%>/images/rs_out.png',
                        text: 'Sent for Quality Check',
                        click: function () {
                        	
                        	 var $selectedRows = $('#FurnishingProductionTableContainer').jtable('selectedRows');
                    	 	 if ($selectedRows.length<1)
                    		 alert("Please select a row for which you want to Sent for Quality Check");
                    	 	 else{
                    	 		var record;
                    	 		$selectedRows.each(function () {
                                    record = $(this).data('record');
                                    });
                    	 		if(record.bogiePpSideAssetId==null)
                	 			{
                	 			alert("PP Side Bogie Cannot be Empty");
                	 			return false;
                	 			}
                	 		if(record.bogieNppSideAssetId==null)
            	 			{
                	 			alert("NPP Side Bogie Cannot be Empty");
            	 			return false;
            	 			}
                                  //alert(moment(record.assemblyStartDate).format('DD-MM-YYYY'));
                                  var startDate=(record.assemblyStartDate).substring(0,10);
                                  
                                  
                                  var num = startDate.match(/\d+/g); 
                          		
                          		var date = new Date(num[0], num[1]-1, num[2]);
                             
                                  $('#datepickerCompletion').datepicker('option', 'minDate', date);
                    	 		
                    	 	 	$("#exitDialog").dialog({
                    	 	 		title : 'Exit for  '+record.bogiesetTrxId + 'from Stage- <%=stageID%>',                     	 	 		
                    	 	 		close: function (e, u) {
              	 		              //$(".formError").remove();
              	 		          	$("#exitDialog").validationEngine('hideAll');
                    	 	 		    },
                	 		 	
 		 							buttons: {
 		 								Submit: {
 	                                        text: "Submit",
 	                                        id: "my-button-submit",
 	                                        click:function () {
	                                  
	                                    	if ($('#datepickerExit').validationEngine('validate')) {
				                                        	
				                                            return false;
				                                        }
	                                    	if ($('#datepickerCompletion').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                            if ($('#exitRemarks').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                            if ($('#coachNumber').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
	                                    	var c=confirm("Verify data before dispatch, You cant not edit after dispatch");
	                                    	if(c==false){return false;}	    	   
	                                    	$.ajax({
	                    						url : "exitForQualityCheck",  //action-name as defined in struts.xml
	                    						dataType: 'json', 
	                    						data : {
	                    							furnishingAssetId: record.furnishingAssetId,
	                    							stageId: '<%=stageID%>',
	                    						    dispatchDate: $('#datepickerExit').val(),
	                    						    assemblyEndDate: $('#datepickerCompletion').val(),
	                    							exitRemark:$('#exitRemarks').val(),
	                    							lateReason:$('#delayReason').val(),
	                    							coachNumber:$('#coachNumber').val(),
	                    							
	                    					
	                    						},
	                    						
	                    						type : 'POST',
	                    						async : false,
	                            	 		})
	                    						.done(function( msg ) {
	                    							
	                    							$('#datepickerExit').val(''),
	                    							$('#datepickerCompletion').val(''),
	                    							
	                    							$('#exitRemarks').val(''),
	                    							$('#delayReason').val(''),
	                    							$('#coachNumber').val(''),
	                    							
	                    							$('#exitDialog').dialog('close');
	                    							
	                    							$('#FurnishingProductionTableContainer').jtable('load');
	         								  })
	         								.error(function (msg){
	         									//$('#dialog').dialog('close');
	         									alert("Error Fetching Data");
	         								})
	         								  ;
					                 			    return true;
 	                                        }    },
				                        Close: function () {
				                        	
				                                        $(this).dialog('close');
				                                    }
 		 								  },
	                                    modal: true
 		 				    	    });
 		 				                    	 		
 		 				                    	 		
 		 				                    	 		
 		 				                    	 		
 		 				                    	 		
 		 				                    	 		    
 		 				            			    	   return true;
 		 				                    	 		    
 		 				                    	 			  
 		 				                    	 		  }//ending else               	  
 		 				                    	  // ajax call ends here				
 		 				    						 
 		 				                        
                        }     
                    	} ,
                	
                	
                	
                	
                	
                	
                	
                	
                	
                	
                	
                	
                	
                	//  old version of code                	
                	<%-- {
                    	icon: '<%=contextpath%>/images/rs_out.png',
                        text: 'Exit/ Turnout',
                        click: function () {
                        	
                        	 var $selectedRows = $('#FurnishingProductionTableContainer').jtable('selectedRows');
                    	 	 if ($selectedRows.length<1)
                    		 alert("Please select a row for which you want to Dispatch for turnout Shop");
                    	 	 else{
                    	 		var record;
                    	 		$selectedRows.each(function () {
                                    record = $(this).data('record');
                                    });
                                  //alert(moment(record.assemblyStartDate).format('DD-MM-YYYY'));
                                  var startDate=(record.assemblyStartDate).substring(0,10);
                                  
                                  
                                  var num = startDate.match(/\d+/g); 
                          		
                          		var date = new Date(num[0], num[1]-1, num[2]);
                             
                                  $('#datepickerCompletion').datepicker('option', 'minDate', date);
                    	 		
                    	 	 	$("#exitDialog").dialog({
                    	 	 		title : 'Exit for  '+record.bogiesetTrxId + 'from Stage- <%=stageID%>',                     	 	 		
                    	 	 		close: function (e, u) {
              	 		              //$(".formError").remove();
              	 		          	$("#exitDialog").validationEngine('hideAll');
                    	 	 		    },
                	 		 	
 		 							buttons: {
 		 								Submit: {
 	                                        text: "Submit",
 	                                        id: "my-button-submit",
 	                                        click:function () {
	                                  
	                                    	if ($('#datepickerExit').validationEngine('validate')) {
				                                        	
				                                            return false;
				                                        }
	                                    	if ($('#datepickerCompletion').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                            if ($('#exitRemarks').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
	                                    	
	                                    	if ($('#coachNumber').validationEngine('validate')) {
	                                        
	                                            return false;
	                                        }
	                                    	var c=confirm("Verify data before dispatch, You cant not edit after dispatch");
	                                    	if(c==false){return false;}	    	   
	                                    	$.ajax({
	                    						url : "exitFurnish",  //action-name as defined in struts.xml
	                    						dataType: 'json', 
	                    						data : {
	                    							furnishingAssetId: record.furnishingAssetId,
	                    							stageId: '<%=stageID%>',
	                    						    dispatchDate: $('#datepickerExit').val(),
	                    						    assemblyEndDate: $('#datepickerCompletion').val(),
	                    							exitRemark:$('#exitRemarks').val(),
	                    							lateReason:$('#delayReason').val(),
	                    							coachNumber:$('#coachNumber').val(),
	                    							coachType:$('#coachType').val(),
	                    					
	                    						},
	                    						
	                    						type : 'POST',
	                    						async : false,
	                            	 		})
	                    						.done(function( msg ) {
	                    							
	                    							$('#datepickerExit').val(''),
	                    							$('#datepickerCompletion').val(''),
	                    							
	                    							$('#exitRemarks').val(''),
	                    							$('#delayReason').val(''),
	                    							$('#coachNumber').val(''),
	                    							$('#coachType').val(''),
	                    							$('#exitDialog').dialog('close');
	                    							
	                    							$('#FurnishingProductionTableContainer').jtable('load');
	         								  })
	         								.error(function (msg){
	         									//$('#dialog').dialog('close');
	         									alert("Error Fetching Data");
	         								})
	         								  ;
					                 			    return true;
 	                                        }    },
				                        Close: function () {
				                        	
				                                        $(this).dialog('close');
				                                    }
 		 								  },
	                                    modal: true
 		 				    	    });
 		 				                    	 		
 		 				                    	 		
 		 				                    	 		
 		 				                    	 		
 		 				                    	 		
 		 				                    	 		    
 		 				            			    	   return true;
 		 				                    	 		    
 		 				                    	 			  
 		 				                    	 		  }//ending else               	  
 		 				                    	  // ajax call ends here				
 		 				    						 
 		 				                        
                        }     
                    	}  --%>
                    // end of old version of code
 		 				            ]
 		 				            },
            
			actions : {
	
 			listAction: 'listFurnishingAction?stageID=<%=stageID%>',
 			updateAction:'updateFurnishingAction?stageID=<%=stageID%>'
 						},
			
			fields : {
				
				sno:{
					title : 'SNo',
					create: false,
					edit : false,
					width: '5%',
					display: function(data)
					{
						
						srno++;
						return srno;
					}
				},
				furnishingAssetId : {
					title : 'furnishingAssetId',
					width: '8%',
					key: true,
					list : true,
					edit : false,
					create : false
									
					},
				shellAssetId: {
					title: 'Shell No',
					width: '20%',
					display:function(data){
 						//var shellNo;
 						var shell={};
 						shell.assetId=data.record.shellAssetId;
 						$.ajax({                    
 							  //url: 'descByshellFromIdinPaintShop', 
 							   url: 'descByshellFromId', 
 							  type: 'post', // performing a POST request
 							  async: false,
							  
 							  dataType: 'json',
 								  data : {
									
 									 shellAssetId: data.record.shellAssetId
 								  	  }									                    
 						})
 								.done(function( msg ) {
 								//	shellNo=msg.shellNo;
 								shell.assetNo=msg.shellNo;
								shellArray.push(shell);
									
 									//return msg.stageName;																			    											
 								  })
 								.error(function (msg){
 									alert("Error Saving Data");
 								})
 								  ;
						
						
 						//return shellNo;
 						return shell.assetNo;
 						},
 						create: false,
 						width : '20%',
 						list: true,
 						edit : false
 					},
 					shellType: {
 						title :'Shell Type',
 						width: '8%',
 						list: true,
 						create: false,
 						edit: false		
 						},		
 						coachType:
						{
						title: 'Coach Type',
						 width : '10%',
						list: true,
						edit : false,
					     create: false 
						},
				
					assemblyDispatchDate: {
						   title: 'Dispatched from Shell',
						   width : '10%',
						  
						  display:function(data){
							  
		 						var assemblyDispatchDatefromShell;
								
		 						$.ajax({                    
		 							  url: 'assemblyDispatchDatefromShell',     
		 							  type: 'post', // performing a POST request
		 							  async: false,
									  
		 							  dataType: 'json',
		 								  data : {
											  shellAssetId: data.record.shellAssetId
		 								  	  }									                    
		 						})
		 								.done(function( msg ) {
		 									assemblyDispatchDatefromShell=msg.assemblyDispatchDatefromShell;
											
		 									//return msg.stageName;																			    											
		 								  })
		 								.error(function (msg){
		 									alert("Error Saving Data");
		 								})
		 								  ;
								
								return ((assemblyDispatchDatefromShell!=null) && (assemblyDispatchDatefromShell!="") ) ? moment(assemblyDispatchDatefromShell).format('DD-MM-YYYY') : "";

		 						},
							create: false,
							edit: false
							},
		
					assemblyStartDate: {
							title :'Assembly Start Date',
							width: '8%',
							inputClass: 'validate[required]',
							type: 'date',
 							displayFormat: 'dd-mm-yy',
							display:function(data){
												 
								return ((data.record.assemblyStartDate!=null) && (data.record.assemblyStartDate!="") ) ? moment(data.record.assemblyStartDate).format('DD-MM-YYYY') : "";
													}, 
							list: true,
							create: false,
							edit: false
											
							},
							vendorAllotted:{
								title :'Alloted Vendor',
								width: '8%',
								options: {"":"select","Hindustan Fiber Ltd.":"Hindustan Fiber Ltd.", 
									"Century (Varodara)":"Century (Varodara)", "CMT":"CMT", "Dhan Laxmi":"Dhan Laxmi", "ACME (New Delhi)":"ACME (New Delhi)",
									"Mahadev":"Mahadev", "AB Composite":"AB Composite", "Satabdi":"Satabdi", "Kinecco":"Kinecco",
									"OVPL":"OVPL", "Vibgyor":"Vibgyor"},
								list: true,
								create: true,
								edit: true
								},
								vendorAllottedDate:
									{
									title :'Alloted Date',
									width: '8%',
									//inputClass: 'validate[required]',
		 							type: 'date',
		 							displayFormat: 'dd-mm-yy',
									display:function(data){
										//alert(data.record.id.hodyCode)	;				 
										return ((data.record.vendorAllottedDate!=null) && (data.record.vendorAllottedDate!="") ) ? moment(data.record.vendorAllottedDate).format('DD-MM-YYYY') : "";
															}, 
														
													
									list: true,
									create: true,
									edit: true
									
									},
					//left bogie display purpose	
							
				bogiePpSideAssetId:{
							title :'PP side Bogie No.',
 					display:function(data){
	 						var bogieNo;
	 						if(data.record.bogiePpSideAssetId!=null)
							{
	 						
	 						$.ajax({                    
	 							  url: 'descByBogieId',     
	 							  type: 'POST', // performing a POST request
	 							  async: false,
								  
	 							  dataType:'json',
	 								  data : {
										
	 									 bogieAssetId:data.record.bogiePpSideAssetId
	 								  	  }									                    
	 						})
	 								.done(function( msg ) {
	 									bogieNo=msg.bogieNo;
										
	 									//return msg.stageName;																			    											
	 								  })
	 								.error(function (msg){
	 									alert("Error retireving Data");
	 								})
	 								  ;
							
							}
	 						return bogieNo;
	 						},
							
							
							list:true,
							create: false,
							edit: false
							},
							//left bogie update and create purpose		
					  bogiePpSideAssetId1: {
						title :'PP Side Bogie No.',
						width: '8%',

						options: bogieNumbers,
						list: false,
						create: true,
						edit: true		
						}, 
					//Non PP SIde Bogie display	
						bogieNppSideAssetId: {
							title :'N-PP side Bogie No.',
							list:true,
							display:function(data){
		 						var bogieNo;
		 						if(data.record.bogieNppSideAssetId!=null)
								{
		 						$.ajax({                    
		 							  url: 'descByBogieId',     
		 							  type: 'POST', // performing a POST request
		 							  async: false,
									  
		 							  dataType: 'json',
		 								  data : {
											
		 									 bogieAssetId:data.record.bogieNppSideAssetId
		 								  	  }									                    
		 						})
		 								.done(function( msg ) {
		 									bogieNo=msg.bogieNo;
											
		 									//return msg.stageName;																			    											
		 								  })
		 								.error(function (msg){
		 									alert("Error Saving Data");
		 								})
		 								  ;
								}
								
		 						return bogieNo;
		 						},
							create: false,
							edit: false
							},
					//right wheel update and create purpose
 					bogieNppSideAssetId1: {
 					title :'N-PP Side Bogie No.',
						width: '8%',
 			          options: bogieNumbers,
 						list: false,
						create: true,
 						edit: true		
							},
							coachLoweringDate:
								{
								title :'Coach Lowering Date',
								width: '8%',
								type: 'date',
								display:function(data){
													 
									return ((data.record.coachLoweringDate!=null) && (data.record.coachLoweringDate!="") ) ? moment(data.record.coachLoweringDate).format('DD-MM-YYYY') : "";
														}, 
		 											
								inputClass: 'validate[required]',
								list: true,
								create: true,
								edit: true
                             
								},
							expectedExitDate: {
								title :'Expected Exit Date',
								width: '8%',
								type: 'date',
								display:function(data){
													 
									return ((data.record.expectedExitDate!=null) && (data.record.expectedExitDate!="") ) ? moment(data.record.expectedExitDate).format('DD-MM-YYYY') : "";
														}, 
		 											
								inputClass: 'validate[required]',
								list: true,
								create: true,
								edit: true
												
								},
								productionBy: {
									   title: 'Production By',
									   width : '10%',
										options : { 'InHouse': 'In House', 'FromTrade': 'From Trade' },
										edit : true,
										create: true 
									},			
													
						
				
				
				remarks: {
				   title: 'Remarks',
				   width : '10%',
					type : 'textarea',
					edit : true,
					create: true 
				},
								

                        
			},
			loadingRecords: function(event,data)
			{
				srno=0;
			},
			recordsLoaded: function(event, data) {
	
				 /*  if (prevStage!='START'){
					 
				     $('#FurnishingProductionTableContainer').find('.jtable-toolbar-item.jtable-toolbar-item-add-record').remove();
				  } */
				  
				},
				formCreated: function (event, data) {
					  
				var startDate=(data.record.assemblyStartDate).substring(0,10);
				
                    var num = startDate.match(/\d+/g); 
             		var date = new Date(num[0], num[1]-1, num[2]);
					 $('[name=expectedExitDate]').datepicker("option","minDate", date)	;	
					 $('[name=vendorAllottedDate]').datepicker("option","minDate", date)	;
 				
					  $("[name=bogiePpSideAssetId1]").on('change', 
								function() {
						
						  var ppBogieAssetId=$("[name=bogiePpSideAssetId1]").val();
						  
						  $("[name=bogieNppSideAssetId1]").find('[value='+ppBogieAssetId+']').remove();
						  
					  });
					  
					  data.form.validationEngine();
					  
					  
					  $("[name=bogieNppSideAssetId1]").on('change', 
								function() {
						  
						  var nppBogieAssetId=$("[name=bogieNppSideAssetId1]").val();
						  
						  $("[name=bogiePpSideAssetId1]").find('[value='+nppBogieAssetId+']').remove();
						  
					  });
					
				
					if(data.formType=='edit')
						{
						var ppBogieNo, nppbogieNo;
						
						
						if(data.record.bogiePpSideAssetId!=null)
						{
 						$.ajax({                    
 							  url: 'descByBogieId',     
 							  type: 'post', // performing a POST request
 							  async: false,
							  
 							  dataType: 'json',
 								  data : {
									
 									 bogieAssetId: data.record.bogiePpSideAssetId
 								  	  }									                    
 						})
 								.done(function( msg ) {
 									ppBogieNo=msg.bogieNo;
									
 									//return msg.stageName;																			    											
 								  })
 								.error(function (msg){
 									alert("Error Saving Data");
 								})
 								  ;
 						$('#Edit-bogiePpSideAssetId1')
 				         .append($("<option selected></option>")
 				                    .attr("value",data.record.bogiePpSideAssetId)
 				                    .text(ppBogieNo));
 						
						}
						
					
					
					//right wheel dropdown
					
					if(data.record.bogieNppSideAssetId!=null)
						{
					
					$.ajax({                    
						  url: 'descByBogieId',     
						  type: 'post', // performing a POST request
						  async: false,
						  
						  dataType: 'json',
							  data : {
								
								  bogieAssetId: data.record.bogieNppSideAssetId
							  	  }									                    
					})
							.done(function( msg ) {
								nppbogieNo=msg.bogieNo;
								
								//return msg.stageName;																			    											
							  })
							.error(function (msg){
								alert("Error Saving Data");
							})
							  ;
					
					$('#Edit-bogieNppSideAssetId1')
			         .append($("<option selected></option>")
			                    .attr("value",data.record.bogieNppSideAssetId)
			                    .text(nppbogieNo));
					
						}
						}
	               	            },
	            recordDeleted: function(event,data)
	    		{
	    			srno=0;
	    			$('#FurnishingProductionTableContainer').jtable('load');
	    		},
	    		
 
					//Validate form when it is being submitted
				formSubmitting: function (event, data) {
			   return data.form.validationEngine('validate');
			             
			            },
			    
				//Dispose validation logic when form is closed
				formClosed: function (event, data) {
			               data.form.validationEngine('hide');
			                data.form.validationEngine('detach');
				},
				recordUpdated:function(event,data)
				{
					srno=0;
					$('#FurnishingProductionTableContainer').jtable('load');
				},
	              
			});
	$('#FurnishingProductionTableContainer').jtable('load');
		});
	
	</script>
	
	<script>
	
	function search(id)
	{
		//alert("am called, id="+id +""+JSON.stringify(shellArray));
		for(var i=0;i<shellArray.length;i++){
			
			if(shellArray[i].assetId==id)
				{
				//alert( shellArray[i].assetNo);
					return shellArray[i].assetNo;
				}
				
			}
		}
	function setMinDate(){
	
		var from = $('#datepickerCompletion').val(); 
		var numbers = from.match(/\d+/g); 
		
		var date = new Date(numbers[2], numbers[1]-1, numbers[0]);
		
		$('#datepickerExit').datepicker('option', 'minDate', date);
	}
	
	</script>
	<script>
// 	function findObjectByKey(array, key, value) {
// 	    for (var i = 0; i < array.length; i++) {
// 	        if (array[i][key] == value) {
// 	            return array[i];
// 	        }
// 	    }
// 	    return null;
// 	}
	
	</script>