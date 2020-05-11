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

<body>
<div id="ShellProductionTableContainer"></div>
    <div id="sidewallSIPDialog" style="height:150%; width:600px; display:none;z-index: 9;overflow-x: hidden;border:1px solid grey;padding:15px;margin-top:5px;" >
    <form name="sidewallSip">
<h3 align="center">SELF INSPECTION PROFARMA</h3>
<h3 align="center">SIDE WALL</h3> 
<table style="width:96%;">
<tr>
<th style="width:16%;">Doc No</th><td style="width:16%;"><input type="text" name="sidewallSipDocNo" id="sidewallSipDocNo" class='validate[required]'></td><!-- <td></td><td></td><td></td><td></td> -->
</tr>
<tr>
<th style="width:16%;">Shift</th><td style="width:16%;"><select name="" style="width:50%;" id="sidewallSipShift" class='validate[required]'>
<option value="">Select</option>
<option value="general">General</option>
<option value="morning">Shift-I</option>
<option value="evening">Shift-II</option>
<option value="night">Shift-III</option>
</select></td>
<th style="width:16%;">&nbsp;Date of Testing</th><td style="width:16%;"><input type="text" style="width:96%;" name="sidewallSipDate" id="sidewallSipDate" class='validate[required]'></td>
</tr>
<tr>
<th style="width:16%;">Side Wall Type (LH/RH/Both)</th><td style="width:16%;"><select style="width:50%;" id="sidewallType">
<option value="">Select</option>
<option value="LH">LH</option>
<option value="RH">RH</option>
<option value="Both">Both</option>
</select></td>
<th style="width:16%;">&nbsp;Shell No</th><td><input type="text" name="sidewallShellNo" style="width:96%;" id="sidewallShellNo" readonly/></td>
<th style="width:16%;">&nbsp;Shell Type</th><td><input type="text" name="sidewallShellType" style="width:96%;" id="sidewallShellType" readonly/></td>

</tr>
</table>
<br>
<table border="1" style="width:99%;">
<tr>
<th style="width:33%;text-align:center;">Activity</th>
<th style="width:33%;text-align:center;">Done by MCF/contractor/robotic machine/manual welding/B.O.</th>
<th style="width:33%;text-align:center;">Jig no./robotic station(LH/RH)/B.O.</th>
</tr>
<tr>
<th style="width:33%;">Frame done</th>
<td><input class="txt" style="width:100%;" type="text" name="frameworkby" id="frameWorkBy"></td>
<td><input class="txt" style="width:100%;" type="text" name="framejigroboticsbo" id="frameJigRoboticsBo"></td>
</tr>
<tr>
<th style="width:33%;">Spot welding done</th>
<td><input class="txt" style="width:100%;" type="text" name="spotweldingby" id="spotWeldingBy"></td>
<td><input class="txt" style="width:100%;"type="text" name="spotweldingjigroboticsbo" id="spotWeldingJigRoboticsBo"></td>
</tr>
<tr>
<th style="width:33%;">Interlocking joint welding done</th>
<td><input class="txt" style="width:100%;" type="text" name="interlockjointby" id="interlockJointBy"></td>
<td><input class="txt" style="width:100%;" type="text" name="interlockjointjigroboticsbo" id="interlockJointJigRoboticsBo"></td>
</tr>
</table>
<br>
<b>Applicability:</b>
<table style="width:100%;">
<tr><td style="width:73%;">&nbsp;&nbsp;&nbsp;1.1   Applicable Drawing No.</td><td style="width:27%;"><input type="text" name="ApplicableDrawingNo" id="sideWallDrawingNo"></td></tr>
<tr><td style="width:73%;">&nbsp;&nbsp;&nbsp;1.2   Applicable W.I No.(If Any)</td><td style="width:27%;"><input type="text" name="ApplicableWINo" id="sideWallWiNo"></td></tr>
</table>

<br>

<b>Data of Traceability:</b>
<table style="width:99%;">
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.1   Side Wall Car line make</td>
<td style="width:33%;">(LHside):<input type="text" name="LHside" id="sidewallCarlineMakeLh"></td>
<td style="width:33%;">(RHside):<input type="text" name="RHside" id="sidewallCarlineMakeRh"></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.2   Side Wall complete make and no</td>
<td style="width:33%;">(LHside):<input type="text" name="sidewallMakeLh" id="sidewallMakeLh" placeholder="Enter Complete Make"></td>
<td style="width:33%;">(RHside):<input type="text" name="sidewallMakeRh" id="sidewallMakeRh" placeholder="Enter Complete Make"></td>
</tr>
<tr>
<td style="width:33%;"></td>
<td style="width:33%;">(LHside):<input type="text" name="sidewallNoLh" id="sidewallNoLh" placeholder="Enter Complete No"></td>
<td style="width:33%;">(RHside):<input type="text" name="sidewallNoRh" id="sidewallNoRh" placeholder="Enter Complete No"></td>
</tr>
</table>

<br>

<b>Observation:</b>
<table  style="width:100%;">
<tr style="width:100%;">
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.1   Items fitted as per Drawing</td>
<td style="width:27%;"><input type="radio" name="option1" value="ok" id="observationItemAsPerDrawingFlag">OK
<input type="radio" name="option1" value="notok"id="observationItemAsPerDrawingFlag">NOT OK
<input type="radio" name="option1" value="na" id="observationItemAsPerDrawingFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.2   Compliance of applicable W.I</td>
<td style="width:27%;"><input type="radio" name="option3" value="ok" id="observationComplianceWiFlag">OK
<input type="radio" name="option3" value="notok" id="observationComplianceWiFlag">NOT OK
<input type="radio" name="option3" value="na" id="observationComplianceWiFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.3   Welding throat and length as per drawing</td>
<td style="width:27%;"><input type="radio" name="option4" value="ok" id="observationWeldingThoatLengthFlag">OK
<input type="radio" name="option4" value="notok" id="observationWeldingThoatLengthFlag">NOT OK
<input type="radio" name="option4" value="na" id="observationWeldingThoatLengthFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.4   Sheet joint laser welding(visually)</td>
<td style="width:27%;"><input type="radio" name="option5" value="ok" id="observationSheetJointLaserFlag">OK
<input type="radio" name="option5" value="notok" id="observationSheetJointLaserFlag">NOT OK
<input type="radio" name="option5" value="na" id="observationSheetJointLaserFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.5   Side wall sheet torquing before framing work specified-80NM,</td>
<td style="width:27%;"><input type="text" name="option6" id="observationSidewallSheetTorque" class='validate[custom[integer]]'>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.6   side wall frame work as per drg.</td>
<td style="width:27%;"><input type="radio" name="option7" value="ok" id="observationSidewallFrameWorkFlag">OK
<input type="radio" name="option7" value="notok" id="observationSidewallFrameWorkFlag">NOT OK
<input type="radio" name="option7" value="na" id="observationSidewallFrameWorkFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.7   condition of spot Welding/Manual butt welding of side wall sheet with member</td>
<td style="width:27%;"><input type="radio" name="option8" value="ok" id="observationSidewallConditionSpotWeldingFlag">OK
<input type="radio" name="option8" value="notok" id="observationSidewallConditionSpotWeldingFlag">NOT OK
<input type="radio" name="option8" value="na" id="observationSidewallConditionSpotWeldingFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.8   Horizontal and vertical member joint welding(Robotics/Manual)</td>
<td style="width:27%;"><input type="radio" name="option9" value="ok" id="observationHorizontalVerticalJointWeldingFlag">OK
<input type="radio" name="option9" value="notok" id="observationHorizontalVerticalJointWeldingFlag">NOT OK
<input type="radio" name="option9" value="na" id="observationHorizontalVerticalJointWeldingFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.9   Roof flange joint level</td>
<td style="width:27%;"><input type="radio" name="option10" value="ok" id="observationRoofFlangeJointFlag">OK
<input type="radio" name="option10" value="notok" id="observationRoofFlangeJointFlag">NOT OK
<input type="radio" name="option10" value="na" id="observationRoofFlangeJointFlag">NA</td>
</tr>
</table>


