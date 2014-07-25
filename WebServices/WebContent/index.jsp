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
	function checkForm1(){
		var flag = true;
		var name = document.namesearchform.elements["name"].value;
		if(name == "" || name == null){
			alert("学名不能为空!");
			flag = false;
		}
		return flag;
	}
	function checkForm2(){
		var flag = true;
		var title = document.titlesearchform.elements["title"].value;
		if(title == "" || title == null){
			alert("标题不能为空!");
			flag = false;
		}
		return flag;
	}
	function checkForm3(){
		var flag = true;
		var title = document.booksearchform.elements["title"].value;
		var author = document.booksearchform.elements["author"].value;
		if((title == "" || title == null) && (author == "" || author == null)){
			alert("标题和作者不能同时为空!");
			flag = false;
		}
		return flag;
	}
	function checkForm4(){
		var flag = true;
		var title = document.partsearchform.elements["title"].value;
		var author = document.partsearchform.elements["author"].value;
		if((title == "" || title == null) && (author == "" || author == null)){
			alert("标题和作者不能同时为空!");
			flag = false;
		}
		return flag;
	}
</script>

</head>

<body>
<form action="nameGetBHLDataNew" method="post" name="namesearchform" onsubmit="return checkForm1();">
<table width="450px;">
	<tr>
		<td colspan="3"><b>根据学名在BHL中查找文献：</b></td>
	</tr>
	<tr><td>&nbsp;</td><td></td><td></td></tr>
	<tr>
		<td align="right">学名(Scientific Name)：</td>
		<td><input type="text" name="name" id="name"/></td>
		<td><input type="submit" name="submit" value="查找" /></td>
	</tr>

</table>
</form>
<br>
<hr color="red">
<form action="titleGetBHLData" method="post" name="titlesearchform" onsubmit="return checkForm2();">
<table width="280px;">
	<tr>
		<td colspan="3"><b>根据 标题 在BHL中查找文献：</b></td>
	</tr>
	<tr><td>&nbsp;</td><td></td><td></td></tr>
	<tr>
		<td align="right">标题：</td>
		<td><input type="text" name="title" id="title"/></td>
		<td><input type="submit" name="submit" value="查找" /></td>
	</tr>

</table>
</form>
<br>
<hr color="red">
<form action="bookSearch" method="post" name="booksearchform" onsubmit="return checkForm3();">
<table width="650px;">
	<tr>
		<td colspan="3"><b>在BHL中查找书或期刊文献：</b></td>
	</tr>
	<tr><td>&nbsp;</td><td></td><td></td></tr>
	<tr>
		<td align="right" width="280">标题：</td>
		<td width="100"><input type="text" name="title" id="title"/></td>
		<td width="270"><font color="red">(*)标题和作者不能同时为空</font></td>
	</tr>
	<tr>
		<td align="right">作者：</td>
		<td><input type="text" name="author" id="author"/></td>
		<td><font color="red">(*)标题和作者不能同时为空</font></td>
	</tr>
	<tr>
		<td align="right">卷：</td>
		<td><input type="text" name="volume"  id="volume"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">版本：</td>
		<td><input type="text" name="edition" id="edition"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">出版日期：</td>
		<td><input type="text" name="year" id="year"/></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">主题：</td>
		<td><input type="text" name="subject" id="subject"/></td>
		<td><input type="submit" name="submit" value="查找" /></td>
	</tr>

</table>
</form>
<br>
<hr color="red">
<form action="partSearch" method="post" name="partsearchform" onsubmit="return checkForm4();">
<table width="650px;">
	<tr>
		<td colspan="3"><b>在BHL中查找书或期刊的章节：</b></td>
	</tr>
	<tr><td>&nbsp;</td><td></td><td></td></tr>
	<tr>
		<td align="right" width="280">标题：</td>
		<td width="100"><input type="text" name="title" /></td>
		<td width="270"><font color="red">(*)标题和作者不能同时为空</font></td>
	</tr>
	<tr>
		<td align="right">作者：</td>
		<td><input type="text" name="author" /></td>
		<td><font color="red">(*)标题和作者不能同时为空</font></td>
	</tr>
	<tr>
		<td align="right">期刊名：</td>
		<td><input type="text" name="container" /></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">出版日期：</td>
		<td><input type="text" name="date" /></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">卷：</td>
		<td><input type="text" name="volume" /></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">系列：</td>
		<td><input type="text" name="series" /></td>
		<td></td>
	</tr>
	<tr>
		<td align="right">期：</td>
		<td><input type="text" name="issue" /></td>
		<td><input type="submit" name="submit" value="查找" /></td>
	</tr>
</table>
</form>
<br>
</body>
</html>
