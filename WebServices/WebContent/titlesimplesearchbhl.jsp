<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="org.big.po.*" %>  
<%@ page import="org.big.util.*" %> 
<%@ page import="java.util.*" %> 
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
<title>title search BHL</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>

</script>
</head>
<body>
	<div align="left">
<%	
	if(request.getSession().getAttribute("tList") == null || request.getAttribute("page") == null){
%>
		<h4>在BHL中搜索到的文献总共有 <font color="red">0</font> 条</h4>
<%
	}else{
	List<Title> list = (List<Title>)request.getSession().getAttribute("tList"); 
	if(list.size() == 0){
%>	
		<h4>在BHL中搜索到的文献总共有 <font color="red">0</font> 条</h4>
<%
	}
%>
		<h4>在BHL中搜索到的文献总共有 <font color="red">${page.rowCount }</font> 条</h4>
<%
	PageUtil p = (PageUtil)request.getAttribute("page");
	for(int i = 0, number = p.getSize()*(p.getNum()-1)+1; i < list.size(); i++, number++){
%>
		<ul style="margin:10px 0px 0px 0px; padding:0;">
			<li style="list-style-type: none;"><%=number %>:&nbsp;<%=list.get(i).getPublicationDate()==null?"":"<b>PublishData:</b>"+list.get(i).getPublicationDate()+" | " %> 
				<b>Title:</b><%=list.get(i).getFullTitle()== null?list.get(i).getShortTitle(): list.get(i).getSortTitle()%> | 
				<%=list.get(i).getPublisherPlace()==null?"":"<b>PublisherPlace:</b>"+list.get(i).getPublisherPlace()+" | " %> 
				<%=list.get(i).getPublisherName()==null?"":"<b>PublisherName:</b>"+list.get(i).getPublisherName() %> 
			</li>
			<br>
		</ul>
	</div>
<%	
		
	}
	}
%>



<div align="center" style="width: 1200px;">
	<jsp:include page="pagination.jsp">
	<jsp:param value="resultData?flag=1" name="url" />
</jsp:include></div>
</body>
</html>