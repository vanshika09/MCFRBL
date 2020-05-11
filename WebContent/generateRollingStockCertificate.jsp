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
<body>
<div id="FurnishingProductionTableContainer"></div>
 <div id="detailDialog" style="height: 200%; width:50%; display:none;z-index: 9;" ></div>
  <div id="rscDialog" style="height:250px; width:50%; display:none;z-index: 9;" >
  <form name="rsc">
  <p><b>Rolling Stock Certificate</b></p>
  <table border="1" style="width:100%;">
   <tr>
  <th style="width:12%;">Doc No.</th> <td style="width:22%;"><input style="width:100%;" type="text" name="docNoRSC" id="docNoRSC" class='validate[required]'/></td>
  <th style="width:10%;">Rev No:</th><td style="width:22%;"><input style="width:100%;" type="text" name="revNoRSC" id="revNoRSC" /></td>
  <th style="width:12%;">Date:</th><td style="width:22%;"><input style="width:100%;" type="text" name="dateOfDocRSC" id="dateOfDocRSC" class='validate[required]'/></td>
  </tr>
  <tr>
  </table>
  <hr/>
  <table>
  <tr>
  <th>Rolling Stock Certificate No: </th><td><input type="text" name="rscNo" id="rscNo" class='validate[required]'/></td></tr>
  <tr>
  <th>Railway Board Order No.</th> <td><input type="text" name="rbOrderNo" id="rbOrderNo" class='validate[required]'/></td>
  </tr>
  <tr>
  <th>Date of Dispatch:</th><td><input type="text" name="dateOfDispatch" id="dateOfDispatch"  class='validate[required]' readonly/></td>
  </tr>
  <tr>
  <th>Booked to: </th>
  <td>Railway:&nbsp;&nbsp;<select name="coachDispatchRly" id="coachDispatchRly" onchange="myFunction(this.value)" class='validate[required]'></select>
  <br>
  Division:&nbsp;&nbsp;<select name="coachDispatchDiv" id="coachDispatchDiv"  class='validate[required]' disabled>
  </select>
  </td>
  </tr>
  <tr>
  <th>Modification (if any)</th><td><textarea name="modificationInCoach" id="modificationInCoach"></textarea></td>
  </tr>
   <tr>
  <th>Deviation (if any)</th><td><textarea name="deviationInCoach" id="deviationInCoach"></textarea></td>
  </tr>
  <tr>
  <th>Item Fitted on the coach on trial: </th><td><select name="trial" id="trial" onchange="trialAddFunction()">
  <option value="">Select</option>
  <option value="Yes">Yes</option>
  <option value="No">No</option>
  </select></td>
  </tr>
  </table>
  <br>
  <div id="trial-add-button" style="dispay:none;">
      <input type="button" class="add-row" value="Add Trial">&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" class="delete-row" value="Delete Trial">      
      <br>
      
      <table border="1" style="width:100%;" id="trialTable">
        <tr>
          <th style="width:20%;">S.No.</th>
          <th></th>
          <th style="width:20%;">Item Particulars</th>
          <th style="width:20%;">Frequency</th>
          <th style="width:20%;">From Date</th>
          <th style="width:20%;">To date</th>
        </tr>
        <tbody></tbody>
       </table>
  </div>
  <!-- If the value of the item fiited on trial is yes, give two button for add and remove row on button click create a table having 
  following column
  S. No.  (running No)
  Item Particulars (Text field)
  Report (Frequency)
  Period of Trial (From Date/ To date)
   -->
  </form>
  </div>
