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
  <div id="issueCoachDispatchMemo" style="height:250px; width:50%; display:none;z-index: 9;" >
  <form name="coach_dispatch_memo">
  <p><b>Issue Coach Dispatch Memo</b></p>
  <table border="1" style="width:100%;">
   <tr>
  <th style="width:12%;">Doc No.</th> <td style="width:22%;"><input style="width:100%;" type="text" name="docNo" id="docNo" class='validate[required]'/></td>
  <th style="width:10%;">Rev No:</th><td style="width:22%;"><input style="width:100%;" type="text" name="revNo" id="revNo"/></td>
  <th style="width:20%;">Date:</th><td style="width:15%;"><input style="width:100%;" type="text" name="docDate" id="docDate" class='validate[required]'/></td>
  </tr>
  
  </table>
  <hr/>
  <table>
   <tr>
  <th style="width:12%;">File No.</th> <td style="width:22%;"><input style="width:100%;" type="text" name="fileNo" id="fileNo" class='validate[required]'/></td>
  </tr>
  <tr>
  <th style="width:10%;">Dispatch Memo No:</th><td style="width:22%;"><input style="width:100%;" type="text" name="dispatchMemoNo" id="dispatchMemoNo" class='validate[required]'/></td>
  </tr>
  <tr>
  <th style="width:20%;">Dispatch Memo Date:</th><td style="width:15%;"><input style="width:100%;" type="text" name="dateOfDispatchMemo" id="dateOfDispatchMemo" class='validate[required]'/></td>
  </tr>
  </table>
  </form>
  </div>
</body>
<script>