<p>&nbsp;&nbsp;&nbsp;3.10  side wall complete sheet lenght.</p>
<table border="1" style="width:95%;margin-left:10px;">
<tr>
<th style="width:5%;text-align:center;">S.No</th>
<th style="width:20.5%;text-align:center;">Type</th>
<th style="width:22.5%;text-align:center;">Specified value</th>
<th style="width:47%;text-align:center;" colspan="2" text-align:center;">Observed value</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">1</th>
<th style="width:20.5%;">LWACCN/LWACCW/ LWSCN/LWFAC</th>
<th style="width:22.5%;">18128#+22</th>
<th style="width:22.5%;">LH side</th>
<th style="width:24.5%;">RH side</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">2</th>
<th style="width:20.5%;">LGS</th>
<th style="width:22.5%;">8496#+13</th>
<td style="width:22.5%;" rowspan="6" Style="width:7%; text-align:center;"><input style="width:100%;" class="txt" type="text" name="lhside" id="sidewallSheetLengthLh" class='validate[custom[integer]]' placeholder="ObservationLH" width="100%"> </td>
<td style="width:24.5%;" rowspan="6" Style="width:7%; text-align:center;"><input style="width:100%;" class="txt" type="text" name="rhside" id="sidewallSheetLengthRh" class='validate[custom[integer]]' placeholder="ObservationRH" width="100%"></td>
</tr>
<tr>
<th style="width:5%;text-align:center;">3</th>
<th style="width:20.5%;">LWLRRM</th>
<th style="width:22.5%;">17471#+20.8</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">4</th>
<th style="width:20.5%;">TRC/TRS</th>
<th style="width:22.5%;">17373#+20.8</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">5</th>
<th style="width:20.5%;">LDSLR</th>
<th style="width:22.5%;">9511#+6,3495#+4, 2260#+12</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">6</th>
<th style="width:20.5%;">LBC</th>
<th style="width:22.5%;">18128#+26</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">7</th>
<th style="width:20.5%;">LWSCZ(Non AC)</th>
<th style="width:22.5%;">18128#+22.2</th>
</tr>
</table>
<br>
<table style="width:100%;">
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.11   Side wall sheet width(specified-1995(+2#))</td>
<td style="width:27%;"><input type="text" name="swsw" id="sidewallSheetWidth" class='validate[custom[integer]]'></td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.12   side wall height from vertical to roof flange top.(specified-1963+2#)</td>
<td style="width:27%;"><input type="text" name="swhfvmtrft" id="sidewallHeightVerticalmemberRoofflange" class='validate[custom[integer]]'></td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.13   Condition of spot welding/manual butt welding of Car line sheet with Car line arch.</td>
<td style="width:27%;">
<input type="radio" name="option11" value="ok" id="spotWeldingCarlinearchFlag">OK
<input type="radio" name="option11" value="notok" id="spotWeldingCarlinearchFlag">NOT OK
<input type="radio" name="option11" value="na" id="spotWeldingCarlinearchFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.14   Brazing work done Carline with side wall sheet from(outside/Manipulator).</td>
<td style="width:27%;">
<input type="radio" name="option12" value="ok" id="brazingCarlineSidewallFlag">OK
<input type="radio" name="option12" value="notok" id="brazingCarlineSidewallFlag">NOT OK
<input type="radio" name="option12" value="na" id="brazingCarlineSidewallFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.15   condition of window profile</td>
<td style="width:27%;">
<input type="radio" name="option13" value="ok" id="windowProfileFlag">OK
<input type="radio" name="option13" value="notok" id="windowProfileFlag">NOT OK
<input type="radio" name="option13" value="na" id="windowProfileFlag">NA</td>
</tr>
</table>

<p>&nbsp;&nbsp;&nbsp;3.16   Pull Box distance</p>
<table border="1" style="width:95%;margin-left:10px;">
<tr>
<th style="width:5%;text-align:center;">S.NO.</th>
<th style="width:20.5%;text-align:center;">Type</th>
<th style="width:45%;text-align:center;" colspan="2">Specified Value</th>
<th style="width:24.5%;text-align:center;">Observerd Value</th>
</tr>
<tr>
<th style="width:5%;text-align:center;" rowspan="2">1</th>
<th style="width:20.5%;" rowspan="2">LWACCW</th>
<th style="width:22.5%;">PPside</th>
<th style="width:22.5%;">From centre-348,1900x3.1725</th>
<td style="width:24.5%;" rowspan="5"><input class="txt" style="width:100%;" type="text" name="observed4" id="pullBoxDistance"  placeholder="Pull Box" ></td>
</tr>
<tr>
<th style="width:22.5%;">NPP to PP side</th>
<th style="width:22.5%;">From center 1552,1900x3</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">2</th>
<th style="width:20.5%;">LWACCN</th>
<th style="width:22.5%;">NPP to PP side</th>
<th style="width:22.5%;">1172.1830x8</th>
</tr>
<tr>
<th style="width:5%;text-align:center;" rowspan="2">3</th>
<th style="width:20.5%;" rowspan="2">LBC</th>
<th style="width:22.5%;">PP side</th>
<th style="width:22.5%;">From centre-348,7672</th>
</tr>
<tr>
<th style="width:22.5%;">NPP side</th>
<th style="width:22.5%;">From centre-4547,8108</th>
</tr>
</table>
<br>
<table style="width:100%;">
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.17   Window seal joint leakage test (LGS/LSCN)</td>
<td style="width:27%;"><input type="radio" name="option14" value="done" id="windowSealLeakageFlag">DONE
<input type="radio" name="option14" value="nodone" id="windowSealLeakageFlag">NOT DONE</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.18   Window sealing angle elevation as per drg.(LSCN/LGS)</td>
<td style="width:27%;"><input type="radio" name="option15" value="ok" id="windowSealAngleFlag">OK
<input type="radio" name="option15" value="notok"id="windowSealAngleFlag">NOT OK
<input type="radio" name="option15" value="na" id="windowSealAngleFlag">NA</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.19   Distance between Car line top to vertical member bottom(specified-2383+2#)</td>
<td style="width:27%;"><input type="text"name="distance" id="distanceCarlinetopVerticalmember" class='validate[custom[integer]]'></td>
</tr>
</table>

<p>&nbsp;&nbsp;&nbsp;3.20   complete length of side wall car line</p>
<table border="1" style="width:95%;margin-left:10px;">
<tr>
<th style="width:5%;text-align:center;">S.NO.</th>
<th style="width:19.5%;text-align:center;">Type</th>
<th style="width:21.5%;text-align:center;">Specified value</th>
<th style="width:48%;text-align:center;" colspan="2">observed value</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">1</th>
<th style="width:19.5%;">LWACCN</th>
<th style="width:21.5%;">17160#+14</th>
<th style="width:23.5%;">LH side</th>
<th style="width:25.5%;">RH side</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">2</th>
<th style="width:19.5%;">LWACCN</th>
<th style="width:22.5%;">18140#+16</th>
<th style="width:23.5%;" rowspan="9"><input class="txt" style="width:100%;" type="text" name="observed5"  id="lengthSidewallCarlineLh" class='validate[custom[integer]]' placeholder="Observation LH"></th>
<th style="width:25.5%;" rowspan="9"><input class="txt" style="width:100%;" type="text" name="observed6" id="lengthSidewallCarlineRh" class='validate[custom[integer]]' placeholder="Observation RH"></th>
</tr>
<tr>
<th style="width:5%;text-align:center;">3</th>
<th style="width:19.5%;">LWSCN</th>
<th style="width:21.5%;">18100#+14</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">4</th>
<th style="width:19.5%;">LGS</th>
<th style="width:21.5%;">8496#+13</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">5</th>
<th style="width:19.5%;">LWLRRM</th>
<th style="width:21.5%;">17463#+10</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">6</th>
<th style="width:19.5%;">TRC/TRS</th>
<th style="width:21.5%;">17297.8#+10</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">7</th>
<th style="width:19.5%;">LDSLR</th>
<th style="width:21.5%;">5091#+15,3502#+2,2110#+2</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">8</th>
<th style="width:19.5%;">LBC</th>
<th style="width:21.5%;">17806#+23.5</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">9</th>
<th style="width:19.5%;">LWSCZ(Non AC)</th>
<th style="width:21.5%;">18116+2</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">10</th>
<th style="width:19.5%;">LWFAC</th>
<th style="width:21.5%;">18146#+8</th>
</tr>
</table>
<br>
<table>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.21   Car line joint leakage test</td>
<td style="width:27%;"><input type="radio" name="option16" value="nodone"id="carlineLeakageFlag">NOT DONE
<input type="radio" name="option16" value="done"id="carlineLeakageFlag">DONE</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.22   Horizontal and vertical member welding joint grinding work</td>
<td style="width:27%;"><input type="radio" name="option17" value="nodone"id=" horizontalVerticalWeldingGrindingFlag">NOT DONE
<input type="radio" name="option17" value="done" id="horizontalVerticalWeldingGrindingFlag">DONE</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.23   Distance of Back piece from vertical member for fixing partion frame(LGS/LSCN)</td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transverse side (Specified-511,911,1322,1772/409,527,784,1821)</td>
<td style="width:27%;"><input type="text" name="transverseside" id="distanceBackpieceVerticalmemberTransverse"></td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Single side (Specified-805,1225/572,1072,1439,1552)</td>
<td style="width:27%;"><input type="text" name="singleside" id="distanceBackpieceVerticalmemberSingle"></td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.24   Roof flange complete length for LPC(17625 mm)</td>
<td style="width:27%;"><input type="text" name="rf" id="roofFlangeLength" class='validate[custom[integer]]'></td>
</tr>
<tr>
<td style="width:73%;">&nbsp;&nbsp;&nbsp;3.25   Width of hatched door for LPC (1692mm and 1292mm)</td>
<td style="width:27%;"><input type="text" name="width" id="widthHatchedDoor" class='validate[custom[integer]]'></td>
</tr>
</table>

<p>&nbsp;&nbsp;&nbsp;3.26   Berth channel assembly distance from vertical channel</p>
<table border="1" style="width:95%;margin-left:10px;">
<tr>
<th style="width:20%;text-align:center;">Description</th>
<th style="width:52%;text-align:center;">Specified value</th>
<th style="width:43%;text-align:center;">Observed</th>
</tr>
<tr>
<th style="width:20%;text-align:center;">Lower(LH)</th>
<th style="width:52%;"><p>LWACCW - 307<br>LWACCN - 307<br>LWFAC - 307<br>LWFACC - 307</p></th>
<td style="width:43%;"><input class="txt" type="text" name="observedLowerLH" id="distanceBerthchannelVerticalchannelLowerLh" class='validate[custom[integer]]' placeholder="Lower LH" style="width:100%;"></td>
</tr>
<tr>
<th style="width:20%;text-align:center;">Middle(LH)</th>
<th style="width:52%;"><p>LWACCN - 1078</p></th>
<td style="width:43%;"><input class="txt" type="text" name="observedMiddleLH" id="distanceBerthchannelVerticalchannelMiddleLh" class='validate[custom[integer]]' placeholder="Middle LH" style="width:100%;"></td>
</tr>
<tr>
<th style="width:20%;text-align:center;">Upper(LH)</th>
<th style="width:52%;"><p>LWACCW - 1377<br>LWACCN - 1744<br>LWFAC - 1340/1840<br>LWFACC - 1362,1768</p></th>
<td style="width:43%;"><input class="txt" type="text" name="observedUpperLH" id="distanceBerthchannelVerticalchannelUpperLh" class='validate[custom[integer]]' placeholder="Upper LH" style="width:100%;"></td>
</tr>
<tr>
<th style="width:20%;text-align:center;">Lower(RH)</th>
<th style="width:52%;"><p>LWACCW - 307<br>LWACCN - 307<br>LWFAC - <br>LWAFACC - 307</p></th>
<td style="width:43%;"><input class="txt" type="text" name="observedLowerRH" id="distanceBerthchannelVerticalchannelLowerRh" class='validate[custom[integer]]' placeholder="Lower RH" style="width:100%;"></td>
</tr>
<tr>
<th style="width:20%;text-align:center;">Upper(RH)</th>
<th style="width:52%;"><p>LWACCW - 1362<br>LWACCN - 1372<br>LWFAC - <br>LWAFACC - 1362</p></th>
<td style="width:43%;"><input class="txt" type="text" name="observedUpperRH" id="distanceBerthchannelVerticalchannelUpperRh" class='validate[custom[integer]]' placeholder="Upper LH" style="width:100%;"></td>
</tr>
</table>
<br>
<table style="width:100%;">
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;3.27   Distance from window center line to angle for window support for wider window in</td>
<td style="width:29.5%;"><input type="text" name="distance" id="distanceWindowcenterAnglewindowsupport" class='validate[custom[integer]]'></td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Non AC shell</td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Specified value - 170mm/170mm(LH/RH)</td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;3.28   Distance from window edge to channel for window fixing support for wider window in</td>
<td style="width:29.5%;"><input type="text" name="distance1" id="distanceWindowedgeChannel" class='validate[custom[integer]]'></td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in Non AC shell</td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Specified  value - 126mm/126mm(TOP/bottom)</td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;3.29   Height of Car line complete specified value-417mm</td>
<td style="width:29.5%;"><input type="text" name="height" id="heightCarline" class='validate[custom[integer]]'></td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;3.30   Complete length of small car line in(LWSCZ(Non AC))specified value -1142mm</td>
<td style="width:29.5%;"><input type="text" name="length" id="lengthSmallcarline" class='validate[custom[integer]]'></td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;3.31   Mounting angle for lower luggage rack bkt height from bottom of side wall</td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (in LGS without PRT )</td>
</tr>
<tr>
<td style="width:71.5%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; specified value -1333mm</td>
<td style="width:29.5%;"><input type="text" name="heightfrombottomofsidewall" id="angleLowerluggageBottomsidewall" class='validate[custom[integer]]'></td>
</tr>
</table>

<table style="width:100%;">
<tr>
<td style="width:60%;">&nbsp;&nbsp;&nbsp;3.32   Distance between angle for honey com  PRT to side wall bottom in</td>
<td style="width:20%;">LSCN(without PRT in shell shop)</td>
</tr>
<tr>
<td style="width:60%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Specified value -465,430,360,640(both end near door side)</td>
<td style="width:20%;"><input type="text" name="distance2"id="distanceAnglehoneyprtSidewallDoorside1" class='validate[custom[integer]]' style="width:100%;"></td>
<td style="width:20%;"><input type="text" name="distance4"id="distanceAnglehoneyprtSidewallDoorside2" class='validate[custom[integer]]' style="width:100%;"></td>
</tr>
<tr>
<td style="width:60%;"></td>
<td style="width:20%;"><input type="text" name="distance5"id="distanceAnglehoneyprtSidewallDoorside3" class='validate[custom[integer]]' style="width:100%;"></td>
<td style="width:20%;"><input type="text" name="distance6"id="distanceAnglehoneyprtSidewallDoorside4" class='validate[custom[integer]]' style="width:100%;"></td>
</tr>
<tr>
<td style="width:60%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Specified value -469,348,360,720(in middle area)</td>
<td style="width:20%;"><input type="text" name="distance3" id="distanceAnglehoneyprtSidewallMiddlearea1" class='validate[custom[integer]]' style="width:100%;"></td>
<td style="width:20%;"><input type="text" name="distance3" id="distanceAnglehoneyprtSidewallMiddlearea2" class='validate[custom[integer]]' style="width:100%;">
</td>
<tr>
<td style="width:60%;"></td>
<td style="width:20%;"><input type="text" name="distance3" id="distanceAnglehoneyprtSidewallMiddlearea3" class='validate[custom[integer]]' style="width:100%;"></td>
<td style="width:20%;"><input type="text" name="distance3" id="distanceAnglehoneyprtSidewallMiddlearea4" class='validate[custom[integer]]' style="width:100%;"></td>
</tr>
</table>

<b>Details</b>

<table style="width:100%;">
<tr>
<td style="width:60%;">&nbsp;&nbsp;&nbsp;4.1   Details of modification carried out (if any):</td>
<td style="width:40%;"><input type="text" name="sideWallDetailsOfModification" id="sideWallDetailsOfModification" style="width:100%;"></td>
</tr>
<tr>
<td style="width:60%;">&nbsp;&nbsp;&nbsp;4.2   Details of trial items fitted(if any):</td>
<td style="width:40%;"><input type="text" name="sideWallDetailsOfTrialItem" id="sideWallDetailsOfTrialItem" style="width:100%;"></td>
</tr>
<tr>
<td style="width:60%;">&nbsp;&nbsp;&nbsp;4.3   Remarks(if any)</td>
<td style="width:40%;"><textarea name="sideWallRemarks" id="sideWallRemarks" style="width:100%;"></textarea></td>
</tr>
</table>
<br>
<p align="center"><b>Side wall Testing Status</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="shellSidewallTestingStatus" id="shellSidewallTestingStatus" class='validate[required]'>
<option value="">Select</option>
<option value="Conforming">Conforming</option>
<option value="Not Conforming">Not Conforming</option>
</select></p>
</form>
 </div>
 
 
 
 
  <div id="RoofSIPDialog" style="height:150%; width:200%; display:none;z-index: 9;overflow-x: hidden;border:1px solid grey;padding:5px;margin-top:5px;" >
    <form name="roofSIP">
<h3 align="center">SELF INSPECTION PROFARMA</h3>
<h3 align="center">Roof</h3> 
<table style="width:100%;margin-left:30px;">
<tr>
<th style="width:15%;">Doc No</th><td style="width:35%;"><input type="text" style="width:60%;" name="roofSipDocNo" id="roofSipDocNo" ></td>
</tr>
<tr>
<th style="width:15%;">Shift</th><td style="width:35%;"><select name="" style="width:25%;" id="roofSipShift">
<option value="">Select</option>
<option value="general">General</option>
<option value="morning">Shift-I</option>
<option value="evening">Shift-II</option>
<option value="night">Shift-III</option>
<option value="">Select</option>
</select></td>
<th style="width:20%;">Date of Testing</th><td style="width:30%;"><input type="text" name="roofSipDate" id="roofSipDate" style="width:60%;"></td>
</tr>
<tr><th style="width:15%;"> Roof Type</th><td style="width:35%;"><input style="width:60%;" type=text id="roofType" class="validate[required]"></td></tr>
<tr><th style="width:15%;"> Roof make</th><td style="width:35%;"><input style="width:60%;" type= text id="roofMake" class='validate[required]'></td></tr>
<tr><th style="width:15%;"> Roof no.</th><td style="width:35%;"><input style="width:60%;" type= text id="roofNo" class='validate[required]'></td></tr>
</table>
<br>
<b style="margin-left:25px;">1. Applicablility:</b> 
<table style="width:100%;margin-left:35px;">
<tr><td style="width:5%;">1.1</td><td style="width:64%;">Applicable Drawing No:</td><td style="width:31%;"><input type=text id="roofApplicableDrawingNo" ></tr>
<tr><td style="width:5%;">1.2</td><td style="width:64%;">Applicable WI NO(if Any):</td><td style="width:31%;"><input type= text id="roofApplicableWiNo"></td></tr>
</table>
<br>
<b style="margin-left:25px;">2. Data of Traceability </b>
<table style="width:100%;margin-left:35px;">
<tr>
<td style="width:5%;">2.1</td>
<td style="width:34%;">Machine used for spot weilding </td>
<td style="width:30%;"><input type=radio id="machineSpotWeild"  name="machineSpotWeild" value="CNCSpotWeilding">CNC Spot Welding</td> 
<td style="width:31%;"><input type=radio id="machineSpotWeild" name="machineSpotWeild" value="ManualButtWeilding">Manual Butt Weilding</td>
</tr>
</table>
<br>
<b style="margin-left:25px;">3. Observations:</b>
<table style="width:100%;margin-left:35px;"> 
<tr><td style="width:5%;">3.1</td><td style="width:64%;">Items Fitted as per Drawing</td><td style="width:31%;"><input type=radio id="observationItemAsPerDrawing" name="observationItemAsPerDrawing" value="ok">OK &nbsp;<input type=radio id="observationItemAsPerDrawing" name="observationItemAsPerDrawing" value="notok">NOT OK &nbsp;<input type= radio id="observationItemAsPerDrawing" name="observationItemAsPerDrawing" value="na"> NA</td></tr>
<tr><td style="width:5%;">3.2</td><td style="width:64%;">Compliance of applicable WI</td><td style="width:31%;"><input type=radio id="observationComplianceWi" name="observationComplianceWi" value="ok">OK &nbsp;<input type=radio id="observationComplianceWi" name="observationComplianceWi" value="notok">NOT OK &nbsp;<input type= radio id="observationComplianceWi" name="observationComplianceWi" value="na"> NA</td></tr>
<tr><td style="width:5%;">3.3</td><td style="width:64%;">Welding throat & length as per drawing</td><td style="width:31%;"> <input type=radio id="observationWeildingThroatLength" name="observationWeildingThroatLength" value="ok">OK &nbsp;<input type=radio id="observationWeildingThroatLength" name="observationWeildingThroatLength" value="notok">NOT OK &nbsp;<input type= radio id="observationWeildingThroatLength" name="observationWeildingThroatLength" value="na"> NA </td></tr>
<tr><td style="width:5%;">3.4</td><td style="width:64%;">Checked Dimensions As per Table</td></tr>
</table>
<table border="1" style="width:95%;margin-left:25px;">
<tr>
<th style="width:5%;text-align:center;">S.No.</th>
<th style="width:65%;text-align:center;">Parameter</th>
<th style="width:25%;text-align:center;">Observation</th>
</tr>
<tr>
<td style="width:5%;text-align:center;">
1
</td>
<td style="width:65%;">
Total length of roof complete
{For LWACCN 17160#+14,LWACCW18210#+14,LCSN/LGS/-20360#+18,
LWLRRM-19247#+14,TRC/TRS-19247#+28,LDSLR-20360#+14,
LBAC-18154#+14,LWSCZ(Non AC)-20360#+15}
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="lengthRoof" class='validate[custom[integer]]' placeholder="roof length">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
2
</td>
<td style="width:65%;">
Length of roof sheet
{For LWACCN 17140#+14,LWACCW18190#+14,LCSN/LGS20320}#+18,
with tray LWLRRM-19215#+14,TRC/TRS-19215#+28,LDSLR-14766.5
(from NPP to tray area)#+14/627.5#+7.0(from PP to tray area),
LBAC-18126#+28,LWSCZ(Non AC)-20320#+28
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="lengthRoofsheet" class='validate[custom[integer]]' placeholder="roof sheet length">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
3
</td>
<td style="width:65%;">
Width of roof complete
{For LWACCN -2786,LWACCW-2798,LCSN/LGS/LWSCZ(Non AC)-2790,
LWLRRM-2798,TRC/TRS-27988,LDSLR-2784,LBAC-2798}
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id=widthRoofsheet class='validate[custom[integer]]' placeholder="roof sheet width">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
4
</td>
<td style="width:65%;">
Roof arch position from center(towards PP side)
{For LWACCN 613,LWACCW432.7,LCSN745,LGS134.5}#+0.5,
LWLRRM95.5,TRC-22#+.5,TRS-415#+0.5,LDSLR-231.7#+0.5,
LBAC-265#+0.5,LWSCZ(Non AC)-307.3(+0.5#)
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="roofArchPositionPp" class='validate[custom[integer]]' placeholder="roof arch pp">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
5
</td>
<td style="width:65%;">
Roof arch position from center(towards NPP side)
{For LWACCN 549,LWACCW633,LCSN751,LGS548}#+0.5,
LWLRRM-235,TRC-128#+0.5,TRS-197.6#+0.5,LDSLR-480.3#+0.5,
LBAC-417#+0.5,LWSCZ(Non AC)-303.7(+0.5#)
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="roofArchPositionNpp" class='validate[custom[integer]]' placeholder="roof arch npp">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
6
</td>
<td style="width:65%;">
Final roof arch complete (PP side) from center of coach
{For LWACCN 8580,LWACCW9073,LCSN/LGS10150}#+0.5,
LWLRRM-10140,TRC-10152#+9.5,TRS-10140#+9.5,LDSLR-10150#+5.0,
LBAC-9073#+7,LWSCZ(Non AC)-10150(+7.5#)
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="roofArchCompletePp" class='validate[custom[integer]]' placeholder="roof arch complete pp">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
7
</td>
<td style="width:65%;">
Final roof arch complete (NPP side) from center of coach
{For LWACCN 8580,LWACCW9073,LCSN/LGS10150}#+0.5,
LWLRRM-9073,TRC-9063#+8.5,TRS-9077#+9.5,LDSLR-10150#+9.0,
LBAC-9073#+7,LWSCZ(Non AC)-10150(+7.5#)
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="roofArchCompleteNpp" class='validate[custom[integer]]' placeholder="roof arch complete npp">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
8
</td>
<td style="width:65%;">
Cross brace height(roof center to top)
{For LWACCN 319,LWACCW301,TRC/TRS301}#+0.5
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="crossBraceHeight" class='validate[custom[integer]]' placeholder="cross brace height">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
9
</td>
<td style="width:65%;">
Roof arch width
{For LWACCN,LWACCW,LCSN/LGS/LWSCZ(Non AC)-2765-10#,
LWLRRM-2765,TRC/TRS2765#-10,LDSLR-2765#-10,LBAC-2765#-10}
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="roofArchWidth" class='validate[custom[integer]]' placeholder="roof arch width">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
10
</td>
<td style="width:65%;">
Distance between roof center line and fan BKT center
(LSCN/LGS)traverse side and single side respectively-
(20,500,420)/(20,500,460) 
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="distanceRoofcenterlineFanbkt" placeholder="distance roof centerline fan">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
11
</td>
<td style="width:65%;">
Distance from the center line of roof and the center line of 
BKT for pillar assembly(traverse side/longitudinal side)
(L3T/LSCN/LGS/L2T)Specified:(383+-3/977+-3),(296+-3/936+-3),
(409.5+-3),(260+-3/900+-3),(mounting plate outer side)
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="distanceRoofcenterlineCenterlinebkt" placeholder="distance roof centerline bkt">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
12
</td>
<td style="width:65%;">
Distance from the center line of roof to berth suspension
BKT distance(traverse side/longitudinal side)LSCN
Specified:251,951/927
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="distanceRoofcenterlineBerthsuspensionbkt" placeholder="distance of roofcenterline berth suspension">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
13
</td>
<td style="width:65%;">
Tray area length for LDSLR-4886
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="trayAreaLength" placeholder="tray area">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
14
</td>
<td style="width:65%;">
Distance from roof center line to fan bkt center at NPP/PP side in
LWSCZ(Non AC)Specifies:623.5,990x8/621.5,990x8
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="distanceRoofcenterlineFanbktNppPp" placeholder="distance of roof centerline fan npp pp">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
15
</td>
<td style="width:65%;">
Distance from roof center line to terminal board bkt center at 
NPP/PP side in LWSCZ(Non AC)Specified:2159,1980x2,2012/2159,1980x2,2012
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="distanceRoofcenterlineTerminalboardbktNppPp" placeholder="distance of roof centerline terminal board npp pp">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
16
</td>
<td style="width:65%;">
Distance from roof center line ti channel at(LH/RH)side in LWSCZ(Non AC)
Specified:359/359,128/128
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="distanceRoofcenterlineChannelLhRh" placeholder="distance of roofcenterline channnel lh rh">
</td>
</tr>
<tr>
<td style="width:5%;text-align:center;">
17
</td>
<td style="width:65%;">
Cross brace supporting bracket distance(L3T/L2T,LWFAC,LBAC)(111/1500)
</td>
<td style="width:25%;">
<input type= text style="width:100%;" id="distanceCrossBraceBracket" placeholder="distance of roof brace bracket">
</td>
</tr>
</table>
<br>
<table style="width:100%;margin-left:35px;">
<tr><td style="width:5%;">3.5</td><td style="width:64%;">Checked Dimensions Remarks</td><td style="width:31%;"><input type=text id="checkedDimensionRemark" ></td></tr>
<tr><td style="width:5%;">3.6</td><td style="width:64%;">Distance from center line of roof and the center line of FL BKTS(traverse side/longitudinal side)Specified:(829,790)(LSCN)</td><td style="width:31%;"><input type=text id="distanceCenterlineroofCenterlineflbkts" ></td></tr>
<tr><td style="width:5%;">3.7</td><td style="width:64%;">Condition of roof sheet joint(lateral &longitudinal welding)(robotic/manual)</td><td style="width:31%;"> <input type=radio id="conditionRoofSheetJoint" name="conditionRoofSheetJoint" value="ok">OK &nbsp;<input type=radio id="conditionRoofSheetJoint" name="conditionRoofSheetJoint" value="notok">NOT OK &nbsp<input type= radio id="conditionRoofSheetJoint" name="conditionRoofSheetJoint" value="na"> NA</td></tr>
<tr><td style="width:5%;">3.8</td><td style="width:64%;">Roof sheet joint leakage test</td><td style="width:31%;"><input type=radio id="roofSheetJointLeakage" name="roofSheetJointLeakage" value="done"> Done &nbsp; &nbsp; <input type=radio id="roofSheetJointLeakage" name="roofSheetJointLeakage" value="notdone">Not Done</td></tr>
<tr><td style="width:5%;">3.9</td><td style="width:64%;">Condition of roof sheet with roof arch(Spot/manual butt)weilding )</td><td style="width:31%;"> <input type=radio id="conditionRoofSheetArch" name="conditionRoofSheetArch" value="ok">OK &nbsp;<input type=radio id="conditionRoofSheetArch" name="conditionRoofSheetArch" value="notok">NOT OK &nbsp;<input type= radio id="conditionRoofSheetArch" name="conditionRoofSheetArch" value="na"> NA</td></tr>
<tr><td style="width:5%;">3.10</td><td style="width:64%;">Distance from the center line of roof and the center line of EL&NL bkts Specified:576790.(LSCN)/FL bkt Specified:849(LGS) </td><td style="width:31%;"><input type= text id="distanceRoofcenterlineCenterlineelbkt" class='validate[required]'></td></tr>
<tr><td style="width:5%;">3.11</td><td style="width:64%;">Fitment of Standard L-Stiffner </td><td style="width:31%;"> <input type=radio id="fittmentLstiffener" name="fittmentLstiffener" value="ok">OK &nbsp<input type=radio id="fittmentLstiffener" name="fittmentLstiffener"  value="notok">NOT OK &nbsp<input type= radio id="fittmentLstiffener" name="fittmentLstiffener" value="na"> NA</td></tr>
<tr><td style="width:5%;">3.12</td><td style="width:64%;">Distance from roof center line to speaker bkt center in LGS specified value-625mm</td><td style="width:31%;"><input type=text id="distanceRoofcenterlineSpeakerbkt" ></td></tr>
<tr><td style="width:5%;">3.13</td><td style="width:64%;">Distance from roof center line to EL bkt center in LGS specified value=712mm </td><td style="width:31%;"><input type=text id="distanceRoofcenterlineElbkt"></td></tr>
<tr><td style="width:5%;">3.14</td><td style="width:64%;">Total no. of cross braces fitted in roof</td><td style="width:31%;"><input type=text id="noCrossBracesFitted" ></td></tr>
</table>
<br>
<b style="margin-left:25px;">4. Details:</b>
<table style="width:100%;margin-left:35px;">
<tr><td style="width:5%;">4.1</td><td style="width:64%;">Details of modification carried out(if any):</td><td style="width:31%;"><input type=text id="roofDetailsOfModification"></td></tr>
<tr><td style="width:5%;">4.2</td><td style="width:64%;">Details of trial items fitted(if any) </td><td style="width:31%;"><input type=text id="roofDetailsOfTrial"></td></tr>
<tr><td style="width:5%;">4.3</td><td style="width:64%;">Remarks(if any)</td><td style="width:31%;"><input type=text id="roofRemarks"></td></tr>
</table>
<br>
<p align="center"><b>Final Decision</b>&nbsp; &nbsp; &nbsp;<input type=radio id="shellRoofSipTestingStatus" name="shellRoofSipTestingStatus" value="Confirming">Conforming <input type=radio id="shellRoofSipTestingStatus" name="shellRoofSipTestingStatus"  value="Not Comfirming">Not Conforming</p>
</form>
 </div>




<div id="UnderframeSIPDialog" style="height:150%; width:200%; display:none;z-index: 9;overflow-x: hidden;border:1px solid grey;padding:5px;margin-top:5px;" >
<h3 align="center">SELF INSPECTION PROFARMA</h3>
<h3 align="center">UNDERFRAME</h3> 
 <form name="underframeSIP">
<table style="width:90%;margin-left:30px;">
<tr>
<th style="width:20%;">DOC No:</th><td style="width:25%;"><input type=text style="width:80%;" name="underframe_docNo" id="underframeDocNo" class='validate[required]' ></td>
</tr>
<tr>
<th style="width:20%;">SHIFT:</th>
<td style="width:25%;"><select name="underframeShiftSelect" id="underframeShiftSelect" style="width:40%;">
<option value="none">Select</option>
<option value="general">General</option>
<option value="shift-I">Shift-I</option>
<option value="Shift-II">Shift-II</option>
<option value="Shift-III">Shift-III</option>
</select></td>
<th style="width:20%;">DATE:</th><td style="width:25%;"><input type=text style="width:76%;" name="underframeDate" id="underframeDate"></td>
</tr>
<tr>
	<th style="width:20%;">SHELL TYPE:</th>
	<td style="width:25%;"><input type=text id="shellType" style="width:80%;"></td>
	<th style="width:20%;">SHELL NO.:</th>
	<td style="width:25%;"><input type=text id="shellNo" style="width:76%;"></td>
</tr>
</table>
<br>
<b  style="margin-left:10px;">1. Applicablility:</b> 
<table style="width:100%;margin-left:10px;">
<tr>
	<td style="width:67%;">&nbsp;&nbsp;&nbsp;1.1 &nbsp;&nbsp;  Applicable Drawing No:</td>
	<td style="width:33%;"><input type=text id="appDrawNoUnderframe" name="appDrawNoUnderframe" class='validate[required]' placeholder="Enter value" >
</tr>
<tr>
	<td style="width:67%;">&nbsp;&nbsp;&nbsp;1.2 &nbsp;&nbsp;  Applicable Line number:</td>
	<td style="width:33%;"><input type=text id="appLineNoUnderframe" name="appLineNoUnderframe" class='validate[required]' placeholder="Enter value" ></td>
</tr>
<tr>
	<td style="width:67%;">&nbsp;&nbsp;&nbsp;1.3 &nbsp;&nbsp;  Applicable WI NO(if Any):</td>
	<td style="width:33%;"><input type=text id="appWiNoUnderframe" name="appWiNoUnderframe" placeholder="Enter value" ></td>
</tr>
</table>
<br>
<b style="margin-left:10px;">2. Data of Traceability </b>
<table style="width:99%;margin-left:10px;">
<tr>
<td style="width:33%;"></td>
<th style="width:34%;">PP Side</th>
<th style="width:32%;">NPP Side</th>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.1 &nbsp;&nbsp;  Front part make</td>
<td style="width:34%;"><input type=text id="frntPrtMakePp" class='validate[required]' placeholder="Enter make value"></td>
<td style="width:32%;"><input type=text id="frntPrtMakeNpp" class='validate[required]' placeholder="Enter make value"></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.2 &nbsp;&nbsp;  Front part no</td>
<td style="width:34%;"><input type=text id="frntPrtNoPp" class='validate[required]' placeholder="Enter no value"></td>
<td style="width:32%;"><input type=text id="frntPrtNoNpp" class='validate[required]' placeholder="Enter no value"></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.3 &nbsp;&nbsp;  CBC Make</td>
<td style="width:34%;"><input type=text id="cbCMakePp" class='validate[required]' placeholder="Enter make Value"></td>
<td style="width:32%;"><input type=text id="cbCMakeNpp" class='validate[required]' placeholder="Enter make Value"></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.4 &nbsp;&nbsp;  CBC no</td>
<td style="width:34%;"><input type=text id="cbCNoPp" class='validate[required]' placeholder="Enter no Value"></td>
<td style="width:32%;"><input type=text id="cbCNoNpp" class='validate[required]' placeholder="Enter no Value"></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.5 &nbsp;&nbsp;  CBC Fitted by </td>
<td style="width:34%;"><input type=text id="cbCFitPp" class='validate[required]' placeholder="Enter value" ></td>
<td style="width:32%;"><input type=text id="cbCFitNpp" class='validate[required]' placeholder="Enter value" ></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.6 &nbsp;&nbsp;  Under Frame  make</td>
<td style="width:34%;"><input type=text id="underframeMakePp" class='validate[required]' placeholder="Enter make value"></td>
<td style="width:32%;"><input type=text id="underframeMakeNpp" class='validate[required]' placeholder="Enter make value" ></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.7 &nbsp;&nbsp;  Under Frame  no</td>
<td style="width:34%;"><input type=text id="underframeNoPp" class='validate[required]' placeholder="Enter no value" ></td>
<td style="width:32%;"><input type=text id="underframeNoNpp" class='validate[required]' placeholder="Enter no value" ></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.8 &nbsp;&nbsp;  WaterTank BKT make and no</td>
<td style="width:34%;"><input type=text id="waterTankBkt1" class='validate[required]' placeholder="Water Tank 1" ></td>
<td style="width:32%;"><input type=text id="waterTankBkt2" class='validate[required]' placeholder="Water Tank 2" ></td>
</tr>
<tr>
<td style="width:33%;"></td>
<td style="width:34%;"><input type=text id="waterTankBkt3" class='validate[required]' placeholder="Water Tank 3" ></td>
<td style="width:32%;"><input type=text id="waterTankBkt4" class='validate[required]' placeholder="Water Tank 4" ></td>
</tr>
<tr>
<td style="width:33%;">&nbsp;&nbsp;&nbsp;2.9 &nbsp;&nbsp;  Under Frame complete make</td>
<td style="width:34%;"><input type=text id="underframeCompleteMake" class='validate[required]' placeholder="underframe Complete make" ></td>
<td style="width:32%;"><input type=text id="underframeCompleteNo" class='validate[required]' placeholder="underframe Complete no" ></td>
</tr>
</table>
<br>
<b style="margin-left:10px;">3. Observations:</b>
<table style="width:100%;margin-left:25px;">
 <tr><td style="width:5%;">3.1</td>
 	<td style="width:61%;">Items Fitted as per Drawing</td>
 	<td style="width:34%;"><input type=radio id="itemsFitted" name="itemsFitted" value="OK" >OK &nbsp; <input type=radio id="itemsFitted" name="itemsFitted" value="NOT OK" >NOT OK &nbsp; <input type= radio name="itemsFitted" id="itemsFitted" value="NA" > NA</td>
 </tr>
<tr><td style="width:5%;">3.2</td>
	<td style="width:61%;">Compliance of applicable WI</td>
	<td style="width:34%;"> <input type=radio id="compAppWi" name="compAppWi" value="OK" >OK &nbsp; <input type=radio id="compAppWi" name="compAppWi" value="NOT OK" >NOT OK &nbsp; <input type= radio id="compAppWi" name="compAppWi"  value="NA" > NA</td>
</tr>
<tr><td style="width:5%;">3.3</td>
	<td style="width:61%;">Welding throat & length as per drawing</td>
	<td style="width:34%;"> <input type=radio id="weldThroatLen" name="weldThroatLen" value="OK" >OK &nbsp; <input type=radio id="weldThroatLen" name="weldThroatLen" value="NOT OK" >NOT OK &nbsp; <input type= radio id="weldThroatLen" name="weldThroatLen" value="NA" > NA </td>
	</tr>
<tr><td style="width:5%;">3.4</td>
	<td style="width:61%;">Proper Tightening of screws of CBC's support device with lock tight(torque 500/50NM)</td>
	<td style="width:34%;"> <input type=radio id="tightScrew" name="tightScrew" value="OK" >OK &nbsp; <input type=radio id="tightScrew" name="tightScrew" value="NOT OK" >NOT OK &nbsp; <input type= radio id="tightScrew" name="tightScrew" value="NA" > NA</td>
</tr>
<tr><td style="width:5%;">3.5</td>
	<td style="width:61%;">Outer face of outer head stock level have checked with plume line and found</td>
	<td style="width:34%;"><input type=radio id="outerFaceOuterHead" name="outerFaceOuterHead" value="OK" >OK &nbsp; <input type=radio id="outerFaceOuterHead" name="outerFaceOuterHead" value="NOT OK" >NOT OK &nbsp; <input type= radio id="outerFaceOuterHead" name="outerFaceOuterHead" value="NA" > NA</td>
</tr>
<tr><td style="width:5%;">3.6</td>
	<td style="width:61%;">Condition of Plug welding with trough sheet &cross member</td>
	<td style="width:34%;"> <input type=radio id="conditionOfPlugWelding" name="conditionOfPlugWelding" value="OK" >OK &nbsp; <input type=radio id="conditionOfPlugWelding" name="conditionOfPlugWelding" value="NOT OK" >NOT OK &nbsp; <input type= radio id="conditionOfPlugWelding" name="conditionOfPlugWelding" value="NA" > NA</td>
</tr>
<tr><td style="width:5%;">3.7</td>
	<td style="width:61%;">Condition of console with sole bar welding</td>
	<td style="width:34%;"> <input type=radio id="conditionOfConsole" name="conditionOfConsole" value="OK" >OK &nbsp; <input type=radio  id="conditionOfConsole" name="conditionOfConsole" value="NOT OK" >NOT OK &nbsp; <input type= radio  id="conditionOfConsole" name="conditionOfConsole" value="NA" > NA</td>
</tr>
<tr><td style="width:5%;">3.8</td>
	<td style="width:61%;">Distance between centers of body bolster(14900+10/-0mm for LHB type coaches)&nbsp; &nbsp; </td>
	<td style="width:34%;"><input type=text id="bodyBolster" class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
	</tr>
<tr><td style="width:5%;">3.9</td>
	<td style="width:61%;">Complete length of under frame: Specified 23440mm+-16  </td>
	<td style="width:34%;"><input type= text id="completeLenUndeframe" class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.10</td>
	<td style="width:61%;">Front part to Front part length: Specified-22700mm+-16 </td>
	<td style="width:34%;"><input type= text id="frntPartToFront"class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
	</tr>
<tr><td style="width:5%;">3.11</td>
	<td style="width:61%;">U/F Width outside :Specified 3236 (-8, +0) </td>
	<td style="width:34%;"><input type=text id="ufWidth"class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.12</td>
	<td style="width:61%;">Covering plate torquing  Specified :200+20 NM</td>
	<td style="width:34%;"><input type=text id="coveringPlate"class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.13</td>
	<td style="width:61%;">&nbsp;&nbsp;&nbsp;3.13   Wedge bolt torquing Specified:</td>
	<td style="width:34%;"><input type=text id="wedgeBolt" class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.14</td>
	<td style="width:61%;">Water tank mounting BKT welding</td>
	<td style="width:34%;"><input type=radio id="waterTankMount" name="waterTankMount" value="OK" >OK &nbsp; &nbsp; <input type=radio id="waterTankMount" name="waterTankMount" value="NOT OK" >NOT OK &nbsp; <input type= radio id="waterTankMount"  name="waterTankMount" value="NA" > NA</td>
</tr>
<tr><td style="width:5%;">3.15</td>
	<td style="width:61%;">Front part both side bracket distances. Specified: 15mm from vestibule plate </td>
	<td style="width:34%;"><input type=text id="frntPartBrktDist" class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.16</td>
	<td style="width:61%;">Distance between Console bracket and center of hub. Specified :15mm from vestibule plate </td>
	<td style="width:34%;"><input type=text id="distBwConsoleBrkt" class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.17</td>
	<td style="width:61%;">Foot steps bracket distance Specified- 710mm</td>
	<td style="width:34%;"><input type= text id="footStepsDist"class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.18</td>
	<td style="width:61%;">Supporting member with trough sheet welding</td>
	<td style="width:34%;"><input type=radio id="suppMemTrough" name="suppMemTrough" value="OK" >OK &nbsp; <input type=radio id="suppMemTrough" name="suppMemTrough" value="NOT OK" >NOT OK &nbsp; <input type= radio id="suppMemTrough"  name="suppMemTrough" value="NA" > NA</td>
</tr>
<tr><td style="width:5%;">3.19</td>
	<td style="width:61%;">Pillar mounting channel assembly with trough sheet welding</td>
	<td style="width:34%;"><input type=radio id="pillarMountChannel" name="pillarMountChannel" value="OK" >OK &nbsp; <input type=radio id="pillarMountChannel" name="pillarMountChannel" value="NOT OK" >NOT OK &nbsp; <input type= radio id="pillarMountChannel" name="pillarMountChannel" value="NA" > NA</td>
</tr>
<tr><td style="width:5%;">3.20</td>
	<td style="width:61%;">Distance between curved roll bracket and center of hub. Specified 1470+-2mm</td>
	<td style="width:34%;"><input type= text id="distBwCurvedRoll"class='validate[required,custom[integer]]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.21</td>
	<td style="width:61%;">Grind the welded joints. remove the extra weld materials for proper finish and leveling</td>
	<td style="width:34%;"><input type=radio id="grindWeldJoints" name="grindWeldJoints" value="DONE" >Done &nbsp; <input type=radio id="grindWeldJoints" name="grindWeldJoints" value="NOT DONE" > NOT Done</td>
</tr>
<tr><td style="width:5%;">3.22</td>
	<td style="width:61%;">Holes for draining of water 10mm diameter in trough floor corugated sheet provided as per drg. </td>
	<td style="width:34%;"><input type=radio id="holesForDrawing" name="holesForDrawing" value="Done" >Done &nbsp; <input type=radio id="holesForDrawing" name="holesForDrawing" value="Not done" > NOT Done</td>
</tr>
<tr><td style="width:5%;">3.23</td>
	<td style="width:61%;">Holes drilled in under frame for mounting the brake pipes and under slung equipments as per drg. </td>
	<td style="width:34%;"><input type=radio id="holesDrilled" name="holesDrilled" value="DONE" >Done &nbsp; <input type=radio id="holesDrilled" name="holesDrilled" value="NOT DONE" > NOT Done</td>
</tr>
<tr><td style="width:5%;">3.24</td>
	<td style="width:61%;">Distance between member complete center to center:1016+-(for Power car)</td>
	<td style="width:34%;"><input type=text id="distBwCenterCenter"class='validate[required]'></td>
</tr>
<tr><td style="width:5%;">3.25</td>
	<td style="width:61%;">Door fixing bracket level and distance(820+-3)</td>
	<td style="width:34%;"><input type=radio id="doorFixBrkt" name="doorFixBrkt" value="OK" >OK &nbsp;<input type=radio id="doorFixBrkt" name="doorFixBrkt" value="NOT OK" >NOT OK &nbsp;<input type= radio id="doorFixBrkt" name="doorFixBrkt" value="NA" > NA
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text id="doorFixBrktOb" class='validate[required,custom[integer]]'></td>
</tr>
</table>
<table style="width:100%;margin-left:25px;">
<tr><td style="width:5%;">3.26</td>
	<td style="width:61%;">Fitment dimension of biological tank bracket and welding conduction:</td>
	<td style="width:34%;"><input type=radio id="fitmentDimenBiotank" name="fitmentDimenBiotank" value="OK" >OK &nbsp; <input type=radio id="fitmentDimenBiotank" name="fitmentDimenBiotank" value="NOT OK" >NOT OK &nbsp;<input type= radio id="fitmentDimenBiotank" name="fitmentDimenBiotank" value="NA" > NA</td>
</tr>
<tr><td style="width:5%;"></td>
	<td style="width:61%;">(a) Longitudial distance between brackets to brackets : Specified 1581</td>
	<td style="width:34%;"><input type=text id="longDistBrktBrktpp" class='validate[required,custom[integer]]' placeholder="Enter value"> (PP SIDE)</td>
</tr>
<tr><td style="width:5%;"></td>
    <td style="width:61%;"></td>
	<td style="width:34%;"><input type=text id="longDistBrktBrktnpp" class='validate[required,custom[integer]]' placeholder="Enter value" > (NPP SIDE)</td>
</tr>
<tr><td style="width:5%;"></td>
	<td style="width:61%;">(b) Lateral distance between brackets to front part center : Specified 995/851</td>
	<td style="width:34%;"><input type=text id="latDistBrktFrntpp" class='validate[required,custom[integer]]' placeholder="Enter value"  > (PP SIDE)</td>
</tr>
<tr><td style="width:5%;"></td>
	<td style="width:61%;"></td>
	<td style="width:34%;"><input type=text id="latDistBrktFrntnpp" class='validate[required,custom[integer]]' placeholder="Enter value"  > (NPP SIDE)</td>
</tr>
<tr><td style="width:5%;"></td>
	<td style="width:61%;">(c) Bio tank hole distance in LDSLR and LPC(Longitudnal x lateral):Specified(817*481/575)</td>
	<td style="width:34%;"><input type=text id="bioTankHoleDist" class='validate[required]' placeholder="Enter value" ></td>
</tr>
</table>

<table style="width:100%;margin-left:25px;">
<tr><td style="width:5%;">3.27</td>
	<td style="width:61%;">Fuel tank mounting bkt. Distance center to center: Long 956+-0.5,lat 878+-0.5,1760+-1 (for LPC)</td>
	<td style="width:34%;"><input type=text id="distCenCen" class='validate[required]' placeholder="Enter value" ></td> 
</tr>
<tr><td style="width:5%;">3.28</td>
	<td style="width:61%;">Fir TRC/TRS, gap between Generator mounting screwing piece centre(1st distance from front part head stock) 840,479,642,479</td>
	<td style="width:34%;"><input type=text id="genMmountScrew1" class='validate[required]' placeholder="Enter value" ></td> 
</tr>
<tr><td style="width:5%;">3.29</td>
	<td style="width:61%;">For TRC/TRS, gap between Generator mounting screwing piece centre 479*4</td>
	<td style="width:34%;"><input type=text id="genMmountScrew2" class='validate[required]' placeholder="Enter value" ></td> 
</tr>
<tr><td style="width:5%;">3.30</td>
	<td style="width:61%;">CBC uncoupling device hole</td>
	<td style="width:34%;"><input type= radio id="cbcUncoup" name="cbcUncoup" value="provided" >Provided<input type= radio id="cbcUncoup" name="cbcUncoup" value="not provided" >not Provided</td>
</tr>
<tr><td style="width:5%;">3.31</td>
	<td style="width:61%;">Transformer mounting distance outer to outer hole(BxL)&diagonal(508x706/Should be equal)</td>
	<td style="width:34%;"><input type=text id="transfMount" class='validate[required]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.32</td>
	<td style="width:61%;">Battery Box mounting distance outer to outer hole(BxL)&diagonal(L2T,L3T/LSCN,LGS)315x1460/500x2061.Should be equal</td>
	<td style="width:34%;"><input type=text id="batteryBox" class='validate[required]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.33</td>
	<td style="width:61%;">Air brake module mounting distance outer to outer hole(BxL) & diagonal(810x1460/should be equal)</td>
	<td style="width:34%;"><input type=text id="airBrakeModule" class='validate[required]' placeholder="Enter value" ></td>
</tr>
<tr><td style="width:5%;">3.34</td>
	<td style="width:61%;">Guide distance (Longitudinal/Lateral)1951+-1.5/483+-1</td>
	<td style="width:34%;"><input type=text id="guideDistPP" class='validate[required]' placeholder="Enter value"/> (PP SIDE)</td>
</tr>
<tr><td style="width:5%;"></td>
	<td style="width:61%;"></td>
	<td style="width:34%;"><input type=text   id="guideDistNPP" class='validate[required]' placeholder="Enter value"/> (NPP SIDE)</td>
</tr>
<tr><td style="width:5%;">3.35</td>
	<td style="width:61%;">Twine pipe hole and BKT(50mm/OK/NOT OK)</td>
	<td style="width:34%;"><input type=text id="twinePipHoleObs"class='validate[required]' placeholder="Enter value"/></td>
</tr>
<tr><td style="width:5%;">3.36</td>
	<td style="width:61%;">Fiba bkt for Under frame air spring bogie</td>
	<td style="width:34%;"><input type=radio id="fibaBktAirPro" name="fibaBktAirPro" value="PROVIDED" >Provided <input type=radio id="fibaBktAirPro" name="fibaBktAirPro" value="NOT PROVIDED" >not provided</td>
</tr>
<tr><td style="width:5%;">3.37</td>
	<td style="width:61%;">Rservoir tank holding bkt for under frame air spring boige</td>
	<td style="width:34%;"><input type=radio id="reserBktAirPro" name="reserBktAirPro" value="Provided" >Provided <input type=radio id="reserBktAirPro" name="reserBktAirPro" value="not provided" >not provided</td>
</tr>
<tr><td style="width:5%;">3.38</td>
	<td style="width:61%;">Cross member distance from under frame center line</td>
</tr>
</table>
<br>
<table border="1" style="width:95%;margin-left:25px;">
<tr>
	<td style="width:15%;" rowspan="3" align="center">Type</td>
	<th style="width:80%;" colspan=4 align="center">Cross member distance from under frame center line</th>
</tr>
<tr>
	<td style="width:35%;" rowspan=2 colspan=2 align="center">Specified value</td>
	<td style="width:40%;" colspan=2 align="center">Observed value</td>
</tr>
<tr>
	<td style="width:20%;" align="center">PP</td><td style="width:20%;" align="center">NPP</td>
</tr>

<tr>
	<td style="width:15%;text-align:center;" rowspan=2><b>L3T/L2T<br>LBC/LWFAC</b></td>
	<td style="width:5%;">NPP</td><td>555+-3,1035+-4,1795+-4,2255+-6,3035+-6,3795+-6,<br>4555+-8,5035+-8,5515+-8,6360+-8</td>
	<td style="width:20%;" rowspan="12" valign="middle">
	<input type=text id="distanceCrossMemberpp1" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 1st Value"/>
	<input type=text id="distanceCrossMemberpp2" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 2nd Value"/>
	<input type=text id="distanceCrossMemberpp3" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 3rd Value"/>
	<input type=text id="distanceCrossMemberpp4" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 4th Value"/>
	<input type=text id="distanceCrossMemberpp5" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 5th Value"/>
	<input type=text id="distanceCrossMemberpp6" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 6th Value"/>
	<input type=text id="distanceCrossMemberpp7" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 7th Value"/>
	<input type=text id="distanceCrossMemberpp8" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 8th Value"/>
	<input type=text id="distanceCrossMemberpp9" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 9th Value"/>
	<input type=text id="distanceCrossMemberpp10" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 10th Value"/>
	</td>
	<td style="width:20%;" rowspan="12" valign="middle">
	<input type=text id="distanceCrossMembernpp1" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 1st Value"/>
	<input type=text id="distanceCrossMembernpp2" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 2nd Value"/>
	<input type=text id="distanceCrossMembernpp3" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 3rd Value"/>
	<input type=text id="distanceCrossMembernpp4" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 4th Value"/>
	<input type=text id="distanceCrossMembernpp5" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 5th Value"/>
	<input type=text id="distanceCrossMembernpp6" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 6th Value"/>
	<input type=text id="distanceCrossMembernpp7" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 7th Value"/>
	<input type=text id="distanceCrossMembernpp8" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 8th Value"/>
	<input type=text id="distanceCrossMembernpp9" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 9th Value"/>
	<input type=text id="distanceCrossMembernpp10" style="width:130px;" class='validate[custom[integer]]' placeholder="Enter 10th Value"/>
	</td>
</tr>
<tr>
	<td style="width:5%;">PP</td>
	<td style="width:30%;">205+-2,965+-3,1445+-4,2205+-6,2965+-6,3445+-6,<br>4205+-8,4965+-8,6360+-8</td>
</tr>

<tr>
	<td style="width:15%;text-align:center;" rowspan=2><b>LSCN/LWSCZ<br>Non AC</b></td>
	<td style="width:5%;">NPP</td>
	<td style="width:30%;">205+-2,965+-3,1445+-4,2205+-6,2965+-6,3445+-6,<br>4205+-8,4965+-8,6360+-8</td>
</tr>
<tr>
	<td style="width:5%;">PP</td>
	<td style="width:30%;">555+-3,1035+-4,1795+-4,2255+-6,3035+-6,3795+-6,<br>4555+-8,5035+-8,5515+-8,6360+-8</td>
	
</tr>

<tr>
	<td style="width:15%;text-align:center;" rowspan=2><b>LGS</b></td>
	<td style="width:5%;">NPP</td>
	<td style="width:30%;">412.5+-3750+-3,1795+-4,2255+-6,3035+-6,3795+-6,<br>4555+8,5035+-8,5515+-8,6360+-8</td>
</tr>
<tr>
	<td style="width:5%;">PP</td>
	<td style="width:30%;">412.5+-3750+-3,1510+-4,1990+-42750+-6,3510+-6,3990+-6,<br>4750+-8,5035+-8,5515+-8,6360+-8</td>
</tr> 

<tr>
	<td style="width:15%;text-align:center;" rowspan=2><b>LRRM</b></td><td style="width:5%;">NPP</td>
	<td style="width:30%;">237.5+-2,766+-3,1372.6+-4,1889.2+-4,2466+-6,2866+-6,<br>3571+-6,4166+-8,4721+-8,5225.5+-8,5730+-8,6360+-8</td>
	
</tr>
<tr>
	<td style="width:5%;">PP</td>
	<td style="width:30%;">318+-2,755+-3,1251.2+-4,1807.5+-4,2336+-6,2942.6+-6,<br>3429.4+-6,4036+-8,4436+-8,5116+-8,5730+-8,6360+_8</td>
	
</tr>

<tr>
	<td style="width:15%;text-align:center;" rowspan=2><b>TRC/TRS</b></td>
	<td style="width:5%;">NPP</td><td style="width:30%;">251+-2,1011+-4,1711+-4,2385+-6,3080+-6,3840+-6,4322+-8,<br>5082+-8,5515+-8,6360+-8</td>
</tr>
<tr>
	<td style="width:5%;">PP</td>
	<td style="width:30%;">299+-2,989+-3,1821+-4,2427+.5+-6,2985+-6,3735+-8,4339+-8,<br>5045+-8,5515+-8,6360+-8</td>
</tr>

<tr>
	<td style="width:15%;text-align:center;" rowspan=2><b>LDSLR</b></td><td style="width:5%;">NPP</td>
	<td style="width:30%;">329+-2,881+-3,1372+-4,1664+-4,2215+-6,3012+-6,3522+-6,<br>4517+-8,5067+-8,5716+-8,6360+-8</td>
	</tr>
<tr>
	<td style="width:5%;">PP</td>
	<td style="width:30%;">366+-2,950+-31589+_4,2250+-4,2600+-4,3050+-6,3850+-6,<br>4250+-8,4605+-8,5175+-8,5445+-86360+-8</td>
</tr>
</table>

<br>
<br>
<p style="margin-left:10px;">&nbsp;&nbsp;&nbsp;3.9  &nbsp; Distance between U/F Pillar mounting channel assembly on trough sheet</p>

<table border="1" style="width:96%;margin-left:20px;">
                    <tr>
                        <td style="width: 20%;text-align: center">Type</td>
                        <td style="width: 50%;text-align: center">Specified value(mm)</td>
                        <td style="width: 26%;text-align: center">Observed value</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>LSCN</b></td>
                        <td style="width: 50%">Center to PP/NPPsside -1800*11.<br> Lateral Distance -639(between both pillar center line).<br> Without PRT-702</td>
                        <td style="width: 26%" rowspan=15><input type=text style="width:100%;" id="obserVal" class='validate[required]' placeholder="Enter value" ></td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>LWACCN</b></td>
                        <td style="width: 50%">(a)center to PPside 625,1830*3,1840,1130<br>(b)NPP side 1205, 1830*3,1840,550<br>Lateral distance -695(between both pillar center line)</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>LWACCW</b></td>
                        <td style="width: 50%">NPP side ddor cut out to PPside -770,1900*9<br>Lateral distance-640(between both pillar center line)</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;" rowspan="3"><b>LWACCW</b></td>
                        <td style="width: 50%">Longitudnal side(PP to NPP)-2405,1745,2405,1745,1745,2405,1745,2405</td>
                    </tr>
                    <tr>
                        <td style="width: 50%">Lateral from center lie -1st-467/IIend-735(between-268mm)</td>
                    </tr>
                    <tr>
                        <td style="width: 50%"><b>Pillar mounting for door support</b><br>Longitudnal side-576,572,607,580,572,532,530,580,572,534,580,572(PP to NPP)<br>Lateral distance from center line-700</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;" rowspan="2"><b>LWFAC Composite</b></td>
                        <td style="width: 50%"><b>Pillar mounting distance(AC2T)</b><br>Longitudnal side-1900,1900,1900,1900<br>Lateral distance-640(between both pillar center line)</td>
                    </tr>
                    <tr>
                        <td style="width: 50%"><b>Pillar mounting distance(LFAC)</b><br>Longitudnal side-from center line 898,2420,1730,2420<br>Lateral frm center line-1st-467/IIend-735(between-268mm)</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>LGS</b></td>
                        <td style="width: 50%">Distance between U/FCenter line and Pillar mounting Bracket on trough sheet<br>Specified-561 and 1702*5 PP& NPP side<br>Lateral distance-705(between both pillar center line)<br>Without PRT-766</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>LWRRM</b></td>
                        <td style="width: 50%">Distance between mounting plate for Generator, Specified-1022+-2 & 1459+-2</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>TRC</b></td>
                        <td style="width: 50%">Distance from lateral center line  (NPP-PP)722*7,467,309</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>Staff car</b></td>
                        <td style="width: 50%">Distance from lateral center line  (NPP-PP)736*9,470*4</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>LDSLR</b></td>
                        <td style="width: 50%">Distance between U/F door center line and pillar mounting center bracket on trough sheet Specified-561 abd 421,1702*2,1688,867,3998,6285 PP& NPP side</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>LBCA</b></td>
                        <td style="width: 50%">Distance from lateral center line(PP-NPP)7195,5362<br>Distance from lateral center line(PP-NPP)735/1031</td>
                    </tr>            
                    <tr>
                        <td style="width: 20%;text-align:center;"><b>LWSCZ NONAC</b></td>
                        <td style="width: 50%">Distance from lateral center line to NPP side for chair mounting member -578,990*8 & PP side -578,990*8<br>Distance from longitudnal center line(LH & RH side for chair mounting member)-534.5,1249.5</td>
                    </tr>
                </table>
<br>
<table style="width:100%;margin-left:10px;">
<tr>
	<td style="width: 67%">&nbsp;&nbsp;&nbsp;4.1 &nbsp;  Details of modification carried out(if any):</td>
	<td style="width: 33%"><textarea id="detlOfModf" placeholder="Enter Modification, if any" style="width: 80%;resize: none;"></textarea></td>
</tr>
<tr>
	<td style="width: 67%">&nbsp;&nbsp;&nbsp;4.2 &nbsp;  Details of trials of items fitted(if any):</td>
	<td style="width: 33%"><textarea id="detlOfTrialItems" placeholder="Enter Trial item, if any" style="width: 80%;resize: none;"></textarea></td>
</tr>
<tr>
	<td style="width: 67%">&nbsp;&nbsp;&nbsp;4.3 &nbsp;  Remarks(if any):</td>
	<td style="width: 33%"><input type=text id="rmk" placeholder="Enter remarks, if any" style="width: 80%;resize: none;" ></td>
</tr>
</table>
<p align="center"><b>Testing Status</b>&nbsp; &nbsp; &nbsp;<input type=radio id="shellUnderframeSipTestingStatus" name="shellUnderframeSipTestingStatus" value="Conforming">Conforming <input type=radio id="shellUnderframeSipTestingStatus" name="shellUnderframeSipTestingStatus" value="Not Comforming">Not Conforming</p>
</form>
</div>




<div id="lavsidewallSIP" style="height:150%; width:200%; display:none;z-index: 9;overflow-x: hidden;border:1px solid grey;padding:5px;margin-top:5px;" >
    <h3 align="center">SELF INSPECTION PROFARMA</h3>
<h3 align="center">LAV SIDE WALL</h3>
<form name="lavSidewallForm">
<table style="width:90%;margin-left:50px;">
<tr>
<th style="width:20%;">Doc No</th><td><input type="text" name="lavsidewallSipDocNo" style="width:80%;" id="lavsidewallSipDocNo" class='validate[required]'></td>
<td></td>
<td></td>
</tr>
<tr>
<th style="width:20%;">Shift</th><td><select  name="lavsidewallSipShift" id="lavsidewallSipShift" style="width:40%;" class='validate[required]'>
<option value="">Select</option>
<option value="general">General</option>
<option value="morning">Shift-I</option>
<option value="evening">Shift-II</option>
<option value="night">Shift-III</option>
</select></td>
<th style="width:20%;">Date of Testing</th><td><input type="text" style="width:80%;" name="lavsidewallSipDate" id="lavsidewallSipDate" class='validate[required]'></td>
</tr>
<tr>
<th style="width:20%;">LavSidewall Type</th><td><input type="text" name="lavsidewallShellType" style="width:80%;" id="lavsidewallShellType"></td>
<th style="width:20%;">LavSidewall No</th><td><input type="text" style="width:80%;" name="lavsidewallNo" id="lavsidewallNo" class='validate[required]'></td>
</tr>
</table>
<br>
<table border="1" style="width:99%;margin-left:5px;">
<tr>
<th style="width:19%;text-align:center;" rowspan="2">Activity</th>
<th style="width:40%;text-align:center;" colspan="4">Done by /MCF contractor robotic machine/manual weldin/B.O</th>
<th style="width:40%;text-align:center;" colspan="4">Jig no./robotic station(L.H/R.H)/B.O</th>
</tr>
<tr>
<td style="width:10%;">LAV-1</td>
<td style="width:10%;">LAV-2</td>
<td style="width:10%;">LAV-3</td>
<td style="width:10%;">LAV-4</td>
<td style="width:10%;">LAV-1</td>
<td style="width:10%;">LAV-2</td>
<td style="width:10%;">LAV-3</td>
<td style="width:10%;">LAV-4</td>
</tr>
<tr>
<th style="width:19%;">Frame work done</th>
<td style="width:10%;"><input type="text"  class="c1" style="width:100%;" id="frameWorkByLav1" name="frameWorkByLav1" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  class="c1" style="width:100%;" id="frameWorkByLav2" name="frameWorkByLav2" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  class="c1" style="width:100%;" id="frameWorkByLav3" name="frameWorkByLav3" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  class="c1" style="width:100%;" id="frameWorkByLav4" name="frameWorkByLav4" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  class="c1" style="width:100%;" id="frameJigRoboticsBoLav1" name="frameJigRoboticsBoLav1" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  class="c1" style="width:100%;" id="frameJigRoboticsBoLav2" name="frameJigRoboticsBoLav2" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="frameJigRoboticsBoLav3" name="frameJigRoboticsBoLav3" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="frameJigRoboticsBoLav4" name="frameJigRoboticsBoLav4" placeholder="Enter text here"></td>
</tr>
<tr>
<th style="width:19%;">Spot Welding Done</th>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="spotWeldingByLav1" name="spotweldingByLav1" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="spotWeldingByLav2" name="spotWeldingByLav2" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="spotWeldingByLav3" name="spotWeldingByLav3" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="spotWeldingByLav4" name="spotWeldingByLav4" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="spotWeldingJigRoboticsBoLav1"  name="spotWeldingJigRoboticsBoLav1" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="spotWeldingJigRoboticsBoLav2"  name="spotWeldingJigRoboticsBoLav2" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="spotWeldingJigRoboticsBoLav3" name="spotWeldingJigRoboticsBoLav3" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="spotWeldingJigRoboticsBoLav4" name="spotWeldingJigRoboticsBoLav4" placeholder="Enter text here"></td>
</tr>
<tr>
<th style="width:19%;">Interlocking joint welding done</th>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="interlockJointByLav1" name="interlockJointByLav1" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="interlockJointByLav2" name="interlockJointByLav2" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="interlockJointByLav3" name="interlockJointByLav3" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="interlockJointByLav4" name="interlockJointByLav4" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="interlockJointJigRoboticsBoLav1"  name="interlockJointJigRoboticsBoLav1" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="interlockJointJigRoboticsBoLav2"  name="interlockJointJigRoboticsBoLav2" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="interlockJointJigRoboticsBoLav3"  name="interlockJointJigRoboticsBoLav3" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" class="c1" style="width:100%;" id="interlockJointJigRoboticsBoLav4"  name="interlockJointJigRoboticsBoLav4" placeholder="Enter text here"></td>
</tr>
</table>
<br>
<b style="margin-left:30px;">1. Applicability:</b>
<table style="width:100%;margin-left:45px;">
<tr>
  <td style="width:5%;">1.1</td>
  <td style="width:59%;">Applicable Drawing No.</td>
  <td style="width:36%;"><input type="text" name="lavSidewallDrawingNo"  id="lavSidewallDrawingNo" ></td>
</tr>
<tr>
  <td style="width:5%;">1.2</td>
  <td style="width:59%;">Applicable W.I No.(If Any)</td>
  <td style="width:36%;"><input type="text" name="lavSidewallWiNo" id="lavSidewallWiNo"></td>
  </tr>
</table>
<br>
 <b style="margin-left:30px;">2. Data of Traceability:</b>
 <table style="width:100%;margin-left:45px;">
 <tr>
  <td style="width:5%;">2.1 </td>
  <td style="width:29%;">LAV side wall make </td>
  <td style="width:30%;"><input type="text" id="lavsidewallMake1" name="lavsidewallMake1" placeholder="Make 1"></td>
  <td style="width:36%;"><input type="text" id="lavsidewallMake2" name="lavsidewallMake2" placeholder="Make 2"></td>
  </tr>
  <tr>
  <td style="width:5%;"></td>
  <td style="width:29%;"></td>
  <td style="width:30%;"><input type="text" id="lavsidewallMake3" name="lavsidewallMake3" placeholder="Make 3"></td>
  <td style="width:36%;"><input type="text" id="lavsidewallMake4" name="lavsidewallMake4" placeholder="Make 4"></td>
  </tr>
  <tr>
  <td style="width:5%;">2.2</td>
  <td style="width:29%;">LAV side wall Sr.no</td>
  <td style="width:30%;"><input type="text" id="lavsidewallNo1" name="lavsidewallNo1" placeholder="No 1"></td>
  <td style="width:36%;"><input type="text" id="lavsidewallNo2" name="lavsidewallNo2" placeholder="No 2"></td>
  </tr>
   <tr>
  <td style="width:5%;"></td>
  <td style="width:29%;"></td>
  <td style="width:30%;"><input type="text" id="lavsidewallNo3" name="lavsidewallNo3" placeholder="No 3"></td>
  <td style="width:36%;"><input type="text" id="lavsidewallNo4" name="lavsidewallNo4" placeholder="No 4"></td>
  </tr>
 </table>

 <b style="margin-left:30px;">3. Observations:</b>
 <table style="width:100%;margin-left:45px;">
 <tr>
 <td style="width:5%;">3.1</td>
 <td style="width:59%;">Items fitted as per drawing</td>
 <td style="width:36%;"><input type="radio"  id="lavSidewallObservationItemsAsPerDrawingFlag" name="lavSidewallObservationItemsAsPerDrawingFlag" value="OK"> OK 
  &nbsp;<input type="radio" id="lavSidewallObservationItemsAsPerDrawingFlag" name="lavSidewallObservationItemsAsPerDrawingFlag" value="NOT OK">NOT Ok
  &nbsp;<input type="radio" id="lavSidewallObservationItemsAsPerDrawingFlag" name="lavSidewallObservationItemsAsPerDrawingFlag" value="NA"> NA
 </td>
 </tr>
 <tr>
<td style="width:5%;">3.2</td>
<td style="width:59%;">Compliance of applicble W.I</td>
<td style="width:36%;">
  <input type="radio" id="lavSidewallObservationComplianceWiFlag" name="lavSidewallObservationComplianceWiFlag" value="OK"> OK
  &nbsp;<input type="radio" id="lavSidewallObservationComplianceWiFlag" name="lavSidewallObservationComplianceWiFlag" value="NOT OK">NOT Ok
  &nbsp;<input type="radio" id="lavSidewallObservationComplianceWiFlag" name="lavSidewallObservationComplianceWiFlag" value="NA"> NA
</td>
 </tr>
 <tr>
 <td style="width:5%;">3.3</td>
 <td style="width:59%;">Welding throat and length as per drawing</td>
 <td style="width:36%;">
  <input type="radio" id="lavSidewallObservationWeldingThroatFlag" name="lavSidewallObservationWeldingThroatFlag" value="OK"> OK
  &nbsp;<input type="radio" id="lavSidewallObservationWeldingThroatFlag" name="lavSidewallObservationWeldingThroatFlag" value="NOT OK">NOT Ok
  &nbsp;<input type="radio" id="lavSidewallObservationWeldingThroatFlag" name="lavSidewallObservationWeldingThroatFlag" value="NA"> NA
  </td>
  </tr>
 </table>
 <br>
<table border= "1" style="width:98%;margin-left:5px;">
<tr class="c3" >
<th style="width:5%;text-align:center;">SNo.</th>
<th style="width:33%;text-align:center;">Parameter</th>
<th style="width:20%;text-align:center;">Value Specified</th>
<th style="width:10%;text-align:center;">Lav.1</th>
<th style="width:10%;text-align:center;">Lav.2</th>
<th style="width:10%;text-align:center;">Lav.3</th>
<th style="width:10%;text-align:center;">Lav.4</th>
</tr>
<tr>
<th style="width:5%;text-align:center;">1.</th>
<th style="width:33%;">Total Height</th>
<th style="width:20%;">1996.5+2</th>
<td style="width:10%;"><input type="text"  id="totalheightLav1" name="totalheightLav1" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalheightLav2" name="totalheightLav2" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalheightLav3" name="totalheightLav3" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalheightLav4" name="totalheightLav4" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
</tr>
<tr>
<th style="width:5%;text-align:center;">2.</th>
<th style="width:33%;">Total width outside</th>
<th style="width:20%;">1336.7+3</th>
<td style="width:10%;"><input type="text"  id="totalwidthoutsideLav1" name="totalwidthoutsideLav1" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalwidthoutsideLav2" name="totalwidthoutsideLav2" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalwidthoutsideLav3" name="totalwidthoutsideLav3" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalwidthoutsideLav4" name="totalwidthoutsideLav4" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>

</tr>
<tr>
<th style="width:5%;text-align:center;">3.</th>
<th style="width:33%;">Total width inside</th>
<th style="width:20%;">1295.8</th>
<td style="width:10%;"><input type="text"  id="totalwidthinsideLav1" name="totalwidthinsideLav1" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalwidthinsideLav2" name="totalwidthinsideLav2" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalwidthinsideLav3" name="totalwidthinsideLav3" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="totalwidthinsideLav4" name="totalwidthinsideLav4" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>

</tr>
<tr>
<th style="width:5%;text-align:center;">4.</th>
<th style="width:33%;">Window cut out</th>
<th style="width:20%;">700+2</th>
<td style="width:10%;"><input type="text"  id="windowcutOutLav1" name="windowcutOutLav1" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="windowcutOutLav2" name="windowcutOutLav2" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="windowcutOutLav3" name="windowcutOutLav3" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="windowcutOutLav4" name="windowcutOutLav4" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
</tr>
<tr>
<th style="width:5%;text-align:center;">5.</th>
<th style="width:33%;">Window cut out side</th>
<th style="width:20%;">680+2</th>
<td style="width:10%;"><input type="text"  id="windowcutOutsideLav1" name="windowcutOutsideLav1" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="windowcutOutsideLav2" name="windowcutOutsideLav2" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="windowcutOutsideLav3" name="windowcutOutsideLav3" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text"  id="windowcutOutsideLav4" name="windowcutOutsideLav4" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
</tr>
<tr>
<th style="width:5%;text-align:center;">6.</th>
<th style="width:33%;" class="c3" >Pillar height from sheet</th>
<th style="width:20%;">60</th>
<td style="width:10%;"><input type="text" id="pillarheightSheetLav1" name="pillarheightSheetLav1" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" id="pillarheightSheetLav2" name="pillarheightSheetLav2" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" id="pillarheightSheetLav3" name="pillarheightSheetLav3" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" id="pillarheightSheetLav4" name="pillarheightSheetLav4" style="width:100%;" class='validate[custom[number]]' placeholder="Enter text here"></td>
</tr>
<tr>
<th style="width:5%;text-align:center;">7.</th>
<th style="width:33%;" class="c3">Window profile cut for Exhaust(in LscN/LGS)</th>
<th style="width:20%;" class="c3" >provided/not provided</th>
<td style="width:10%;"><input type="text" id="windowprofilecutForExhaustLav1" style="width:100%;" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" id="windowprofilecutForExhaustLav2" style="width:100%;" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" id="windowprofilecutForExhaustLav3" style="width:100%;" placeholder="Enter text here"></td>
<td style="width:10%;"><input type="text" id="windowprofilecutForExhaustLav4" style="width:100%;" placeholder="Enter text here"></td>
</tr>
</table>
<br>
<table style="width:100%;margin-left:45px;">
<tr>
<td style="width:5%;">3.4</td>
<td style="width:59%;">Lav.Side wall sheet frame as per drawing</td>
<td style="width:36%;">
  <input type="radio" class="c4"  id="lavsidewallFrameAsPerDrawingFlag" value="DONE">DONE
  <input type="radio" class="c4" id="lavsidewallFrameAsPerDrawingFlag" value="NOT DONE">NOT DONE
</td>
</tr>
<tr>  
<td style="width:5%;">3.5</td>
<td style="width:59%;">Lav.Side wall sheet with member spot welding/manual butt welding</td>
<td style="width:36%;">
  <input type="radio" class="c4"  id="lavsidewallMemberWeldingFlag" value="DONE">DONE
  <input type="radio" class="c4" id="lavsidewallMemberWeldingFlag" value="NOT DONE">NOT DONE
 </td>
 </tr>
 <tr> 
<td style="width:5%;">3.6</td>
<td style="width:59%;">Condition of Lav.Side wall member joint(robotic/manual)</td>
<td style="width:36%;">
  <input type="radio" class="c4"  id="conditionLavsidewallMemberJointweldingFlag" value="OK"> OK
  <input type="radio" class="c4"  id="conditionLavsidewallMemberJointweldingFlag" value="NOT OK">NOT Ok
  <input type="radio" class="c4"  id="conditionLavsidewallMemberJointweldingFlag" value="NA"> NA
</td>  
 </tr>
 <tr>
 <td style="width:5%;">3.7</td>
 <td style="width:59%;">Condition of Lav.Side wall sheet laser joint welding(visually)</td>
 <td style="width:36%;">
 <input type="radio" class="c4" id="conditionLavsidewallSheetLaserweldingFlag" value="OK"> OK
  <input type="radio" class="c4" id="conditionLavsidewallSheetLaserweldingFlag" value="NOT OK">NOT Ok
  <input type="radio" class="c4" id="conditionLavsidewallSheetLaserweldingFlag" value="NA"> NA
  </td>
 </tr>
 </table>
<br>
<b style="margin-left:30px;">4. Details</b>
 <table style="width:100%;margin-left:45px;">
 <tr>
<td style="width:5%;">4.1</td>
<td style="width:59%;">Details of modification carried out(if any)</td>
<td style="width:36%;">
  <input type="text" class="c4" id="lavSidewallDetailsOfModification" name="detailsOfModification">
 </td>
 </tr>
 <tr> 
 <td style="width:5%;">4.2</td>
 <td style="width:59%;">Details of trail items fitted(if any):</td>
 <td style="width:36%;">
  <input type="text" class="c4" id="lavSidewallDetailsOfTrial" name="detailsOfTrial">
 </td>
 </tr>
 <tr> 
<td style="width:5%;">4.3</td>
<td style="width:59%;">Remarks(if any):</td>
<td style="width:36%;">
<input  type="text" class="c4"  id="lavSidewallRemarks" name="remarks">

  </td>
</tr>  
  </table>
  <p align="center"><b>Testing Status</b>&nbsp; &nbsp; &nbsp;<input type=radio name="shellLavSidewallSipTestingStatus" id="shellLavSidewallSipTestingStatus" value="Confirming">Conforming <input type=radio  name="shellLavSidewallSipTestingStatus" id="shellLavSidewallSipTestingStatus" value="Not Comfirming">Not Conforming</p>
</form>
 </div>




<div id="endwallSIP" style="height:150%; width:200%; display:none;z-index: 9;overflow-x: hidden;border:1px solid grey;padding:5px;margin-top:5px;padding-right:10px;">
     <h3 align="center">SELF INSPECTION PROFARMA</h3>
<h3 align="center">END WALL</h3>
<form name="endwallSIP">
<table style="width:94%;margin-left:40px;">
<tr>
<th style="width:23%;">Doc No</th><td style="width:28%;"><input type="text" name="endwallSipDocNo" id="endwallSipDocNo" style="width:70%;" class='validate[required]'></td><td></td><td></td>
</tr>
<tr>
<th style="width:23%;">Shift</th><td style="width:28%;"><select style="width:30%;"  name="endwallSipShift" id="endwallSipShift" class='validate[required]'>
<option value="">Select</option>
<option value="general">General</option>
<option value="morning">Shift-I</option>
<option value="evening">Shift-II</option>
<option value="night">Shift-III</option>

</select></td>
<th style="width:24%;">Date of Testing</th><td style="width:19%;"><input style="width:100%;" type="text" name="endwallSipDate" id="endwallSipDate" class='validate[required]'></td><td></td>
</tr>
<tr>
<th style="width:23%;">LavSidewall Type</th><td style="width:28%;"><input style="width:70%;" type="text" name="endwallShellType" id="endwallShellType"></td>
<th style="width:24%;">LavSidewall No</th><td style="width:19%;"><input style="width:100%;" type="text" name="endwallNo" id="endwallNo" class='validate[required]'></td>
</tr>
</table>
<br>
<b style="margin-left:25px;">1. Applicability:</b>
<table style="width:100%;margin-left:35px;">
 <tr>
  <td style="width:5%;">1.1</td>
  <td style="width:64%;">Applicable Drawing No.</td>
  <td style="width:31%;"><input type="text" name="drawingNoendwall" id="drawingNoendwall" ></td>
 </tr>
 <tr>
  <td style="width:5%;">1.2</td>
  <td style="width:64%;">Applicable W.I No.(If Any)</td>
  <td style="width:31%;"><input type="text" name="wiNoendwall" id="wiNoendwall"></td>
 </tr>
</table>
  
<b style="margin-left:25px;">2. Data of Traceability:</b>
<table style="width:100%;margin-left:35px;">  
 <tr>
  <td style="width:5%;">2.1</td>
  <td style="width:34%;">End wall make and No.(in house(MCF/Contractor)/bought out)</td>
  <td style="width:30%;"><input type="text" name="endwallPpMake" id="endwallPpMake" placeholder="Endwall make pp"></td>
  <td style="width:31%;"><input type="text" name="endwallNppMake" id="endwallNppMake" placeholder="Endwall make npp"></td>
 </tr>
 <tr>
  <td style="width:5%;"></td>
  <td style="width:34%;"></td>
  <td style="width:30%;"><input type="text" name="endwallPpNo" id="endwallPpNo" placeholder="Endwall no pp"></td>
  <td style="width:31%;"><input type="text" name="endwallNppNo" id="endwallNppNo" placeholder="Endwall no npp"></td>
 </tr>
</table>
   
 <b style="margin-left:25px;">3. Observations:</b>
 <table style="width:100%;margin-left:35px;">
  <tr>
  <td style="width:5%;">3.1</td>
   <td style="width:64%;">Items fitted as per drawing</td>
   <td style="width:31%;">
   <input type="radio"  id="observationItemAsPerDrawing" name="observationItemAsPerDrawing" value="OK"> OK
   <input type="radio" id="observationItemAsPerDrawing" name="observationItemAsPerDrawing" value="NOT OK">NOT Ok
   <input type="radio" id="observationItemAsPerDrawing" name="observationItemAsPerDrawing" value="NA"> NA
   </td>
  </tr>
 
 <tr>
  <td style="width:5%;">3.2</td>
<td style="width:64%;">Compliance of applicble W.I</td>
<td style="width:31%;">
  <input type="radio" id="observationComplianceWi" name="observationComplianceWi" value="OK"> OK
  <input type="radio" id="observationComplianceWi" name="observationComplianceWi" value="NOT OK">NOT Ok
  <input type="radio" id="observationComplianceWi" name="observationComplianceWi" value="NA"> NA
</td>
 </tr>
 <tr>
  <td style="width:5%;">3.3</td>
 <td style="width:64%;">Welding throat and bead length as per drawing</td>
 <td style="width:31%;">
  <input type="radio" id="observationWeldingThroatLength" name="observationWeldingThroatLength" value="OK"> OK
  <input type="radio" id="observationWeldingThroatLength" name="observationWeldingThroatLength" value="NOT OK">NOT Ok
  <input type="radio" id="observationWeldingThroatLength" name="observationWeldingThroatLength" value="NA"> NA
  </td>
  </tr>
  
  <tr>
  <td style="width:5%;">3.4</td>
  <td style="width:64%;">Stopper hole distance from U channel:Specified  15+0.5mm,</td>
  <td style="width:31%;"><input type="text" id="distanceStopperholeUchannel" class='validate[custom[number]]' placeholder="Enter text here" ></td>
  </tr>
  
  <tr>
  <td style="width:5%;">3.5</td>
  <td style="width:64%;">Distance between U channel and stopper hole:Specified 41+1mm,</td>
  <td style="width:31%;"><input type="text" id="distanceUchannelStopperhole" class='validate[custom[number]]'  placeholder="Enter text here" ></td>
  </tr>
  
  <tr>
  <td style="width:5%;">3.6</td>
  <td style="width:64%;">Vestibule U channel between gap inner distance:Specified 1148+4mm,</td>
  <td style="width:31%;"><input type="text" id="distanceVestibuleUchannelPp" class='validate[custom[number]]' placeholder="Enter text here" > (PP)</td>
  </tr>
  
  <tr>
  <td style="width:5%;"></td>
  <td style="width:64%;"></td>
    <td style="width:31%;"><input type="text" id="distanceVestibuleUchannelNpp" class='validate[custom[number]]' placeholder="Enter text here" > (NPP)</td>
  </tr>
  
  <tr>
  <td style="width:5%;">3.7</td>
 <td style="width:64%;">Condition of Tail lamp bracket holes:</td>
 <td style="width:31%;">
  <input type="radio" id="conditionTailLampHole" name="conditionTailLampHole" value="OK"> OK
  <input type="radio" id="conditionTailLampHole" name="conditionTailLampHole" value="NOT OK">NOT Ok
  <input type="radio" id="conditionTailLampHole" name="conditionTailLampHole" value="NA"> NA
  </td>
  </tr>
  
  <tr>
  <td style="width:5%;">3.8</td>
 <td style="width:64%;">Condition of Vestibule hole:</td>
 <td style="width:31%;">
  <input type="radio" id="conditionVestibuleHole" name="conditionVestibuleHole" value="OK"> OK
  <input type="radio" id="conditionVestibuleHole" name="conditionVestibuleHole" value="NOT OK">NOT Ok
  <input type="radio" id="conditionVestibuleHole" name="conditionVestibuleHole" value="NA"> NA
  </td>
  </tr>
  
  <tr>
  <td style="width:5%;">3.9</td>
 <td style="width:64%;">Condition of Drain hole:</td>
 <td style="width:31%;">
  <input type="radio" id="conditionDrainHole" name="conditionDrainHole" value="OK"> OK
  <input type="radio" id="conditionDrainHole" name="conditionDrainHole" value="NOT OK">NOT Ok
  <input type="radio" id="conditionDrainHole" name="conditionDrainHole" value="NA"> NA
  </td>
  </tr>
  
  <tr>
  <td style="width:5%;">3.10</td>
  <td style="width:64%;">End wall outer width:Specified 3122+6mm,</td>
  <td style="width:31%;"><input type="text" id="endwallOuterWidth" class='validate[custom[number]]' placeholder="Enter text here" ></td>
  </tr>
  
  
  <tr>
  <td style="width:5%;">3.11</td>
 <td style="width:64%;">End wall exhaust cutting(in AC Shell)></td>
 <td style="width:31%;">
  <input type="radio" id="endwallExhaustCutting" name="endwallExhaustCutting" value="Provided">Provided
  <input type="radio" id="endwallExhaustCutting" name="endwallExhaustCutting" value="Not Provided">Not Provided
  </td>
  </tr>
  
   <tr>
  <td style="width:5%;">3.12</td>
 <td style="width:64%;">End wall back pieces for vestibule door</td>
 <td style="width:31%;">
  <input type="radio" id="endwallPieceVerstibule" name="endwallPieceVerstibule" value="Provided">Provided
  <input type="radio" id="endwallPieceVerstibule" name="endwallPieceVerstibule" value="Not Provided">Not Provided
  </td>
  </tr>
  
   <tr>
  <td style="width:5%;">3.13</td>
  <td style="width:64%;">Roof Element water eject hole size at end wall(L*W)(105*55mm)</td>
  <td style="width:31%;"><input type="text" id="roofelementWaterejectHole" placeholder="Enter text here" ></td>
  </tr>
  
  <tr>
  <td style="width:5%;">3.14</td>
  <td style="width:64%;">End Back pieces for mounting of vestibule door :Specified value(1572,720,70 mm)</td>
  <td style="width:31%;"><input type="text" id="backpieceVestibuleDoor" placeholder="Enter text here" ></td>
  </tr>
  </table>
  
  <b style="margin-left:25px;">4. Details</b>
  <table style="width:100%;margin-left:35px;">
  <tr>
  <td style="width:5%;">4.1</td>
  <td style="width:64%;">Details of modification carried out(if any)</td>
  <td style="width:31%;"><input type="text" id="detailsOfModificationendwall" placeholder="Enter text here"></td>
  </tr>
   <tr>
   <td style="width:5%;">4.2</td>
  <td style="width:64%;">Details of trial items fitted(if any)</td>
  <td style="width:31%;"><input type="text" id="detailsOfTrialendwall" placeholder="Enter text here"></td>
  </tr>
    <tr>
    <td style="width:5%;">4.3</td>
  <td style="width:64%;">Remarks</td>
  <td style="width:31%;"><input type="text" id="remarksendwall" placeholder="Enter text here"></td>
  </tr>
  </table>
  <br>
  <p align="center"><b>Endwall Testing Status</b>&nbsp; &nbsp; &nbsp;<input type="radio" id="endwallTestingStatus" name="endwallTestingStatus" value="Conforming">Conforming <input type="radio" id="endwallTestingStatus" name="endwallTestingStatus" value="Non Conforming">Non Conforming</p>
  </form>
 </div>
 </body>

<script type="text/javascript">
		$(document).ready(function() {
		
			var srno,i=1;
			var shelltypes=[];
			shelltypes[0]={ Value: "", DisplayText: "Select" };
			
			<c:forEach var="a" items="${shellType}">
			var o = new Option("${a}", "${a}");
			/// jquerify the DOM object 'o' so we can use the html method
			$(o).html("${a}");
			$("#shellType").append(o);
			shelltypes[i]={ Value: "${a}", DisplayText: "${a}" };
		i++;
	    </c:forEach>

  
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
			
			//Date picker code end here
		//start code
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
			//end code
			
			$('#sidewallSipDate').datepicker({
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

		    });
			$('#roofSipDate').datepicker({
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

		    });
			$('#underframeDate').datepicker({
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

		    });
			$('#lavsidewallSipDate').datepicker({
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

			$('#endwallSipDate').datepicker({
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
			
			
	$('#ShellProductionTableContainer').jtable({
			
			title : 'Shell Shop Production',
			
			paging:true,
            sorting: true,
            defaultSorting: 'shellAssetId ASC',
            selecting: true, //Enable selecting
            multiselect: false, 
            multiSorting: true,
            animationsEnabled : true,
      //Create toolbat
            toolbar: {
                items: [
                	 {
                     	icon: '<%=contextpath%>/images/rs_out.png',
                         text: 'Sidewall SIP',
                         click: function () {
                         	var $selectedRows = $('#ShellProductionTableContainer').jtable('selectedRows');
                     	 	 if ($selectedRows.length<1)
                     		 alert("Please select a row for which you want to Fill SIP Data");
                     	 	 else{
                     	 		var record;
                     	 		$selectedRows.each(function () {
                                     record = $(this).data('record');
                                     });
 								//setting min value
 								
 								//to show data predefine in shell transaction
 								$.ajax({
 								url:"showExistingShellData", //action-name as defined in struts.xml
 								dataType:'json',
 								type:'POST',
 								async:false,
 								data:{
 								shellAssetId:record.shellAssetId,	
 								},
 								success:function(data)
 								{
 									$('#sidewallSipDocNo').val(data.docNoSideWall);
 									$('#sidewallType').val(data.sideWallType);
 									$('#sidewallShellNo').val(data.shellNo);
 									$('#sidewallShellType').val(data.shellType);
 								}
 									
 								});
 								
 								
 								
 							if(record.sidewallSipFlag==1)
 								{
 								var cfm=confirm("Data for Side Wall SIP Testing is already updated for selected Shell. Do you want to verify data?");
 	                          	if(cfm==false){return false;}	
 								$.ajax({
 									url:"showSaveDataSideWall", //action-name as defined in struts.xml
 									dataType:'json',
 									type:'POST',
 									async:false,
 									data:{
 									shellAssetId:record.shellAssetId,	
 									},
 									success:function(data)
 									{
 										$('#sidewallSipShift').val(data.shellSideWallTran.sidewallSipShift);
 										$('#sidewallType').val(data.shellSideWallTran.sidewallType);
 										var sideWallDate=(data.shellSideWallTran.sidewallSipDate).substring(0,10);
 										var sideWallDateArray=sideWallDate.split("-");
 										//var sideWallD= new Date(sideWallDateArray[0],sideWallDateArray[1]-1,sideWallDateArray[2]);
 										$('#sidewallSipDate').datepicker("setDate", new Date(sideWallDateArray[0],sideWallDateArray[1]-1,sideWallDateArray[2]))
 										$('#sideWallDrawingNo').val(data.shellSideWallTran.drawingNo);
 										$('#sideWallWiNo').val(data.shellSideWallTran.wiNo);
 										$('#frameWorkBy').val(data.shellSideWallTran.frameWorkBy);
 										$('#frameJigRoboticsBo').val(data.shellSideWallTran.frameJigRoboticsBo);
 										$('#spotWeldingBy').val(data.shellSideWallTran.spotWeldingBy);
 										$('#spotWeldingJigRoboticsBo').val(data.shellSideWallTran.spotWeldingJigRoboticsBo);
 										$('#interlockJointBy').val(data.shellSideWallTran.interlockJointBy);
 										$('#interlockJointJigRoboticsBo').val(data.shellSideWallTran.interlockJointJigRoboticsBo);
 										$('#sidewallCarlineMakeLh').val(data.shellSideWallTran.sidewallCarlineMakeLh);
 										$('#sidewallCarlineMakeRh').val(data.shellSideWallTran.sidewallCarlineMakeRh);
 										$('#sidewallMakeLh').val(data.shellTran.sideWallMakePp);
 										$('#sidewallMakeRh').val(data.shellTran.sideWallMakeNpp);
 										$('#sidewallNoLh').val(data.shellTran.sideWallNoPp);
 										$('#sidewallNoRh').val(data.shellTran.sideWallNoNpp);
 										$('[id="observationItemAsPerDrawingFlag"]').val([data.shellSideWallTran.observationItemAsPerDrawingFlag]);
 										$('[id="observationComplianceWiFlag"]').val([data.shellSideWallTran.observationComplianceWiFlag]);
 										$('[id="observationWeldingThoatLengthFlag"]').val([data.shellSideWallTran.observationWeldingThoatLengthFlag]);
 										$('[id="observationSheetJointLaserFlag"]').val([data.shellSideWallTran.observationSheetJointLaserFlag]);
 										$('[id="observationSidewallFrameWorkFlag"]').val([data.shellSideWallTran.observationSidewallFrameWorkFlag]);
 										$('[id="observationSidewallConditionSpotWeldingFlag"]').val([data.shellSideWallTran.observationSidewallConditionSpotWeldingFlag]);
 										$('[id="observationHorizontalVerticalJointWeldingFlag"]').val([data.shellSideWallTran.observationHorizontalVerticalJointWeldingFlag]);
 										$('[id="observationRoofFlangeJointFlag"]').val([data.shellSideWallTran.observationRoofFlangeJointFlag]);

 										
 										$('#observationSidewallSheetTorque').val(data.shellSideWallTran.observationSidewallSheetTorque);
 										
 										$('#sidewallSheetLengthLh').val(data.shellSideWallTran.sidewallSheetLengthLh);
 										$('#sidewallSheetLengthRh').val(data.shellSideWallTran.sidewallSheetLengthRh);
 										$('#sidewallSheetWidth').val(data.shellSideWallTran.sidewallSheetWidth);
 										$('#sidewallHeightVerticalmemberRoofflange').val(data.shellSideWallTran.sidewallHeightVerticalmemberRoofflange);
 										
 										$('[id="spotWeldingCarlinearchFlag"]').val([data.shellSideWallTran.spotWeldingCarlinearchFlag]);
 										
 										$('[id="brazingCarlineSidewallFlag"]').val([data.shellSideWallTran.brazingCarlineSidewallFlag]);
 						
 										$('[id="windowProfileFlag"]').val([data.shellSideWallTran.windowProfileFlag]);
 										$('#pullBoxDistance').val(data.shellSideWallTran.pullBoxDistance);
 										
 										$('[id="windowSealLeakageFlag"]').val([data.shellSideWallTran.windowSealLeakageFlag]);
 										
 										$('[id="windowSealAngleFlag"]').val([data.shellSideWallTran.windowSealAngleFlag]);
 										$('#distanceCarlinetopVerticalmember').val(data.shellSideWallTran.distanceCarlinetopVerticalmember);
 										$('#lengthSidewallCarlineLh').val(data.shellSideWallTran.lengthSidewallCarlineLh);
 										$('#lengthSidewallCarlineRh').val(data.shellSideWallTran.lengthSidewallCarlineRh);
 									
 										$('[id="carlineLeakageFlag"]').val([data.shellSideWallTran.carlineLeakageFlag]);
 									
 										$('[id="horizontalVerticalWeldingGrindingFlag"]').val([data.shellSideWallTran.horizontalVerticalWeldingGrindingFlag]);
 										$('#distanceBackpieceVerticalmemberTransverse').val(data.shellSideWallTran.distanceBackpieceVerticalmemberTransverse);
 										$('#distanceBackpieceVerticalmemberSingle').val(data.shellSideWallTran.distanceBackpieceVerticalmemberSingle);
 										$('#roofFlangeLength').val(data.shellSideWallTran.roofFlangeLength);
 										$('#widthHatchedDoor').val(data.shellSideWallTran.widthHatchedDoor);
 										$('#distanceBerthchannelVerticalchannelLowerLh').val(data.shellSideWallTran.distanceBerthchannelVerticalchannelLowerLh);
 										$('#distanceBerthchannelVerticalchannelMiddleLh').val(data.shellSideWallTran.distanceBerthchannelVerticalchannelMiddleLh);
 										$('#distanceBerthchannelVerticalchannelUpperLh').val(data.shellSideWallTran.distanceBerthchannelVerticalchannelUpperLh);
 										$('#distanceBerthchannelVerticalchannelUpperRh').val(data.shellSideWallTran.distanceBerthchannelVerticalchannelUpperRh);
 								        $('#distanceBerthchannelVerticalchannelLowerRh').val(data.shellSideWallTran.distanceBerthchannelVerticalchannelLowerRh);
 										$('#distanceWindowcenterAnglewindowsupport').val(data.shellSideWallTran.distanceWindowcenterAnglewindowsupport);
 										$('#distanceWindowedgeChannel').val(data.shellSideWallTran.distanceWindowedgeChannel);
 										$('#heightCarline').val(data.shellSideWallTran.heightCarline);
 										$('#lengthSmallcarline').val(data.shellSideWallTran.lengthSmallcarline);
 										$('#angleLowerluggageBottomsidewall').val(data.shellSideWallTran.angleLowerluggageBottomsidewall);
 										$('#distanceAnglehoneyprtSidewallDoorside1').val(data.shellSideWallTran.distanceAnglehoneyprtSidewallDoorside1);
 										$('#distanceAnglehoneyprtSidewallDoorside2').val(data.shellSideWallTran.distanceAnglehoneyprtSidewallDoorside2);
 										$('#distanceAnglehoneyprtSidewallDoorside3').val(data.shellSideWallTran.distanceAnglehoneyprtSidewallDoorside3);
 										$('#distanceAnglehoneyprtSidewallDoorside4').val(data.shellSideWallTran.distanceAnglehoneyprtSidewallDoorside4);
 										$('#distanceAnglehoneyprtSidewallMiddlearea1').val(data.shellSideWallTran.distanceAnglehoneyprtSidewallMiddlearea1);
 										$('#distanceAnglehoneyprtSidewallMiddlearea2').val(data.shellSideWallTran.distanceAnglehoneyprtSidewallMiddlearea2);
 										$('#distanceAnglehoneyprtSidewallMiddlearea3').val(data.shellSideWallTran.distanceAnglehoneyprtSidewallMiddlearea3);
 										$('#distanceAnglehoneyprtSidewallMiddlearea4').val(data.shellSideWallTran.distanceAnglehoneyprtSidewallMiddlearea4);
 										$('#sideWallDetailsOfModification').val(data.shellSideWallTran.sideWallDetailsOfModification);
 										$('#sideWallDetailsOfTrialItem').val(data.shellSideWallTran.sideWallDetailsOfTrialItem);
 										$('#sideWallRemarks').val(data.shellSideWallTran.sideWallRemarks);
 										$('#shellSidewallTestingStatus').val(data.shellSideWallTran.shellSidewallTestingStatus);
 										
 									}
 										
 									});
 								
 								}
 												
 								$('#sidewallDate').datepicker('option', 'minDate', new Date(record.assemblyStartDate));
 								
             					
                     	 	 	$("#sidewallSIPDialog").dialog({
                     	 	 		title : 'Side Wall Inspection for  '+record.shellTransactionId + 'from Stage- <%=stageID%>',
                     	 	 		width:'58%',
                     	 	 		close: function (e, u) {
               	 		              //$(".formError").remove();
               	 		          	$("#sidewallSIPDialog").validationEngine('hideAll');
               	 		         $('#sidewallSIPDialog').find('form[name="sidewallSip"]')[0].reset();
               	 		          },
                 	 		 	
  		 							buttons: {
 	                                    Submit: {
 	                                       text: "Submit",
 	                                        id: "my-button-submit",
 	                                        click:function () {
 	                                    		
 	                                    	//alert("$('#qtyDispatched').val()->"+$('#qtyDispatched').val());
 	                                    	//alert("record.balanceQtyToDispatch->"+record.balanceQtyToDispatch);
 	                            	 		
 	                                    	if ($('#sidewallSipShift').validationEngine('validate')) {
 				                                        	
 				                                            return false;
 				                                        }  //similar for other
 				                                        
 											if ($('#sidewallSipDocNo').validationEngine('validate')) {
 				                                        	
 				                                            return false;
 				                                        } 
 											if ($('#sidewallSipDate').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#observationSidewallSheetTorque').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#sidewallSheetLengthLh').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#sidewallSheetLengthRh').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#sidewallSheetWidth').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#sidewallHeightVerticalmemberRoofflange').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#pullBoxDistance').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#distanceCarlinetopVerticalmember').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#lengthSidewallCarlineLh').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#lengthSidewallCarlineRh').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#roofFlangeLength').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#widthHatchedDoor').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 											if ($('#distanceBerthchannelVerticalchannelLowerLh').validationEngine('validate')) {
 	
     												return false;
 											}
 											if ($('#distanceBerthchannelVerticalchannelUpperRh').validationEngine('validate')) {
 	
    													 return false;
 											}
 											if ($('#distanceWindowcenterAnglewindowsupport').validationEngine('validate')) {
 	
     											return false;
 											}
 											if ($('#distanceWindowedgeChannel').validationEngine('validate')) {
 	
    													 return false;
 											}
 											if ($('#heightCarline').validationEngine('validate')) {
 												
 													 return false;
 										    }
 											if ($('#lengthSmallcarline').validationEngine('validate')) {
 												
 													 return false;
 										}
 											if ($('#angleLowerluggageBottomsidewall').validationEngine('validate')) {
 												
 													 return false;
 										}
 											if ($('#distanceAnglehoneyprtSidewallDoorside1').validationEngine('validate')) {
 												
 													 return false;
 										}
 											if ($('#distanceAnglehoneyprtSidewallDoorside2').validationEngine('validate')) {
 												
 												 return false;
 									}
 											if ($('#distanceAnglehoneyprtSidewallDoorside3').validationEngine('validate')) {
 												
 												 return false;
 									}
 											if ($('#distanceAnglehoneyprtSidewallDoorside4').validationEngine('validate')) {
 												
 												 return false;
 									}
 											if ($('#distanceAnglehoneyprtSidewallMiddlearea1').validationEngine('validate')) {
 												
 												 return false;
 									}
 											if ($('#distanceAnglehoneyprtSidewallMiddlearea2').validationEngine('validate')) {
 												
 												 return false;
 									}
 											if ($('#distanceAnglehoneyprtSidewallMiddlearea3').validationEngine('validate')) {
 												
 												 return false;
 									}
 											if ($('#distanceAnglehoneyprtSidewallMiddlearea4').validationEngine('validate')) {
 												
 												 return false;
 									}
 											if ($('#shellSidewallTestingStatus').validationEngine('validate')) {
 												
												 return false;
									}

 											
 	                                   var c=confirm("Do you want to submit data for Sidewall Testing");
 	                                    	if(c==false){return false;}
                                          		    	   
 	                                    	$.ajax({
 	                    						url : "savesidewallSIP",  //action-name as defined in struts.xml
 	                    						dataType: 'json', 
 	                    						data : {
 	                    							shellAssetId: record.shellAssetId,
 	                    							sidewallDate:$('#sidewallSipDate').val(),
 	                    							 sidewallSipDocNo:$('#sidewallSipDocNo').val(),
 	                    							 sidewallShellType:$('#sidewallShellType').val(),
 	                    							 sidewallShellNo:$('#sidewallShellNo').val(),
 	                    						  sidewallSipShift:$('#sidewallSipShift').val(),
 	                    						  sidewallType:$('#sidewallType').val(),
 	                    						 sideWallDrawingNo:$('#sideWallDrawingNo').val(),
 	                    						sideWallWiNo:$('#sideWallWiNo').val(),
 	                    						  frameWorkBy:$('#frameWorkBy').val(),
 	                    						  frameJigRoboticsBo:$('#frameJigRoboticsBo').val(),
 	                    						  spotWeldingBy:$('#spotWeldingBy').val(),
 	                    						  spotWeldingJigRoboticsBo:$('#spotWeldingJigRoboticsBo').val(),
 	                    						  interlockJointBy:$('#interlockJointBy').val(),
 	                    					  	  interlockJointJigRoboticsBo:$('#interlockJointJigRoboticsBo').val(),
 	                    						  sidewallCarlineMakeLh:$('#sidewallCarlineMakeLh').val(),
 	                    						  sidewallCarlineMakeRh:$('#sidewallCarlineMakeRh').val(),
 	                    						  sidewallMakeLh:$('#sidewallMakeLh').val(),
 	                    						  sidewallMakeRh:$('#sidewallMakeRh').val(),
 	                    						  sidewallNoLh:$('#sidewallNoLh').val(),
	                    						  sidewallNoRh:$('#sidewallNoRh').val(),
 	                    						  observationItemAsPerDrawingFlag:$("input[id='observationItemAsPerDrawingFlag']:checked").val(),
 	                    						  observationComplianceWiFlag:$("input[id='observationComplianceWiFlag']:checked").val(),
 	                    						  observationWeldingThoatLengthFlag:$("input[id='observationWeldingThoatLengthFlag']:checked").val(),
 	                    						  observationSheetJointLaserFlag:$("input[id='observationSheetJointLaserFlag']:checked").val(),
 	                    						  observationSidewallSheetTorque:$('#observationSidewallSheetTorque').val(),
 	                    						  observationSidewallFrameWorkFlag:$("input[id='observationSidewallFrameWorkFlag']:checked").val(),
 	                    						  observationSidewallConditionSpotWeldingFlag:$("input[id='observationSidewallConditionSpotWeldingFlag']:checked").val(),
 	                    						  observationHorizontalVerticalJointWeldingFlag:$('#observationHorizontalVerticalJointWeldingFlag').val(),
 	                    						  observationRoofFlangeJointFlag:$("input[id='observationRoofFlangeJointFlag']:checked").val(),
 	                    						  sidewallSheetLengthLh:$('#sidewallSheetLengthLh').val(),
 	                    						  sidewallSheetLengthRh:$('#sidewallSheetLengthRh').val(),
 	                    						  sidewallSheetWidth:$('#sidewallSheetWidth').val(),
 	                    						  sidewallHeightVerticalmemberRoofflange:$('#sidewallHeightVerticalmemberRoofflange').val(),
 	                    						  spotWeldingCarlinearchFlag:$("input[id='spotWeldingCarlinearchFlag']:checked").val(),
 	                    						  brazingCarlineSidewallFlag:$("input[id='brazingCarlineSidewallFlag']:checked").val(),
 	                    						  windowProfileFlag:$("input[id='windowProfileFlag']:checked").val(),
 	                    						  pullBoxDistance:$('#pullBoxDistance').val(),
 	                    						  windowSealLeakageFlag:$("input[id='windowSealLeakageFlag']:checked").val(),
 	                    						  windowSealAngleFlag:$("input[id='windowSealAngleFlag']:checked").val(),
 	                    						  distanceCarlinetopVerticalmember:$('#distanceCarlinetopVerticalmember').val(),
 	                    						  lengthSidewallCarlineLh:$('#lengthSidewallCarlineLh').val(),
 	                    						  lengthSidewallCarlineRh:$('#lengthSidewallCarlineRh').val(),
 	                    						  carlineLeakageFlag:$("input[id='carlineLeakageFlag']:checked").val(),
 	                    						  horizontalVerticalWeldingGrindingFlag:$("input[id='horizontalVerticalWeldingGrindingFlag']:checked").val(), 
 	                    						  distanceBackpieceVerticalmemberTransverse:$('#distanceBackpieceVerticalmemberTransverse').val(),
 	                    						  distanceBackpieceVerticalmemberSingle:$('#distanceBackpieceVerticalmemberSingle').val(),
 	                    						  roofFlangeLength:$('#roofFlangeLength').val(),
 	                    						  widthHatchedDoor:$('#widthHatchedDoor').val(),
 	                    						  distanceBerthchannelVerticalchannelLowerLh:$('#distanceBerthchannelVerticalchannelLowerLh').val(),
 	                    						  distanceBerthchannelVerticalchannelMiddleLh:$('#distanceBerthchannelVerticalchannelMiddleLh').val(),
 	                    						  distanceBerthchannelVerticalchannelUpperLh:$('#distanceBerthchannelVerticalchannelUpperLh').val(),
 	                    						  distanceBerthchannelVerticalchannelLowerRh:$('#distanceBerthchannelVerticalchannelLowerRh').val(),
 	                    						  distanceBerthchannelVerticalchannelUpperRh:$('#distanceBerthchannelVerticalchannelUpperRh').val(),
 	                    						  distanceWindowcenterAnglewindowsupport:$('#distanceWindowcenterAnglewindowsupport').val(),
 	                    						  distanceWindowedgeChannel:$('#distanceWindowedgeChannel').val(),
 	                    						  heightCarline:$('#heightCarline').val(),
 	                    						  lengthSmallcarline:$('#lengthSmallcarline').val(),
 	                    						  angleLowerluggageBottomsidewall:$('#angleLowerluggageBottomsidewall').val(),
 	                    						  distanceAnglehoneyprtSidewallDoorside1:$('#distanceAnglehoneyprtSidewallDoorside1').val(),
 	                    						  distanceAnglehoneyprtSidewallDoorside2:$('#distanceAnglehoneyprtSidewallDoorside2').val(),
 	                    						  distanceAnglehoneyprtSidewallDoorside3:$('#distanceAnglehoneyprtSidewallDoorside3').val(),
 	                    					  	  distanceAnglehoneyprtSidewallDoorside4:$('#distanceAnglehoneyprtSidewallDoorside4').val(),
 	                    						  distanceAnglehoneyprtSidewallMiddlearea1:$('#distanceAnglehoneyprtSidewallMiddlearea1').val(),
 	                    						  distanceAnglehoneyprtSidewallMiddlearea2:$('#distanceAnglehoneyprtSidewallMiddlearea2').val(),
 	                    						  distanceAnglehoneyprtSidewallMiddlearea3:$('#distanceAnglehoneyprtSidewallMiddlearea3').val(),
 	                    						  distanceAnglehoneyprtSidewallMiddlearea4:$('#distanceAnglehoneyprtSidewallMiddlearea4').val(),
 	                    						  sideWallDetailsOfModification:$('#sideWallDetailsOfModification').val(),
 	                    						  sideWallDetailsOfTrialItem:$('#sideWallDetailsOfTrialItem').val(),
 	                    						  sideWallRemarks:$('#sideWallRemarks').val(),
 	                    						 shellSidewallTestingStatus:$('#shellSidewallTestingStatus').val(),
 	                    						 
 	                    						  
 	                    						},
 	                    						
 	                    						type : 'POST',
 	                    						async : false,
 	                            	 		})
 	                    						.done(function( msg ) {
 	                    							
 	                    						$('#sidewallSipDate').val(''),
 	                    							$('#sidewallSipDocNo').val(''),
 	                    							$('#sidewallShellNo').val(''),
 	                    							$('#sidewallShellType').val(''),
 	                    						  	$('#sidewallSipShift').val(''),
 	                    						  	$('#sidewallType').val(''),
 	                    						  $('#sideWallDrawingNo').val(''),
 	                    						  $('#sideWallWiNo').val(''),
 	                    						  $('#frameWorkBy').val(''),
 	                    						  $('#frameJigRoboticsBo').val(''),
 	                    						  $('#spotWeldingBy').val(''),
 	                    						  $('#spotWeldingJigRoboticsBo').val(''),
 	                    						  $('#interlockJointBy').val(''),
 	                    					  	  $('#interlockJointJigRoboticsBo').val(''),
 	                    						  $('#sidewallCarlineMakeLh').val(''),
 	                    						  $('#sidewallCarlineMakeRh').val(''),
 	                    						  $('#sidewallMakeNoLh').val(''),
 	                    						  $('#sidewallMakeNoRh').val(''),
 	                    						  $("input[id='observationItemAsPerDrawingFlag']:checked").val(''),
 	                    						  $("input[id='observationComplianceWiFlag']:checked").val(''),
 	                    						  $("input[id='observationWeldingThoatLengthFlag']:checked").val(''),
 	                    						  $("input[id='observationSheetJointLaserFlag']:checked").val(''),
 	                    						  $('#observationSidewallSheetTorque').val(''),
 	                    						  $("input[id='observationSidewallFrameWorkFlag']:checked").val(''),
 	                    						  $("input[id='observationSidewallConditionSpotWeldingFlag']:checked").val(''),
 	                    						  $('#observationHorizontalVerticalJointWeldingFlag').val(''),
 	                    						  $("input[id='observationRoofFlangeJointFlag']:checked").val(''),
 	                    						  $('#sidewallSheetLengthLh').val(''),
 	                    						  $('#sidewallSheetLengthRh').val(''),
 	                    						  $('#sidewallSheetWidth').val(''),
 	                    						  $('#sidewallHeightVerticalmemberRoofflange').val(''),
 	                    						  $("input[id='spotWeldingCarlinearchFlag']:checked").val(''),
 	                    						  $("input[id='brazingCarlineSidewallFlag']:checked").val(''),
 	                    						  $("input[id='windowProfileFlag']:checked").val(''),
 	                    						  $('#pullBoxDistance').val(''),
 	                    						  $("input[id='windowSealLeakageFlag']:checked").val(''),
 	                    						  $("input[id='windowSealAngleFlag']:checked").val(''),
 	                    						  $('#distanceCarlinetopVerticalmember').val(''),
 	                    						  $('#lengthSidewallCarlineLh').val(''),
 	                    						  $('#lengthSidewallCarlineRh').val(''),
 	                    						  $("input[id='carlineLeakageFlag']:checked").val(''),
 	                    						  $("input[name='horizontalVerticalWeldingGrindingFlag']:checked").val(''), 
 	                    						  $('#distanceBackpieceVerticalmemberTransverse').val(''),
 	                    						  $('#distanceBackpieceVerticalmemberSingle').val(''),
 	                    						  $('#roofFlangeLength').val(''),
 	                    						  $('#widthHatchedDoor').val(''),
 	                    						  $('#distanceBerthchannelVerticalchannelLowerLh').val(''),
 	                    						  $('#distanceBerthchannelVerticalchannelMiddleLh').val(''),
 	                    						  $('#distanceBerthchannelVerticalchannelUpperLh').val(''),
 	                    						  $('#distanceBerthchannelVerticalchannelLowerRh').val(''),
 	                    						  $('#distanceBerthchannelVerticalchannelUpperRh').val(''),
 	                    						  $('#distanceWindowcenterAnglewindowsupport').val(''),
 	                    						  $('#distanceWindowedgeChannel').val(''),
 	                    						  $('#heightCarline').val(''),
 	                    						  $('#lengthSmallcarline').val(''),
 	                    						  $('#angleLowerluggageBottomsidewall').val(''),
 	                    						  $('#distanceAnglehoneyprtSidewallDoorside1').val(''),
 	                    						  $('#distanceAnglehoneyprtSidewallDoorside2').val(''),
 	                    						  $('#distanceAnglehoneyprtSidewallDoorside3').val(''),
 	                    					  	  $('#distanceAnglehoneyprtSidewallDoorside4').val(''),
 	                    						  $('#distanceAnglehoneyprtSidewallMiddlearea1').val(''),
 	                    						  $('#distanceAnglehoneyprtSidewallMiddlearea2').val(''),
 	                    						  $('#distanceAnglehoneyprtSidewallMiddlearea3').val(''),
 	                    						  $('#distanceAnglehoneyprtSidewallMiddlearea4').val(''),
 	                    						  $('#sideWallDetailsOfModification').val(''),
 	                    						  $('#sideWallDetailsOfTrialItem').val(''),
 	                    						  $('#sideWallRemarks').val(''),
 	                
 	                    							                    							
 	                    							$('#sidewallSIPDialog').dialog('close');
 	                    							$('#ShellProductionTableContainer').jtable('load');
 	         								  })
 	         								.error(function (msg){
 	         									//$('#dialog').dialog('close');
 	         									alert("Error Fetching Data");
 	         								})
 	         								  ;
 					                 			    	   return true;
 				                                    }
 	                                    },
 				                        Close: function () {
 				                        	$('#sidewallSIPDialog').find('form[name="sidewallSip"]')[0].reset(); 
 				                                        $(this).dialog('close');
 				                                    }
 	                                    },
 	                    	        modal: true
     	    });
                     	 		
                     	 		
                     	 		
                     	 		
                     	 		
                     	 		    
             			    	   return true;
                     	 		    
                     	 			  
                     	 		  }//ending else               	  
                     	  // ajax call ends here				
     						 
                         }
                     },
                     
                     {
                     	icon: '<%=contextpath%>/images/rs_out.png',
                         text: 'Roof SIP',
                         click: function () {
                         	
                         	
                         	
                         	 var $selectedRows = $('#ShellProductionTableContainer').jtable('selectedRows');
                     	 	 if ($selectedRows.length<1)
                     		 alert("Please select a row for which you want to fill inspection");
                     	 	 else{
                     	 		var record;
                     	 		$selectedRows.each(function () {
                                     record = $(this).data('record');
                                     });
 								//setting min value
 								$.ajax({
 								url:"showExistingRoofData",  //action-name as defined in struts.xml
 								dataType:'json',
 								type:'POST',
 								async:false,
 								data:{
 								shellAssetId:record.shellAssetId,	
 								},
 								success:function(data)
 								{
 									$('#roofSipDocNo').val(data.docNoRoof);
 									$('#roofMake').val(data.roofMake);
 									$('#roofNo').val(data.roofNo);
 									
 								}
 									
 								});
 								//end of code
 								if(record.roofSipFlag==1)
 								{
 								
 								$.ajax({
 									url:"showSaveDataRoof", //action-name as defined in struts.xml
 									dataType:'json',
 									type:'POST',
 									async:false,
 									data:{
 									shellAssetId:record.shellAssetId,	
 									},
 									success:function(data)
 									{
 										$('#roofSipShift').val(data.shellRoofTransaction.roofSipShift);
 										$('#roofType').val(data.shellRoofTransaction.roofType);
 										
 										var roofDate=(data.shellRoofTransaction.roofSipDate).substring(0,10);
 										var roofDateArray=roofDate.split("-");
 										$('#roofSipDate').datepicker("setDate",new Date(roofDateArray[0],roofDateArray[1]-1,roofDateArray[2])); 
 										$('#roofApplicableDrawingNo').val(data.shellRoofTransaction.applicableDrawingNo);
 										$('#roofApplicableWiNo').val(data.shellRoofTransaction.applicableWiNo);
 									   $('[id="machineSpotWeild"]').val([data.shellRoofTransaction.machineSpotWeild]);
 										//$('#machineSpotWeild').val(data.shellRoofTransaction.machineSpotWeild);
 										$('[id="observationItemAsPerDrawing"]').val([data.shellRoofTransaction.observationItemAsPerDrawing]);
 										//$('#observationItemAsPerDrawing').val(data.shellRoofTransaction.observationItemAsPerDrawing);
 										$('[id="observationComplianceWi"]').val([data.shellRoofTransaction.observationComplianceWi]);
 										//$('#observationComplianceWi').val(data.shellRoofTransaction.observationComplianceWi);
 										$('[id="observationWeildingThroatLength"]').val([data.shellRoofTransaction.observationWeildingThroatLength]);
 										//$('#observationWeildingThroatLength').val(data.shellRoofTransaction.observationWeildingThroatLength);
 										$('#lengthRoof').val(data.shellRoofTransaction.lengthRoof);
 										$('#lengthRoofsheet').val(data.shellRoofTransaction.lengthRoofsheet);
 										$('#widthRoofsheet').val(data.shellRoofTransaction.widthRoofsheet);
 										$('#roofArchPositionPp').val(data.shellRoofTransaction.roofArchPositionPp);
 										$('#roofArchPositionNpp').val(data.shellRoofTransaction.roofArchPositionNpp);
 										$('#roofArchCompletePp').val(data.shellRoofTransaction.roofArchCompletePp);
 										$('#roofArchCompleteNpp').val(data.shellRoofTransaction.roofArchCompleteNpp);
 										$('#crossBraceHeight').val(data.shellRoofTransaction.crossBraceHeight);
 										$('#roofArchWidth').val(data.shellRoofTransaction.roofArchWidth);
 										$('#distanceRoofcenterlineFanbkt').val(data.shellRoofTransaction.distanceRoofcenterlineFanbkt);
 										$('#distanceRoofcenterlineCenterlinebkt').val(data.shellRoofTransaction.distanceRoofcenterlineCenterlinebkt);
 										$('#distanceRoofcenterlineBerthsuspensionbkt').val(data.shellRoofTransaction.distanceRoofcenterlineBerthsuspensionbkt);
 										$('#trayAreaLength').val(data.shellRoofTransaction.trayAreaLength);
 										$('#distanceRoofcenterlineFanbktNppPp').val(data.shellRoofTransaction.distanceRoofcenterlineFanbktNppPp);
 										$('#distanceRoofcenterlineTerminalboardbktNppPp').val(data.shellRoofTransaction.distanceRoofcenterlineTerminalboardbktNppPp);
 										$('#distanceRoofcenterlineChannelLhRh').val(data.shellRoofTransaction.distanceRoofcenterlineChannelLhRh);
 										$('#distanceCrossBraceBracket').val(data.shellRoofTransaction.distanceCrossBraceBracket);
 										$('#checkedDimensionRemark').val(data.shellRoofTransaction.checkedDimensionRemark);
 										$('#distanceCenterlineroofCenterlineflbkts').val(data.shellRoofTransaction.distanceCenterlineroofCenterlineflbkts);
 										//$('#conditionRoofSheetJoint').val(data.shellRoofTransaction.conditionRoofSheetJoint);
 										$('[id="conditionRoofSheetJoint"]').val([data.shellRoofTransaction.conditionRoofSheetJoint]);
 										//$('#roofSheetJointLeakage').val(data.shellRoofTransaction.roofSheetJointLeakage);
 										$('[id="roofSheetJointLeakage"]').val([data.shellRoofTransaction.roofSheetJointLeakage]);
 										//$('#conditionRoofSheetArch').val(data.shellRoofTransaction.conditionRoofSheetArch);
 										$('[id="conditionRoofSheetArch"]').val([data.shellRoofTransaction.conditionRoofSheetArch]);
 										$('#distanceRoofcenterlineCenterlineelbkt').val(data.shellRoofTransaction.distanceRoofcenterlineCenterlineelbkt);
 										//$('#fittmentLstiffener').val(data.shellRoofTransaction.fittmentLstiffener);
 										$('[id="fittmentLstiffener"]').val([data.shellRoofTransaction.fittmentLstiffener]);
 										$('#distanceRoofcenterlineSpeakerbkt').val(data.shellRoofTransaction.distanceRoofcenterlineSpeakerbkt);
 										$('#distanceRoofcenterlineElbkt').val(data.shellRoofTransaction.distanceRoofcenterlineElbkt);
 										$('#noCrossBracesFitted').val(data.shellRoofTransaction.noCrossBracesFitted);
 										$('#roofDetailsOfModification').val(data.shellRoofTransaction.detailsOfModification);
 										$('#roofDetailsOfTrial').val(data.shellRoofTransaction.detailsOfTrial);
 										$('#roofRemarks').val(data.shellRoofTransaction.remarks);
 										//$('#shellRoofSipTestingStatus').val(data.shellRoofTransaction.shellRoofSipTestingStatus);
 										$('[id="shellRoofSipTestingStatus"]').val([data.shellRoofTransaction.shellRoofSipTestingStatus]);
 										$('#entryBy').val(data.shellRoofTransaction.entryBy);
 										$('#entryTime').val(data.shellRoofTransaction.entryTime);
 										
 									}
 										
 									});
 								
 								}
 								
 								$('#roofSipDate').datepicker('option', 'minDate', new Date(record.assemblyStartDate));
 								
             					
                     	 	 	$("#RoofSIPDialog").dialog({
                     	 	 		title : 'Roof Inspection for '+record.shellTransactionId + 'from Stage- <%=stageID%>', 
                     	 	 		width:'60%',
                     	 	 		close: function (e, u) {
               	 		              //$(".formError").remove();
               	 		          	$("#RoofSIPDialog").validationEngine('hideAll');
               	 		          	$('#RoofSIPDialog').find('form[name="roofSIP"]')[0].reset();
               	 		          	
               	 		          },
                 	 		 	
  		 							buttons: {
 	                                    Submit: {
 	                                       text: "Submit",
 	                                        id: "my-button-submit",
 	                                        click:function () {
 	                                        	
 	 	                                    	
 	                            	 		 	
 	                                    	
 	                                   
 	                                    	if ($('#lengthRoof').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    	//alert("error");
 	                                    	if ($('#lengthRoofsheet').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    	if ($('#widthRoofsheet').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    	if ($('#roofArchPositionPp').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    	
 	                                    	if ($('#roofArchPositionNpp').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    
 	                                    	if ($('#roofArchCompletePp').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    	if ($('#roofArchCompleteNpp').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    	if ($('#crossBraceHeight').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    	if ($('#roofArchWidth').validationEngine('validate')) {
 	                                            return false;
 	                                        }
 	                                    	
 	                                    	
 	                                    	//similar for others
 				                                        
 	                                    	var c=confirm("submit data for Roof");
 	                                    	if(c==false){return false;}
                                           //   if ($('#underFrameNumber').validationEngine('validate')) {
 	                                        	
 	                                       //     return false;
 	                                      //  }
 	                                    		    	   
 	                                    	$.ajax({
 	                    						url : "saveRoofSIP",  //action-name as defined in struts.xml
 	                    						dataType: 'json', 
 	                    						data : {
 	                    							shellAssetId: record.shellAssetId,                   							
 	                    							roofSipDocNo:$('#roofSipDocNo').val(),              							
 	                    							roofSipShift:$('#roofSipShift').val(),
 	                    					
 	                    					        roofSipDate: $('#roofSipDate').val(),  
 	                    							roofType:$('#roofType').val(),
 	                    							roofMake:$('#roofMake').val(), 
 	                    							roofNo:$('#roofNo').val(),
 	                    							roofApplicableDrawingNo:$('#roofApplicableDrawingNo').val(),
 	                    							roofApplicableWiNo: $('#roofApplicableWiNo').val(),                   							
 	                    							machineSpotWeild:$("input[id='machineSpotWeild']:checked").val(),              							
 	                    							observationItemAsPerDrawing:$("input[id='observationItemAsPerDrawing']:checked").val(),
 	                    							observationComplianceWi: $("input[id='observationComplianceWi']:checked").val(),                   							
 	                    							observationWeildingThroatLength:$("input[id='observationWeildingThroatLength']:checked").val(),              							
 	                    							lengthRoof:$('#lengthRoof').val(),
 	                    						//	underFrameNumber:$('#underFrameNumber').val(),
 	                    							lengthRoofsheet:$('#lengthRoofsheet').val(),
 	                    							widthRoofsheet:$('#widthRoofsheet').val(),
 	                    							 roofArchPositionPp:$('#roofArchPositionPp').val(),
 	                    							 roofArchPositionNpp:$('#roofArchPositionNpp').val(),
 	                    							roofArchCompletePp:$('#roofArchCompletePp').val(),
 	                    							roofArchCompleteNpp:$('#roofArchCompleteNpp').val(),
 	                    						    crossBraceHeight:$('#crossBraceHeight').val(),
 	                    							roofArchWidth:$('#roofArchWidth').val(),
 	                    							distanceRoofcenterlineFanbkt:$('#distanceRoofcenterlineFanbkt').val(),
 	                    							distanceRoofcenterlineCenterlinebkt:$('#distanceRoofcenterlineCenterlinebkt').val(),
 	                    							distanceRoofcenterlineBerthsuspensionbkt:$('#distanceRoofcenterlineBerthsuspensionbkt').val(),
 	                    							trayAreaLength:$('#trayAreaLength').val(),
 	                    							distanceRoofcenterlineFanbktNppPp:$('#distanceRoofcenterlineFanbktNppPp').val(),
 	                    							distanceRoofcenterlineTerminalboardbktNppPp:$('#distanceRoofcenterlineTerminalboardbktNppPp').val(),
 	                    							distanceRoofcenterlineChannelLhRh:$('#distanceRoofcenterlineChannelLhRh').val(),
 	                    							distanceCrossBraceBracket:$('#distanceCrossBraceBracket').val(),
 	                    						    checkedDimensionRemark:$('#checkedDimensionRemark').val(),
 	                    						    distanceCenterlineroofCenterlineflbkts:$('#distanceCenterlineroofCenterlineflbkts').val(),
 	                    							conditionRoofSheetJoint:$("input[id='conditionRoofSheetJoint']:checked").val(),
 	                    							roofSheetJointLeakage:$("input[id='roofSheetJointLeakage']:checked").val(),
 	                    							conditionRoofSheetArch:$("input[id='conditionRoofSheetArch']:checked").val(),
 	                    						    distanceRoofcenterlineCenterlineelbkt:$('#distanceRoofcenterlineCenterlineelbkt').val(),
 	                    						    fittmentLstiffener:$("input[id='fittmentLstiffener']:checked").val(),
 	                    							distanceRoofcenterlineSpeakerbkt:$('#distanceRoofcenterlineSpeakerbkt').val(),
 	                    							distanceRoofcenterlineElbkt:$('#distanceRoofcenterlineElbkt').val(),
 	                    							noCrossBracesFitted:$('#noCrossBracesFitted').val(),
 	                    				            roofDetailsOfModification:$('#roofDetailsOfModification').val(),
 	                    							roofDetailsOfTrial:$('#roofDetailsOfTrial').val(),
 	                    							roofRemarks:$('#roofRemarks').val(),
 	                    							shellRoofSipTestingStatus:$("input[id='shellRoofSipTestingStatus']:checked").val(),
 	                    							entryby:$('#entryBy').val(),
 	                    							entrytime:$('#entryTime').val()
 	                    						},
 	                    						
 	                    						type : 'POST',
 	                    						async : false,
 	                            	 		})
 	                    						.done(function( msg ) {
 	                    							$('#shellAssetId').val(''),                   							
 		                    						$('#roofSipDocNo').val(''),              							
 		                    					    $('#roofSipShift').val(''),
 		                    						$('#roofSipDate').val(''),
 		                    						$('#roofType').val(''),
 		                    						$('#roofMake').val(''), 
 		                    						$('#roofNo').val(''), 
 		                    						$('#roofApplicableDrawingNo').val(''),
 		                    						$('#roofApplicableWiNo').val(''),                   							
 		                    						$("input[id='machineSpotWeild']:checked").val(''),
 		                    						$("input[id='observationItemAsPerDrawing']:checked").val(''),
 		                    						$("input[id='observationComplianceWi']:checked").val(''),
 		                    						$("input[id='observationWeildingThroatLength']:checked").val(''),         							
 		                    						$('#lengthRoof').val(''),
 		                    						//	underFrameNumber:$('#underFrameNumber').val(),
 		                    						$('#lengthRoofsheet').val(''),
 		                    						$('#widthRoofsheet').val(''),
 		                    						$('#roofArchPositionPp').val(''),
 		                    						$('#roofArchPositionNpp').val(''),
 		                    						$('#roofArchCompletePp').val(''),
 		                    						$('#roofArchCompleteNpp').val(''),
 		                    					    $('#crossBraceHeight').val(''),
 		                    						$('#roofArchWidth').val(''),
 		                    						$('#distanceRoofcenterlineFanbkt').val(''),
 		                   							$('#distanceRoofcenterlineCenterlinebkt').val(''),
 		                   							$('#distanceRoofcenterlineBerthsuspensionbkt').val(''),
 		                   							$('#trayAreaLength').val(''),
 		                   							$('#distanceRoofcenterlineFanbktNppPp').val(''),
 		                   							$('#distanceRoofcenterlineTerminalboardbktNppPp').val(''),
 		                   							$('#distanceRoofcenterlineChannelLhRh').val(''),
 		                   						    $('#distanceCrossBraceBracket').val(''),
 		                   							$('#checkedDimensionRemark').val(''),
 		                    						$('#distanceCenterlineroofCenterlineflbkts').val(''),
 		                    						$("input[id='conditionRoofSheetJoint']:checked").val(''),
 		                    						$("input[id='roofSheetJointLeakage']:checked").val(''),
 		                    						$("input[id='conditionRoofSheetArch']:checked").val(''),
 		                    						$('#distanceRoofcenterlineCenterlineelbkt').val(''),
 		                    						$("input[id='fittmentLstiffener']:checked").val(''),
 		                    						$('#distanceRoofcenterlineSpeakerbkt').val(''),
 		                    					    $('#distanceRoofcenterlineElbkt').val(''),
 		                    				        $('#noCrossBracesFitted').val(''),
 		                    						$('#roofDetailsOfModification').val(''),
 		                    					    $('#roofDetailsOfTrial').val(''),
 		                    						$('#roofRemarks').val(''),
 		                    					    $("input[id='shellRoofSipTestingStatus']:checked").val(''),
 		                    					    $('#entryBy').val(''),
 		                    					    $('#entryTime').val(''),
 	                    							
 	      
 	                    							$('#RoofSIPDialog').dialog('close');
 	                    							
 	                    							$('#ShellProductionTableContainer').jtable('load');
 	         								  })
 	         								.error(function (msg){
 	         									//$('#dialog').dialog('close');
 	         									alert("Error Fetching Data");
 	         								})
 	         								  ;
 					                 			    	   return true;
 				                                    }
 	                                    },
 				                        Close: function () {
 				                        	$('#RoofSIPDialog').find('form[name="roofSIP"]')[0].reset();
 				                                        $(this).dialog('close');
 				                                    }
 	                                    },
 	                    	        modal: true
     	    });
                     	 		
                     	 		
                     	 		
                     	 		
                     	 		
                     	 		    
             			    	   return true;
                     	 		    
                     	 			  
                     	 		  }//ending else               	  
                     	  // ajax call ends here				
     						 
                         }
                     },
                     
                     {
                     	icon: '<%=contextpath%>/images/rs_out.png',
                         text: 'Underframe SIP',
                         click: function () {
                         	
                         	
                         	
                         	 var $selectedRows = $('#ShellProductionTableContainer').jtable('selectedRows');
                     	 	 if ($selectedRows.length<1)
                     		 alert("Please select a row for which you want to set Inspection For Underframe");
                     	 	 else{
                     	 		var record;
                     	 		$selectedRows.each(function () {
                                     record = $(this).data('record');
                                     });
 								//setting min value
 								$.ajax({
 								url:"showExistingShellData",  //action-name as defined in struts.xml
 								dataType:'json',
 								type:'POST',
 								async:false,
 								data:{
 								shellAssetId:record.shellAssetId,	
 								},
 								success:function(data)
 								{
 									$('#underframeDocNo').val(data.docnounderframe);
 									$('#shellType').val(data.shellType);
 									$('#shellNo').val(data.shellNo);
 									
 								}
 									
 								});
 								
 								if(record.underframeSipFlag==1)
 								{
 								
 								$.ajax({
 									url:"showSaveDataUnderframe", //action-name as defined in struts.xml
 									dataType:'json',
 									type:'POST',
 									async:false,
 									data:{
 									shellAssetId:record.shellAssetId,	
 									},
 									success:function(data)
 									{	
 										$('#underframeShiftSelect').val(data.shellUndeframeSipTrans.underframeShiftSelect);
 										var underframedate=(data.shellUndeframeSipTrans.underframeDate).substring(0,10);
 										var framedateArray=underframedate.split("-");
 										$('#underframeDate').datepicker("setDate",new Date(framedateArray[0],framedateArray[1]-1,framedateArray[2]));
 										$('#appDrawNoUnderframe').val(data.shellUndeframeSipTrans.appDrawNoUnderframe);
 										$('#appLineNoUnderframe').val(data.shellUndeframeSipTrans.appLineNoUnderframe);
 										$('#appWiNoUnderframe').val(data.shellUndeframeSipTrans.appWiNoUnderframe);
 										
 										$('#frntPrtMakePp').val(data.shellTran.frntPrtMakePp);
 										$('#frntPrtMakeNpp').val(data.shellTran.frntPrtMakeNpp);
 										$('#frntPrtNoPp').val(data.shellTran.frntPrtNoPp);
 										$('#frntPrtNoNpp').val(data.shellTran.frntPrtNoNpp);
 										$('#cbCMakePp').val(data.shellTran.cbCMakePp);
 										$('#cbCMakeNpp').val(data.shellTran.cbCMakeNpp);
 										$('#cbCNoPp').val(data.shellTran.cbCNoPp);
 										$('#cbCNoNpp').val(data.shellTran.cbCNoNpp);
 										$('#cbCFitPp').val(data.shellTran.cbcFittedByPp);
 										$('#cbCFitNpp').val(data.shellTran.cbcFittedByNpp);
 										$('#underframeMakePp').val(data.shellTran.underframeMakePp);
 										$('#underframeMakeNpp').val(data.shellTran.underframeMakeNpp);
 										$('#underframeNoPp').val(data.shellTran.underframeNoPp);
 										$('#underframeNoNpp').val(data.shellTran.underframeNoNpp);
 										$('#waterTankBkt1').val(data.shellTran.waterTankBkt1);
 										$('#waterTankBkt2').val(data.shellTran.waterTankBkt2);
 										$('#waterTankBkt3').val(data.shellTran.waterTankBkt3);
 										$('#waterTankBkt4').val(data.shellTran.waterTankBkt4);
 										$('#underframeCompleteMake').val(data.shellTran.underframeCompleteMake);
 										$('#underframeCompleteNo').val(data.shellTran.underframeCompleteNo);
 										
 										$('[id="itemsFitted"]').val([data.shellUndeframeSipTrans.itemsFitted]);
 										$('[id="compAppWi"]').val([data.shellUndeframeSipTrans.compAppWi]);
 										$('[id="weldThroatLen"]').val([data.shellUndeframeSipTrans.weldThroatLen]);
 										$('[id="tightScrew"]').val([data.shellUndeframeSipTrans.tightScrew]);
 										$('[id="outerFaceOuterHead"]').val([data.shellUndeframeSipTrans.outerFaceOuterHead]);
 										$('[id="conditionOfPlugWelding"]').val([data.shellUndeframeSipTrans.conditionOfPlugWelding]);
 										$('[id="conditionOfConsole"]').val([data.shellUndeframeSipTrans.conditionOfConsole]);
 										$('#bodyBolster').val(data.shellUndeframeSipTrans.bodyBolster);
 										$('#completeLenUndeframe').val(data.shellUndeframeSipTrans.completeLenUndeframe);
 										$('#frntPartToFront').val(data.shellUndeframeSipTrans.frntPartToFront);
 										$('#ufWidth').val(data.shellUndeframeSipTrans.ufWidth);
 										$('#coveringPlate').val(data.shellUndeframeSipTrans.coveringPlate);
 										$('#wedgeBolt').val(data.shellUndeframeSipTrans.wedgeBolt);
 										$('[id="waterTankMount"]').val([data.shellUndeframeSipTrans.waterTankMount]);
 										$('#frntPartBrktDist').val(data.shellUndeframeSipTrans.frntPartBrktDist);
 										$('#distBwConsoleBrkt').val(data.shellUndeframeSipTrans.distBwConsoleBrkt);
 										$('#footStepsDist').val(data.shellUndeframeSipTrans.footStepsDist);
 										$('[id="suppMemTrough"]').val([data.shellUndeframeSipTrans.suppMemTrough]);
 										$('[id="pillarMountChannel"]').val([data.shellUndeframeSipTrans.pillarMountChannel]);
 										$('#distBwCurvedRoll').val(data.shellUndeframeSipTrans.distBwCurvedRoll);
 										$('[id="grindWeldJoints"]').val([data.shellUndeframeSipTrans.grindWeldJoints]);
 										$('[id="holesForDrawing"]').val([data.shellUndeframeSipTrans.holesForDrawing]);
 										$('[id="holesDrilled"]').val([data.shellUndeframeSipTrans.holesDrilled]);
 										$('#distBwCenterCenter').val(data.shellUndeframeSipTrans.distBwCenterCenter);
 										$('[id="doorFixBrkt"]').val([data.shellUndeframeSipTrans.doorFixBrkt]);
 										$('#doorFixBrktOb').val(data.shellUndeframeSipTrans.doorFixBrktOb);
 										$('[id="fitmentDimenBiotank"]').val([data.shellUndeframeSipTrans.fitmentDimenBiotank]);
 										$('#longDistBrktBrktpp').val(data.shellUndeframeSipTrans.longDistBrktBrktpp);
 										$('#longDistBrktBrktnpp').val(data.shellUndeframeSipTrans.longDistBrktBrktnpp);
 										$('#latDistBrktFrntpp').val(data.shellUndeframeSipTrans.latDistBrktFrntpp);
 										$('#latDistBrktFrntnpp').val(data.shellUndeframeSipTrans.latDistBrktFrntnpp);
 										$('#bioTankHoleDist').val(data.shellUndeframeSipTrans.bioTankHoleDist);
 										$('#distCenCen').val(data.shellUndeframeSipTrans.distCenCen);
 										$('#genMmountScrew1').val(data.shellUndeframeSipTrans.genMmountScrew1);
 										$('#genMmountScrew2').val(data.shellUndeframeSipTrans.genMmountScrew2);
 										$('[id="cbcUncoup"]').val([data.shellUndeframeSipTrans.cbcUncoup]);
 										$('#transfMount').val(data.shellUndeframeSipTrans.transfMount);
 										$('#batteryBox').val(data.shellUndeframeSipTrans.batteryBox);
 										$('#airBrakeModule').val(data.shellUndeframeSipTrans.airBrakeModule);
 										$('#guideDistPP').val(data.shellUndeframeSipTrans.guideDistPP);
 										$('#guideDistNPP').val(data.shellUndeframeSipTrans.guideDistNPP);
 										$('#twinePipHoleObs').val(data.shellUndeframeSipTrans.twinePipHoleObs);
 										$('[id="fibaBktAirPro"]').val([data.shellUndeframeSipTrans.fibaBktAirPro]);
 										$('[id="reserBktAirPro"]').val([data.shellUndeframeSipTrans.reserBktAirPro]);
 										$('#distanceCrossMemberpp1').val(data.shellUndeframeSipTrans.distanceCrossMemberpp1);
 										$('#distanceCrossMemberpp2').val(data.shellUndeframeSipTrans.distanceCrossMemberpp2);
 										$('#distanceCrossMemberpp3').val(data.shellUndeframeSipTrans.distanceCrossMemberpp3);
 										$('#distanceCrossMemberpp4').val(data.shellUndeframeSipTrans.distanceCrossMemberpp4);
 										
 										$('#distanceCrossMemberpp5').val(data.shellUndeframeSipTrans.distanceCrossMemberpp5);
 										$('#distanceCrossMemberpp6').val(data.shellUndeframeSipTrans.distanceCrossMemberpp6);
 										$('#distanceCrossMemberpp7').val(data.shellUndeframeSipTrans.distanceCrossMemberpp7);
 										$('#distanceCrossMemberpp8').val(data.shellUndeframeSipTrans.distanceCrossMemberpp8);
 										$('#distanceCrossMemberpp9').val(data.shellUndeframeSipTrans.distanceCrossMemberpp9);
 										$('#distanceCrossMemberpp10').val(data.shellUndeframeSipTrans.distanceCrossMemberpp10);
 										$('#distanceCrossMembernpp1').val(data.shellUndeframeSipTrans.distanceCrossMembernpp1);
 										$('#distanceCrossMembernpp2').val(data.shellUndeframeSipTrans.distanceCrossMembernpp2);
 										$('#distanceCrossMembernpp3').val(data.shellUndeframeSipTrans.distanceCrossMembernpp3);
 										$('#distanceCrossMembernpp4').val(data.shellUndeframeSipTrans.distanceCrossMembernpp4);
 										$('#distanceCrossMembernpp5').val(data.shellUndeframeSipTrans.distanceCrossMembernpp5);
 										$('#distanceCrossMembernpp6').val(data.shellUndeframeSipTrans.distanceCrossMembernpp6);
 										$('#distanceCrossMembernpp7').val(data.shellUndeframeSipTrans.distanceCrossMembernpp7);
 										$('#distanceCrossMembernpp8').val(data.shellUndeframeSipTrans.distanceCrossMembernpp8);
 										$('#distanceCrossMembernpp9').val(data.shellUndeframeSipTrans.distanceCrossMembernpp9);
 										$('#distanceCrossMembernpp10').val(data.shellUndeframeSipTrans.distanceCrossMembernpp10);
 										$('#obserVal').val(data.shellUndeframeSipTrans.obserVal);
 										$('#detlOfModf').val(data.shellUndeframeSipTrans.detlOfModf);
 										$('#detlOfTrialItems').val(data.shellUndeframeSipTrans.detlOfTrialItems);
 										$('#rmk').val(data.shellUndeframeSipTrans.rmk);
 										$('[id="shellUnderframeSipTestingStatus"]').val([data.shellUndeframeSipTrans.underframeTestingStatus]);
 										
 										
 								
 										
 									}
 										
 									});
 								
 								}


 								
 								$('#underframeDate').datepicker('option', 'minDate', new Date(record.assemblyStartDate));
 								
             					
                     	 	 	$("#UnderframeSIPDialog").dialog({
                     	 	 		title : 'Exit for  '+record.shellTransactionId + 'from Stage- <%=stageID%>',  
                     	 	 		width:'60%',
                     	 	 		close: function (e, u) {
                     	 	 			$('#UnderframeSIPDialog').find('form[name="underframeSIP"]')[0].reset();
               	 		          	$("#UnderframeSIPDialog").validationEngine('hideAll');
               	 		          },
                 	 		 	
  		 							buttons: {
 	                                    Submit: {
 	                                       text: "Submit",
 	                                        id: "my-button-submit",
 	                                        click:function () {
 	                                     
 	                                    	if ($('#underframeDocNo').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }
 	                                    	
 											  if ($('#appDrawNoUnderframe').validationEngine('validate')) {
 		                                        	
 		                                            return false;
 		                                        }

 											if ($('#appLineNoUnderframe').validationEngine('validate')) {
 	                                        	
 	                                            return false;
 	                                        }										
 											
 											if ($('#waterTankBkt1').validationEngine('validate')) {
 												
 	   											 return false;
 												}
 											if ($('#waterTankBkt2').validationEngine('validate')) {
 												
 	   											 return false;
 												}
 											if ($('#waterTankBkt3').validationEngine('validate')) {
 												
 	   											 return false;
 												}
 											if ($('#waterTankBkt4').validationEngine('validate')) {
 												
 	   											 return false;
 												}
 											
 											if ($('#cbCFitPp').validationEngine('validate')) {
 												
 	   											 return false;
 												}
 											if ($('#cbCFitNpp').validationEngine('validate')) {
 												
 	   											 return false;
 												}

 											
 											if ($('#bodyBolster').validationEngine('validate')) {
 	
 											    return false;
 											}
 											if ($('#completeLenUndeframe').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#frntPartToFront').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#ufWidth').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#coveringPlate').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#wedgeBolt').validationEngine('validate')) {
 												
 											    return false;
 											}
 											
 											if ($('#frntPartBrktDist').validationEngine('validate')) {
 												
 											    return false;
 											}
 											
 											
 											if ($('#distBwConsoleBrkt').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#footStepsDist').validationEngine('validate')) {
 												                                        	
 												 return false;
 												                                        }
 											if ($('#distBwCurvedRoll').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#distBwCenterCenter').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#doorFixBrktOb').validationEngine('validate')) {
 												
 											    return false;
 											}

 											
 											if ($('#longDistBrktBrktpp').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#longDistBrktBrktnpp').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#latDistBrktFrntpp').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#latDistBrktFrntnpp').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#bioTankHoleDist').validationEngine('validate')) {
 																							
 											    return false;
 											}
 											if ($('#distCenCen').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#genMmountScrew1').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#genMmountScrew2').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#transfMount').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#batteryBox').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#airBrakeModule').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#guideDistPP').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#guideDistNPP').validationEngine('validate')) {
 												
 											    return false;
 											}
 											if ($('#twinePipHoleObs').validationEngine('validate')) {
 																							
 											   return false;
 											}
 											if ($('#distanceCrossMemberpp1').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp2').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp3').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp4').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp5').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp6').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp7').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp8').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp9').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMemberpp10').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp1').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp2').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp3').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp4').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp5').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp6').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp7').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp8').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp9').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#distanceCrossMembernpp10').validationEngine('validate')) {
 												
 												   return false;
 												}
 											if ($('#obserVal').validationEngine('validate')) {
 												
 											    return false;
 											}
 											
 	                                    	var c=confirm("Verify data before save, Do you want to Save");
 	                                    	if(c==false){return false;}
                                           //   if ($('#underFrameNumber').validationEngine('validate')) {
 	                                        	
 	                                       //     return false;
 	                                      //  }
 	                                    		    	   
 	                                    	$.ajax({
 	                    						url : "UnderframeSIP",  //action-name as defined in struts.xml
 	                    						dataType: 'json', 
 	                    						data : {
 	                    							shellAssetId: record.shellAssetId,
 	                    							
 	                    							
 	                    							appDrawNoUnderframe:$('#appDrawNoUnderframe').val(),
 	                    							underframeDocNo:$('#underframeDocNo').val(),              							
 	                    							underframeShiftSelect:$('#underframeShiftSelect').val(),
 	                    							underframeDate:$('#underframeDate').val(),
 	                    							appLineNoUnderframe:$('#appLineNoUnderframe').val(),
 	                    							appWiNoUnderframe:$('#appWiNoUnderframe').val(),
 	                    							
 	                    							waterTankBkt1:$('#waterTankBkt1').val(),
 	                    							waterTankBkt2:$('#waterTankBkt2').val(),
 	                    							waterTankBkt3:$('#waterTankBkt3').val(),
 	                    							waterTankBkt4:$('#waterTankBkt4').val(),
 	                    							cbCFitPp:$('#cbCFitPp').val(),
 	                    							cbCFitNpp:$('#cbCFitNpp').val(),
 	                    							frntPrtMakePp:$('#frntPrtMakePp').val(),
 	                                    			frntPrtMakeNpp:$('#frntPrtMakeNpp').val(),
 	                                    			frntPrtNoPp:$('#frntPrtNoPp').val(),
 	                                    			frntPrtNoNpp:$('#frntPrtNoNpp').val(),
 	                                    			cbCMakePp:$('#cbCMakePp').val(),
 	                                    			cbCMakeNpp:$('#cbCMakeNpp').val(),
 	                                    			cbCNoPp:$('#cbCNoPp').val(),
 	                                    			cbCNoNpp:$('#cbCNoNpp').val(),
 	                                    			underframeMakePp:$('#underframeMakePp').val(),
 	                                    			underframeMakeNpp:$('#underframeMakeNpp').val(),
 	                                    			underframeNoPp:$('#underframeNoPp').val(),
 	                                    			underframeNoNpp:$('#underframeNoNpp').val(),
 	                                    			underframeCompleteMake:$('#underframeCompleteMake').val(),
 	                                    			underframeCompleteNo:$('#underframeCompleteNo').val(),
 	                    							
 	                    							itemsFitted:$("input[id='itemsFitted']:checked").val(),
 	                    							compAppWi:$("input[id='compAppWi']:checked").val(),
 	                    							
 	                    							weldThroatLen:$("input[id='weldThroatLen']:checked").val(),
 	                    							tightScrew:$("input[id='tightScrew']:checked").val(),
 	                    							outerFaceOuterHead:$("input[id='outerFaceOuterHead']:checked").val(),
 	                    							conditionOfPlugWelding:$("input[id='conditionOfPlugWelding']:checked").val(),
 	                    							conditionOfConsole:$("input[id='conditionOfConsole']:checked").val(),
 	                    							bodyBolster:$('#bodyBolster').val(),
 	                    							completeLenUndeframe:$('#completeLenUndeframe').val(),
 	                    							frntPartToFront:$('#frntPartToFront').val(),
 	                    							ufWidth:$('#ufWidth').val(),
 	                    							coveringPlate:$('#coveringPlate').val(),
 	                    							wedgeBolt:$('#wedgeBolt').val(),
 	                    							waterTankMount:$("input[id='waterTankMount']:checked").val(),
 	                    							frntPartBrktDist:$('#frntPartBrktDist').val(),
 	                    							footStepsDist:$('#footStepsDist').val(),
 	                    							distBwConsoleBrkt:$('#distBwConsoleBrkt').val(),
 	                    							suppMemTrough:$("input[id='suppMemTrough']:checked").val(),
 	                    							pillarMountChannel:$("input[id='pillarMountChannel']:checked").val(),
 	                    							distBwCurvedRoll:$('#distBwCurvedRoll').val(),
 	                    							grindWeldJoints:$("input[id='grindWeldJoints']:checked").val(),
 	                    							holesForDrawing:$("input[id='holesForDrawing']:checked").val(),
 	                    							holesDrilled:$("input[id='holesDrilled']:checked").val(),
 	                    							distBwCenterCenter:$('#distBwCenterCenter').val(),
 	                    							doorFixBrkt:$("input[id='doorFixBrkt']:checked").val(),
 	                    							doorFixBrktOb:$('#doorFixBrktOb').val(),
 	                    							fitmentDimenBiotank:$('#fitmentDimenBiotank').val(),
 	                    							longDistBrktBrktpp:$('#longDistBrktBrktpp').val(),
 	                    							longDistBrktBrktnpp:$('#longDistBrktBrktnpp').val(),
 	                    						    latDistBrktFrntpp:$('#latDistBrktFrntpp').val(),
 	                    							latDistBrktFrntnpp:$('#latDistBrktFrntnpp').val(),
 	                    							bioTankHoleDist:$('#bioTankHoleDist').val(),
 	                    							distCenCen:$('#distCenCen').val(),
 	                    							genMmountScrew1:$('#genMmountScrew1').val(),
 	                    							genMmountScrew2:$('#genMmountScrew2').val(),
 	                    							cbcUncoup:$("input[id='cbcUncoup']:checked").val(),
 	                    							transfMount:$('#transfMount').val(),
 	                    							batteryBox:$('#batteryBox').val(),
 	                    							airBrakeModule:$('#airBrakeModule').val(),
 	                    							guideDistPP:$('#guideDistPP').val(),
 	                    							guideDistNPP:$('#guideDistNPP').val(),
 	                    							twinePipHoleObs:$('#twinePipHoleObs').val(),
 	                    							fibaBktAirPro:$("input[id='fibaBktAirPro']:checked").val(),
 	                    							reserBktAirPro:$("input[id='reserBktAirPro']:checked").val(),
 	                    							distanceCrossMemberpp1:$('#distanceCrossMemberpp1').val(),
 	                    							distanceCrossMemberpp2:$('#distanceCrossMemberpp2').val(),
 	                    							distanceCrossMemberpp3:$('#distanceCrossMemberpp3').val(),
 	                    							distanceCrossMemberpp4:$('#distanceCrossMemberpp4').val(),
 	                    							distanceCrossMemberpp5:$('#distanceCrossMemberpp5').val(),
 	                    							distanceCrossMemberpp6:$('#distanceCrossMemberpp6').val(),
 	                    							distanceCrossMemberpp7:$('#distanceCrossMemberpp7').val(),
 	                    							distanceCrossMemberpp8:$('#distanceCrossMemberpp8').val(),
 	                    							distanceCrossMemberpp9:$('#distanceCrossMemberpp9').val(),
 	                    							distanceCrossMemberpp10:$('#distanceCrossMemberpp10').val(),
 	                    							distanceCrossMembernpp1:$('#distanceCrossMembernpp1').val(),
 	                    							distanceCrossMembernpp2:$('#distanceCrossMembernpp2').val(),
 	                    							distanceCrossMembernpp3:$('#distanceCrossMembernpp3').val(),
 	                    							distanceCrossMembernpp4:$('#distanceCrossMembernpp4').val(),
 	                    							distanceCrossMembernpp5:$('#distanceCrossMembernpp5').val(),
 	                    							distanceCrossMembernpp6:$('#distanceCrossMembernpp6').val(),
 	                    							distanceCrossMembernpp7:$('#distanceCrossMembernpp7').val(),
 	                    							distanceCrossMembernpp8:$('#distanceCrossMembernpp8').val(),
 	                    							distanceCrossMembernpp9:$('#distanceCrossMembernpp9').val(),
 	                    							distanceCrossMembernpp10:$('#distanceCrossMembernpp10').val(),
 	                    							obserVal:$('#obserVal').val(),
 	                    							detlOfModf:$('#detlOfModf').val(),
 	                    							detlOfTrialItems:$('#detlOfTrialItems').val(),
 	                    							rmk:$('#rmk').val(),
 	                    							shellUnderframeTestingStatus:$("input[id='shellUnderframeSipTestingStatus']:checked").val(),
 	                    							
 	                    						
 	                    						},
 	                    						
 	                    						type : 'POST',
 	                    						async : false,
 	                            	 		})
 	                            	 		
 	                            	 	
 	                    						.done(function( msg ) {
 	                    							
 	                    							
 	                    						    $('#appDrawNoUnderframe').val(''),                   							
 	                    							$('#underframeDocNo').val(''),              							
 	                    							$('#underframeShiftSelect').val(''),
 	                    							$('#underframeDate').val(''),
 	                    							$('#appLineNoUnderframe').val(''),
 	                    							$('#appWiNoUnderframe').val(''),
 	                    							
 	                    							
 	                    							$('#waterTankBkt1').val(''),
 	                    							$('#waterTankBkt2').val(''),
 	                    							$('#waterTankBkt3').val(''),
 	                    							$('#waterTankBkt4').val(''),
 	                    							$('#cbCFitPp').val(''),
 	                    							$('#cbCFitNpp').val(''),
 	                    							$('#frntPrtMakePp').val(''),
 	                                    			$('#frntPrtMakeNpp').val(''),
 	                                    			$('#frntPrtNoPp').val(''),
 	                                    			$('#frntPrtNoNpp').val(''),
 	                                    			$('#cbCMakePp').val(''),
 	                                    			$('#cbCMakeNpp').val(''),
 	                                    			$('#cbCNoPp').val(''),
 	                                    			$('#cbCNoNpp').val(''),
 	                                    			$('#underframeMakePp').val(''),
 	                                    			$('#underframeMakeNpp').val(''),
 	                                    			$('#underframeNoPp').val(''),
 	                                    			$('#underframeNoNpp').val(''),
 	                                    			$('#underframeCompleteMake').val(''),
 	                                    			$('#underframeCompleteNo').val(''),
 	                    							
 	       				  							
 	       				  						    $("input[id='itemsFitted']:checked").val(''),
 	                    							$("input[id='compAppWi']:checked").val(''),
 	                    							$("input[id='weldThroatLen']:checked").val(''),
 	                    							$("input[id='tightScrew']:checked").val(''),
 	                    							$("input[id='outerFaceOuterHead']:checked").val(''),
 	                    							$("input[id='conditionOfPlugWelding']:checked").val(''),
 	                    							$('#conditionOfConsole').val(''),
 	                    							$('#bodyBolster').val(''),
 	                    							$('#completeLenUndeframe').val(''),
 	                    							$('#frntPartToFront').val(''),
 	                    							$('#ufWidth').val(''),
 	                    							$('#coveringPlate').val(''),
 	                    							$('#wedgeBolt').val(''),
 	                    							$("input[id='waterTankMount']:checked").val(''),
 	                    							$('#frntPartBrktDist').val(''),
 	                    							$('#footStepsDist').val(''),
 	                    							$('#distBwConsoleBrkt').val(''),
 	                    							$("input[id='suppMemTrough']:checked").val(''),
 	                    							$("input[id='pillarMountChannel']:checked").val(''),
 	                    							$('#distBwCurvedRoll').val(''),
 	                    							$("input[id='grindWeldJoints']:checked").val(''),
 	                    							$("input[id='holesForDrawing']:checked").val(''),
 	                    							$("input[id='holesDrilled']:checked").val(''),
 	                    							$('#distBwCenterCenter').val(''),
 	                    							$("input[id='doorFixBrkt']:checked").val(''),
 	                    							$('#doorFixBrktOb').val(''),
 	                    							$('#fitmentDimenBiotank').val(''),
 	                    							$('#longDistBrktBrktpp').val(''),
 	                    							$('#longDistBrktBrktnpp').val(''),
 	                    						    $('#latDistBrktFrntpp').val(''),
 	                    							$('#latDistBrktFrntnpp').val(''),
 	                    							$('#bioTankHoleDist').val(''),
 	                    							$('#distCenCen').val(''),
 	                    							$('#genMmountScrew1').val(''),
 	                    							$('#genMmountScrew2').val(''),
 	                    							$("input[id='cbcUncoup']:checked").val(''),
 	                    							$('#transfMount').val(''),
 	                    							$('#batteryBox').val(''),
 	                    							$('#airBrakeModule').val(''),
 	                    							$('#guideDistPP').val(''),
 	                    							$('#guideDistNPP').val(''),
 	                    							$('#twinePipHoleObs').val(''),
 	                    							$("input[id='fibaBktAirPro']:checked").val(''),
 	                    							$("input[id='reserBktAirPro']:checked").val(''),
 	                    							$('#distanceCrossMemberpp1').val(''),
 	                    							$('#distanceCrossMemberpp2').val(''),
 	                    							$('#distanceCrossMemberpp3').val(''),
 	                    							$('#distanceCrossMemberpp4').val(''),
 	                    							$('#distanceCrossMemberpp5').val(''),
 	                    							$('#distanceCrossMemberpp6').val(''),
 	                    							$('#distanceCrossMemberpp7').val(''),
 	                    							$('#distanceCrossMemberpp8').val(''),
 	                    							$('#distanceCrossMemberpp9').val(''),
 	                    							$('#distanceCrossMemberpp10').val(''),
 	                    							$('#distanceCrossMembernpp1').val(''),
 	                    							$('#distanceCrossMembernpp2').val(''),
 	                    							$('#distanceCrossMembernpp3').val(''),
 	                    							$('#distanceCrossMembernpp4').val(''),
 	                    							$('#distanceCrossMembernpp5').val(''),
 	                    							$('#distanceCrossMembernpp6').val(''),
 	                    							$('#distanceCrossMembernpp7').val(''),
 	                    							$('#distanceCrossMembernpp8').val(''),
 	                    							$('#distanceCrossMembernpp9').val(''),
 	                    							$('#distanceCrossMembernpp10').val(''),
 	                    							$('#obserVal').val(''),
 	                    							$('#detlOfModf').val(''),
 	                    							$('#detlOfTrialItems').val(''),
 	                    							$('#rmk').val(''),
 	                    							$("input[id='shellUnderframeSipTestingStatus']:checked").val(''),
 	                    							
 	                    							
 	                    							
 	                    							
 	                    							$('#UnderframeSIPDialog').dialog('close');
 	                    						
 	                    							$('#ShellProductionTableContainer').jtable('load');
 	                    							
 	                    							
 	                    							
 	                    							
 	                    							
 	         								  })
 	         								.error(function (msg){
 	         									//$('#dialog').dialog('close');
 	         									alert("Error Fetching Data");
 	         								})
 	         								  ;
 					                 			    	   return true;
 				                                    }
 	                                    },
 				                        Close: function () {
 				                        	$('#UnderframeSIPDialog').find('form[name="underframeSIP"]')[0].reset();
 				                                        $(this).dialog('close');
 				                                        
 				                                    }
 	                                    },
 	                    	        modal: true
     	    });
                     	 		
             			    	   return true;
                     	 		    
                     	 			  
                     	 		  }		
     						 
                         }
                     },  
                     
                     
                     // dialog code for lav. sidewall
                     
                      {
                    	icon: '<%=contextpath%>/images/rs_out.png',
                        text: 'Lavsidewall SIP',
                        click: function () {
                        	
                        	
                        	
                        	 var $selectedRows = $('#ShellProductionTableContainer').jtable('selectedRows');
                    	 	 if ($selectedRows.length<1)
                    		 alert("Please select a row for which you want to fill SIP data");
                    	 	 else{
                    	 		var record;
                    	 		$selectedRows.each(function () {
                                    record = $(this).data('record');
                                    });
								//setting min value
								$.ajax({
								url:"showExistingShellData",  //action-name as defined in struts.xml
								dataType:'json',
								type:'POST',
								async:false,
								data:{
								shellAssetId:record.shellAssetId,	
								},
								success:function(data)
								{
									$('#lavsidewallSipDocNo').val(data.lavsidewallSipDocNo);
								    $('#lavsidewallNo').val(data.shellNo);
								    $('#lavsidewallShellType').val(data.shellType);
								    $('#lavsidewallMake1').val(data.lavsidewallMake1);
									$('#lavsidewallMake2').val(data.lavsidewallMake2);
									$('#lavsidewallMake3').val(data.lavsidewallMake3);
									$('#lavsidewallMake4').val(data.lavsidewallMake4);
									$('#lavsidewallNo1').val(data.lavsidewallNo1);
									$('#lavsidewallNo2').val(data.lavsidewallNo2);
									$('#lavsidewallNo3').val(data.lavsidewallNo3);
									$('#lavsidewallNo4').val(data.lavsidewallNo4);
								}
									
								});
								
								
                      	if(record.lavsidewallSipFlag==1)
								{
								
								$.ajax({
									url:"showSaveDataLavSideWall", //action-name as defined in struts.xml
									dataType:'json',
									type:'POST',
									async:false,
									data:{
									shellAssetId:record.shellAssetId,	
									},
									success:function(data)
									{
										
										$('#lavsidewallSipShift').val(data.shellLavSideWallTran.lavsidewallSipShift);
										var lavDate=(data.shellLavSideWallTran.lavsidewallSipDate).substring(0,10);
										var lavDateArray=lavDate.split("-");
										$('#lavsidewallSipDate').datepicker("setDate",new Date(lavDateArray[0],lavDateArray[1]-1,lavDateArray[2]));
										$('#lavSidewallDrawingNo').val(data.shellLavSideWallTran.drawingNo);
										$('#lavSidewallWiNo').val(data.shellLavSideWallTran.wiNo);
										$('#frameWorkByLav1').val(data.shellLavSideWallTran.frameWorkByLav1);
										
										$('#frameJigRoboticsBoLav1').val(data.shellLavSideWallTran.frameJigRoboticsBoLav1);
										$('#frameWorkByLav2').val(data.shellLavSideWallTran.frameWorkByLav2);
										$('#frameJigRoboticsBoLav2').val(data.shellLavSideWallTran.frameJigRoboticsBoLav2);
										$('#frameWorkByLav3').val(data.shellLavSideWallTran.frameWorkByLav3);
										$('#frameJigRoboticsBoLav3').val(data.shellLavSideWallTran.frameJigRoboticsBoLav3);
										$('#frameWorkByLav4').val(data.shellLavSideWallTran.frameWorkByLav4);
										$('#frameJigRoboticsBoLav4').val(data.shellLavSideWallTran.frameJigRoboticsBoLav4);
										$('#spotWeldingByLav1').val(data.shellLavSideWallTran.spotWeldingByLav1);
										$('#spotWeldingByLav2').val(data.shellLavSideWallTran.spotWeldingByLav2);
										$('#spotWeldingByLav3').val(data.shellLavSideWallTran.spotWeldingByLav3);
										$('#spotWeldingByLav4').val(data.shellLavSideWallTran.spotWeldingByLav4);
										$('#spotWeldingJigRoboticsBoLav1').val(data.shellLavSideWallTran.spotWeldingJigRoboticsBoLav1);
										$('#spotWeldingJigRoboticsBoLav2').val(data.shellLavSideWallTran.spotWeldingJigRoboticsBoLav2);
										$('#spotWeldingJigRoboticsBoLav3').val(data.shellLavSideWallTran.spotWeldingJigRoboticsBoLav3);
										$('#spotWeldingJigRoboticsBoLav4').val(data.shellLavSideWallTran.spotWeldingJigRoboticsBoLav4);
										$('#interlockJointByLav1').val(data.shellLavSideWallTran.interlockJointByLav1);
										$('#interlockJointByLav2').val(data.shellLavSideWallTran.interlockJointByLav2);
										$('#interlockJointByLav3').val(data.shellLavSideWallTran.interlockJointByLav3);
										$('#interlockJointByLav4').val(data.shellLavSideWallTran.interlockJointByLav4);
										$('#interlockJointJigRoboticsBoLav1').val(data.shellLavSideWallTran.interlockJointJigRoboticsBoLav1);
										$('#interlockJointJigRoboticsBoLav2').val(data.shellLavSideWallTran.interlockJointJigRoboticsBoLav2);
										$('#interlockJointJigRoboticsBoLav3').val(data.shellLavSideWallTran.interlockJointJigRoboticsBoLav3);
										$('#interlockJointJigRoboticsBoLav4').val(data.shellLavSideWallTran.interlockJointJigRoboticsBoLav4);
										$('[id="lavSidewallObservationItemsAsPerDrawingFlag"]').val([data.shellLavSideWallTran.observationItemsAsPerDrawingFlag]);
										$('[id="lavSidewallObservationComplianceWiFlag"]').val([data.shellLavSideWallTran.observationComplianceWiFlag]);
										$('[id="lavSidewallObservationWeldingThroatFlag"]').val([data.shellLavSideWallTran.observationWeldingThroatFlag]);
										
										$('#totalheightLav1').val(data.shellLavSideWallTran.totalheightLav1);
										$('#totalheightLav2').val(data.shellLavSideWallTran.totalheightLav2);
										$('#totalheightLav3').val(data.shellLavSideWallTran.totalheightLav3);
										$('#totalheightLav4').val(data.shellLavSideWallTran.totalheightLav4);
										$('#totalwidthoutsideLav1').val(data.shellLavSideWallTran.totalwidthoutsideLav1);
										$('#totalwidthoutsideLav2').val(data.shellLavSideWallTran.totalwidthoutsideLav2);
										$('#totalwidthoutsideLav3').val(data.shellLavSideWallTran.totalwidthoutsideLav3);
										$('#totalwidthoutsideLav4').val(data.shellLavSideWallTran.totalwidthoutsideLav4);
										$('#totalwidthinsideLav1').val(data.shellLavSideWallTran.totalwidthinsideLav1);
										$('#totalwidthinsideLav2').val(data.shellLavSideWallTran.totalwidthinsideLav2);
										$('#totalwidthinsideLav3').val(data.shellLavSideWallTran.totalwidthinsideLav3);
										$('#totalwidthinsideLav4').val(data.shellLavSideWallTran.totalwidthinsideLav4);
										$('#windowcutOutLav1').val(data.shellLavSideWallTran.windowcutOutLav1);
										$('#windowcutOutLav2').val(data.shellLavSideWallTran.windowcutOutLav2);
										$('#windowcutOutLav3').val(data.shellLavSideWallTran.windowcutOutLav3);
										$('#windowcutOutLav4').val(data.shellLavSideWallTran.windowcutOutLav4);
										$('#windowcutOutsideLav1').val(data.shellLavSideWallTran.windowcutOutsideLav1);
										$('#windowcutOutsideLav2').val(data.shellLavSideWallTran.windowcutOutsideLav2);
										$('#windowcutOutsideLav3').val(data.shellLavSideWallTran.windowcutOutsideLav3);
										$('#windowcutOutsideLav4').val(data.shellLavSideWallTran.windowcutOutsideLav4);
										$('#pillarheightSheetLav1').val(data.shellLavSideWallTran.pillarheightSheetLav1);
										$('#pillarheightSheetLav2').val(data.shellLavSideWallTran.pillarheightSheetLav2);
										$('#pillarheightSheetLav3').val(data.shellLavSideWallTran.pillarheightSheetLav3);
										$('#pillarheightSheetLav4').val(data.shellLavSideWallTran.pillarheightSheetLav4);
										$('#windowprofilecutForExhaustLav1').val(data.shellLavSideWallTran.windowprofilecutForExhaustLav1);
										$('#windowprofilecutForExhaustLav2').val(data.shellLavSideWallTran.windowprofilecutForExhaustLav2);
										$('#windowprofilecutForExhaustLav3').val(data.shellLavSideWallTran.windowprofilecutForExhaustLav3);
										$('#windowprofilecutForExhaustLav4').val(data.shellLavSideWallTran.windowprofilecutForExhaustLav4);
										$('[id="lavsidewallFrameAsPerDrawingFlag"]').val([data.shellLavSideWallTran.lavsidewallFrameAsPerDrawingFlag]);
										$('[id="lavsidewallMemberWeldingFlag"]').val([data.shellLavSideWallTran.lavsidewallMemberWeldingFlag]);
										$('[id="conditionLavsidewallMemberJointweldingFlag"]').val([data.shellLavSideWallTran.conditionLavsidewallMemberJointweldingFlag]);
										$('[id="conditionLavsidewallSheetLaserweldingFlag"]').val([data.shellLavSideWallTran.conditionLavsidewallSheetLaserweldingFlag]);
										$('#lavSidewallDetailsOfModification').val(data.shellLavSideWallTran.detailsOfModification);
										$('#lavSidewallDetailsOfTrial').val(data.shellLavSideWallTran.detailsOfTrial);
										$('#lavSidewallRemarks').val(data.shellLavSideWallTran.remarks);
										$('[id="shellLavSidewallSipTestingStatus"]').val([data.shellLavSideWallTran.lavSidewallTestingStatus]);
									  
									}
									});
								
								}
								
								$('#lavsidewallSipDate').datepicker('option', 'minDate', new Date(record.assemblyStartDate));
								
            					
                    	 	 	$("#lavsidewallSIP").dialog({
                    	 	 		title : 'LavSideWall Inspection Form'+record.shellTransactionId + 'from Stage- <%=stageID%>',
                    	 	 		width:'55%',
                    	 	 		close: function (e, u) {
                    	 	 			$('#lavsidewallSIP').find('form[name="lavSidewallForm"]')[0].reset();
              	 		          	$("#lavsidewallSIP").validationEngine('hideAll');
              	 		          },
              	 		          
              	 		 
                	 		 	
 		 							buttons: {
	                                    Submit: {
	                                       text: "Submit",
	                                        id: "my-button-submit",
	                                        click:function () {
	                                        	 
	                                    	//alert("$('#qtyDispatched').val()->"+$('#qtyDispatched').val());
	                                    	//alert("record.balanceQtyToDispatch->"+record.balanceQtyToDispatch);
	                            	 		
	                                    	if ($('#lavsidewallSipDate').validationEngine('validate')) {
				                                        	//alert(!$("#dialog").validationEngine('validate'));
				                                            return false;}
	                                    	 
	                                    	  if ($('#lavsidewallSipDocNo').validationEngine('validate')) {
	                                            return false;
	                                            
	                                          }
                                              
	                                    	  if ($('#totalheightLav1').validationEngine('validate')) {
	                                        	
	                                          return false;
	                                        }
	                                    	  
                                           if ($('#totalheightLav2').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           
                                           
                                           if ($('#totalheightLav3').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalheightLav4').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalwidthoutsideLav1').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalwidthoutsideLav2').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalwidthoutsideLav3').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalwidthoutsideLav4').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalwidthinsideLav1').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalwidthinsideLav2').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalwidthinsideLav3').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#totalwidthinsideLav4').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           
                                          
                                           
                                           if ($('#windowcutOutLav1').validationEngine('validate')) {
                                    	
	                                            return false;
	                                        }
                                           if ($('#windowcutOutLav2').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                         
                                           if ($('#windowcutOutLav3').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#windowcutOutLav4').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                         
                                           if ($('#windowcutOutsideLav1').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           if ($('#windowcutOutsideLav2').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                          
                                           if ($('#windowcutOutsideLav3').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        } 
                                           if ($('#windowcutOutsideLav4').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                        
                                         
                                           if ($('#pillarheightSheetLav1').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           
                                           if ($('#pillarheightSheetLav2').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                          
                                           if ($('#pillarheightSheetLav3').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                           
                                           if ($('#pillarheightSheetLav4').validationEngine('validate')) {
	                                        	
	                                            return false;
	                                        }
                                      
                                            var c=confirm("Do you want to confirm lavsidewall testing?");
	                                    	if(c==false){return false;}
                                          //   if ($('#underFrameNumber').validationEngine('validate')) {
	                                        	
	                                       //     return false;
	                                      //  }
	                                    		 
                 
	                                    	$.ajax({
	                    						url : "saveLavShell",  //action-name as defined in struts.xml
	                    						dataType: 'json', 
	                    						data : {
	                    							shellAssetId: record.shellAssetId,
	                    	                        //	underFrameNumber:$('#underFrameNumber').val(),
	                    							lavsidewallSipDocNo:$ ('#lavsidewallSipDocNo').val(),
	                    							lavsidewallSipShift: $('#lavsidewallSipShift').val(),
	                    							lavsidewallSipDate: $('#lavsidewallSipDate').val(),
	                    							lavsidewallNo:$('#lavsidewallNo').val(),
	                    							lavsidewallShellType:$('#lavsidewallShellType').val(),
	                    							lavSidewallDrawingNo:$('#lavSidewallDrawingNo').val(),
	                    							lavSidewallWiNo: $('#lavSidewallWiNo').val(),
	                    							frameWorkByLav1:$('#frameWorkByLav1').val(),
	                    							frameJigRoboticsBoLav1: $('#frameJigRoboticsBoLav1').val(),
	                    							frameWorkByLav2:$('#frameWorkByLav2').val(),
	                    							frameJigRoboticsBoLav2:$('#frameJigRoboticsBoLav2').val(),
	                    							frameWorkByLav3:$('#frameWorkByLav3').val(),
	                    							frameJigRoboticsBoLav3:$('#frameJigRoboticsBoLav3').val(),
	                    							frameWorkByLav4:$('#frameWorkByLav4').val(),
	                    							frameJigRoboticsBoLav4:$('#frameJigRoboticsBoLav4').val(),
	                    							spotWeldingByLav1:$('#spotWeldingByLav1').val(),
	                    							spotWeldingJigRoboticsBoLav1:$('#spotWeldingJigRoboticsBoLav1').val(),
	                    							spotWeldingByLav2:$('#spotWeldingByLav2').val(),
	                    							spotWeldingJigRoboticsBoLav2:$('#spotWeldingJigRoboticsBoLav2').val(),
	                    							spotWeldingByLav3:$('#spotWeldingByLav3').val(),
	                    							spotWeldingJigRoboticsBoLav3:$('#spotWeldingJigRoboticsBoLav3').val(),
	                    							spotWeldingByLav4:$('#spotWeldingByLav4').val(),
	                    							spotWeldingJigRoboticsBoLav4:$('#spotWeldingJigRoboticsBoLav4').val(),
	                    							interlockJointByLav1: $('#interlockJointByLav1').val(),
	                    							interlockJointJigRoboticsBoLav1:$('#interlockJointJigRoboticsBoLav1').val(),
	                    							interlockJointByLav2:$('#interlockJointByLav2').val(),
	                    							interlockJointJigRoboticsBoLav2:$('#interlockJointJigRoboticsBoLav2').val(),
	                    							interlockJointByLav3: $('#interlockJointByLav3').val(),
	                    							interlockJointJigRoboticsBoLav3:$('#interlockJointJigRoboticsBoLav3').val(),
	                    							interlockJointByLav4:$('#interlockJointByLav4').val(),
	                    							interlockJointJigRoboticsBoLav4:$('#interlockJointJigRoboticsBoLav4').val(),
	                    							lavsidewallMake1:$('#lavsidewallMake1').val(),
	                    							lavsidewallMake2:$('#lavsidewallMake2').val(),
	                    							lavsidewallMake3:$('#lavsidewallMake3').val(),
	                    							lavsidewallMake4:$('#lavsidewallMake4').val(),
	                    							lavsidewallNo1:$('#lavsidewallNo1').val(),
	                    							lavsidewallNo2:$('#lavsidewallNo2').val(),
	                    							lavsidewallNo3:$('#lavsidewallNo3').val(),
	                    							lavsidewallNo4:$('#lavsidewallNo4').val(),
	                    							lavSidewallObservationItemsAsPerDrawingFlag:$("input[id='lavSidewallObservationItemsAsPerDrawingFlag']:checked").val(),
	                    							lavSidewallObservationComplianceWiFlag:$("input[id='lavSidewallObservationComplianceWiFlag']:checked").val(),
	                    							lavSidewallObservationWeldingThroatFlag:$("input[id='lavSidewallObservationWeldingThroatFlag']:checked").val(),
	                    							totalheightLav1:$('#totalheightLav1').val(),
	                    							totalheightLav2:$('#totalheightLav2').val(),
	                    							totalheightLav3:$('#totalheightLav3').val(),
	                    							totalheightLav4:$('#totalheightLav4').val(),
	                    							totalwidthoutsideLav1:$('#totalwidthoutsideLav1').val(),
	                    							totalwidthoutsideLav2:$('#totalwidthoutsideLav2').val(),
	                    							totalwidthoutsideLav3:$('#totalwidthoutsideLav3').val(),
	                    							totalwidthoutsideLav4:$('#totalwidthoutsideLav4').val(),
	                    							totalwidthinsideLav1:$('#totalwidthinsideLav1').val(),
	                    							totalwidthinsideLav2:$('#totalwidthinsideLav2').val(),
	                    							totalwidthinsideLav3:$('#totalwidthinsideLav3').val(),
	                    							totalwidthinsideLav4:$('#totalwidthinsideLav4').val(),
	                    							windowcutOutLav1:$('#windowcutOutLav1').val(),
	                    							windowcutOutLav2:$('#windowcutOutLav2').val(),
	                    							windowcutOutLav3:$('#windowcutOutLav3').val(),
	                    							windowcutOutLav4:$('#windowcutOutLav4').val(),
	                    							windowcutOutsideLav1:$('#windowcutOutsideLav1').val(),
	                    							windowcutOutsideLav2:$('#windowcutOutsideLav2').val(),
	                    							windowcutOutsideLav3:$('#windowcutOutsideLav3').val(),
	                    							windowcutOutsideLav4:$('#windowcutOutsideLav4').val(),
	                    							pillarheightSheetLav1:$('#pillarheightSheetLav1').val(),
	                    							pillarheightSheetLav2:$('#pillarheightSheetLav2').val(),
	                    							pillarheightSheetLav3:$('#pillarheightSheetLav3').val(),
	                    							pillarheightSheetLav4:$('#pillarheightSheetLav4').val(),
	                    							windowprofilecutForExhaustLav1:$('#windowprofilecutForExhaustLav1').val(),
	                    							windowprofilecutForExhaustLav2:$('#windowprofilecutForExhaustLav2').val(),
	                    							windowprofilecutForExhaustLav3:$('#windowprofilecutForExhaustLav3').val(),
	                    							windowprofilecutForExhaustLav4:$('#windowprofilecutForExhaustLav4').val(),
	                    							lavsidewallFrameAsPerDrawingFlag:$("input[id='lavsidewallFrameAsPerDrawingFlag']:checked").val(),
	                    							lavsidewallMemberWeldingFlag:$("input[id='lavsidewallMemberWeldingFlag']:checked").val(),
	                                                conditionLavsidewallMemberJointweldingFlag:$("input[id='conditionLavsidewallMemberJointweldingFlag']:checked").val(),
	                                                conditionLavsidewallSheetLaserweldingFlag:$("input[id='conditionLavsidewallSheetLaserweldingFlag']:checked").val(),
	                                                lavSidewallDetailsOfModification:$('#lavSidewallDetailsOfModification').val(),
	                                                lavSidewallDetailsOfTrial:$('#lavSidewallDetailsOfTrial').val(),
	                                                lavSidewallRemarks:$('#lavSidewallRemarks').val(),
	                                                lavSidewallTestingStatus:$("input[name='shellLavSidewallSipTestingStatus']:checked").val(),
	                    						
	                    						},
	                    						
	                    						type : 'POST',
	                    						async : false,
	                            	 		})

	                            	 		
	                    						.done(function( msg ) {
	                    							shellAssetId: record.shellAssetId,
	                    	                        //	underFrameNumber:$('#underFrameNumber').val(),
	                    							$('#lavsidewallSipDocNo').val(''),
	                    							$('#lavsidewallSipShift').val(''),
	                    							$('#lavsidewallSipDate').val(''),
	                    							$('#lavsidewallNo').val(''),
	                    							$('#lavsidewallShellType').val(''),
	                    							$('#lavSidewallDrawingNo').val(''),
	                    							$('#lavSidewallWiNo').val(''),
	                    							$('#frameWorkByLav1').val(''),
	                    						    $('#frameJigRoboticsBoLav1').val(''),
	                    							$('#frameWorkByLav2').val(''),
	                    							$('#frameJigRoboticsBoLav2').val(''),
	                    							$('#frameWorkByLav3').val(''),
	                    							$('#frameJigRoboticsBoLav3').val(''),
	                    							$('#frameWorkByLav4').val(''),
	                    							$('#frameJigRoboticsBoLav4').val(''),
	                    							$('#spotWeldingByLav1').val(''),
	                    							$('#spotWeldingJigRoboticsBoLav1').val(''),
	                    							$('#spotWeldingByLav2').val(''),
	                    						    $('#spotWeldingJigRoboticsBoLav2').val(''),
	                    							$('#spotWeldingByLav3').val(''),
	                    							$('#spotWeldingJigRoboticsBoLav3').val(''),
	                    							$('#spotWeldingByLav4').val(''),
	                    							$('#spotWeldingJigRoboticsBoLav4').val(''),
	                    						    $('#interlockJointByLav1').val(''),
	                    						    $('#interlockJointJigRoboticsBoLav1').val(''),
	                    						    $('#interlockJointByLav2').val(''),
	                    						    $('#interlockJointJigRoboticsBoLav2').val(''),
	                    						    $('#interlockJointByLav3').val(''),
	                    							$('#interlockJointJigRoboticsBoLav3').val(''),
	                    							$('#interlockJointByLav4').val(''),
	                                                $('#interlockJointJigRoboticsBoLav4').val(''),
	                    							$('#lavsidewallMake1').val(''),
	                    							$('#lavsidewallMake2').val(''),
	                    							$('#lavsidewallMake3').val(''),
	                    							$('#lavsidewallMake4').val(''),
	                    							$('#lavsidewallNo1').val(''),
	                    							$('#lavsidewallNo2').val(''),
	                    							$('#lavsidewallNo3').val(''),
	                    							$('#lavsidewallNo4').val(''),
	                    							$("input[id='lavSidewallObservationItemsAsPerDrawingFlag']:checked").val(''),
	                    							$("input[id='lavSidewallObservationComplianceWiFlag']:checked").val(''),
	                    							$("input[id='lavSidewallObservationWeldingThroatFlag']:checked").val(''),
	                    							$('#totalheightLav1').val(''),
	                    							$('#totalheightLav2').val(''),
	                    						    $('#totalheightLav3').val(''),
	                    							$('#totalheightLav4').val(''),
	                    							$('#totalwidthoutsideLav1').val(''),
	                    							$('#totalwidthoutsideLav2').val(''),
	                    							$('#totalwidthoutsideLav3').val(''),
	                    							$('#totalwidthoutsideLav4').val(''),
	                    							$('#totalwidthinsideLav1').val(''),
	                    					        $('#totalwidthinsideLav2').val(''),
	                    						    $('#totalwidthinsideLav3').val(''),
	                    							$('#totalwidthinsideLav4').val(''),
	                    							$('#windowcutOutLav1').val(''),
	                    							$('#windowcutOutLav2').val(''),
	                    					        $('#windowcutOutLav3').val(''),
	                    						    $('#windowcutOutLav4').val(''),
	                    							$('#windowcutOutsideLav1').val(''),
	                    							$('#windowcutOutsideLav2').val(''),
	                    							$('#windowcutOutsideLav3').val(''),
	                    							$('#windowcutOutsideLav4').val(''),
	                    							$('#pillarheightSheetLav1').val(''),
	                    						    $('#pillarheightSheetLav2').val(''),
	                    							$('#pillarheightSheetLav3').val(''),
	                    							$('#pillarheightSheetLav4').val(''),
	                    							$('#windowprofilecutForExhaustLav1').val(''),
	                    							$('#windowprofilecutForExhaustLav2').val(''),
	                    					        $('#windowprofilecutForExhaustLav3').val(''),
	                    							$('#windowprofilecutForExhaustLav4').val(''),
	                    							$("input[id='lavsidewallFrameAsPerDrawingFlag']:checked").val(''),
	                    							$("input[id='lavsidewallMemberWeldingFlag']:checked").val(''),
	                                                $("input[id='conditionLavsidewallMemberJointweldingFlag']:checked").val(''),
	                                                $("input[id='conditionLavsidewallSheetLaserweldingFlag']:checked").val(''),
	                                                $('#lavSidewallDetailsOfModification').val('');
	                                                $('#lavSidewallDetailsOfTrial').val('');
	                                                $('#lavSidewallRemarks').val(''),
	                                                $("input[id='shellLavSidewallSipTestingStatus']:checked").val(''),
	                                                
	                    							$('#lavsidewallSIP').dialog('close');
	                                               
	                    							$('#ShellProductionTableContainer').jtable('load');
	         								  })
	         								.error(function (msg){
	         									//$('#dialog').dialog('close');
	         									alert("Error Fetching Data");
	         								})
	         								  ;
					                 			    	   return true;
				                                    }
	                                    },
				                        Close: function () {
				                        	$('#lavsidewallSIP').find('form[name="lavSidewallForm"]')[0].reset();
				                                        $(this).dialog('close');
				                                    }
	                                    },
	                    	        modal: true
    	    });
                    	 		
                    	 		
                    	 		
                    	 		
                    	 		
                    	 		    
            			    	   return true;
                    	 		    
                    	 			  
                    	 		  }
                 	 		
                    	//ending else               	  
                        // ajax call ends here				
    						 
                        }
                    },
                    
                    // endwall
                    
                    {
                    	icon: '<%=contextpath%>/images/rs_out.png',
                        text: 'Endwall SIP',
                        click: function () {
                        	
                        	
                        	
                        	 var $selectedRows = $('#ShellProductionTableContainer').jtable('selectedRows');
                    	 	 if ($selectedRows.length<1)
                    		 alert("Please select a row for which you want to fill SIP data");
                    	 	 else{
                    	 		var record;
                    	 		$selectedRows.each(function () {
                                    record = $(this).data('record');
                                    });
								//setting min value
									$.ajax({
								url:"showExistingEndwallData",  //action-name as defined in struts.xml
								dataType:'json',
								type:'POST',
								async:false,
								data:{
								shellAssetId:record.shellAssetId,	
								},
								success:function(data)
								{
									$('#endwallSipDocNo').val(data.endwallSipDocNo);
								    $('#endwallNo').val(data.shellNo);
								    $('#endwallShellType').val(data.shellType);
								    $('#endwallPpMake').val(data.endwallMakePp);
								    $('#endwallNppMake').val(data.endwallMakeNpp);
								    $('#endwallPpNo').val(data.endwallNoPp);
								    $('#endwallNppNo').val(data.endwallNoNpp);
								}
									
								});
                      	if(record.endwallSipFlag==1)
								{
						
								$.ajax({
									url:"showSaveDataEndWall", //action-name as defined in struts.xml
									dataType:'json',
									type:'POST',
									async:false,
									data:{
									shellAssetId:record.shellAssetId,	
									},
									success:function(data)
									{
										
										$('#endwallSipShift').val(data.shellEndwallSipTran.endwallSipShift);
										var endDate=(data.shellEndwallSipTran.endwallSipDate).substring(0,10);
										var endDateArray=endDate.split("-");
										$('#endwallSipDate').datepicker("setDate",new Date(endDateArray[0],endDateArray[1]-1,endDateArray[2]));
										$('#drawingNoendwall').val(data.shellEndwallSipTran.drawingNo);
										$('#wiNoendwall').val(data.shellEndwallSipTran.wiNo);
										$('[id="observationItemAsPerDrawing"]').val([data.shellEndwallSipTran.observationItemAsPerDrawing]);
										$('[id="observationComplianceWi"]').val([data.shellEndwallSipTran.observationComplianceWi]);
										$('[id="observationWeldingThroatLength"]').val([data.shellEndwallSipTran.observationWeldingThroatLength]);
										$('#distanceStopperholeUchannel').val(data.shellEndwallSipTran.distanceStopperholeUchannel);
										$('#distanceUchannelStopperhole').val(data.shellEndwallSipTran.distanceUchannelStopperhole);
										$('#distanceVestibuleUchannelPp').val(data.shellEndwallSipTran.distanceVestibuleUchannelPp);
										$('#distanceVestibuleUchannelNpp').val(data.shellEndwallSipTran.distanceVestibuleUchannelNpp);
										$('[id="conditionTailLampHole"]').val([data.shellEndwallSipTran.conditionTailLampHole]);
										$('[id="conditionVestibuleHole"]').val([data.shellEndwallSipTran.conditionVestibuleHole]);
										$('[id="conditionDrainHole"]').val([data.shellEndwallSipTran.conditionDrainHole]);
										$('#endwallOuterWidth').val(data.shellEndwallSipTran.endwallOuterWidth);
										$('[id="endwallExhaustCutting"]').val([data.shellEndwallSipTran.endwallExhaustCutting]);
										$('[id="endwallPieceVerstibule"]').val([data.shellEndwallSipTran.endwallPieceVerstibule]);
										$('[id="endwallTestingStatus"]').val([data.shellEndwallSipTran.endwallTestingStatus]);
										$('#roofelementWaterejectHole').val(data.shellEndwallSipTran.roofelementWaterejectHole);
										$('#backpieceVestibuleDoor').val(data.shellEndwallSipTran.backpieceVestibuleDoor);
										$('#detailsOfModificationendwall').val(data.shellEndwallSipTran.detailsOfModification);
										$('#detailsOfTrialendwall').val(data.shellEndwallSipTran.detailsOfTrial);
										$('#remarksendwall').val(data.shellEndwallSipTran.remarks);
									}
										
									});
								
								}
								
								
								
								$('#endwallSipDate').datepicker('option', 'minDate', new Date(record.assemblyStartDate));

						
                    	 	 	$("#endwallSIP").dialog({
                    	 	 		title : 'LavSideWall Inspection Form'+record.shellTransactionId + 'from Stage- <%=stageID%>',
                    	 	 		width:'55%',
                    	 	 		close: function (e, u) {
                    	 	 			$('form[name="endwallSIP"]')[0].reset();
              	 		          	$("#endwallSIP").validationEngine('hideAll');
              	 		          },
              	 		    
 		 							buttons: {
	                                    Submit: {
	                                       text: "Submit",
	                                        id: "my-button-submit",
	                                        click:function () {
	                                        	 
	                                    	//alert("$('#qtyDispatched').val()->"+$('#qtyDispatched').val());
	                                    	//alert("record.balanceQtyToDispatch->"+record.balanceQtyToDispatch);
	                            	 		if ($('#endwallSipDate').validationEngine('validate')) {
				                                        	//alert(!$("#dialog").validationEngine('validate'));
				                                            return false;}
	                                    	 
	                                    	  if ($('#endwallSipDocNo').validationEngine('validate')) {
	                                            return false;
	                                            
	                                          }
	                                    
	                                    	  if ($('#distanceStopperholeUchannel').validationEngine('validate')) {
		                                            return false;
		                                            
		                                          }
	                                    	  if ($('#distanceUchannelStopperhole').validationEngine('validate')) {
		                                            return false;
		                                            
		                                          }
	                                    	  if ($('#distanceVestibuleUchannelPp').validationEngine('validate')) {
		                                            return false;
		                                            
		                                          }
	                                    	  if ($('#distanceVestibuleUchannelNpp').validationEngine('validate')) {
		                                            return false;
		                                            
		                                          }
	                                    	  if ($('#endwallOuterWidth').validationEngine('validate')) {
		                                            return false;
		                                            
		                                          }
	                     
                                            var c=confirm("Do you want to confirm lavsidewall testing?");
	                                    	if(c==false){return false;}
                                          
                 
	                                    	$.ajax({
	                           	             url : "saveEndShell",  //action-name as defined in struts.xml
	                           	                dataType: 'json', 
	                           	                 data : {
	                           	                 shellAssetId: record.shellAssetId,
	                           	                   //	underFrameNumber:$('#underFrameNumber').val(),
	                           	                          endwallSipDocNo:$ ('#endwallSipDocNo').val(),
	                           	                          endwallSipShift:$ ('#endwallSipShift').val(),
	                                                      endwallSipDate:$ ('#endwallSipDate').val(),
	                           	                          drawingNo:$ ('#drawingNoendwall').val(),
	                                                      wiNo:$ ('#wiNoendwall').val(),
	                                                      endwallPpMake:$('#endwallPpMake').val(),
	                                                      endwallNppMake:$('#endwallNppMake').val(),
	                                                      endwallPpNo:$('#endwallPpNo').val(),
	                                                      endwallNppNo:$('#endwallNppNo').val(),
	                                                      observationItemAsPerDrawing:$("input[id='observationItemAsPerDrawing']:checked").val(),        						
	                           	                          observationComplianceWi:$("input[id='observationComplianceWi']:checked").val(),
	                                                      observationWeldingThroatLength:$("input[id='observationWeldingThroatLength']:checked").val(),                                
	                           	                          distanceStopperholeUchannel:$ ('#distanceStopperholeUchannel').val(), 
	                                                      distanceUchannelStopperhole:$ ('#distanceUchannelStopperhole').val(), 
	                                                      distanceVestibuleUchannelPp:$ ('#distanceVestibuleUchannelPp').val(),
	                                                      distanceVestibuleUchannelNpp:$ ('#distanceVestibuleUchannelNpp').val(),
	                                                      conditionTailLampHole:$("input[id='conditionTailLampHole']:checked").val(),
	                                                      conditionVestibuleHole:$("input[id='conditionVestibuleHole']:checked").val(),
	                                                      conditionDrainHole:$("input[id='conditionDrainHole']:checked").val(),
	                                                      endwallOuterWidth:$ ('#endwallOuterWidth').val(),
	                                                      endwallExhaustCutting:$("input[id='endwallExhaustCutting']:checked").val(),
	                                                      endwallPieceVerstibule:$("input[id='endwallPieceVerstibule']:checked").val(),
	                                                      endwallTestingStatus:$("input[id='endwallTestingStatus']:checked").val(),
	                                                      roofelementWaterejectHole:$ ('#roofelementWaterejectHole').val(),
	                                                      backpieceVestibuleDoor:$ ('#backpieceVestibuleDoor').val(),
	                                                      detailsOfModification:$('#detailsOfModificationendwall').val(),
	                           	                          detailsOfTrial:$('#detailsOfTrialendwall').val(),
	                           	                          remarks:$('#remarksendwall').val(),
	                                                     		
	                           	               },
	                           	                    						
	                           	                  type : 'POST',
	                           	                  async : false,
	                           	               })

	                            	 		.done(function( msg ) {
	                                                 shellAssetId: record.shellAssetId,
	                     	                        
	                                                 $('#endwallSipDocNo').val(''),
	                                                 $('#endwallSipShift').val(''),
                                                     $('#endwallSipDate').val(''),
                                                     $('#drawingNoendwall').val(''),
                                                     $ ('#wiNoendwall').val(''),
                                                     $("input[id='observationItemAsPerDrawing']:checked").val(''),        						
	                                                 $("input[id='observationComplianceWi']:checked").val(''),
                                                     $("input[id='observationWeldingThroatLength']:checked").val(''),                                
	                                                 $('#distanceStopperholeUchannel').val(''), 
                                                     $('#distanceUchannelStopperhole').val(''), 
                                                     $('#distanceVestibuleUchannelPp').val(''),
                                                     $ ('#distanceVestibuleUchannelNpp').val(''),
                                                     $("input[id='conditionTailLampHole']:checked").val(''),
                                                     $("input[id='conditionVestibuleHole']:checked").val(''),
                                                     $("input[id='conditionDrainHole']:checked").val(''),
                                                     $ ('#endwallOuterWidth').val(''),
                                                     $("input[id='endwallExhaustCutting']:checked").val(''),
                                                     $("input[id='endwallPieceVerstibule']:checked").val(''),
                                                     $("input[id='endwallTestingStatus']:checked").val(''),
                                                     $ ('#roofelementWaterejectHole').val(''),
                                                     $ ('#backpieceVestibuleDoor').val(''),	
                                                     $('#detailsOfModificationendwall').val(''),
	                                                 $('#detailsOfTrialendwall').val(''),
	                                                 $('#remarksendwall').val(''),
	                                                 $('#endwallSIP').dialog('close');
	                                                 $('#ShellProductionTableContainer').jtable('load');
	              })
	                    					
	         								.error(function (msg){
	         									$('form[name="endwallSIP"]')[0].reset();
	         									alert("Error Fetching Data");
	         								})
	         								  ;
					                 			    	   return true;
				                                    }
	                                    },
				                        Close: function () {
				                        	$('form[name="endwallSIP"]')[0].reset();
				                                        $(this).dialog('close');
				                                    }
	                                    },
	                    	        modal: true
    	    });
                    	 		
                    	 		
                    	 		
                    	 		
                    	 		
                    	 		    
            			    	   return true;
                    	 		    
                    	 			  
                    	 		  }
                 	 		
                    	//ending else               	  
                        // ajax call ends here				
    						 
                        }
                    },
                    
                  
                    
                    
                    
                    
                     
            ]
            },
         
			actions : {
			
 	
 			listAction: 'listSIPComonentShellAction?stageID=<%=stageID%>'
 			
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
				
				shellAssetId : {
					title : 'shellAssetId',
					width: '8%',
					key: true,
					list : false,
					edit : false,
					create : false
									
					},
					shellTransactionId : {
						title : 'Shell Production Id',
						width: '8%',
						
						list : true,
						edit : false,
						create : true,
						inputClass: 'validate[required]'				
						},
						
				shellType: {
					title: 'Shell Type',
					width: '10%',
					options: shelltypes,
					
					list: true,
					edit : true
				},
				shellNumber:
					{
					title: 'Shell No'
					},
				remarks: {
				   title: 'Remarks',
				   width : '20%',
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
	
				  if (prevStage!='START'){
					 
				     $('#ShellProductionTableContainer').find('.jtable-toolbar-item.jtable-toolbar-item-add-record').remove();
				  }
				  
				},
				formCreated: function (event, data) {
					data.form.find('textarea[name="remarks"]').attr('placeholder','Enter Remarks');
					data.form.find('input[name="assemblyStartDate"]').attr('placeholder','Enter Jig Entry Date');
					data.form.find('input[name="expectedExitDate"]').attr('placeholder','Enter Expected dispatch Date');

						
					//alert(data.record.assemblyStartDate);
					/* $('[name=assemblyStartDate]').
					datepicker("option", "disabled", false ).
					val('').css('background-color' ,'').datepicker("option", "maxDate", new Date);
					$('[name=assemblyStartDate]').val(moment(data.record.assemblyStartDate).format('DD-MM-YYYY'));
					
					$('[name=assemblyStartDate]').datepicker({
					    onSelect: function(selected) {
					    	alert("hello");
					var d=data.assemblyStartDate;
					alert(d);
					    }
					}) */
					
					$('[name=assemblyStartDate]').datepicker({
						
						dateFormat: 'dd-mm-yy',
					    onSelect: function(selected) {
					      $('[name=expectedExitDate]').datepicker("option","minDate", selected)
     // $('[name=assemblyStartDate]').val(moment(selected).format('DD-MM-YYYY'));
					      //$('[name=assemblyStartDate]').datepicker('hide');
					    }
					}).datepicker("option", "maxDate", new Date);;

					$('[name=expectedExitDate]').datepicker({ 
						
						dateFormat: 'dd-mm-yy',
					    onSelect: function(selected) {
					        $('[name=assemblyStartDate]').datepicker("option","maxDate", selected)
  //	$('[name=expectedExitDate]').val(moment(selected).format('DD-MM-YYYY'));
					     //   $(this).datepicker('hide');
 					    }
 					}); 
			
					data.form.validationEngine();
	               	            },
	            recordDeleted: function(event,data)
	    		{
	    			srno=0;
	    			$('#ShellProductionTableContainer').jtable('load');
	    		},
	    		
 
					//Validate form when it is being submitted
				formSubmitting: function (event, data) {
			    return data.form.validationEngine('validate');
			             
			            },
			    
				//Dispose validation logic when form is closed
				formClosed: function (event, data) {
			               data.form.validationEngine('hide');
			               data.form.validationEngine('detach');
				}
	              
			});
	$('#ShellProductionTableContainer').jtable('load');
		});
		
		
	</script>
	 
	<script>
	function setMinDate(){
	
		var from = $('#datepickerCompletion').val(); 
		var numbers = from.match(/\d+/g); 
		
		var date = new Date(numbers[2], numbers[1]-1, numbers[0]);
		
		$('#datepickerExit').datepicker('option', 'minDate', date);
	}
	
	</script>