<%@page import="java.text.DateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<link href="css/css.css" rel="stylesheet" rev="stylesheet" type="text/css" />
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


<div id="main">
<%
	 String[] select = (String[])request.getParameterValues("select[]");
	 
	 //删除我的商品中的记录
		if(select!=null){
	 	int numdel = select.length;
	 	for(int i=0;i<numdel;i++){
				 
				 		
				 String sql="delete from 12181_sale where ID ='"+select[i]+"';";
				 int rs = conn.executeUpdate(sql);
				 //同时删除购物车中的该商品记录
				 sql = "delete from 12181_cart where 商品ID ='"+select[i]+"';";
				 rs = conn.executeUpdate(sql);
				 //删除商品图片
				 java.io.File file = new java.io.File(application.getRealPath("salepic")+"\\"+select[i]+".jpg");
				 file.delete();
				    	
				}	 
		 }
		 String sql = "select * from 12181_sale where ID like '"+inf.getPhone()+"%' order by ID DESC;";
		 ResultSet rs=conn.executeQuery(sql);
		 rs.last();   
		 int num = rs.getRow();    
		 rs.first();
		 
		 if(num==0) {
		 out.print("您暂无出售中商品。可以选择出售新商品。");
		 %>
	
		  <form action="" method="post">
			<div style="margin:10px 0px 0px 0px;width:400px; height:50px;border:solid 0px gray;" >
			<input type="image" border=0 src="pic/sale.png"  onclick="javascript:this.form.action='newsale.jsp';this.form.submit()">
			</div>
		 <% 
		 }
		 else{
		 
			%>
	 	
			 	<div style="margin:30px 0px 0px 20px;width:600px; height:50px;border:solid 0px gray;" ><input type="image" border=0 src="pic/setall.png" onclick="checkAll()" >
				<input type="image" border=0 src="pic/unsetall.png" onclick="UNcheckAll()"></div>
				<form action="" method="post">
				<div style="margin:-50px 0px 0px 410px;width:400px; height:50px;border:solid 0px gray;" >
				<input type="image" border=0 src="pic/delete.png"  onclick="javascript:this.form.action='sale.jsp';this.form.submit()">
				<input type="image" border=0 src="pic/update.png"  onclick="javascript:this.form.action='saleupdate.jsp';this.form.submit()">
				<input type="image" border=0 src="pic/sale.png"  onclick="javascript:this.form.action='newsale.jsp';this.form.submit()">
				</div>
				<% 
			for(int i=0;i<num;i++)
			{		 
			%>
				<div style="margin:20px 0px 0px 50px;width:600px; height:240px;border:solid 1px gray;" >
					<div id="cartcheck" ><input type="checkbox" name="select[]" value="<%out.print(rs.getString("ID"));%>"/> </div>
					<div id="cartpic"><a href="showgood.jsp?ID=<%out.print(rs.getString("ID"));%>"><img src="<%out.print(rs.getString("图片路径"));%>" /></a></div>
					<div id="cartshow" aligen="left" ><br>&nbsp;&nbsp;&nbsp;&nbsp;<B><%out.print(rs.getString("名称"));%> </B>
											  <br><br>&nbsp;&nbsp;&nbsp;&nbsp;数量：<%out.print(rs.getInt("余量"));%>
											  <br>&nbsp;&nbsp;&nbsp;&nbsp;单价：￥<%out.print(rs.getInt("价格"));%> 元
											  <br>&nbsp;&nbsp;&nbsp;&nbsp;分类：<%out.print(rs.getString("分类"));%>
											  <br>&nbsp;&nbsp;&nbsp;&nbsp;ID：<%out.print(rs.getString("ID"));%></div>
					</div>
				<% 
					rs.next();
		}
	%>
	<script language="javascript">
				
				function checkAll(){
				  var names=document.getElementsByName("select[]");
				  var len=names.length;
				  if(len>0){
					var i=0;
					for(i=0;i<len;i++) names[i].checked=true;
				  }
				}
				 function UNcheckAll(){
				  var names=document.getElementsByName("select[]");
				  var len=names.length;
				  if(len>0){
					var i=0;
					for(i=0;i<len;i++) names[i].checked=false;
				  }
				}
				 
				</script>
	 	<%
		 }
 %>
</form>




</div>

</div>
</body>
</html>