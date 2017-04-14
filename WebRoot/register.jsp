<%@page import="java.text.DateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<jsp:useBean id="rem" scope="page" class="javabean.rem"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">

<html>
<head>
<link href="css/css.css"rel="stylesheet"rev="stylesheet"type="text/css"/>
<title>拍拍网-注册</title>
<a name="head"></a>

</head>
<body>
	<div id="top">
	<a href="index.jsp"><img border="0"src="pic/mainlogo.png"></a>
	</div>

 <form action="search.jsp"method="get">
  
				<div id="bread">
					<pre>               <a href="index.jsp">首页</a>        <a href="login.jsp">登录</a>       <B><a href="register.jsp"><font color=#0080FF>新用户注册</font></a></B>  </pre>
				  </div>
				 <div id="search">
				 <input  name="search" placeholder="查询商品" value="" spellcheck="false" class="">
				 </div>
				 <div id="searchbutton">
				  <input type="image" border=0 src="pic/search.png"  onClick="this.form.submit()">
				 </div>
				  <div id="welcome">
				   <font color="gray">欢迎您，游客</font> 
				 </div>

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
 
<form action='register.jsp' method='post'>
<div id="main">
<%
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	if(name!=null)name = new String(name.getBytes("iso-8859-1"), "utf-8"); 
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	if(address!=null)address = new String(address.getBytes("iso-8859-1"), "utf-8"); 
	String psw1 = request.getParameter("psw1");
	String psw2 = request.getParameter("psw2");
	
	if(psw1!=null&&psw2!=null&&!psw1.equals(psw2)){
	%>
		<script> alert("两次密码输入不一致！")</script>
		<script>location.href="changepsw.jsp";</script>
	<% 
	}
	if(phone!=null){
		
		rem.setAddress(address);
		rem.setEmail(email);
		rem.setPhone(phone);
		rem.setUsername(name);
	
		String sql = "select * from 12181_user where 电话="+phone+";";
		ResultSet rs = conn.executeQuery(sql);
		
		if(rs.next()){
		%>
		<script> alert("该电话号码已被注册！")</script>
		<script>location.href="register.jsp";</script>
		<% 
		}
		 sql = "insert into 12181_user values('"+phone+"','"+email+"','"+name+"',md5('"+psw1+"'),null,'"+address+"');";
		int x = conn.executeUpdate(sql);
		
		//自动登录
		inf.setAddress(address);
		inf.setEmail(email);
		inf.setPhone(phone);
		inf.setUsername(name);
		inf.setAbs(application.getRealPath("salepic"));
		
		%><script>location.href="index.jsp";</script><% 
	}
	
%>

 	<h3><p align="center">新用户注册</p></h3> 
	 <h4><p align="center"><font color="red">以下资料下均为必填</font></p></h4> 
		 <div id="char" >
			<p align="left" ><input  style="width:300px;height:30px;font-size:15px" type="text" name="phone"  placeholder="电话（一经填写不允许修改）" maxlength="11" value="<% if(rem.getPhone()!=null)out.print(rem.getPhone());%>"></p>
		</div> 
	 <div id="char" >
			<p align="left" ><input  style="width:300px;height:30px;font-size:15px" type="text" name="name"  placeholder="用户名" value="<% if(rem.getUsername()!=null)out.print(rem.getUsername());%>"></p>
		</div> 
	 <div id="char">
			<p align="left"><input  style="width:300px;height:30px;font-size:15px" type="text" name="email"  placeholder="邮箱" value="<% if(rem.getEmail()!=null)out.print(rem.getEmail());%>"></p>
		</div> 
	 <div id="char">
			<p align="left"><input  style="width:300px;height:30px;font-size:15px" type="text" name="address"  placeholder="默认收货地址" value="<% if(rem.getAddress()!=null)out.print(rem.getAddress());%>"></p>
		</div> 
	 <div id="char">
			<p align="left"><input  style="width:300px;height:30px;font-size:15px" type="password" name="psw1"  placeholder="密码" value=""></p>
		</div> 
	 <div id="char">
			<p align="left"><input  style="width:300px;height:30px;font-size:15px" type="password" name="psw2"  placeholder="再次输入密码">
		</div> 
	 
			<p align="center"><input type="image" border=0 src="pic/save.png"  onClick="this.form.submit()">
			</p>
			 

</div>
</form>
</body>
</html>
