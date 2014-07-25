<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String scientificName=request.getParameter("scientificName");
String retstart=request.getParameter("retstart");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Name search GBIF</title>

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
var scientificName="<%=scientificName%>";
var retstart="<%=retstart%>";
$(function(){
	$.getJSON("nameGetNCBIData",
			{
				scientificName:scientificName,
				retstart:retstart
			},function(data)
			{
				$("#rs_data").append("搜索结果为：<font color='red'>"+data.count+" </font>条<br><br>");
				var rs = "<table align='center' width='1000px;' style='border-collapse:collapse;'>";
				rs += "<tr style='border:1px solid #eee;' bgcolor='silver'>";
				rs += "<td width='150px;'>Name/Gene ID</td>";
				rs += "<td width='350px;'>Description</td>";
				rs += "<td width='350px;'>Location</td>";
				rs += "<td width='150px;'>Aliases</td></tr>";
				$.each(data.result,function(i,obj){
					if(i != "uids"){
						rs += "<tr><td><a href='http://www.ncbi.nlm.nih.gov/gene/"+obj.uid+"'>"+obj.name+"</a><br>ID："+obj.uid+"</td>";
						rs += "<td>"+obj.description+"["+obj.organism.scientificname+"("+obj.organism.commonname+")]</td>";
						rs += "<td>Chromosome "+obj.chromosome+","+(obj.genomicinfo[0]==null?'':obj.genomicinfo[0].chraccver)+"("+(obj.genomicinfo[0]==null?'':obj.genomicinfo[0].chrstart)+".."+(obj.genomicinfo[0]==null?'':obj.genomicinfo[0].chrstop)+")</td>";
						rs += "<td>"+obj.otheraliases+"</td></tr>";
						rs += "<tr height='15px;'></tr>";
					}
					//$(data.result.uids).each(function(){
					//});
				});
				rs += "<tr><td colspan='4' align='center'>";
				
				if(retstart == 0){
					rs += "<font color='red'>第"+(data.start/20+1)+"页</font>&nbsp;";
					if(Math.ceil(data.count/20) != 1){
						
						rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&retstart="+(data.start+20)+"'>下一页</a>&nbsp;";
						rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&retstart="+((Math.ceil(data.count/20)-1)*20)+"'>末页</a>&nbsp;";
					}

				}else if(retstart == ((Math.ceil(data.count/20)-1)*20)){
					rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&retstart=0'>首页</a>&nbsp;";
					rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&retstart="+(data.start-20)+"'>上一页</a>&nbsp;";
					rs += "<font color='red'>第"+(data.start/20+1)+"页</font>&nbsp;";
				}else{
					rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&retstart=0'>首页</a>&nbsp;";
					rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&retstart="+(data.start-20)+"'>上一页</a>&nbsp;";
					rs += "<font color='red'>第"+(data.start/20+1)+"页</font>&nbsp;";
					rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&retstart="+(data.start+20)+"'>下一页</a>&nbsp;";
					rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&retstart="+((Math.ceil(data.count/20)-1)*20)+"'>末页</a>&nbsp;";

				}
				rs += "共<font color='red'>"+Math.ceil(data.count/20)+"</font>页";
				rs += "</td><tr></table>";
				$("#rs_data").append(rs);
			});
});
</script>
</head>
<body>
<div id="rs_data"></div>
<br>
<table><tr><td colspan="1"  align="left"></td></tr></table>
</body>
</html>