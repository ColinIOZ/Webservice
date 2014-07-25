<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String scientificName=request.getParameter("scientificName");
String offset=request.getParameter("offset");
String country=request.getParameter("country");
String hasCoordinate=request.getParameter("hasCoordinate");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Name search GBIF</title>

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
var name="<%=scientificName%>";
var offset="<%=offset%>";
var country="<%=country%>";
var hasCoordinate="<%=hasCoordinate%>";
$(function(){
	$.getJSON("nameGetGBIFData",
			{
				scientificName:name,
				offset:offset,
				country:country,
				hasCoordinate:hasCoordinate
			},function(data)
			{
			if(data.results == null)
			{
				var content="<h4>在GBIF中搜索结果为 0 条</h4>";
				$("#rs_data").append(content);
				return;
			}else{
				
				$("#rs_data").empty();
				var content="<h4>在GBIF中搜索结果为"+data.count+"条</h4>";
				$("#rs_data").append(content);	
				var rs = "<table align='center' width='1000px;' style='border-collapse:collapse;'>";
				rs += "<tr style='border:1px solid #eee;' bgcolor='#98D470'>";
				rs += "<td align='center' style='border:1px solid #eee;' width='380px;'></td>";
				rs += "<td align='center' style='border:1px solid #eee;' width='124px;'>位置</td>";
				rs += "<td align='center' style='border:1px solid #eee;' width='124px;'>经度</td>";
				rs += "<td align='center' style='border:1px solid #eee;' width='124px;'>纬度</td>";
				rs += "<td align='center' style='border:1px solid #eee;' width='124px;'>记录类型</td>";
				rs += "<td align='center' style='border:1px solid #eee;' width='124px;'>日期</td></tr>";
				$.each(data.results,function(i,obj){
					
					rs += "<tr style='border:1px solid #eee;'><td align='center' style='border:1px solid #eee;'>";
					rs += "<font color='silver'>"+obj.gbifID+"、"+obj.catalogNumber+"</font><br>";
					rs += "<b><a href='http://www.gbif.org/occurrence/"+obj.gbifID+"' style='text-decoration:none;'>"+obj.scientificName+"</a></b><br>";
					rs += "</td><td align='center' style='border:1px solid #eee;' height='100px;'>";
					rs += "<b>"+(obj.country==null?'N/A':obj.country)+"</b><br><font color='silver'>";
					rs += (obj.elevation==null?'':"Elevation:"+obj.elevation+"m")+(obj.depth==null?'':"<br>Depth:"+obj.depth+"m")+"</font>";
					rs += "</td><td align='center' style='border:1px solid #eee;'>";
					rs += "<b>"+(obj.decimalLongitude==null?'N/A':obj.decimalLongitude)+"</b>";
					rs += "</td><td align='center' style='border:1px solid #eee;'>";
					rs += "<b>"+(obj.decimalLatitude==null?'N/A':obj.decimalLatitude)+"</b>";
					rs += "</td><td align='center' style='border:1px solid #eee;'>";
					rs += "<b>"+(obj.basisOfRecord==null?'N/A':obj.basisOfRecord.toLowerCase().replace('_',' '))+"</b>";
					rs += "</td><td align='center' style='border:1px solid #eee;'>";
					rs += "<b>"+(obj.month==null?'N':obj.month)+"/"+(obj.year==null?'A':obj.year)+"</b>";
					rs += "</td></tr>";
					
					
				});	
				rs += "</table><br>";
				rs += "<div align='center'>";
				var first = 1;
				var numCount = 6;
				var num = offset/data.limit+1;
				var last = Math.ceil(data.count/data.limit);
				var start = Math.max(first,num-numCount/2);
				var end = Math.min(last,start+numCount);
				rs += "<a href='namesearchgbif.jsp?scientificName="+name+"&offset=0&country="+country+"&hasCoordinate="+hasCoordinate+"' style='text-decoration:none;'>首页</a>&nbsp;";
				for(var i = start+1 ; i < end; i++){
					if(num == i)
						rs += "<font color='red'>["+i+"]</font>&nbsp;";
					else
						rs += "<a href='namesearchgbif.jsp?scientificName="+name+"&offset="+(i-1)*data.limit+"&country="+country+"&hasCoordinate="+hasCoordinate+"' style='text-decoration:none;'>["+i+"]</a>&nbsp;";
				}
				if(end != last){
					rs += "...";
				}
				rs += "<a href='namesearchgbif.jsp?scientificName="+name+"&offset="+((Math.ceil(data.count/data.limit)-1)*data.limit)+"&country="+country+"&hasCoordinate="+hasCoordinate+"' style='text-decoration:none;'>末页</a>&nbsp;";
				rs += "共<font color='red'>"+Math.ceil(data.count/data.limit)+"</font>页";
				rs += "</div>";
				$("#rs_data").append(rs);
				
			}
				
			});
});
</script>
</head>
<body>
<div id="rs_data"></div>
<br>

</body>
</html>