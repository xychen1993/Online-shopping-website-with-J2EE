<%@page import="java.text.DateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<link href="./css/css.css" rel="stylesheet" rev="stylesheet" type="text/css" />
	<title>拍拍网-购物车</title>
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
			<pre>               <a href="index.jsp">首页</a>      <b><a href="cart.jsp"><font color=#0080FF>购物车</font></a></b>     <a href="purchased.jsp">已购买</a>      <a href="sale.jsp">我的商品</a>     <a href="userinf.jsp">我的资料</a>     <a href="logout.jsp">退出登录</a>  </pre>
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

<form action="cartupdate.jsp" method="post">
<div id="main">
<%
	String[] select = (String[])request.getParameterValues("select[]");
	int numup=0;
	if(select!=null) numup = select.length;
	
	String number = request.getParameter("number");
	String people = request.getParameter("people");
	if(people!=null)people = new String(people.getBytes("iso-8859-1"), "utf-8"); 
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	if(address!=null)address = new String(address.getBytes("iso-8859-1"), "utf-8"); 
	String ID = request.getParameter("ID");
	
	if(numup>1){
	  %>            <script> alert("一次仅允许选择一项进行修改！")</script>
			
					<script language="javascript" type="text/javascript">
					window.location.href="cart.jsp"
					</script>
	<%
	}
	if(select==null&&number==null){
	
	 %>            <script> alert("您尚未选中项目！")</script>
			
					<script language="javascript" type="text/javascript">
					window.location.href="cart.jsp"
					</script>
		<%
	}
	
	//更新预定内容
	if(number!=null){
		
		String sql = "update 12181_cart set 收货人='"+people+"',数量='"+number+"',电话='"+phone+"',地址='"+address+"' where 交易ID='"+ID+"';";
		int rs = conn.executeUpdate(sql);
		out.print("<script>location.href='cart.jsp';</script>");
	}
	
	else{
	String sql = "select * from 12181_cart where 交易ID ='"+select[0]+"';";
	ResultSet rs = conn.executeQuery(sql);
	rs.next();
	
	%> 
		<div id="show1">
			<a><img border="1" src="<%out.print(rs.getString("图片路径"));%>" ></a>
			</div> 
		 <h3><p align="center">"<%out.print(rs.getString("名称"));%>"</p></h3> 
		 <div id="char" style="font-size:16px">
				<p align="left" >数量：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  style="width:100px;height:20px;font-size:15px" type="text" name="number"  value="<%out.print(rs.getString("数量"));%>"></p>
			</div> 
		 <div id="char" style="">
				<p align="left" >收货人：&nbsp;&nbsp;&nbsp;<input  style="width:100px;height:20px;font-size:15px" type="text" name="people"  value="<%out.print(rs.getString("收货人"));%>"></p>
			</div> 
		 <div id="char">
			<p align="left" >联系方式：<input  style="width:150px;height:20px;font-size:15px" type="text" name="phone"  value="<%out.print(rs.getString("电话"));%>" maxlength="11"></p>
			</div> 
		 <div id="char">
				<p align="left" >收货地址：<input  style="width:300px;height:20px;font-size:15px" type="text" name="address"  value="<%out.print(rs.getString("地址"));%>" maxlength="11"></p>
				</p>
				</div> 
		 <p align="left" ><input  style="width:100px;height:20px;font-size:15px" type="hidden" name="ID"  value="<%out.print(select[0]);%>"></p> 
		 
				<p align="center"><input type="image" border=0 src="pic/save.png"  onClick="this.form.submit()">
				</p>
				
	<%} %>
				 
</form>
</div>
</body>
</html>
