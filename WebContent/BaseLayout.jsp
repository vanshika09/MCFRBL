<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
/* select {
    color: black !important;
} */

  #page-container
 {
 position: relative;
 /* min-height: 100vh; */
 }
 #content-wrap
 {
 padding-bottom: 1.5rem;
 } 
 footer
 {
 position: fixed;
 bottom: -5px;
 width:100%;
/*  height: 2.5rem; */
 cellspacing:0px;
 padding-bottom: 0px;
 
 }
 #main-body
 {
 width:100%;
 position: relative;
 top:5%;
 align:left;
 }
 
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>
</head>
<body>

<!-- <table> -->
<!-- 	<tr> -->
<%-- 		<td height="20%" colspan="2" align="center"><tiles:insertAttribute name="header" /> --%>
<!-- 		</td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<%-- 		<td valign="middle" height="75%" width="10%"><tiles:insertAttribute name="menu" /></td> --%>
<%-- 		<td valign="top" height="75%" width="90%" ><tiles:insertAttribute name="body"/></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<%-- 		<td height="5%" width="100%" colspan="2" valign="bottom"><tiles:insertAttribute name="footer" /></td> --%>
<!-- 	</tr> -->
<!-- </table> -->
<div id="page-container" style="height:100%;">
<div id="content-wrap" style="height:97%;">
<div style="height:20%;margin-right:0px;width:100%;"><tiles:insertAttribute name="header" /></div>
<div style="height:8%;margin-right:0px;width:100%;"><tiles:insertAttribute name="menu" /></div>

<div style="height:69%;" id="main-body"><tiles:insertAttribute name="body"/></div>
</div>

<footer style="height:3%;margin-right:0px;"><tiles:insertAttribute name="footer"/> </footer>
</div>
</body>
</html>