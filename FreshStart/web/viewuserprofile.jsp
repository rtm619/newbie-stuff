<%@page import="java.util.Base64"%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>SocialNet</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/arial.js"></script>
<script type="text/javascript" src="js/cuf_run.js"></script>
</head>
<body>
<div class="main">
  <div class="main_resize">
    <div class="header">
      <div class="logo">
          <h1><a href="#"><span>Honey</span>comb<br/><small>Connecting Students</small></a></h1>
      </div>
      <div class="search">
        <form method="post" id="search" action="search.jsp">
          <span>
          <input type="text" value="Search Users..." name="search" id="s" />
          <input name="searchsubmit" type="image" src="images/search.gif" value="Go" id="searchsubmit" class="btn"  />
          </span>
        </form>
        <!--/searchform -->
        <div class="clr"></div>
      </div>
      <div class="clr"></div>
      <div class="menu_nav">
        <ul>
          <li class="active"><a href="#">Home</a></li>
          <li><a href="signout.jsp" onclick="return confirm('Are you sure you want to Sign Out?');">Sign Out</a></li>
        </ul>
        <div class="clr"></div>
      </div>
      <div class="hbg"><img src="images/header_image.jpg" width="923" height="291" alt="" /></div>
    </div>
    <div class="content">
      <div class="content_bg">
        <div class="mainbar">
            <h2><span>Profile Information</span></h2><br></br>
            <div class="clr"></div>
            <%!
                String un=null;
                String fn=null;
                String ln=null;
                String em=null;
                String dob=null;
                String gen=null;
                String mob=null;
                String loc=null;
                String rel=null;
                String bio=null;
                String imgDataBase64=null;
            %>
            <%
                            un=request.getParameter("username");
                            try{
                                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                                PreparedStatement ps=con.prepareStatement("select first_name, last_name,email,date_of_birth,gender,contact_number,location, relationship_status,profile_img_location, about_me from Userdata where username=?");
                                ps.setString(1, un);
                                ResultSet rs=ps.executeQuery();
                                while(rs.next()){
                                    fn=rs.getString(1);
                                    ln=rs.getString(2);
                                    em=rs.getString(3);
                                    dob=rs.getString(4);
                                    gen=rs.getString(5);
                                    mob=rs.getString(6);
                                    loc=rs.getString(7);
                                    rel=rs.getString(8);
                                    Blob b=rs.getBlob(9);
                                    bio=rs.getString(10);
                                    byte [] imgData=b.getBytes(1, (int) b.length());
                                    imgDataBase64=new String(Base64.getEncoder().encode(imgData));
                                    out.write("<div class='article'>");
                                    out.write("<h2><span>"+fn+" "+ln+"</span></h2>");
                                    out.write("<p><img src='data:image/jpeg;base64,"+imgDataBase64+"' alt='profile picture not available' width='265' height='265' align='right'>");
                                    out.write("<p>User ID: "+un+"</p>");
                                    out.write("<p>Email ID: "+em+"</p>");
                                    out.write("<p>Date of Birth: "+dob+"</p>");
                                    out.write("<p>Gender: "+gen+"</p>");
                                    out.write("<p>Contact No: "+mob+"</p>");
                                    out.write("<p>Current Location: "+loc+"</p>");
                                    out.write("<p>Relationship Status: "+rel+"</p>");
                                    out.write("<p>About Me: "+bio+"</p>");
                                    out.write("</p><div class='clr'></div></div>");
                                }
                            }
                            catch(Exception e){
                                out.println(e);
                            }
                        %>
        </div>
        <div class="sidebar">
            <%
                try{
                    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                    Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                    PreparedStatement ps=con.prepareStatement("select username from session where login_status=1");
                    ResultSet rs=ps.executeQuery();
                    while(rs.next()){
                        un=rs.getString(1);
                    }
                    ps=con.prepareStatement("select first_name, last_name,profile_img_location from Userdata where username=?");
                    ps.setString(1, un);
                    rs=ps.executeQuery();
                    while(rs.next()){
                        fn=rs.getString(1);
                        ln=rs.getString(2);
                        Blob b=rs.getBlob(3);
                        byte [] imgData=b.getBytes(1, (int) b.length());
                        imgDataBase64=new String(Base64.getEncoder().encode(imgData));
                    }
                }
                catch(Exception e){
                    out.println(e);
                }
            %>
		  <div class="gadget">
                      <h2 class="star"><span>Hi, </span><%out.print(fn+" "+ln); %> </h2>
                  <img src="data:image/jpeg;base64,<%=imgDataBase64 %>" alt="profile picture not available" width="100" height="100"></img>
		  </div>
          <div class="gadget">
            <h2 class="star"><span>Profile</span> Menu</h2>
            <div class="clr"></div>
            <ul class="sb_menu">
	      <li><a href="Profiles.jsp">Profile</a></li>
              <li><a href="Timelines.jsp">Timeline</a></li>
              <li><a href="Photos.jsp">Photos</a></li>
              <li><a href="EditProfile.jsp">Edit Profile</a></li>
              <li><a href="EditProfilePic.jsp">Change Profile Picture</a></li>
              <li><a href="password change.jsp">Change Password</a></li>
            </ul>
          </div>
        </div>
        <div class="clr"></div>
      </div>
    </div>
  </div>
  
</div>
<div class="footer">
  <div class="footer_resize">
    <p class="lf">Copyright &copy; Honeycomb. All Rights Reserved</p>
    <p class="rf">Designed with Netbeans</p>
    <div class="clr"></div>
  </div>
</div>
</body>
</html>