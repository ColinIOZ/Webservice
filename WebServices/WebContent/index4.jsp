<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	$.getJSON("json/db.json",
			function(data)
				{
					if(data==null)
					{
						var content="<select name='db'><option value='0'>请选择</option></select>";
						$("#rs_data").append(content);
						return;
					}
					$("#rs_data").empty();
					var rs = "<select name='db'>";
				    rs += "<option value='0'>请选择</option>";
					$(data.einforesult.dblist).each(function(){
						rs += "<option value='"+this+"'>"+this+"</option>";								
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

<form action="namesearchncbi.jsp" method="post" name="" onsubmit="return checkForm();">
<table width="300px;">
	<tr>
		<td colspan="3"><b>根据学名在NCBI中查找数据：</b></td>
	</tr>
	<tr><td>&nbsp;</td><td></td><td></td></tr>
	<tr>
		<td align="right">学名：</td>
		<td><input type="text" name="scientificName" id="scientificName"/>
		<input type="hidden" name="retstart" value="0"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">数据库：</td>
		<td>
			<div id="rs_data">
			<select name="db" id="db" >
				<option value="0">请选择</option>
				
			</select>
			</div>
		</td>
		<td><input type="submit" name="submit" value="查找" id="sub"/></td>
	</tr>

</table>
</form>
<br>

<div id="rs_data">

</div>


</body>
</html>
