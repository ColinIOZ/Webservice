<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.big.util.*" %>  
<%@ page import="net.sf.json.*" %> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript">
$(function(){
	$.getJSON("json/countryCode.json",
			function(data)
				{
					if(data==null)
					{
						var content="<select name='country'><option value='0'>请选择</option></select>";
						$("#rs_data").append(content);
						return;
					}
					$("#rs_data").empty();
					var rs = "<select name='country'>";
				    rs += "<option value='0'>请选择</option>";
					$.each(data.results,function(i,obj){
						if(i > 0)
							rs += "<option value='"+obj.field1+"'>"+obj.field0+"</option>";								
					});
					rs += "</select>";
					
					$("#rs_data").append(rs);
					
				});
});

function checkForm(){
	var flag = true;
	if($("#scientificName").val() == ""){
		alert("学名不能为空");
		flag = false;
	}
	return flag;
}

</script>

</head>

<body>

<form action="namesearchgbif.jsp" method="post" name="" onsubmit="return checkForm();">
<table width="600px;">
	<tr>
		<td colspan="3"><b>根据学名在GBIF中查找数据：</b></td>
	</tr>
	<tr><td>&nbsp;</td><td></td><td></td></tr>
	<tr>
		<td align="right">学名：</td>
		<td><input type="text" name="scientificName" id="scientificName"/>
			<input type="hidden" name="offset" value="0"/> 	
		</td>
		<td></td>
	</tr>
	<tr>
		<td align="right">国家：</td>
		<td><div id="rs_data">
			<select name="country" id="country" onclick="queryData();">
				<option value="0">请选择</option>
				
			</select>
			</div>
		</td>
		<td></td>
	</tr>
	<tr>
		<td align="right">是否包含坐标：</td>
		<td><select name="hasCoordinate">
			<option value="0">请选择</option>
			<option value="true">包含</option>
			<option value="false">不包含</option>
		</select></td>
		<td><input type="submit" name="submit" value="查找" /></td>
	</tr>

</table>
</form>
<br>
</body>
</html>