var shellArray=[];
var record;


		$(document).ready(function() {
			
			$('#docDate').datepicker({
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
		    }).datepicker("setDate", new Date(2019,0,19));
			$('#dateOfDispatchMemo').datepicker({
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
					    var bogieNumbers=[]; 

				var j=1;
				bogieNumbers[0]={ Value:null, DisplayText: "Select" };
				<c:forEach var="b" items="${bogieNumberList}">
				bogieNumbers[j]={ Value: "${b.key}", DisplayText: "${b.value}" };
					j++;
				    </c:forEach>
				  //end: retrieving axle number in dropdown option
	
						
	$('#FurnishingProductionTableContainer').jtable({
			
			title : 'Issue Dispatch Memo for Coach',
			
			paging:true,
			pageSize: 25,
            sorting: true,
            defaultSorting:'coachNumber ASC',
            selecting: true, //Enable selecting
            multiselect:true, 
            multiSorting: true,
            animationsEnabled : true,
            
            // create toolbar
            toolbar: {
            	items:[
            		{
            			icon: '<%=contextpath%>/images/rs_out.png',
                        text: 'Dispatch Memo Certificate',
                        click: function () {
                        	 var $selectedRows = $('#FurnishingProductionTableContainer').jtable('selectedRows');
                    	 	 if ($selectedRows.length<1)
                    		 alert("Please select a row for which you want to generate Rolling Stock Certificate!!!");
                    	 	 else{
                    	 		var record;
                    	 		var coachNumberArr=[], furnishingAssetIdArr=[],receiptDateAtQualityArr=[];
                    	 		$selectedRows.each(function () {
                                    record = $(this).data('record');
                                    coachNumberArr.push(record.coachNumber);
                                    furnishingAssetIdArr.push(record.furnishingAssetId);
                                    receiptDateAtQualityArr.push(record.receiptDateAtQuality);
                                    });
                    	 		var maxDate = receiptDateAtQualityArr.reduce(function (a, b) { return a > b ? a : b; });
                    	 		
                    	 		 var from=maxDate.substring(0, 10);
                                 
                      		    var numbers = from.match(/\d+/g); 
                         		
                          		var date = new Date(numbers[0], numbers[1]-1, numbers[2]);
                         		
                         		$('#dateOfDispatchMemo').datepicker('option', 'minDate', date);
                         		$('#docNo').val("MCF/RBL/QMF 7017"),
    						    $('#revNo').val("03"),
                    	 	 	$("#issueCoachDispatchMemo").dialog({
                    	 	 		title : 'Coach Dispatch Memo',  
                    	 	 		width: '50%',
                    	 	 		height: ($(window).height() - 60),                   	 	 		
                    	 	 		close: function (e, u) {
              	 		              //$(".formError").remove();
              	 		          	$("#issueCoachDispatchMemo").validationEngine('hideAll');
              	 		         	$('#issueCoachDispatchMemo').find('form[name="coach_dispatch_memo"]')[0].reset();
              	 		     		
              	 		          },
                	 		 	
 		 							buttons: {
	                                    Submit: function () {
	                                    	if ($('#docNo').validationEngine('validate')){
	                                            return false;
	                                        }
              	 		       if ($('#docDate').validationEngine('validate')){
                                   return false;
                               }
              	 		       if ($('#fileNo').validationEngine('validate')){
                                   return false;
                               }
                    	 	 	if ($('#dispatchMemoNo').validationEngine('validate')){
                                    return false;
                                }
                    	 	if ($('#dateOfDispatchMemo').validationEngine('validate')){
                                return false;
                            }


											
	                                    	$.ajax({
	                    						url : "saveDispatchMemoDetails",
	                    						dataType: 'json', 
	                    						data : {
	                    							
	                    							furnishingAssetIdJson: JSON.stringify(furnishingAssetIdArr),
	                    							coachNumberJson: JSON.stringify(coachNumberArr),
	                    							docNo:$('#docNo').val(),
	                    							revNo:$('#revNo').val(),
	                    							docDate:$('#docDate').val(),
	                    							fileNo:$('#fileNo').val(),
	                    							dateOfDispatchMemo: $('#dateOfDispatchMemo').val(),
	                    							
	                    							dispatchMemoNo: $('#dispatchMemoNo').val(),
	                    							
	                    							
	                    							},
	                    						
	                    						type : 'POST',
	                    						async : false,
	                            	 		})
	                    						.done(function( msg ) {
	                    							
	                    							
	                    							$('#docNo').val(''),
	                    							$('#revNo').val(''),
	                    							$('#docDate').val(''),
	                    							$('#fileNo').val(''),
	                    							$('#dateOfDispatchMemo').val(''),
	                    							
	                    							$('#dispatchMemoNo').val(''),
	                    							
	                    							$('#issueCoachDispatchMemo').dialog('close');                   							
	                    							$('#FurnishingProductionTableContainer').jtable('load');
	         								  })
	         								.error(function (msg){
	         									//$('#dialog').dialog('close');
	         									alert("Error Fetching Data");
	         								});
	                                    		    	   return true;
				                                    },
				                        Close: function () {
				                        	 $('#issueCoachDispatchMemo').find('form[name="coach_dispatch_memo"]')[0].reset();
				                        	 $(this).dialog('close');           
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
	
 			listAction: 'availableForIssueDispatchMemoFurnishingAction?stageID=<%=stageID%>',
 			
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
				
				shellAssetId: {
					title: 'Shell No',
					
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
 						width : '7%',
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
						 width : '8%',
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
                      
								
			
					coachNumber: {
						   title: 'Coach No.',
						   width : '8%',
							
							edit : false,
							create: false 
						},
						dispatchRly:
							{
							 title: 'Zone',
							   width : '5%',
								
								edit : false,
								create: false
							},
							
							dispatchDiv:
							{
								 title: 'Dispatch To',
								   width : '8%',
									edit : false,
									create: false,
									display:function(data){
									
										if(data.record.dispatchDiv!=null)
											{
                                            return "Sr. DME/ "+data.record.dispatchDiv ;
											}
									}
								},
						
								rspFlag:
								{
							title: 'R S Certificate',
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
							
				var URL="open-rsp-report?furnishing_asset_id="+furnishingAssetId;
								
				var diagtitle="ROLLING STOCK CERTIFICATE";
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
		</script>