<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.ArrayList"%>

<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
	<link href="css/css.css" rel="stylesheet" rev="stylesheet" type="text/css" />
	<title>拍拍网-查询</title>
	<a name="head"></a>
	</head>
<body>
	<div id="top">
	<a href="index.jsp"><img border="0"src="pic/mainlogo.png"></a>
	</div>

<form action="search.jsp" method="get">
   <% 
   	 String phone = request.getParameter("phone"); 
	 String psw=request.getParameter("psw");

	 //inf内已经有了用户信息，直接显示登陆后首页
	 if(inf.getPhone()!=null)
	 {
	 %>
		<div id="bread">
			<pre>               <b><a href="index.jsp"><font color=#0080FF>首页</font></a></b>      <a href="cart.jsp">购物车</a>     <a href="purchased.jsp">已购买</a>      <a href="sale.jsp">我的商品</a>     <a href="userinf.jsp">我的资料</a>     <a href="logout.jsp">退出登录</a>  </pre>
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
	
	//判断登录是否成功
	else if(phone!=null)
	{
	
	 //开启数据库 查询数据库获得信息
	 
		String sql="select * from 12181_user where 密码=md5('"+psw+"') and 电话="+phone+";";
	    ResultSet rs = conn.executeQuery(sql);
	
        	//登录成功
 			if(rs.next())
 			{
 				inf.setUsername(rs.getString("用户名"));
 				inf.setPhone(phone);
 				inf.setEmail(rs.getString("邮箱"));
 				inf.setAddress(rs.getString("默认收货地址"));
				  
				%>
				<div id="bread">
					<pre>               <b><a href="index.jsp"><font color=#0080FF>首页</font></a></b>      <a href="cart.jsp">购物车</a>     <a href="cart.jsp">已购买</a>      <a href="sale.jsp">我的商品</a>     <a href="userinf.jsp">我的资料</a>     <a href="logout.jsp">退出登录</a>  </pre>
				  </div>
				 <div id="search">
				 <input  name="search" placeholder="查询商品" value="" spellcheck="false" class="">
				 </div>
				 <div id="searchbutton">
				  <input type="image" border=0 src="pic/search.png"  onClick="this.form.submit()">
				 </div>
				  <div id="welcome">
				   <font color="gray">欢迎您，<%out.print(inf.getUsername());%></font> 
				 </div>
			<% 
				  
 			}
 			
 			//用户名/密码错误，返回登陆界面
 			 else
			   {
				%>
					<script> alert("用户名或密码错误！")</script>
			
					<script language="javascript" type="text/javascript">
					window.location.href="login.jsp"
					</script>
					
				<%
			   }
	}
	 //游客身份
   else if(phone==null&&inf.getPhone()==null){
				%>
				<div id="bread">
					<pre>               <b><a href="index.jsp"><font color=#0080FF>首页</font></a></b>        <a href="login.jsp">登录</a>       <a href="register.jsp">新用户注册</a>  </pre>
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
	 String key = request.getParameter("search"); 
	 key = new String(key.getBytes("iso-8859-1"), "utf-8"); 
	 
	 //多关键字搜索
	 String[] keyword= key.split(" ");
	 int number = keyword.length;
	 
	 //for(int i=0;i<number;i++) out.print(keyword[i]);
	ArrayList<ResultSet> rs = new ArrayList<ResultSet>();
	 int num=0;
	 int[] numf =null;
	 
	 int k=0;
	 for(int i=0;i<number;i++)
	 {
	 	String sql="select * from 12181_sale where 名称 like '%"+keyword[i]+"%' or 描述 like '%"+keyword[i]+"%' or 分类 like '%"+keyword[i]+"%';";
		 ResultSet r =  conn.executeQuery(sql);
		
		if(r.next()) 
		{ 
			rs.add(r);
			
			r.last();   
			int num2 = r.getRow();    
			r.first();
			
			num+=num2; //搜索出的商品总数
			k++;
		}
		
	 }
	 
	//显示搜索商品
	
	
	if(k==0) out.print("暂无匹配信息");
	else{
		
		String[] check= new String[num];
		
		int i=0;
		int c=0;
		//显示商品信息
		for(int z=0;;z++){
		
		 int lie =70;
			 %>
			  <div style="margin:30px 0px 0px <%out.print(lie);%>px;width:200px; height:260px;border:dotted 1px black;"  >
					<div id="indexpic">
					<a href="showgood.jsp?ID=<%out.print(rs.get(i).getString("ID"));%>"><img src="<%out.print(rs.get(i).getString("图片路径"));%>" /></a>
					</div>
					<%out.print(rs.get(i).getString("名称"));%><br>
					￥<%out.print(rs.get(i).getString("价格"));%>
				</div>
			<% 
			 num--;
			 if(num<=0) break;
			
			 check[c++]=rs.get(i).getString("ID");
			
			 if(!rs.get(i).next()) i++;
			 if(i==k)break;
			 
			 for(int j=i;;j++)
			 {
			 	int flag=0;
			 	String id=rs.get(i).getString("ID");
				 for(int kk=0;kk<check.length;kk++){
					
					if(id.equals(check[kk])){
		
						if(!rs.get(i).next()) i++;
						if(i==k)break;
						flag=1;
						num--;
						break;
					}
					
				 }
				 if(i==k)break;
				 if(flag==0) break;
				 if(num<=0) break;
			}
			if(num<=0) break;
			if(i==k)break;
	
			lie+=270;
			 %><div style="margin:-260px 0px 0px <%out.print(lie);%>px;width:200px; height:260px;border:dotted 1px black;"  >
					<div id="indexpic">
					<a href="showgood.jsp?ID=<%out.print(rs.get(i).getString("ID"));%>"><img src="<%out.print(rs.get(i).getString("图片路径"));%>" /></a>
					</div>
					<%out.print(rs.get(i).getString("名称"));%><br>
					￥<%out.print(rs.get(i).getString("价格"));%>
				</div>
			<% 
			  
			 num--;
			 if(num<=0) break;
			
			 check[c++]=rs.get(i).getString("ID");
			 if(!rs.get(i).next()) i++;
			 if(i==k)break;
			 
			 for(int j=i;;j++)
			 {
			 	int flag=0;
			 	String id=rs.get(i).getString("ID");
				 for(int kk=0;kk<check.length;kk++){
					
					if(id.equals(check[kk])){
		
						if(!rs.get(i).next()) i++;
						 if(i==k)break;
						flag=1;
						num--;
						break;
					}
					
				 }
				  if(i==k)break;
				 if(flag==0) break;
				 if(num<=0) break;
			}
			 if(i==k)break;
			if(num<=0) break;
	
	
			lie+=270;
			
			 %><div style="margin:-260px 0px 0px <%out.print(lie);%>px;width:200px; height:260px;border:dotted 1px black;"  >
					<div id="indexpic">
					<a href="showgood.jsp?ID=<%out.print(rs.get(i).getString("ID"));%>"><img src="<%out.print(rs.get(i).getString("图片路径"));%>" /></a>
					</div>
					<%out.print(rs.get(i).getString("名称"));%><br>
					￥<%out.print(rs.get(i).getString("价格"));%>
				</div>
			<% 
			  
			  num--;
			 if(num<=0) break;
			
			 check[c++]=rs.get(i).getString("ID");
			 if(!rs.get(i).next()) i++;
			 if(i==k)break;
			 
			 for(int j=i;;j++)
			 {
			 	int flag=0;
			 	String id=rs.get(i).getString("ID");
				 for(int kk=0;kk<check.length;kk++){
					
					if(id.equals(check[kk])){
		
						if(!rs.get(i).next()) i++;
						 if(i==k)break;
						flag=1;
						num--;
						break;
					}
					
				 }
				  if(i==k)break;
				 if(flag==0) break;
				 if(num<=0) break;
			}
			 if(i==k)break;
			if(num<=0) break;
	
	
			
			lie+=270;
			
			
		
		}	
	
}
%>
</div>
</body>
</html>
