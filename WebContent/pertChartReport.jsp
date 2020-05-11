<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>

<% String contextpath=request.getContextPath();%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Pert Chart</title>
    <style>
    #myDiagramDiv canvas {
  		outline: none;
    }
    </style> 
    
    
    <script src="<%=contextpath %>/js/go.js"></script>
    
    <script src="<%=contextpath %>/js/html2pdf.bundle.min.js"></script>
    
       
    <script src="<%=contextpath %>/js/jquery.min.js"></script>
    
  	<script src="<%=contextpath %>/js/bootstrap.min.js"></script>
    
    
    
    
    <script>

//function init() {
$(document).ready(function() { 
	 var pertChartData=[]; 


	    var k=0;
	<c:forEach var="m" items="${pertChartList}">
	pertChartData[k]={ key: ${m.key}, text: "${m.text}", optimistic:"${m.earlyStart}",mostLikely:"${m.lateStart}", pesimistic:"${m.length}", stdDev:"${m.earlyFinish}",  totalProd:"${m.slack}",workInHand:"${m.lateFinish}", critical:${m.critical} };
		k++;
	</c:forEach> 

	 
	 
    if (window.goSamples) goSamples();  // init for these samples -- you don't need to call this
    var $ = go.GraphObject.make;  // for more concise visual tree definitions

    // colors used, named for easier identification
    var blue = "#0288D1";
    var pink = "#B71C1C";
    var pinkfill = "#F8BBD0";
    var bluefill = "#B3E5FC";
     
    myDiagram =
      $(go.Diagram, "myDiagramDiv",
        {
          initialAutoScale: go.Diagram.Uniform,
          layout: $(go.LayeredDigraphLayout),
          allowHorizontalScroll: false,
          allowVerticalScroll: false
          
        });

    // The node template shows the activity name in the middle as well as
    // various statistics about the activity, all surrounded by a border.
    // The border's color is determined by the node data's ".critical" property.
    // Some information is not available as properties on the node data,
    // but must be computed -- we use converter functions for that.
    myDiagram.nodeTemplate =
      $(go.Node, "Auto",
        $(go.Shape, "Rectangle",  // the border
          { fill: "white", strokeWidth: 2 },
          new go.Binding("fill", "critical", function(b) { return (b ? pinkfill : bluefill); }),
          new go.Binding("stroke", "critical", function(b) { return (b ? pink : blue); })),
        $(go.Panel, "Table",
          { padding: 0.5 },
          $(go.RowColumnDefinition, { column: 1, separatorStroke: "black" }),
          $(go.RowColumnDefinition, { column: 2, separatorStroke: "black" }),
          $(go.RowColumnDefinition, { row: 1, separatorStroke: "black", background: "white", coversSeparators: true }),
          $(go.RowColumnDefinition, { row: 2, separatorStroke: "black" }),
          $(go.TextBlock, // earlyStart
            new go.Binding("text", "optimistic"),
            { row: 0, column: 0, margin: 5, textAlign: "center" }),
          $(go.TextBlock, //length
            new go.Binding("text", "mostLikely"),   
            { row: 0, column: 1, margin: 5, textAlign: "center" , font: "bold 14px sans-serif"}),
          $(go.TextBlock,  // earlyFinish
            new go.Binding("text", "pesimistic"),   
			{ row: 0, column: 2, margin: 5, textAlign: "center" }),

          $(go.TextBlock,
            new go.Binding("text", "text"),
            {
              row: 1, column: 0, columnSpan: 6, margin: 5,
              textAlign: "center", font: "bold 14px sans-serif"
            }),

          $(go.TextBlock,  // lateStart
            new go.Binding("text", "stdDev"),
			{ row: 2, column: 0, columnSpan: 1, margin: 5, textAlign: "center" }),
          $(go.TextBlock,  // slack
            new go.Binding("text", "totalProd"),
            { row: 2, column: 1, columnSpan: 1, margin: 5, textAlign: "center" }),
          $(go.TextBlock, // lateFinish
            new go.Binding("text", "workInHand"),
            { row: 2, column: 2, columnSpan: 1 , margin: 5, textAlign: "center" })
        )  // end Table Panel
      );  // end Node

    // The link data object does not have direct access to both nodes
    // (although it does have references to their keys: .from and .to).
    // This conversion function gets the GraphObject that was data-bound as the second argument.
    // From that we can get the containing Link, and then the Link.fromNode or .toNode,
    // and then its node data, which has the ".critical" property we need.
    //
    // But note that if we were to dynamically change the ".critical" property on a node data,
    // calling myDiagram.model.updateTargetBindings(nodedata) would only update the color
    // of the nodes.  It would be insufficient to change the appearance of any Links.
    function linkColorConverter(linkdata, elt) {
      var link = elt.part;
      if (!link) return blue;
      var f = link.fromNode;
      if (!f || !f.data || !f.data.critical) return blue;
      var t = link.toNode;
      if (!t || !t.data || !t.data.critical) return blue;
      return pink;  // when both Link.fromNode.data.critical and Link.toNode.data.critical
    }

    // The color of a link (including its arrowhead) is red only when both
    // connected nodes have data that is ".critical"; otherwise it is blue.
    // This is computed by the binding converter function.
    myDiagram.linkTemplate =
      $(go.Link,
        { toShortLength: 6, toEndSegmentLength: 20 },
        $(go.Shape,
          { strokeWidth: 4 },
          new go.Binding("stroke", "", linkColorConverter)),
        $(go.Shape,  // arrowhead
          { toArrow: "Triangle", stroke: null, scale:1.5 },
          new go.Binding("fill", "", linkColorConverter))
      );

    // here's the data defining the graph
    var nodeDataArray=pertChartData;
    	/* [
      { key: 1, text: "Start", earlyStart: 0, length: 0, earlyFinish: 0, lateStart: 0, slack: 0, lateFinish: 0, critical: true },
      { key: 2, text: "Wheel", earlyStart: 2, length: 9, earlyFinish: 11, lateStart: 12, slack: 22, lateFinish: 7, critical: true },
      { key: 3, text: "Shell", earlyStart: 2, earlyStart: 2, length: 9, earlyFinish: 11, lateStart: 12, slack: 22, lateFinish: 	7, critical: true },
      { key: 4, text: "Bogie", earlyStart: 2, length: 9, earlyFinish: 11, lateStart: 12, slack: 22, lateFinish: 7, critical: true},
      { key: 5, text: "Paint", earlyStart: 2, length: 9, earlyFinish: 11, lateStart: 12, slack: 22, lateFinish: 7, critical: true },
      { key: 6, text: "Furnishing", earlyStart: 2, length: 9, earlyFinish: 11, lateStart: 12, slack: 22, lateFinish: 7, critical: true },
     
      { key: 7, text: "Quality", earlyStart: 2, length: 9, earlyFinish: 11, lateStart: 12, slack: 22, lateFinish: 7, critical: true},
      { key: 8, text: "Gateout", earlyStart: 2, length: 9, earlyFinish: 11, lateStart: 12, slack: 22, lateFinish: 7, critical: true }
    ]; */  
    var linkDataArray = [
      { from: 1, to: 2 },
      { from: 1, to: 3 },
      { from: 2, to: 4 },
     /*  { from: 2, to: 5 }, */
      { from: 3, to: 5 },
      { from: 4, to: 6 },
      { from: 5, to: 6 },
      { from: 6, to: 7 },
     
      { from: 7, to: 8 },
      { from: 8, to: 9 }
    ];
    myDiagram.model = new go.GraphLinksModel(nodeDataArray, linkDataArray);

    // create an unbound Part that acts as a "legend" for the diagram
    myDiagram.add(
      $(go.Node, "Auto",
        $(go.Shape, "Rectangle",  // the border
          { fill: bluefill }),
        $(go.Panel, "Table",
          $(go.RowColumnDefinition, { column: 1, separatorStroke: "black" }),
          $(go.RowColumnDefinition, { column: 2, separatorStroke: "black" }),
          $(go.RowColumnDefinition, { row: 1, separatorStroke: "black", background: bluefill, coversSeparators: true }),
          $(go.RowColumnDefinition, { row: 2, separatorStroke: "black" }),
          $(go.TextBlock, "OPTIMISTIC TIME",
            { row: 0, column: 0, margin: 5, textAlign: "center" }),
          $(go.TextBlock, "MOST LIKELY",
            { row: 0, column: 1, margin: 5, textAlign: "center" }),
          $(go.TextBlock, "PESIMISTIC TIME",
            { row: 0, column: 2, margin: 5, textAlign: "center" }),

          $(go.TextBlock, "Activity Name",
            {
              row: 1, column: 0, columnSpan: 3, margin: 5,
              textAlign: "center", font: "bold 14px sans-serif"
            }),

          $(go.TextBlock, "STD DEV TIME",
            { row: 2, column: 0, margin: 5, textAlign: "center" }),
          
          $(go.TextBlock, "TOTAL PROD",
            { row: 2, column: 1, margin: 5, textAlign: "center" }),
            
          $(go.TextBlock, "WORK IN HAND",
            { row: 2, column: 2, margin: 5, textAlign: "center" })
         
        )  // end Table Panel
      ));
  });

