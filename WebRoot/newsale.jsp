<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="GBK" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@page import="java.text.DateFormat"%>
<%@ page import ="java.sql.*" %>
<%@page import="com.oreilly.servlet.MultipartRequest" %> 


<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<link href="./css/css.css" rel="stylesheet" rev="stylesheet" type="text/css" />
	<title>������-�ҵ���Ʒ</title>
	<a name="head"></a>

</head>
<body>
<div id="top">
<a href="index.jsp"><img border="0"src="pic/mainlogo.png"></a>
</div>

 <form action="search.jsp" method="get" >
   <% 
	 //inf���Ѿ������û���Ϣ��ֱ����ʾ��½����ҳ
	 if(inf.getPhone()!=null)
	 {
	 %>
		<div id="bread">
			<pre>               <a href="index.jsp">��ҳ</a>      <a href="cart.jsp">���ﳵ</a>     <a href="purchased.jsp">�ѹ���</a>      <b><a href="sale.jsp"><font color=#0080FF>�ҵ���Ʒ</font></a></b>     <a href="userinf.jsp">�ҵ�����</a>     <a href="logout.jsp">�˳���¼</a>  </pre>
		  </div>
		 <div id="search">
		 <input  name="search" placeholder="��ѯ��Ʒ" value="" spellcheck="false" class="">
		 </div>
		 <div id="searchbutton">
		  <input type="image" border=0 src="pic/search.png"  onClick="this.form.submit()">
		 </div>
		  <div id="welcome">
		   <font color="gray">��ӭ����<%out.print(inf.getUsername()); %></font> 
		 </div>
	<% 
	}
	
	//r�����ο����ȵ�¼
	else 
	{
	%>
					<script> alert("���ȵ�¼��")</script>
			
					<script language="javascript" type="text/javascript">
					window.location.href="login.jsp"
					</script>
					
		<%
	 
	}
		   
		  %>
   </form>

 <div id="navigation">
   <a href="search.jsp?search=�·�"><img border="0"src="pic/clothes.png"></a><br>
	<a href="search.jsp?search=ʳƷ"><img border="0"src="pic/food.png"></a><br> 
	<a href="search.jsp?search=ͼ��"><img border="0"src="pic/book.png"></a><br>
	<a href="search.jsp?search=�ֻ������"><img border="0"src="pic/cell.png"></a><br>
	<a href="search.jsp?search=���Լ����"><img border="0"src="pic/computer.png"></a><br>
	<a href="search.jsp?search=���õ���"><img border="0"src="pic/electric.png"></a><br>
	<a href="search.jsp?search=����"><img border="0"src="pic/others.png"></a><br>
	<br><a><font size=2px;>���ߣ�������</font></a><br>
	 <a><font size=2px;>ѧ�ţ�1120112181</font></a><br>
	 <a><font size=2px;>�༶��08111103</font></a><br>
	 <a><font size=2px;>�绰��18810579183</font></a><br>
 </div>

<div id="main">
<form action='doUpload.jsp' method='post' enctype='multipart/form-data'>	
<form action='doUpload.jsp' method='post' enctype='multipart/form-data'>
<p align="center">��ѡ������ƷͼƬһ���ϴ�&nbsp;&nbsp;&nbsp;&nbsp;<input type='file' name='upfile' onchange="previewImage(this)" size='50'></p>
<div id="preview">
<p align="center"><img id="imghead" width=100 height=100 border=0 src='<%=request.getContextPath()%>/images/defaul.jpg'></p>
</div>
<p align="center"><input type="image" border=0 src="pic/save.png"  onclick="javascript:this.form.action='doUpload.jsp';this.form.submit()"></p>
</form>
<script type="text/javascript">


                //ͼƬ�ϴ�Ԥ��    IE�������˾���
        function previewImage(file)
        {
          var MAXWIDTH  = 260; 
          var MAXHEIGHT = 180;
          var div = document.getElementById('preview');
          if (file.files && file.files[0])
          {
              div.innerHTML ='<img id=imghead>';
              var img = document.getElementById('imghead');
              img.onload = function(){
                var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
                img.width  =  rect.width;
                img.height =  rect.height;
                 img.style.marginLeft = rect.left+310;
                img.style.marginTop = rect.top+'px';
              }
              var reader = new FileReader();
              reader.onload = function(evt){img.src = evt.target.result;}
              reader.readAsDataURL(file.files[0]);
          }
          else //����IE
          {
            var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
            file.select();
            var src = document.selection.createRange().text;
            div.innerHTML = '<img id=imghead>';
            var img = document.getElementById('imghead');
            img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
            var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
            status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
            div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>";
          }
        }
        function clacImgZoomParam( maxWidth, maxHeight, width, height ){
            var param = {top:0, left:0, width:width, height:height};
            if( width>maxWidth || height>maxHeight )
            {
                rateWidth = width / maxWidth;
                rateHeight = height / maxHeight;
                
                if( rateWidth > rateHeight )
                {
                    param.width =  maxWidth;
                    param.height = Math.round(height / rateWidth);
                }else
                {
                    param.width = Math.round(width / rateHeight);
                    param.height = maxHeight;
                }
            }
            
            param.left = Math.round((maxWidth - param.width) / 2);
            param.top = Math.round((maxHeight - param.height) / 2);
            return param;
        }
</script>  
</div>
</div>
</body>
</html>
