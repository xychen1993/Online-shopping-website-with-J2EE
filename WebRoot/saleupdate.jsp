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

<form action='saleupdate.jsp' method='post'>
<div id="main">
<%
	String[] select = (String[])request.getParameterValues("select[]");
	int numup=0;
	if(select!=null) numup = select.length;
	
	String money = request.getParameter("money");
	String name = request.getParameter("name");
	if(name!=null)name = new String(name.getBytes("iso-8859-1"), "utf-8"); 
	String mount = request.getParameter("mount");
	String type = request.getParameter("type");
	if(type!=null)type = new String(type.getBytes("iso-8859-1"), "utf-8"); 
	String des = request.getParameter("description");
	if(des!=null)des = new String(des.getBytes("iso-8859-1"), "utf-8");
	String ID = request.getParameter("ID");
	
	if(numup>1){
	  %>            <script> alert("一次仅允许选择一项进行修改！")</script>
			
					<script language="javascript" type="text/javascript">
					window.location.href="sale.jsp"
					</script>
	<%
	}
	else if(numup==0&&name==null){
	 %>            <script> alert("您尚未选中项目！")</script>
			
					<script language="javascript" type="text/javascript">
					window.location.href="sale.jsp"
					</script>
		<%
	}
	
	if(name!=null){
		String sql = "update 12181_sale set 名称='"+name+"',描述='"+des+"',价格="+money+",余量="+mount+",分类='"+type+"' where ID='"+ID+"';";
		int rs = conn.executeUpdate(sql);
		//对购物车的商品信息也进行修改
		sql = "update 12181_cart set 名称='"+name+"',价格="+money+" where 商品ID='"+ID+"' and 购买=0;";
	    rs = conn.executeUpdate(sql);
		out.print("<script>location.href='sale.jsp';</script>");
	}
	else{
		String sql = "select * from 12181_sale where ID ='"+select[0]+"';";
		ResultSet rs = conn.executeQuery(sql);
		rs.next();
		
		String[] type1=new String[7];
		 type1[0]="衣服";
		 type1[1]="食品";
		 type1[2]="图书";
		 type1[3]="手机及配件";
		 type1[4]="电脑及配件";
		 type1[5]="家用电器";
		 type1[6]="其它";
		 
		 %>
		 
		  <div id="show1">
			<a><img border="1" src="<%out.print(rs.getString("图片路径")); %>" ></a>
			</div> 
		 <div id="char" style="font-size:16px">
				<p align="left" >名称：<input  style="width:200px;height:20px;font-size:15px" type="text" name="name"  value="<%out.print(rs.getString("名称")); %>"></p>
			</div> 
		 <div id="char" style="">
				<p align="left" >单价：<input  style="width:100px;height:20px;font-size:15px" type="text" name="money"  value="<%out.print(rs.getInt("价格")); %>">元</p>
			</div> 
		 <div id="char">
			<p align="left" >库存：<input  style="width:150px;height:20px;font-size:15px" type="text" name="mount"  value="<%out.print(rs.getString("余量")); %>" maxlength="11"></p>
			</div> 
		<div id="char">
				<p align="left" >分类：
				<select size="1" name="type"> 
		<% 
			for(int i=0;i<7;i++)
			{
				if(type1[i].equalsIgnoreCase(rs.getString("分类"))){%> 
				<option value="<%out.print(type1[i]);%>" selected="selected" ><%out.print(type1[i]);%></option> 
				<%}
				else{ %>
				<option value="<%out.print(type1[i]);%>" ><%out.print(type1[i]);%></option> 
			<%
			}}
		%>	
		 </select>
				</p>
				</div> 
				
		 <div id="char">
				<p align="left" >描述：</p>
				</p><textarea rows="15" name="description"style="width: 200px; height:80px; z-index:0;border-style:1px;margin-top:-40px;margin-left:80px;"><%out.print(rs.getString("描述")); %></textarea></p>
				</p>
				</div> 
		 <p align="left" ><input  style="width:100px;height:20px;font-size:15px" type="hidden" name="ID"  value="<%out.print(select[0]); %>"></p> 
		 
				<p align="center"><input type="image" border=0 src="pic/save.png"  onClick="this.form.submit()">
				</p>
				 
		<% 
	}
 %>
</form>
</div>
</body>
</html>
