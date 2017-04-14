<%@page import="java.text.DateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<link href="./css/css.css" rel="stylesheet" rev="stylesheet" type="text/css" />
	<title>拍拍网-我的商品</title>
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
			<pre>               <a href="index.jsp">首页</a>      <a href="cart.jsp">购物车</a>     <a href="purchased.jsp">已购买</a>      <b><a href="sale.jsp"><font color=#0080FF>我的商品</font></a></b>     <a href="userinf.jsp">我的资料</a>     <a href="logout.jsp">退出登录</a>  </pre>
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

<form action="newsale2.jsp" method="post">
<div id="main">
<%
	
	String ID = request.getParameter("ID");
	
	String name= request.getParameter("name");
	if(name!=null)name = new String(name.getBytes("iso-8859-1"), "utf-8"); 
	String mount= request.getParameter("mount");
	String type= request.getParameter("type");
	if(type!=null)type = new String(type.getBytes("iso-8859-1"), "utf-8"); 
	String des= request.getParameter("description");
	if(des!=null)des = new String(des.getBytes("iso-8859-1"), "utf-8"); 
	String money= request.getParameter("money");
	
	
	//插入新商品
	if(name!=null){
		
		String sql = "insert into 12181_sale values('"+ID+"','"+name+"','"+"salepic/"+ID+".jpg"+"','"+des+"',"+money+","+mount+",'"+type+"');";
		int rs = conn.executeUpdate(sql);
		
		out.print("<script>location.href='sale.jsp';</script>");
	}
	
	else{
	
	
	%> 
			<div id="show1">
			<a><img border="1" src="salepic/<%out.print(ID+".jpg");%>" ></a>
			</div>
		 <div id="char" style="color:gray;">
				<p align="left" >名称：<input  style="width:200px;height:20px;font-size:15px" type="text" name="name" ></p>
			</div> 
		 <div id="char" style="color:gray;">
				<p align="left" >库存：<input  style="width:200px;height:20px;font-size:15px" type="text" name="mount"  ></p>
			</div> 
		 <div id="char" style="color:gray;">
			<p align="left" >单价：<input  style="width:180px;height:20px;font-size:15px" type="text" name="money" > &nbsp;元</p>
			</div> 
		 
				<div id="char" style="color:gray;">
				<p align="left" >分类：
				<select size="1" name="type">
				<option value="衣服" selected="selected">衣服</option>
				<option value="食品" >食品</option>
				<option value="图书">图书</option>
				<option value="手机及配件">手机及配件</option>
				<option value="电脑及配件">电脑及配件</option>
				<option value="家用电器">家用电器</option>
				<option value="其它">其它</option>
				</select>
				</p>
				 
		
				<p align="left" >描述：</p>
				</p><textarea rows="15" name="description"style="width: 200px; height:80px; z-index:0;border-style:1px;margin-top:-40px;margin-left:80px;"></textarea></p>
				</p>
				
				<p align="left" ><input  style="width:180px;height:20px;font-size:15px" type="hidden" name="ID" value="<%out.print(ID);%>"> &nbsp;</p>
				
				 <div  style="color:gray;margin:5px 10px 20px 90px;"><input type="image" border=0 src="pic/save.png"  onClick="this.form.submit()">
				</div>
				
				
				
		
				
	<%} %>
				 
</form>
</div>
</body>
</html>
