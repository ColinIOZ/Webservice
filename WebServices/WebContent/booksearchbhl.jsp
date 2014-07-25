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
<title>book search BHL</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>

</script>
</head>
<body>

	<div align="left">
<%	
	if(request.getSession().getAttribute("bList") == null || request.getAttribute("page") == null){
%>
		<h4>在BHL中搜索到的文献总共有 <font color="red">0</font> 条</h4>
<%
	}else{
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getSession().getAttribute("bList"); 
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
		
		JSONArray ja2 = JSONArray.fromObject(list.get(i).get("Items")) ;
		List<Item> items = new ArrayList<Item>();
		items = gson.fromJson(ja2.toString(), new TypeToken<List<Item>>() {
		}.getType());
%>
		
		<ul style="margin:10px 0px 0px 0px; padding:0;">
			<li style="list-style-type: none;"><%=number %>:&nbsp;<%=list.get(i).get("PublicationDate")==null?"":"<b>PublishData:</b>"+list.get(i).get("PublicationDate")+" | "%> 
				<b>Title:</b><%=list.get(i).get("FullTitle")%> | 
				<%=list.get(i).get("PublisherPlace")==null?"":"<b>PublisherPlace:</b>"+list.get(i).get("PublisherPlace")+" | " %>  
				<%=list.get(i).get("PublisherName")==null?"":"<b>PublisherName:</b>"+list.get(i).get("PublisherName") %> 
			</li>
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
			<li style="list-style-type: none;">
				<b>Volume:</b>
<%
	if(items.size() != 0){
	for(int k = 0; k < items.size(); k++ ){
%>
				<%=items.get(k).getVolume()==null?"":items.get(k).getVolume() %>
<%  }
%>
			</li>
		</ul>
	</div>
<%	
	}
	}
	}
	}
%>



<div align="center" style="width: 1200px;">
	<jsp:include page="pagination.jsp">
	<jsp:param value="resultData?flag=2" name="url" />
</jsp:include></div>
</body>
</html>