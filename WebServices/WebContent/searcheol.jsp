<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String q = request.getParameter("q");
String ppage = request.getParameter("page");
String exact = request.getParameter("exact");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Name search BHL</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
var q="<%=q%>";
var page="<%=ppage%>";
var exact="<%=exact%>";
$(function(){
	$.getJSON("searchGetEOLData",
		{
		q:q, 
		page:page, 
		exact:exact
		
		},function(data)
			{
				if(data==null)
				{
					var content="<h4>在eol中搜索的结果为0条</h4>";
					$("#rs_head").append(content);
					return;
				}
				$("#rs_body").empty();
						
				var rs = "<select name='id'>";
				if(data.results.length == 0){
					rs += "<option>没有结果了</option>";
				}else{
					
					$.each(data.results,function(i,obj){
						if(obj.id!=null)
						{
							rs += "<option value='"+obj.id+"'>"+obj.title+"</option>";
						}
							
					});
					rs += "</select>";
				}
				$("#rs_body").append(rs);
				
			});
});
</script>
</head>
<body>
<div id="rs_head"></div>
<form action="pagesearcheol.jsp" method="post" name="" >
<table width="650px;">
	<tr>
		<td colspan="3"><b>请选择要查看的详细信息：</b></td>
	</tr>
	<tr><td>&nbsp;</td><td></td><td></td></tr>
	<tr>
		<td align="right">ScientificName：</td>
		<td><div id="rs_body"><select name='id'></select></div></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">images：</td>
		<td><input type="text" name="images" id="images" value="1"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">videos：</td>
		<td><input type="text" name="videos" id="videos" value="1"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">sounds：</td>
		<td><input type="text" name="sounds" id="sounds" value="0"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">maps：</td>
		<td><input type="text" name="maps" id="maps" value="0"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">text：</td>
		<td><input type="text" name="text" id="text" value="1"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">iucn：</td>
		<td><select name="iucn">
			<option selected="selected" value="false">false</option>
			<option value="true">true</option>
		</select></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">subjects：</td>
		<td><input type="text" name="subjects" id="subjects" value="overview"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">licenses：</td>
		<td><input type="text" name="licenses" id="licenses" value="all"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">details：</td>
		<td><select name="details">
			<option value="false">false</option>
			<option selected="selected" value="true">true</option>
		</select></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">common_names：</td>
		<td><select name="common_names">
			<option value="false">false</option>
			<option selected="selected" value="true">true</option>
		</select></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">synonyms：</td>
		<td><select name="synonyms">
			<option value="false">false</option>
			<option selected="selected" value="true">true</option>
		</select></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">references：</td>
		<td><select name="references">
			<option value="false">false</option>
			<option selected="selected" value="true">true</option>
		</select></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">vetted：</td>
		<td><select name="vetted">
			<option value="0" selected="selected">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
		</select></td>
		<td><input type="submit" name="submit" value="查找" /></td>
	</tr>

</table>
</form>

</body>
</html>