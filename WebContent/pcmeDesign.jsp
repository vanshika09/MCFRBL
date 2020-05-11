<%@ page import="com.opensymphony.xwork2.ActionContext" %> 
<%@ page import= "java.text.SimpleDateFormat" %>
<%@ page import= "java.util.Date" %>
  <%@ page import="ACTION.DashboardAction" %> 
  <%@ taglib uri="/birt.tld" prefix="birt"%> 

 <%
 String contextpath=request.getContextPath();
Date startDate=new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("startDate"));
%>

<!-- Include jTable script file. -->
<script src="<%=contextpath %>/js/jquery-2.1.4.min.js" type="text/javascript"></script> 
<script src="<%=contextpath %>/js/jquery-ui-1.11.4.custom/jquery-ui.js" type="text/javascript"></script> 


<script>
$(document).ready(function() {
	//alert("resetting height");
	var width=$(window).width();
 	var height= $(window).height();
 	
    $('iframe').css('height', height * 1.0);
    $('iframe').css('width', width * 0.98);
    //alert("height:"+height+"  width:"+width);
    
});


</script>

<birt:viewer id="birtViewer" 
				reportDesign="reports/pcme.rptdesign"
				pattern="frameset" 
				scrolling="yes" 
				
				showParameterPage="false">
				<birt:param name="cdate" value='<%=startDate%>'></birt:param>


</birt:viewer>