</script>
    
    
    
    <!--  -->
  </head>
<!--  <body onload="init()"> -->
  <body>
 <div class="container-fluid" id="printAll" style="margin:30px;padding:0px;">
 <% String fromDate=request.getParameter("StartDate");
 String toDate=request.getParameter("EndDate");
 %>
 
<h4 style="font-weight: bold;" align="center">PERT CHART FROM <%=fromDate%> TO <%=toDate%></h4>

<div class="row" id="row2">
					<div class="col-sm-12" align="center">
					    <div id="sample" align="center" class="chart-wrapper">
					  		
					  			<div id="myDiagramDiv" style="z-index:-1; position:relative;border: solid 0px black; width:1200px;height:300px;margin-top:-40px; margin-bottom:0px;" ></div>
					  			<div id="mybutton" data-html2canvas-ignore="true" style="margin-top:-40px;"><input type="button" id="downloadPdf" onclick="printDiv()" value="Print Me"/></div>
						</div>
					</div>
				</div>
				
<!-- <div><h6 align="center" style="margin-top:-150px;"><input type="button" id="downloadPdf" onclick="printDiv()" value="Print Me"/></h6></div> -->
				
<!-- ROW 2 -->

				

 </div>
 
 
 <script> 
        function printDiv() { 	
        	var element = document.getElementById('printAll');
        
        	var opt = {
        	  margin:       1,
        	  filename:     'pertchart.pdf',
        	  image:        { type: 'jpeg', quality: 1 },
        	  html2canvas:  { scale: 4 },
        	  jsPDF:        { unit: 'px', format:[1400,800], orientation: 'landscape' }
        	};

        	
        	html2pdf(element, opt);

            
        } 
 </script>
 
 
</body>
</html>
