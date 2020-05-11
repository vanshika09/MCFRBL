<!DOCTYPE style PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% String contextpath=request.getContextPath();%>
<%@ page import="hibernateConnect.HibernateConfig" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="model.User" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.apache.struts2.dispatcher.SessionMap" %>
<%@ page import="com.opensymphony.xwork2.ActionSupport" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="org.apache.struts2.dispatcher.SessionMap" %>
<%@ page import="org.apache.struts2.interceptor.SessionAware" %>
<head>
<style>
.table_class
{
	/* border: 1px solid black; */
	border:0px; 
    padding: 0px;
    background: url(images/raebareli_building.jpg);
    background-repeat: no-repeat;
    background-size: 82% 100%; 
    background-position: center; 
    }
  .heading_h1  {
    color:black;
    text-shadow: 2px 3px 2px grey;
    text-align: center;
    font-weight:bold;
    text-decoration: blink; 
}

.heading_h3  {
	color:black;
    text-shadow: 2px 2px 3px grey;
    text-align: center;
    font-weight:bold;
    text-decoration: blink; 
    /* text-shadow: 3px 2px #DA70D6;
    text-align: center;
    text-decoration: blink; */
}
.alignment-center
{
text-align: center;
}

</style>
<script src="<%=contextpath %>/js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script type="text/javascript"><%-- 
$(document).ready(function()
		{
		    $(window).bind("beforeunload", function(event) { 
		       var x= confirm("Do you really want to close?") ; 
		       if(x==true)
			       {
		    	   window.location="<%=request.getContextPath()%>"+"/logout";
		    	   return true;
		    	 
			       }
		       else{
		    	   event.preventDefault();
		    	   event.stopImmediatePropagation();
		    	   return false;
			       
		       }
		    });
	class="alignment-center"
		}); --%>
</script>
</head>
<body>
<%
User loginUser = null;
Session session_hibernate = null;
String username= null;
String roles= null;
String name=null;
HttpSession session_http = ServletActionContext.getRequest().getSession(true);
username = (String) session_http.getAttribute("userid");

if (username != null)
{
session_hibernate = HibernateConfig.getSession();
loginUser = (User)session_hibernate.get(User.class,username.trim());
name=loginUser.getUserName();
roles= loginUser.getRoles();
}
%>
<table class="table_class" style="width:100%;height:50px;margin-top:0px;">
<tr>
<td style="width:9%;"><img src="<%=contextpath %>/images/cris_logo.jpg?OpenImageResource" style="margin-left:20%;width:60%;height:60%;"></td>
<td style="width:82%;"><h1 class="heading_h1" style="margin-bottom:0px;margin-top:0px;">Modern Coach Factory, Raebareli</h1><br><h3 class="heading_h3" style="margin-bottom:0px;margin-top:0px;">Production Monitoring System</h3>
<p style="margin-top:0px;color:white;text-shadow:1px 2px 1px black;"><span style="float:left">&nbsp;&nbsp;Welcome <b><%=name%>,</b> you are authorized for <%=roles%> Shop</span><span  style="float:right"><a href="home-page"><img src='images/home_icon.png' alt="home"/></a></span></p>
</td>

<td style="width:9%;"><img src="<%=contextpath %>/images/mcf_logo.jpg?OpenImageResource"  style="margin-left:20%;width:60%;height:60%;"></td></tr>

</table>
</body>
</html>
