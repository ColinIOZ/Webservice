<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String scientificName=request.getParameter("name");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Name search BHL</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
var name="<%=scientificName%>";
$(function(){
	$.getJSON("nameGetBHLData",{scientificName:name},function(data)
			{
			if(data==null)
			{
				var content="<h4>在BHL中关于"+name+"的文献总共有 "+0+" 条</h4>";
				$("#bhl_data").append(content);
				return;
			}
				if(data.Status=="ok")
				{
					$("#bhl_data").empty();
					if(data.Result==null)
					{
						var content="<h4>在BHL中关于"+name+"的文献总共有 "+0+" 条</h4>";
						$("#bhl_data").append(content);
						return;
					}
					var count=data.Result.Titles.length;
					var content="<h4>在BHL中关于"+name+"的文献总共有 "+count+" 条</h4>";
					$("#bhl_data").append(content);
					$("#bhl_data").append("<ul>");
					$.each(data.Result.Titles,function(i,obj){
						if(i>=5)
						{
							var more="<br/><li><a href='http://www.biodiversitylibrary.org/name/"+name.replace(" ","_")+"'>查看更多文献</a></li>";
							$("#bhl_data").append(more);
							return false;
						}
						var date=obj.PublicationDate==null?"":obj.PublicationDate;
						var authors=obj.Authors==null?"":obj.Authors;
						
						var title=obj.FullTitle==null?obj.ShortTitle:obj.FullTitle;
						var fulltitle="";
						if(authors!=null&&authors.trim()!="")
						{
							fulltitle+="<b>Authors</b>: "+authors+"| ";
						}
						if(date!=null&&date.trim()!="")
						{
							fulltitle+="<b>PubishDate</b>:"+date+"| ";
						}
						if(title!=null&&title.trim()!="")
						{
							fulltitle+="<b>Title</b>:"+title+"| ";
						}
						if(obj.PublisherPlace!=null&&obj.PublisherPlace.trim()!="")
						{
							fulltitle+="<b>PublisherPlace</b>:"+obj.PublisherPlace+"| ";
						}
						if(obj.PublisherName!=null&&obj.PublisherName.trim()!="")
						{
							fulltitle+="<b>PublisherName</b>:"+obj.PublisherName;
						}
						var c=i+1;
						var li="<li>"+c+": "+fulltitle+"</li>";
						$("#bhl_data").append(li);
						//$("#bhl_data").append("<br/>");
						
						$.each(obj.Items,function(it,item){
							var volume=item.Volume;
							$("#bhl_data").append("<h5>Volume:"+volume+"</h5>");
							var table="<table style='text-align:center'><tr>";
							//table+="<td valign='center'>Volume<br/>"+volume+"</td>";
							$.each(item.Pages,function(p,page){
								//$("#bhl_data").append("<table>");
								//$("#bhl_data").append("<tr><td colspan='2'>");
								//if((p+1)%5==0)
								
								var pflag=page.PageNumbers[0].Prefix;
								var np=page.PageNumbers[0].Number;
								var simg=page.ThumbnailUrl;
								var limg=page.FullSizeImageUrl;
								var ocr=page.OcrUrl;
								var purl=page.PageUrl;
								table+="<td>";
								table+="<table>";
								table+="<tr><td colspan='2'>";
								var str="<a href='"+limg+"'>";
								str+="<img width='80px' height='100px' src='"+simg+"'/>";
								table+=str+"</a>";
								table+="</td></tr><tr><td>";
								table+="<span style='font-size:80%'><a href='"+purl+"'>"+pflag+np+"</a></span>";
								table+="</td><td>";
								table+="|<span style='font-size:80%'><a href='"+ocr+"'>OCR文本</a></span>";
								table+="</td></tr></table>";
								table+="</td>";
								//$("#bhl_data").append("</td></tr><tr><td>");
								//$("#bhl_data").append(pflag+np);
								//$("#bhl_data").append("</td><td>");
								//$("#bhl_data").append(ocr);
								
							});
							table+="</tr></table>";
							$("#bhl_data").append(table);
						});
						
					});
					//$("#bhl_data").append("</ul>");
				}
				
			});
});
</script>
</head>
<body>
<div id="bhl_data"></div>
</body>
</html>