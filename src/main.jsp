<!DOCTYPE html>
<!-- 
Template Name: Metronic - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.0
Version: 1.5.2
Author: KeenThemes
Website: http://www.keenthemes.com/
Purchase: http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes
-->
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
   <meta charset="utf-8" />
   <title>DashBoard</title>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta content="width=device-width, initial-scale=1.0" name="viewport" />
   <meta content="" name="description" />
   <meta content="" name="author" />
   <meta name="MobileOptimized" content="320">
   <!-- BEGIN GLOBAL MANDATORY STYLES -->          
   <link href="assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
   <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
   <link href="assets/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
   <!-- END GLOBAL MANDATORY STYLES -->
   <!-- BEGIN THEME STYLES --> 
   <link href="assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
   <link href="assets/css/style.css" rel="stylesheet" type="text/css"/>
   <link href="assets/css/style-responsive.css" rel="stylesheet" type="text/css"/>
   <link href="assets/css/plugins.css" rel="stylesheet" type="text/css"/>
   <link href="assets/css/themes/default.css" rel="stylesheet" type="text/css" id="style_color"/>
   <link href="assets/css/custom.css" rel="stylesheet" type="text/css"/>
   <!-- END THEME STYLES -->
   <link rel="shortcut icon" href="favicon.ico" />
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="page-header-fixed">
   <!-- BEGIN HEADER -->   
   <div class="header navbar navbar-inverse navbar-fixed-top">
      <!-- BEGIN TOP NAVIGATION BAR -->
      <div class="header-inner">
         <!-- BEGIN LOGO -->  
         <a class="navbar-brand" href="main.jsp">
         <img src="assets/img/logo.png" alt="logo" class="img-responsive" />
         </a>
         <!-- END LOGO -->
         <!-- BEGIN RESPONSIVE MENU TOGGLER --> 
         <a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
         <img src="assets/img/menu-toggler.png" alt="" />
         </a> 
         <!-- END RESPONSIVE MENU TOGGLER -->
         <!-- BEGIN TOP NAVIGATION MENU -->
         <ul class="nav navbar-nav pull-right">
            <!-- BEGIN NOTIFICATION DROPDOWN -->
            <li class="dropdown" id="header_notification_bar">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                  data-close-others="true">
               <i class="icon-warning-sign"></i>
               <span class="badge">6</span>
               </a>
            </li>
            <!-- END NOTIFICATION DROPDOWN -->
            <!-- BEGIN INBOX DROPDOWN -->
            <li class="dropdown" id="header_inbox_bar">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                  data-close-others="true">
               <i class="icon-envelope"></i>
               <span class="badge">5</span>
               </a>
               <ul class="dropdown-menu extended inbox">
                  <li>
                     <p>You have 12 new messages</p>
                  </li>
                  <li>
                     <ul class="dropdown-menu-list scroller" style="height: 250px;">
                        <li>  
                           <a href="inbox.html?a=view">
                           <span class="photo"><img src="./assets/img/avatar2.jpg" alt=""/></span>
                           <span class="subject">
                           <span class="from">Lisa Wong</span>
                           <span class="time">Just Now</span>
                           </span>
                           <span class="message">
                           Vivamus sed auctor nibh congue nibh. auctor nibh
                           auctor nibh...
                           </span>  
                           </a>
                        </li>
                        <li>  
                           <a href="inbox.html?a=view">
                           <span class="photo"><img src="./assets/img/avatar3.jpg" alt=""/></span>
                           <span class="subject">
                           <span class="from">Richard Doe</span>
                           <span class="time">16 mins</span>
                           </span>
                           <span class="message">
                           Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh
                           auctor nibh...
                           </span>  
                           </a>
                        </li>
                        <li>  
                           <a href="inbox.html?a=view">
                           <span class="photo"><img src="./assets/img/avatar1.jpg" alt=""/></span>
                           <span class="subject">
                           <span class="from">Bob Nilson</span>
                           <span class="time">2 hrs</span>
                           </span>
                           <span class="message">
                           Vivamus sed nibh auctor nibh congue nibh. auctor nibh
                           auctor nibh...
                           </span>  
                           </a>
                        </li>
                        <li>  
                           <a href="inbox.html?a=view">
                           <span class="photo"><img src="./assets/img/avatar2.jpg" alt=""/></span>
                           <span class="subject">
                           <span class="from">Lisa Wong</span>
                           <span class="time">40 mins</span>
                           </span>
                           <span class="message">
                           Vivamus sed auctor 40% nibh congue nibh...
                           </span>  
                           </a>
                        </li>
                        <li>  
                           <a href="inbox.html?a=view">
                           <span class="photo"><img src="./assets/img/avatar3.jpg" alt=""/></span>
                           <span class="subject">
                           <span class="from">Richard Doe</span>
                           <span class="time">46 mins</span>
                           </span>
                           <span class="message">
                           Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh
                           auctor nibh...
                           </span>  
                           </a>
                        </li>
                     </ul>
                  </li>
                  <li class="external">   
                     <a href="inbox.html">See all messages <i class="m-icon-swapright"></i></a>
                  </li>
               </ul>
            </li>
            <!-- END INBOX DROPDOWN -->
            <!-- BEGIN TODO DROPDOWN -->
            <!-- END TODO DROPDOWN -->
            <!-- BEGIN USER LOGIN DROPDOWN -->
            <li class="dropdown user">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
               <img alt="" src="assets/img/avatar1_small.jpg"/>
               <span class="username"> <%=session.getAttribute("loged_in")%></span>
               <i class="icon-angle-down"></i>
               </a>
               <ul class="dropdown-menu">
                  <li><a href="extra_profile.jsp"><i class="icon-user"></i> My Profile</a>
                  </li>
                  <li><a href="#"><i class="icon-tasks"></i> My Tasks <span class="badge badge-success">7</span></a>
                  </li>
                  <li class="divider"></li>
                  <li><a href="javascript:;" id="trigger_fullscreen"><i class="icon-move"></i> Full Screen</a>
                  </li>
                  <li><a href="extra_lock.html"><i class="icon-lock"></i> Lock Screen</a>
                  </li>
                  <li><a href="logout.jsp"><i class="icon-key"></i> Log Out</a>
                  </li>
               </ul>
            </li>
            <!-- END USER LOGIN DROPDOWN -->
         </ul>
         <!-- END TOP NAVIGATION MENU -->
      </div>
      <!-- END TOP NAVIGATION BAR -->
   </div>
   <!-- END HEADER -->
   <div class="clearfix"></div>
   <!-- BEGIN CONTAINER -->   
   <div class="page-container">
      <!-- BEGIN SIDEBAR -->
      <div class="page-sidebar navbar-collapse collapse">
         <!-- BEGIN SIDEBAR MENU -->        
         <ul class="page-sidebar-menu">
            <li>
               <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
               <div class="sidebar-toggler hidden-phone"></div>
               <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
            </li>
            <li>
               <!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
               <form class="sidebar-search" action="search.jsp" method="POST">
                  <div class="form-container">
                     <div class="input-box">
                        <a href="test.jsp" class="remove"></a>
                        <input type="text" placeholder="Search..." name="key"/>
                        <input type="button" class="submit" value=" "/>
                     </div>
                  </div>
               </form>
               <!-- END RESPONSIVE QUICK SEARCH FORM -->
            </li>
            <li class="start ">
               <a href="main.jsp">
               <i class="icon-home"></i> 
               <span class="title">Main</span>
               </a>
            </li>

            <li class="tooltips" data-placement="left" data-original-title="Frontend&nbsp;Theme For&nbsp;Metronic&nbsp;Admin">
               <a href="help.jsp" target="_blank">
               <i class="icon-gift"></i> 
               <span class="title">Help</span>
               </a>
            </li>
             <li class="tooltips" data-placement="left" data-original-title="Frontend&nbsp;Theme For&nbsp;Metronic&nbsp;Admin">
               <a href="displayAll.jsp">
               <i class="icon-home"></i> 
               <span class="title">Images</span>
               </a>
            </li>
            <li class="">
               <a href="javascript:;">
               <i class="icon-sitemap"></i> 
               <span class="title">Friends</span>
               <span class="arrow "></span>
               </a>
               <ul class="sub-menu">
                  <li >
                     <a href="CreateGroup.jsp">
                     <i class="icon-briefcase"></i>
                     <span class="badge badge-warning badge-roundless">New!</span>Groups</a>
                  </li>
               </ul>
            </li>
            <li class="">
               <a href="javascript:;">
               <i class="icon-map-marker"></i> 
               <span class="title">Upload</span>
               <span class="arrow "></span>
               </a>
               <ul class="sub-menu">
                  <li >
                     <a href="SingleUpload.jsp">
                     Single(Multiple) Upload</a>
                  </li>
               </ul>
            </li>
            <li class="last ">
               <a href="dataViewer.jsp">
               <i class="icon-bar-chart"></i> 
               <span class="title">Statistic Data</span>
               </a>
            </li>
         </ul>
         <!-- END SIDEBAR MENU -->
      </div>
      <!-- END SIDEBAR -->
      <!-- BEGIN PAGE -->
      <div class="page-content">
         <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->               
         <div class="modal fade" id="portlet-config" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                     <h4 class="modal-title">Modal title</h4>
                  </div>
                  <div class="modal-body">
                     Widget settings form goes here
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn blue">Save changes</button>
                     <button type="button" class="btn default" data-dismiss="modal">Close</button>
                  </div>
               </div>
               <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
         </div>
         <!-- /.modal -->
         <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
         <!-- BEGIN STYLE CUSTOMIZER -->
         <div class="theme-panel hidden-xs hidden-sm">
            <div class="toggler"></div>
            <div class="toggler-close"></div>
            <div class="theme-options">
               <div class="theme-option theme-colors clearfix">
                  <span>THEME COLOR</span>
                  <ul>
                     <li class="color-black current color-default" data-style="default"></li>
                     <li class="color-blue" data-style="blue"></li>
                     <li class="color-brown" data-style="brown"></li>
                     <li class="color-purple" data-style="purple"></li>
                     <li class="color-grey" data-style="grey"></li>
                     <li class="color-white color-light" data-style="light"></li>
                  </ul>
               </div>
               <div class="theme-option">
                  <span>Layout</span>
                  <select class="layout-option form-control input-small">
                     <option value="fluid" selected="selected">Fluid</option>
                     <option value="boxed">Boxed</option>
                  </select>
               </div>
               <div class="theme-option">
                  <span>Header</span>
                  <select class="header-option form-control input-small">
                     <option value="fixed" selected="selected">Fixed</option>
                     <option value="default">Default</option>
                  </select>
               </div>
               <div class="theme-option">
                  <span>Sidebar</span>
                  <select class="sidebar-option form-control input-small">
                     <option value="fixed">Fixed</option>
                     <option value="default" selected="selected">Default</option>
                  </select>
               </div>
               <div class="theme-option">
                  <span>Footer</span>
                  <select class="footer-option form-control input-small">
                     <option value="fixed">Fixed</option>
                     <option value="default" selected="selected">Default</option>
                  </select>
               </div>
            </div>
         </div>
         <!-- END BEGIN STYLE CUSTOMIZER -->           
         <!-- BEGIN PAGE HEADER-->
         <div class="row">
            <div class="col-md-12">
               <!-- BEGIN PAGE TITLE & BREADCRUMB-->
               <h3 class="page-title">
                  Top Five Images <small>Top Five Images(High To Low)</small>
               </h3>
               <ul class="page-breadcrumb breadcrumb">
                  <li class="btn-group">
                     <button type="button" class="btn blue dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000" data-close-others="true">
                     <span>Actions</span> <i class="icon-angle-down"></i>
                     </button>
                     <ul class="dropdown-menu pull-right" role="menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Separated link</a></li>
                     </ul>
                  </li>
                  <li>
                     <i class="icon-home"></i>
                     <a href="main.jsp">Home</a> 
                     <i class="icon-angle-right"></i>
                  </li>
                  <li><a href="#">Top Five Images</a></li>
               </ul>
               <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
         </div>
         <!-- END PAGE HEADER-->
         <!-- BEGIN PAGE CONTENT-->
         <div class="row">
            <div class="col-md-12">
            	<%@ page import="java.io.*"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="oracle.jdbc.*"%>
	<%@ page import="java.lang.System"%>
            <%
            String username = (String)session.getAttribute("loged_in");
            	if (username == null) {
			username = "";
			%>
	<p>Unauthorized access</p>
	<meta http-equiv="refresh" content="1; url = login.html">
	<%
		}
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";

		String m_userName = "c391g3";
		String m_password = "C1234567";

		Connection m_con = null;
		
            	String sql = "SELECT i.PHOTO_ID FROM (SELECT DISTINCT COUNT_NUM FROM POPULARITY  ORDER BY COUNT_NUM DESC)num,IMAGES i,POPULARITY p WHERE ROWNUM <=5 AND i.PHOTO_ID = p.PHOTO_ID AND p.COUNT_NUM = num.COUNT_NUM order by p.COUNT_NUM DESC";
            	String sql2 = "SELECT i.SUBJECT FROM (SELECT DISTINCT COUNT_NUM FROM POPULARITY  ORDER BY COUNT_NUM DESC)num,IMAGES i,POPULARITY p WHERE ROWNUM <=5 AND i.PHOTO_ID = p.PHOTO_ID AND p.COUNT_NUM = num.COUNT_NUM order by p.COUNT_NUM DESC";
            	try {
			Class drvClass = Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
			drvClass.newInstance();

		} catch (Exception e) {
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());

		}
		try {

			m_con = DriverManager.getConnection(m_url, m_userName,m_password);
		}
		catch(Exception e){
			out.println(e.toString());
		}
            %>
               	<table border="1">
		<tr>
	<%
				/*User's Image ==START==*/
		Statement stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet result2 = stmt.executeQuery(sql);
				while (result2.next()) {
					String id = String.valueOf(result2.getLong(1));
					//out.println(id);
			%>
			
			<td><a href="displaySinglePhoto.jsp?photo_id=<%=id%>"><img
					src="displayblob.jsp?photo_id=<%=id%>&type=thumbnail" WIDTH="150"
					HEIGHT="150"></a></td>
			<%
				}
						/*User's Image ==END==*/
			%>
		</tr><tr>
			<%
				/*User's subject ==START==*/
		Statement stmt2 = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet imgResult = stmt2.executeQuery(sql2);
				while (imgResult.next()) {
					String subject = imgResult.getString(1);
			%>
			<td><%=subject%></td>
			<%
				/*User's subject ==START==*/
						}
			%>
		</tr>



		<tr>
		</tr>
                           
            </div>
         </div>
         <!-- END PAGE CONTENT-->
      </div>
      <!-- END PAGE -->    
   </div>
   <!-- END CONTAINER -->
   <!-- BEGIN FOOTER -->
   <!-- END FOOTER -->
   <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
   <!-- BEGIN CORE PLUGINS -->   
   <!--[if lt IE 9]>
   <script src="assets/plugins/respond.min.js"></script>
   <script src="assets/plugins/excanvas.min.js"></script> 
   <![endif]-->   
   <script src="assets/plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
   <script src="assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
   <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
   <script src="assets/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>      
   <script src="assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
   <script src="assets/plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript" ></script>
   <script src="assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
   <script src="assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>  
   <script src="assets/plugins/jquery.cookie.min.js" type="text/javascript"></script>
   <script src="assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script>
   <!-- END CORE PLUGINS -->
   <script src="assets/scripts/app.js"></script>      
   <script>
      jQuery(document).ready(function() {    
         App.init();
      });
   </script>
   <!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
