<%@page import="java.text.DateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<jsp:useBean id="conn" scope="page" class="javabean.conn"/>
<jsp:useBean id="inf" scope="session" class="javabean.inf"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<%
	inf.setAddress(null);
	inf.setEmail(null);
	inf.setPhone(null);
	inf.setUsername(null);
	
 %>
 <script language="javascript"type="text/javascript">window.location.href="index.jsp"</script>
