<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="org.big.po.*" %>
<%@ page import="org.big.util.*" %>   
<%@ page import="java.util.*" %> 
<%@ page import="net.sf.json.JSONArray" %> 
<%@ page import="com.google.gson.Gson" %> 
<%@ page import="com.google.common.reflect.TypeToken" %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>part search BHL</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
</script>
</head>
<body>

	<div align="left">
<%	
	if(request.getSession().getAttribute("pList") == null || request.getAttribute("page") == null){
%>
		<h4>在BHL中搜索到的文献总共有 <font color="red">0</font> 条</h4>
<%	
	}else{
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getSession().getAttribute("pList"); 
	if(list.size() == 0){
%>	
		<h4>在BHL中搜索到的文献总共有 <font color="red">0</font> 条</h4>
<%
	}else{
%>
		<h4>在BHL中搜索到的文献总共有 <font color="red">${page.rowCount }</font> 条</h4>
<%
	PageUtil p = (PageUtil)request.getAttribute("page");
	for(int i = 0, number = p.getSize()*(p.getNum()-1)+1; i < list.size(); i++, number++){
		Gson gson = new Gson();
		JSONArray ja1 = JSONArray.fromObject(list.get(i).get("Authors")) ;
		List<Author> authors = new ArrayList<Author>();
		authors = gson.fromJson(ja1.toString(), new TypeToken<List<Author>>() {
		}.getType());
		
		JSONArray ja2 = JSONArray.fromObject(list.get(i).get("Pages")) ;
		List<Map<String, Object>> pages = new ArrayList<Map<String, Object>>();
		pages = gson.fromJson(ja2.toString(),
	            new TypeToken<List<Map<String, Object>>>() {
	            }.getType());
%>
		
		<ul style="margin:10px 0px 0px 0px; padding:0;">
			<li style="list-style-type: none;">
				<%=number %>:&nbsp;<%=list.get(i).get("Date")==null?"":"<b>PublishData:</b>"+list.get(i).get("Date")+" | "%> 
				<b>Title:</b><%=list.get(i).get("Title")%> | 
				<%=list.get(i).get("PublisherPlace")==null?"":"<b>PublisherPlace:</b>"+list.get(i).get("PublisherPlace")+" | " %>  
				<%=list.get(i).get("PublisherName")==null?"":"<b>PublisherName:</b>"+list.get(i).get("PublisherName") %> 
			</li>
			<br/>
			<li style="list-style-type: none;">
				<table width="600px;">
					<tr>
						<td><b>Authors:</b></td>
						<td><b>Name</b></td>
						<td><b>Role</b></td>
					</tr>
<%
	if(authors.size() != 0){
	for(int j = 0; j < authors.size(); j++ ){
%>
					<tr>
						<td></td>
						<td><%=authors.get(j).getName() %></td>
						<td><%=authors.get(j).getRole() %></td>
					</tr>
<%	
	}
	}
%>
							
				</table>
			</li>
			<br/>
			<li style="list-style-type: none;">
				<b>Volume:</b><%=list.get(i).get("Volume")==null?"":list.get(i).get("Volume")%>
			</li>
			<br/>
			<li style="list-style-type: none;">
				<table>
					<tr>
<% 
	if(pages.size() != 0){
	for(int k = 0; k < pages.size(); k++){
		JSONArray ja3 = JSONArray.fromObject(pages.get(k).get("PageTypes")) ;
		List<PageType> pageTypes = new ArrayList<PageType>();
		pageTypes = gson.fromJson(ja3.toString(), new TypeToken<List<PageType>>() {
		}.getType());
		JSONArray ja4 = JSONArray.fromObject(pages.get(k).get("PageNumbers")) ;
		List<PageNumber> pageNumbers = new ArrayList<PageNumber>();
		pageNumbers = gson.fromJson(ja4.toString(), new TypeToken<List<PageNumber>>() {
		}.getType());
%>
						<td>
							<table>
								<tr>
									<td align="center">
										<a href="<%=pages.get(k).get("FullSizeImageUrl") %>">
											<img src="<%=pages.get(k).get("ThumbnailUrl") %>" width='80px' height='100px'>
										</a>
									</td>
								</tr>
								<tr>
									<td align="center">
									<span style='font-size:13px;'>
										<a href='<%=pages.get(k).get("PageUrl") %>'>
										<%=pageNumbers.size()==0?"Page":pageNumbers.get(0).getPrefix().toString() %>
										<%=pageNumbers.size()==0?"0":pageNumbers.get(0).getNumber().toString() %>
										</a>
										|
										<a href='<%=pages.get(k).get("OcrUrl") %>'>OCR文本</a>
									</span>
									</td>
									
								</tr>
							</table>
						</td>
<%	
	}
	}
%>
					</tr>
				
				</table>
			</li>
		</ul>
	</div>
<%	
	}
	}
	}
%>



<div align="center" style="width: 1200px;">
	<jsp:include page="pagination.jsp">
	<jsp:param value="resultData?flag=3" name="url" />
</jsp:include></div>
</body>
</html>