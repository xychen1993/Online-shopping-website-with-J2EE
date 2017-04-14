<%@page import="java.text.DateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<html>
<head>
<link href="css/css.css" rel="stylesheet" rev="stylesheet" type="text/css" />
<title>拍拍网-商品详细信息</title>
<a name="head"></a>

</head>
<body>
	<div id="top">
	<a href="index.jsp"><img border="0"src="pic/mainlogo.png"></a>
	</div>

 <form action="search.jsp" method="get">
   <% 
	 //inf内已经有了用户信息，直接显示登陆后首页
	 if(inf.getPhone()!=null)
	 {
	 %>
		<div id="bread">
			<pre>               <a href="index.jsp">首页</a>      <a href="cart.jsp">购物车</a>     <a href="purchased.jsp">已购买</a>      <a href="sale.jsp">我的商品</a>    <b><a href="userinf.jsp"><font color=#0080FF>我的资料</font></a></b>     <a href="logout.jsp">退出登录</a>  </pre>
		  </div>
		 <div id="search">
		 <input  name="search" placeholder="查询商品" value="" spellcheck="false" class="">
		 </div>
		 <div id="searchbutton">
		  <input type="image" border=0 src="pic/search.png"  onClick="this.form.submit()">
		 </div>
		  <div id="welcome">
		   <font color="gray">欢迎您，<%out.print(inf.getUsername()); %></font> 
		 </div>
	<% 
	}
	
	//r若是游客请先登录
	else 
	{
	%>
					<script> alert("请先登录！")</script>
			
					<script language="javascript" type="text/javascript">
					window.location.href="login.jsp"
					</script>
					
		<%
	 
	}
		   
		  %>
   </form>

 <div id="navigation">
   <a href="search.jsp?search=衣服"><img border="0"src="pic/clothes.png"></a><br>
	<a href="search.jsp?search=食品"><img border="0"src="pic/food.png"></a><br> 
	<a href="search.jsp?search=图书"><img border="0"src="pic/book.png"></a><br>
	<a href="search.jsp?search=手机及配件"><img border="0"src="pic/cell.png"></a><br>
	<a href="search.jsp?search=电脑及配件"><img border="0"src="pic/computer.png"></a><br>
	<a href="search.jsp?search=家用电器"><img border="0"src="pic/electric.png"></a><br>
	<a href="search.jsp?search=其它"><img border="0"src="pic/others.png"></a><br>
	<br><a><font size=2px;>作者：陈欣怡</font></a><br>
	 <a><font size=2px;>学号：1120112181</font></a><br>
	 <a><font size=2px;>班级：08111103</font></a><br>
	 <a><font size=2px;>电话：18810579183</font></a><br>
 </div>


<form action='userupdate.jsp' method='post'>
<div id="main">
 	<h3><p align="center">我的资料</p></h3> 
	<div id="char" >
			<p align="left" >用户名：<%out.print(inf.getUsername());%></p>
		</div> 
	<div id="char" >
			<p align="left" >电话：<%out.print(inf.getPhone());%></p>
		</div> 
	<div id="char">
			<p align="left">邮箱：<%out.print(inf.getEmail());%></p>
		</div> 
	<div id="char">
			<p align="left">默认收货地址：<%out.print(inf.getAddress());%></p>
					</div> 
	
			<p align="center">
			<a href="changepsw.jsp"><img src="pic/changepsw.png" /></a>
			<input type="image" border=0 src="pic/update.png"  onClick="this.form.submit()">
			</p>
			 
</div>
</form>
</body>
</html>
