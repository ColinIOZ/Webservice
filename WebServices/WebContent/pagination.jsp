<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'pagination.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css"> 
	-->
	<script type="text/javascript">
		/*
		 * 凡是在javascript中遇到的路径跳转问题  解决方案：在路径前先加/代表服务器的端口号路径  再加项目名
		 */
		function testForward(url,path){
			var num = document.getElementById("num").value;
			url = path + "/" + url + "num=" + num;
			window.location.href = url;
		}
	</script>

  </head>
  
  <body>
  	<%
  		//凡是使用该页面做分页的页面 必须传递过来一个参数名为url的地址
  		String url = request.getParameter("url"); 
  		url = url + (url.indexOf("?")>0?"&":"?");
  	 %>
    <!-- 使用此页面的前提是和PageUtil类一起使用  并且将PageUtil类放到作用域的属性名应该为page -->
  	<c:if test="${page.pageCount!=0 }">
		<c:if test="${page.num!=page.first }">
			<a href="<%=url %>num=${page.first }">【首页】</a>
			<a href="<%=url %>num=${page.prev }">【上一页】</a>
		</c:if>
		
		<c:forEach begin="${page.start }" end="${page.end }" var="i">
			<c:choose>
				<c:when test="${page.num==i }">
					<b style="color: red">【${i }】</b>
				</c:when>
				<c:otherwise>
					<a href="<%=url %>num=${i }">【${i }】</a>
				</c:otherwise>
			</c:choose>
		</c:forEach> 
		
		<c:if test="${page.num!=page.last }">
			<a href="<%=url %>num=${page.next }">【下一页】</a>
			<a href="<%=url %>num=${page.last }">【末页】</a>
		</c:if>
		
		跳转到<input type="text" id="num" style="width: 45px;height: 20px"/>页
		<input type="button" value="GO" onclick="testForward('<%=url %>','<%=path %>')" style="background-color: 696969">
		<br>		
		共查询出<b style="color: red">${page.rowCount }</b>条数据
		当前是<b style="color: red">${page.num }</b>/<b style="color: red">${page.pageCount }</b>页
  	</c:if>
  </body>
</html>
