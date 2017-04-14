<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="GBK"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<% 
	String saleid=null;
	response.setContentType("text/html");
   String uploadPath =request.getSession().getServletContext().getRealPath("/")+"upload/images/";
   String tempPath = request.getSession().getServletContext().getRealPath("/")+"upload/images/temp/";
   String imagePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
   if(!new File(uploadPath).isDirectory())
   new File(uploadPath).mkdirs();
   if(!new File(tempPath).isDirectory())
   new File(tempPath).mkdirs();
   
   try {
   DiskFileUpload fu = new DiskFileUpload();
   fu.setSizeMax(4194304);
   fu.setSizeThreshold(4096);
   fu.setRepositoryPath(tempPath);
   List fileItems = fu.parseRequest(request);
   Iterator i = fileItems.iterator();
  
   while(i.hasNext()) {
   FileItem file = (FileItem)i.next();
   String sourcefileName = file.getName();
   
   //获取用户电话+时间=商品ID=图片名
   java.text.SimpleDateFormat now = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   java.util.Date current = new java.util.Date();
	   String date1= now.format(current);
	   String datetime=current.toString();
	   String[] temp = datetime.split(" ");
	   datetime = temp[5]+temp[1]+temp[2]+temp[3];
	 saleid = inf.getPhone()+datetime;
			 
		saleid=saleid.replace(":","");
	   	String Name=saleid+".jpg";
	   
	   
   		
   
   File f1=new File(application.getRealPath("salepic")+"\\"+Name);
   file.write(f1);
   
     out.print("<script>location.href='newsale2.jsp?ID="+saleid+"';</script>"); 
   
   }
   
   }
   catch(Exception e) {
   }
   out.flush();
   out.close();
   
  out.print("<script>location.href='newsale2.jsp?ID="+saleid+"';</script>"); 
%>
<script>location.href='newsale2.jsp?ID=<%out.print(saleid);%>';</script>
