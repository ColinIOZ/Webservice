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
var page="<%=ppage%>";
var exact="<%=exact%>";

function checkForm(){
	var flag = true;
	if($("#q").val() == ""){
		alert("学名不能为空");
		flag = false;
	}
		
	return flag;
}

</script>

</head>

<body>

<form action="index2.jsp" method="post" name="" onsubmit="return checkForm();">
<table width="300px;">
	<tr>
		<td colspan="3"><b>根据学名在EOL中查找数据：</b></td>
	</tr>
	<tr><td>&nbsp;</td><td></td><td></td></tr>
	<tr>
		<td align="right">学名：</td>
		<td><input type="text" name="q" id="q"/></td>
		<td><input type="hidden" name="page" id="page" value="1"/></td>
	</tr>
	<tr>
		<td align="right">搜索条件：</td>
		<td><select name="exact">
			<option value="false" selected="selected">模糊查找</option>
			<option value="true" >精确查找</option>
		</select></td>
		<td><input type="submit" name="submit" value="查找" id="sub"/></td>
	</tr>

</table>
</form>
<br>

<div id="rs_data">
<%	if(q  != null && ppage != null && exact != null){%>
	
<script type="text/javascript">
	
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
					rs += "<a href='index2.jsp?q="+q+"&page=1&exact="+exact+"'>首页</a>&nbsp;";
				if(data.previous != null)
					rs += "<a href='index2.jsp?q="+q+"&"+data.previous.substring(data.previous.indexOf('?')+1)+"&exact="+exact+"'>上一页</a>&nbsp;";
				if(data.self != null)
					rs += "<font color='red'>第"+data.self.substring(data.self.indexOf('=')+1)+"页</font>&nbsp;";
				if(data.next != null)	
					rs += "<a href='index2.jsp?q="+q+"&"+data.next.substring(data.next.indexOf('?')+1)+"&exact="+exact+"'>下一页</a>&nbsp;";
				if(data.last != null){
					rs += "<a href='index2.jsp?q="+q+"&"+data.last.substring(data.last.indexOf('?')+1)+"&exact="+exact+"'>末页</a>&nbsp;";
					rs += "共<font color='red'>"+data.last.substring(data.last.indexOf('=')+1)+"</font>页";
				}	
				
				$("#rs_data").append(rs);
				
			});
	
});

</script>
<%}%>
</div>


</body>
</html>
