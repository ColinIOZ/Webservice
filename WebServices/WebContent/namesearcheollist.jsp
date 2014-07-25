<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<% 
String q = request.getParameter("q");
String ppage = request.getParameter("page");
String exact = request.getParameter("exact");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript">

var q="<%=q%>";
var page=1;
if("<%=ppage%>" != null)
	page="<%=ppage%>";
var exact="<%=exact%>";
	
$(function(){
	$.getJSON("searchGetEOLData",
		{
		q:q, 
		page:page, 
		exact:exact
		
		},function(data)
			{
				$("#rs_data").empty();
				if(data==null)
				{
					var content="<h4>在eol中搜索的结果为0条</h4>";
					$("#rs_data").append(content);
					return;
				}
				if(data.totalResults == 1){
					var a = $("<a/>");
					a.click(function(){
						$.each(data.results,function(i,obj){
							window.location.href = "pagesearcheol.jsp?id="+obj.id;									
						});
						
					});
					a.click();
					
				}else{
				var rs = "<h4>在eol中搜索的结果为"+data.totalResults+"条</h4>";
				rs += "<table>";
				$.each(data.results,function(i,obj){
					if(obj.id != null)
					{
						rs += "<tr><td>"+(data.startIndex+i)+"、</td><td></td><td><a href='pagesearcheol.jsp?id="+obj.id+"'>"+obj.title+"</a></td><tr>";
					}
							
				});
				rs += "</table><br>";
				
				if(data.first != null)
					rs += "<a href='namesearcheollist.jsp?q="+q+"&page=1&exact="+exact+"'>首页</a>&nbsp;";
				if(data.previous != null)
					rs += "<a href='namesearcheollist.jsp?q="+q+"&"+data.previous.substring(data.previous.indexOf('?')+1)+"&exact="+exact+"'>上一页</a>&nbsp;";
				if(data.self != null)
					rs += "<font color='red'>第"+data.self.substring(data.self.indexOf('=')+1)+"页</font>&nbsp;";
				if(data.next != null)	
					rs += "<a href='namesearcheollist.jsp?q="+q+"&"+data.next.substring(data.next.indexOf('?')+1)+"&exact="+exact+"'>下一页</a>&nbsp;";
				if(data.last != null){
					rs += "<a href='namesearcheollist.jsp?q="+q+"&"+data.last.substring(data.last.indexOf('?')+1)+"&exact="+exact+"'>末页</a>&nbsp;";
					rs += "共<font color='red'>"+data.last.substring(data.last.indexOf('=')+1)+"</font>页";
				}	
				
				$("#rs_data").append(rs);
				}
				
			});
	
});


</script>

</head>

<body>

<div id="rs_data"></div>


</body>
</html>
