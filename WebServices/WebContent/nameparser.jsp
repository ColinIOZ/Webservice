<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Taxon Name Parser</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
$(function(){
	$("#parsebtn").click(function(){
		$("#parse_output").empty();
		var sciname=$("#sciname").val();
		$("#json a").attr("href","taxonNameParser?name="+sciname);
		if(sciname=="")
		{
			$("#parse_output").append("<span style='color:red'>请输入要解析的拉丁名</span>");
			return;
		}
		$.getJSON("taxonNameParser",{name:sciname},function(data){
			if(data==null||data.ParsableType!=true)
			{
				$("#parse_output").append("<span style='color:red'>请输入的拉丁名无法解析</span>");
				return;
			}
			var str="<table>";
			$.each(data,function(k,v){
				str+="<tr><td>"+k+":</td><td>"+v+"</td></tr>";
			});
			str+="</table>";
			$("#parse_output").append("<h4>解析结果：</h4>");
			$("#parse_output").append(str);
		});
	});
});
</script>
</head>
<body style="margin:0 auto; width:600px">
<div style="width:700px">
<div><h3>生物拉丁名解析服务</h3></div>
<table><tr><td>
<div id="parse_input">
<input type="text" name="sciname" id="sciname" style="width:300px" value="Aix galericulata Linnaeus,1758"/><input type="button" id="parsebtn" value="解析">
</div>
</td>
<tr><td>
<div id=parse_output>

</div>
</td></tr><tr><td>
<h4>Web API简介</h4>
<p>
Web API地址: http://www.zoology.csdb.cn/WebServices/taxonNameParser<br/>
参 数：name, 要进行解析的拉丁名<br/>
调用方法：post, request<br/>
结 果：JSON<br/>
示例：<br/><a target="_blank" href="/WebServices/taxonNameParser?name=Aix galericulata Linnaeus,1758">http://www.zoology.csdb.cn/WebServices/taxonNameParser?name=Aix galericulata Linnaeus,1758</a>
</p>
</td></tr></table>
</div>
</body>
</html>