</body>
<script>
/* var assetId; */
function trialAddFunction() {
	
	if(document.getElementById("trial").value=="Yes")
		{
		 $("#trial-add-button").show();
		 
		}
	else
		{
		 $("#trial-add-button").hide();
	
		}
}
/* function DateCheck()
{
  var StartDate= document.getElementById('datepicker1').value;
  var EndDate= document.getElementById('datepicker2').value;
  var eDate = new Date(EndDate);
  var sDate = new Date(StartDate);
  if(StartDate!= '' && StartDate!= '' && sDate> eDate)
    {
    alert("Please ensure that the End Date is greater than or equal to the Start Date.");
    return false;
    }
} */
var shellArray=[];
var record;


		$(document).ready(function() {
			$("#trial-add-button").hide();
			 $(".add-row").click(function() {
           	var srno = document.getElementById('trialTable').rows.length;
           	   var markup="<tr>"+"<td style='width:20%;'>" +srno+ "</td>"+
           	   "<td><input type='hidden'  name='primaryKey' id='primaryKey' value=0></input></td>"+
               "<td style='width:20%;'><input style='width:100%;' type='text' class='toUperCase' name='trialItem' id='trialItem'></input></td>"+
               "<td style='width:20%;'><input style='width:100%;' type='text' class='toUperCase' name='trialFrequency' id= 'trialFrequency'></input></td>"+
               "<td style='width:20%;'><input style='width:100%;' type='text' class='datepicker' name='fromDate"+srno+"' id='fromDate'></input></td>"+
               "<td style='width:20%;'><input style='width:100%;' type='text' class='datepicker' name='toDate"+srno+"' id='toDate'></input></td>"+"</tr>";
               //alert(markup);
               $('#trialTable >tbody:last').append(markup);
               $('[name="fromDate'+srno+'"]').datepicker({
   		        //inline: true,
   		        dateFormat: 'dd-mm-yy',
   		        changeMonth: true,
   		        changeYear: true,
   		        yearRange: '-1:+1',
   		        maxDate: new Date(),
   		        constrainInput: true,
   		        duration: '',
   		        gotoCurrent: true,
   		        beforeShow: function() {
   		            setTimeout(function(){
   		                $('.ui-datepicker').css('z-index', 99999999999999);
   		            }, 0);
   		        }
   		    });
               $('[name="toDate'+srno+'"]').datepicker({
      		        //inline: true,
      		        dateFormat: 'dd-mm-yy',
      		        changeMonth: true,
      		        changeYear: true,
      		        yearRange: '-1:+1',
      		        maxDate: new Date(),
      		        constrainInput: true,
      		        duration: '',
      		        gotoCurrent: true,
      		        beforeShow: function() {
      		            setTimeout(function(){
      		                $('.ui-datepicker').css('z-index', 99999999999999);
      		            }, 0);
      		        }
      		    });
           });
           $(".delete-row").click(function(){
  		   $('#trialTable tr:last').remove();
               });
             
		 // end of add row code
			
			
          
			
			
			
			$('#dateOfDocRSC').datepicker({
		        //inline: true,
		        dateFormat: 'dd-mm-yy',
		        changeMonth: true,
		        changeYear: true,
		        yearRange: '-1:+1',
		        maxDate: new Date(),
		        constrainInput: true,
		        duration: '',
		        gotoCurrent: true,
		        beforeShow: function() {
		            setTimeout(function(){
		                $('.ui-datepicker').css('z-index', 99999999999999);
		            }, 0);
		        }
		    });
			$('#dateOfDispatch').datepicker({
		        //inline: true,
		        dateFormat: 'dd-mm-yy',
		        changeMonth: true,
		        changeYear: true,
		        yearRange: '-1:+1',
		        maxDate: new Date(),
		        constrainInput: true,
		        duration: '',
		        gotoCurrent: true,
		        beforeShow: function() {
		            setTimeout(function(){
		                $('.ui-datepicker').css('z-index', 99999999999999);
		            }, 0);
		        }
		    });
			
			
		
			
			 /* $(document).on('focus',".datePick", function(){
				 $(this).datepicker({                        
				   	 dateFormat: 'dd-mm-yy',
				        changeMonth: true,
				        changeYear: true,
				        yearRange: '-1:+1',
				        maxDate: new Date(),
				        constrainInput: true,
				        duration: '',
				        gotoCurrent: true,
				        beforeShow: function() {
				            setTimeout(function(){
				                $('.ui-datepicker').css('z-index', 99999999999999);
				            }, 0);
				        }                       
				        });
				});  */
			
			$("#coachDispatchRly").append('<option value="">Select</option>');
			<c:forEach var="a" items="${zoneList}">
			var o = new Option("${a}", "${a}");
			$("#coachDispatchRly").append(o);
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
	
						
	$('#FurnishingProductionTableContainer').jtable({
			
			title : 'Issue QCRA for Coach',
			
			paging:true,
            sorting: true,
            defaultSorting:'coachNumber ASC',
            selecting: true, //Enable selecting
            multiselect: false, 
            multiSorting: true,
            animationsEnabled : true,
            
            // create toolbar
            toolbar: {
            	items:[
            		{
            			icon: '<%=contextpath%>/images/rs_out.png',
                        text: 'Rolling Stock Certificate',
                        click: function () {
                        	
                        	 var $selectedRows = $('#FurnishingProductionTableContainer').jtable('selectedRows');
                    	 	 if ($selectedRows.length<1)
                    		 alert("Please select a row for which you want to generate Rolling Stock Certificate!!!");
                    	 	 else{
                    	 		var record;
                    	 		$selectedRows.each(function () {
                                    record = $(this).data('record');
                                    });
                    	 		$.ajax({
            						url : "showExistingDataOfRsc",  //action-name as defined in struts.xml
            						dataType: 'json', 
            						async:false,
            						data : {
            							furnishingAssetId: record.furnishingAssetId,
            						},
            						success:function(data)
            						{
            							
            							$('#docNoRSC').val(data.docNo);
            							$('#revNoRSC').val(data.revNo);
            							if(data.furnishingTransaction.coachDispatchDate!=null)
            							{
        							var date2=(data.furnishingTransaction.coachDispatchDate).substring(0,10);
            							
        							var date2Array=date2.split("-");
        							$('#dateOfDispatch').datepicker("setDate",new Date(date2Array[0],date2Array[1]-1,date2Array[2]));
            							}
            							if(data.rollingStockCertificate!=null)
                							{
            							var date1=(data.rollingStockCertificate.docDate).substring(0,10);
            							var date1Array=date1.split("-");
            							$('#dateOfDocRSC').datepicker("setDate",new Date(date1Array[0],date1Array[1]-1,date1Array[2]));
            							$('#rscNo').val(data.rollingStockCertificate.rscNo);	
            							$('#rbOrderNo').val(data.rollingStockCertificate.orderNo);
                							
            							
            							$('#modificationInCoach').val(data.rollingStockCertificate.rscModification);	
            							$('#deviationInCoach').val(data.rollingStockCertificate.rscDeviation);
                							}
            							$('#coachDispatchRly').val(data.furnishingTransaction.dispatchRly);	
            							$("#coachDispatchDiv").removeAttr('disabled');
            		            		$('#coachDispatchDiv').find('option').remove().end();
            	                        $('#coachDispatchDiv').append('<option value='+data.furnishingTransaction.dispatchDiv+'>'+data.furnishingTransaction.dispatchDiv+'</option>');
            	                        if(data.trialGenerationInRsc!=null)
                	                        {
            	                        if(data.trialGenerationInRsc.length!=0)
            							{
                							
                							$("#trial-add-button").show();
                							$('#trialTable tr').not($('#trialTable tr:first')).remove();
            								         
            								 for ( var i = 1; i <= data.trialGenerationInRsc.length; i++) {
            								 var markup="<tr><td style='width:20%;'> "+i+" </td>"+
            								 "<td><input type='hidden'  name='primaryKey' id='primaryKey' value="+data.trialGenerationInRsc[i].trialGenerationItemId+"></input></td>"+
           								  "<td style='width:20%;'><input style='width:100%;' type='text' class='toUperCase' name='trialItem' id='trialItem' value="+data.trialGenerationInRsc[i].itemParticulars+"></input></td>"+
            								  "<td style='width:20%;'><input style='width:100%;' type='text' class='toUperCase' name='trialFrequency' id='trialFrequency' value="+data.trialGenerationInRsc[i].frequency+"></input></td>"+
            								  "<td style='width:20%;'><input style='width:100%;' type='date' class='datepicker' name='fromDate' id='fromDate' value="+(data.trialGenerationInRsc[i].fromDate).substring(0,10)+"></input></td>"+
            								  "<td style='width:20%;'><input style='width:100%;' type='date' class='datepicker' name='toDate' id='toDate' value="+(data.trialGenerationInRsc[i].toDate).substring(0,10)+"></input></td></tr>";
            								 
             								 $('#trialTable >tbody:last').append(markup);
            								 }
            								 }
            						}
            						}
								});
                    	 		
                    	 	/* $('#datepickerCompletion').datetimepicker('option', 'minDate', new Date(record.dispatchDateForRepair)); */
                    	 	 	$("#rscDialog").dialog({
                    	 	 		title : 'Rolling Stock Certificate for '+search(record.shellTransactionId) + 'from Stage- <%=stageID%>',  
                    	 	 		width: '50%',
                    	 	 		height: ($(window).height() - 60),                   	 	 		
                    	 	 		close: function (e, u) {
              	 		              //$(".formError").remove();
              	 		          	$("#rscDialog").validationEngine('hideAll');
              	 		         	$('#rscDialog').find('form[name="rsc"]')[0].reset();
              	 		     		$("#trial-add-button").hide();
              	 		  			$('#coachDispatchDiv').val('');
              	 		          },
                	 		 	
 		 							buttons: {
	                                    Submit: function () {
	                                    	if ($('#docNoRSC').validationEngine('validate')){
	                                            return false;
	                                        }
              	 		       if ($('#dateOfDocRSC').validationEngine('validate')){
                                   return false;
                               }
              	 		       if ($('#rscNo').validationEngine('validate')){
                                   return false;
                               }
                    	 	 	if ($('#rbOrderNo').validationEngine('validate')){
                                    return false;
                                }
                    	 	if ($('#dateOfDispatch').validationEngine('validate')){
                                return false;
                            }
                    	 	if ($('#coachDispatchRly').validationEngine('validate')){
                                return false;
                            }
                    	 	if ($('#coachDispatchDiv').validationEngine('validate')){
                                return false;
                            }

											var primaryKeyArr=[], itemParticularsArr=[],frequencyArr=[],fromDateArr=[],toDateArr=[];
											$('input[name="primaryKey"]').each(function(){
												primaryKeyArr.push($(this).val());
	                                    		console.log(primaryKeyArr);
	                                    	});
	                                    	$('input[name="trialItem"]').each(function(){
	                                    		itemParticularsArr.push($(this).val());
	                                    		console.log(itemParticularsArr);
	                                    	});	
	                                    	$('input[name="trialFrequency"]').each(function(){
	                                    		frequencyArr.push($(this).val());
	                                    		console.log(frequencyArr);
	                                    	});
	                                    	$('input[id="fromDate"]').each(function(){
	                                    		fromDateArr.push($(this).val());
	                                    		console.log(fromDateArr);
	                                    	});	
	                                    	$('input[id="toDate"]').each(function(){
	                                    		toDateArr.push($(this).val());
	                                    		console.log(toDateArr);
	                                    	});	
	                                    	for(var i=0; i<itemParticularsArr.length;i++)
	                                    	{
		                                    	if(itemParticularsArr[i]=='')
			                                    	{
		                                    		alert("Item Particulars required at row "+ [i+1]);
	                             			   		return false;
			                                    	}
		                                    	if(frequencyArr[i]=='')
		                                    	{
	                                    		alert("Frequency required at row "+ [i+1]);
                             			   		return false;
		                                    	}
		                                    	if(fromDateArr[i]=='')
		                                    	{
	                                    		alert("From Date required at row "+ [i+1]);
                             			   		return false;
		                                    	}
		                                    	if(toDateArr[i]=='')
		                                    	{
	                                    		alert("To Date required at row "+ [i+1]);
                             			   		return false;
		                                    	}
	                                    		var from = fromDateArr[i];
	                             				var to = toDateArr[i]; 
	                             				if(Date.parse(from) > Date.parse(to))
	                             				{
	                             			   		alert("Invalid Date Range at row "+ [i+1]);
	                             			   		return false;
	                             				}
	                             				
	                                    	}
	                                    	if ($('#rscDialog').validationEngine('validate')) {
				                                            return false;
				                                        } 
	                                    	$.ajax({
	                    						url : "saveRollingStockCertificate",
	                    						dataType: 'json', 
	                    						data : {
	                    							
	                    							furnishingAssetId: record.furnishingAssetId,
	                    							docDate:$('#dateOfDocRSC').val(),
	                    							docNoRSC:$('#docNoRSC').val(),
	                    							revNoRSC:$('#revNoRSC').val(),
	                    							rscNo:$('#rscNo').val(),
	                    							orderNo: $('#rbOrderNo').val(),
	                    							coachDispatchDate: $('#dateOfDispatch').val(),
	                    							dispatchRly: $('#coachDispatchRly').val(),
	                    							dispatchDiv: $('#coachDispatchDiv').val(),
	                    							rscModification: $('#modificationInCoach').val(),
	                    							rscDeviation: $('#deviationInCoach').val(),
	                    							primaryKeys: JSON.stringify(primaryKeyArr),
	                    							itemParticulars:JSON.stringify(itemParticularsArr),
	                    							frequency:JSON.stringify(frequencyArr),
	                    							fromDate:JSON.stringify(fromDateArr),
	                    							toDate:JSON.stringify(toDateArr),
	                    							trial:$('#trial').val(),
	                    							},
	                    						
	                    						type : 'POST',
	                    						async : false,
	                            	 		})
	                    						.done(function( msg ) {
	                    							
	                    							
	                    							$('#dateOfDocRSC').val('');
	                    							$('#rscNo').val('');
	                    							$('#rbOrderNo').val('');
	                    							$('#dateOfDispatch').val('');
	                    							$('#coachDispatchRly').val('');
	                    							$('#coachDispatchDiv').val('');
	                    							$('#modificationInCoach').val(''),
	                    							$('#deviationInCoach').val(''),
	                    							$('#trial').val(''),
	                    							$('#rscDialog').dialog('close');                   							
	                    							$('#FurnishingProductionTableContainer').jtable('load');
	         								  })
	         								.error(function (msg){
	         									//$('#dialog').dialog('close');
	         									alert("Error Fetching Data");
	         								});
	                                    	 $("#trial-add-button").hide();
	                                    	 $('#coachDispatchDiv').val('');
					                 			    	   return true;
				                                    },
				                        Close: function () {
				                        	 $('#rscDialog').find('form[name="rsc"]')[0].reset();
				                        	 $(this).dialog('close');           
				                        	 $("#trial-add-button").hide();
				                             $('#coachDispatchDiv').val('');
				                                    }
	                                    },
	                    	        modal: true
    	    });
                   
                    	 	 }	
                    	 		
            			    	   return true;
                    	 		    
                    	 			  
                    	 		  }//ending else               	  
                    	  // ajax call ends here				
    	
            		}
            		]            	
            },
         
			actions : {
	
 			listAction: 'availableForGenerateRSCFurnishingAction?stageID=<%=stageID%>',
 			
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
				furnishingAssetId : {
					title : 'furnishingAssetId',
					width: '8%',
					key: true,
					list : false,
					edit : false,
					create : false
									
					},
					
		
// 					assemblyStartDate: {
// 							title :'Assembly Start Date',
// 							width: '8%',
// 							inputClass: 'validate[required]',
// 							type: 'date',
//  							displayFormat: 'dd-mm-yy',
// 							display:function(data){
												 
// 								return ((data.record.assemblyStartDate!=null) && (data.record.assemblyStartDate!="") ) ? moment(data.record.assemblyStartDate).format('DD-MM-YYYY') : "";
// 													}, 
// 							list: true,
// 							create: false,
// 							edit: false
											
// 							},
							vendorAllotted:{
								title :'Alloted Vendor',
								width: '8%',
								
								list: true,
								create: false,
								edit: false
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
							
				bogiePpSideAssetId: {
							title :'PP side Bogie No.',
 					display:function(data){
	 						var bogieNo;
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
		 							  type: 'post', // performing a POST request
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

				exitRemarkFurnishing: {
				   title: 'Remark given by Furnishing',
				   width : '10%',
					type : 'textarea',
					edit : false,
					create: false 
				},
								
				
				qciTestingDate:
					{
					title: 'QCI Testing Date',
					width: '5%',
					type:'date',
					display:function(data){
						 
						return ((data.record.qciTestingDate!=null) && (data.record.qciTestingDate!="") ) ? moment(data.record.qciTestingDate).format('DD-MM-YYYY') : "";
											}, 
							
					},
					coachNumber: {
						   title: 'Coach No.',
						   width : '10%',
							
							edit : false,
							create: false 
						},
						
								cctvTestingFlag:
								{
							title: 'CCTV SIP Report',
				            width: '3%',
				            edit: false,
				            create: false,	
				            display: function (data) {
				         var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Edit Schedule" />');	
				         $img.click(function () {
				        
				        	var wWidth = $(window).width();
							var dWidth = wWidth * 0.9;
							var wheight = $(window).height();
							var dheight = wheight * 0.9;
							var furnishingAssetId=data.record.furnishingAssetId;
							
				var URL="open-cctv-SIP-report?furnishingAssetId="+furnishingAssetId;
								
				var diagtitle="Final SIP Report";
									$( "#detailDialog" ).load( URL ).dialog({
																			title: diagtitle,
																			modal:true,
																			height:dheight, 
																			width: '40%', 
																			}).prev(".ui-dialog-titlebar").css("background","blue");
						
				        	
				         });
				            	
				            	return $img;	
				            }
								},
								
								plumbingTestingFlag:
								{
							title: 'Plumbing SIP Report',
				            width: '3%',
				            edit: false,
				            create: false,	
				            display: function (data) {
				         var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Edit Schedule" />');	
				         $img.click(function () {
				        
				        	var wWidth = $(window).width();
							var dWidth = wWidth * 0.9;
							var wheight = $(window).height();
							var dheight = wheight * 0.9;
							var furnishingAssetId=data.record.furnishingAssetId;
							
				var URL="open-plumbing-SIP-report?furnishingAssetId="+furnishingAssetId;
								
				var diagtitle="Final SIP Report";
									$( "#detailDialog" ).load( URL ).dialog({
																			title: diagtitle,
																			modal:true,
																			height:dheight, 
																			width: '40%', 
																			}).prev(".ui-dialog-titlebar").css("background","blue");
						
				        	
				         });
				            	
				            	return $img;	
				            }
								},
								
								
								showerTestingFlag:
								{
							title: 'Shower TestingReport',
				            width: '3%',
				            edit: false,
				            create: false,	
				            display: function (data) {
				         var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Edit Schedule" />');	
				         $img.click(function () {
				        
				        	var wWidth = $(window).width();
							var dWidth = wWidth * 0.9;
							var wheight = $(window).height();
							var dheight = wheight * 0.9;
							var furnishingAssetId=data.record.furnishingAssetId;
							
				var URL="open-showertesting-SIP-report?furnishingAssetId="+furnishingAssetId;
								
				var diagtitle="Shower Testing SIP Report";
									$( "#detailDialog" ).load( URL ).dialog({
																			title: diagtitle,
																			modal:true,
																			height:dheight, 
																			width: '40%', 
																			}).prev(".ui-dialog-titlebar").css("background","blue");
						
				        	
				         });
				            	
				            	return $img;	
				            }
								},
								fibaTestingFlag:
								{
							title: 'Fiba Testing Report',
				            width: '3%',
				            edit: false,
				            create: false,	
				            display: function (data) {
				         var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Edit Schedule" />');	
				         $img.click(function () {
				        
				        	var wWidth = $(window).width();
							var dWidth = wWidth * 0.9;
							var wheight = $(window).height();
							var dheight = wheight * 0.9;
							var furnishingAssetId=data.record.furnishingAssetId;
							
				var URL="open-fibatesting-SIP-report?furnishingAssetId="+furnishingAssetId;
								
				var diagtitle="Fiba Testing SIP Report";
									$( "#detailDialog" ).load( URL ).dialog({
																			title: diagtitle,
																			modal:true,
																			height:dheight, 
																			width: '40%', 
																			}).prev(".ui-dialog-titlebar").css("background","blue");
						
				        	
				         });
				            	
				            	return $img;	
				            }
								},
								biotankTestingFlag:
								{
								title: 'BioTank Testing Report',
					            width: '3%',
					            edit: false,
					            create: false,	
					            display: function (data) {
					         var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Edit Schedule" />');	
					         $img.click(function () {
					        
					        	var wWidth = $(window).width();
								var dWidth = wWidth * 0.9;
								var wheight = $(window).height();
								var dheight = wheight * 0.9;
								var furnishingAssetId=data.record.furnishingAssetId;
								
					var URL="open-biotank-SIP-report?furnishingAssetId="+furnishingAssetId;
									
					var diagtitle="Bio Tank Testing SIP Report";
										$( "#detailDialog" ).load( URL ).dialog({
																				title: diagtitle,
																				modal:true,
																				height:dheight, 
																				width: '40%', 
																				}).prev(".ui-dialog-titlebar").css("background","blue");
							
					        	
					         });
					            	
					            	return $img;	
					            }
									},	
									airBrakeTestingFlag:
									{
									title: 'AirBrake Testing Report',
						            width: '3%',
						            edit: false,
						            create: false,	
						            display: function (data) {
						         var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Edit Schedule" />');	
						         $img.click(function () {
						        
						        	var wWidth = $(window).width();
									var dWidth = wWidth * 0.9;
									var wheight = $(window).height();
									var dheight = wheight * 0.9;
									var furnishingAssetId=data.record.furnishingAssetId;
									
						var URL="open-airbrake-SIP-report?furnishingAssetId="+furnishingAssetId;
										
						var diagtitle="Air Brake Testing SIP Report";
											$( "#detailDialog" ).load( URL ).dialog({
																					title: diagtitle,
																					modal:true,
																					height:dheight, 
																					width: '40%', 
																					}).prev(".ui-dialog-titlebar").css("background","blue");
								
						        	
						         });
						            	
						            	return $img;	
						            }
										},	
												
										cbcTestingFlag:
										{
										title: 'CBC Height Testing Report',
							            width: '3%',
							            edit: false,
							            create: false,	
							            display: function (data) {
							         var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Edit Schedule" />');	
							         $img.click(function () {
							        
							        	var wWidth = $(window).width();
										var dWidth = wWidth * 0.9;
										var wheight = $(window).height();
										var dheight = wheight * 0.9;
										var furnishingAssetId=data.record.furnishingAssetId;
										
							var URL="open-buffercbcheight-SIP-report?furnishingAssetId="+furnishingAssetId;
											
							var diagtitle="Buffer/CBC Height Testing SIP Report";
												$( "#detailDialog" ).load( URL ).dialog({
																						title: diagtitle,
																						modal:true,
																						height:dheight, 
																						width: '40%', 
																						}).prev(".ui-dialog-titlebar").css("background","blue");
									
							        	
							         });
							            	
							            	return $img;	
							            }
											},					
									
											fireSmokeTestingFlag:
											{
											title: 'Fire-Smoke Testing Report',
								            width: '3%',
								            edit: false,
								            create: false,	
								            display: function (data) {
								         var $img = $('<img src="<%=contextpath%>/images/schedule_form.png" title="Edit Schedule" />');	
								         $img.click(function () {
								        
								        	var wWidth = $(window).width();
											var dWidth = wWidth * 0.9;
											var wheight = $(window).height();
											var dheight = wheight * 0.9;
											var furnishingAssetId=data.record.furnishingAssetId;
											
								var URL="open-firesomke-SIP-report?furnishingAssetId="+furnishingAssetId;
												
								var diagtitle="Fire, Smoke Detection and Suppression System";
													$( "#detailDialog" ).load( URL ).dialog({
																							title: diagtitle,
																							modal:true,
																							height:dheight, 
																							width: '40%', 
																							}).prev(".ui-dialog-titlebar").css("background","blue");
										
								        	
								         });
								            	
								            	return $img;	
								            }
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
	function myFunction(zone)
	{
		
		var zoneValue = $('#coachDispatchRly').val() ;
		if(zoneValue!="")
			
			{
		$("#coachDispatchDiv").removeAttr('disabled');
		//alert(zoneValue);
		 $.ajax({                    
             url: 'getDiv',    
             type: 'post', // performing a POST request
             async: false,
             
             dataType: 'json',
             data : {
             zone: zoneValue,
               }                    
            })
            .done(function( msg ) {
           
            if(msg.divList!=null)
              {
          
            $('#coachDispatchDiv')
                           .find('option')
                           .remove()
                           .end();

            $('#coachDispatchDiv').append(
                    '<option value="">Select</option>');
                        for ( var i = 0; i < msg.divList.length; i++) {
                       
                        $('#coachDispatchDiv').append(
                        '<option value=' + msg.divList[i] + '>'
                        + msg.divList[i]
                        + '</option>');
                       
                        }
              }
           
             })
            .error(function (msg){
            alert("Error Saving Data");
            })
             ;
                     
               
		
		
		
			}
	}

	</script>