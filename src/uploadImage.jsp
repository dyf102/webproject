<%@ page contentType="text/html" pageEncoding="GBK"%>
<%@ page import="org.lxh.smart.*"%>
<%@ page import="cn.mldn.lxh.util.*"%>
<html>
<head><title>www.mldnjava.cn��MLDN�߶�Java��ѵ</title></head>
<body>
<%
	request.setCharacterEncoding("GBK") ;
%>
<%
	SmartUpload smart = new SmartUpload() ;
	smart.initialize(pageContext) ;	// ��ʼ���ϴ�����
	smart.upload() ;			// �ϴ�׼��
	String name = smart.getRequest().getParameter("uname") ;
	IPTimeStamp its = new IPTimeStamp(request.getRemoteAddr()) ;	// ȡ�ÿͻ��˵�IP��ַ
	for(int x=0;x<smart.getFiles().getCount();x++){
		String ext = smart.getFiles().getFile(x).getFileExt() ;	// ��չ����
		String fileName = its.getIPTimeRand() + "." + ext ;
		smart.getFiles().getFile(x).saveAs(this.getServletContext().getRealPath("/")+"upload"+java.io.File.separator + fileName) ;
	}
%>
</body>
</html>