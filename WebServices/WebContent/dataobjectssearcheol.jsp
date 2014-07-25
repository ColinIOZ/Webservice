<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String id=request.getParameter("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Name search BHL</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
var id="<%=id%>";
$(function(){
	$.getJSON("dataObjectsGetEOLData",{id:id},function(data)
			{
			if(data==null)
			{
				var content="<h4>在eol中关于"+id+"的结果为null</h4>";
				$("#bhl_data").append(content);
				return;
			}
					$("#bhl_data").empty();
					var content="<h4>在eol中关于"+id+"的结果如下：";
					$("#bhl_data").append(content);
					$("#bhl_data").append("<ul>");
					
					if(data.identifier!=null)
					{
						$("#bhl_data").append("<b>identifier</b>: "+data.identifier+"<br>");
					}
					if(data.scientificName!=null&&data.scientificName.trim()!="")
					{
						$("#bhl_data").append("<b>scientificName</b>: "+data.scientificName+"<br>");
					}
					if(data.taxonConcepts!=null)
					{
						var rs = "<table width='600px;'><tr><td><b>taxonConcepts</b>: </td><td><b>identifier</b></td><td><b>scientificName</b></td></tr>";
						$.each(data.taxonConcepts,function(i,obj){
							rs+="<tr><td></td><td>"+obj.identifier+"</td><td>"+obj.scientificName+"</td></tr>";
							
						});
						rs+="</table>";
						$("#bhl_data").append(rs);
					}
					
					$.each(data.dataObjects,function(i,obj){
						var rs = "<b>dataObjects:</b>"+(i+1)+"<br>";
						if(obj.identifier!=null&&obj.identifier.trim()!="")
						{
							rs+="<b>identifier</b>: "+obj.identifier+"<br>";
						}
						if(obj.dataObjectVersionID!=null)
						{
							rs+="<b>dataObjectVersionID</b>:"+obj.dataObjectVersionID+"<br>";
						}
						if(obj.dataType!=null&&obj.dataType.trim()!="")
						{
							rs+="<b>dataType</b>:"+"<a href='"+obj.dataType+"'>"+obj.dataType+"</a>"+"<br>";
						}
						if(obj.dataSubtype!=null&&obj.dataSubtype.trim()!="")
						{
							rs+="<b>dataSubtype</b>:"+obj.dataSubtype+"<br>";
						}
						if(obj.vettedStatus!=null&&obj.vettedStatus.trim()!="")
						{
							rs+="<b>vettedStatus</b>:"+obj.vettedStatus+"<br>";
						}
						if(obj.dataRating!=null)
						{
							rs+="<b>dataRating</b>:"+obj.dataRating+"<br>";
						}
						if(obj.mimeType!=null&&obj.mimeType.trim()!="")
						{
							rs+="<b>mimeType</b>:"+obj.mimeType+"<br>";
						}
						if(obj.created!=null&&obj.created.trim()!="")
						{
							rs+="<b>created</b>:"+obj.created+"<br>";
						}
						if(obj.title!=null&&obj.title.trim()!="")
						{
							rs+="<b>title</b>:"+obj.title+"<br>";
						}
						if(obj.rightsHolder!=null&&obj.rightsHolder.trim()!="")
						{
							rs+="<b>rightsHolder</b>:"+obj.rightsHolder+"<br>";
						}
						if(obj.description!=null&&obj.description.trim()!="")
						{
							rs+="<b>description</b>:"+obj.description+"<br>";
						}
						if(obj.mediaURL!=null&&obj.mediaURL.trim()!="")
						{
							rs+="<b>mediaURL</b>:"+"<a href='"+obj.mediaURL+"'>"+obj.mediaURL+"</a>"+"<br>";
						}
						if(obj.eolMediaURL!=null&&obj.eolMediaURL.trim()!="")
						{
							rs+="<b>eolMediaURL</b>:"+"<a href='"+obj.eolMediaURL+"'>"+obj.eolMediaURL+"</a>"+"<br>";
						}
						if(obj.eolThumbnailURL!=null&&obj.eolThumbnailURL.trim()!="")
						{
							rs+="<b>eolThumbnailURL</b>:"+"<img width='80px' height='100px' src='"+obj.eolThumbnailURL+"'/>";
						}
						rs += "<br>";
						var li="<li>"+rs+"</li>";
						$("#bhl_data").append(li);
					});
					$("#bhl_data").append("</ul>");
				
			});
});
</script>
</head>
<body>
<div id="bhl_data"></div>
</body>
</html>