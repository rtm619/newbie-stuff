<%-- 
    Document   : comments
    Created on : 7 Apr, 2017, 5:15:23 PM
    Author     : Reetam
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Honeycomb</title>
	<link rel="stylesheet" type="text/css" href="user.css">
</head>
<body>
    <%!
        String un=null;
        String fn=null;
        String ln=null;
        Blob b=null;
        String imgDataBase64=null;
        Connection con=null;
        PreparedStatement ps=null; 
        ResultSet rs=null;
    %>
    <%
        try{
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
            ps=con.prepareStatement("select username from Session where login_status=1");
            rs=ps.executeQuery();
            while(rs.next()){
                un=rs.getString(1);
            }
            ps=con.prepareStatement("select first_name, last_name from Userdata where username=?");
            ps.setString(1, un);
            rs=ps.executeQuery();
            while(rs.next()){
                fn=rs.getString(1);
                ln=rs.getString(2); 
            }
            imgDataBase64=null;
            ps=con.prepareStatement("select profile_pic from Profileimage where username=?");
            ps.setString(1, un);
            rs=ps.executeQuery();
            while(rs.next()){
                b=rs.getBlob(1);
                byte [] imgData=null;
                imgData=b.getBytes(1,(int) b.length());
                imgDataBase64=new String(Base64.getEncoder().encode(imgData));
            }
        }
        catch(Exception e){
            out.println(e);
        }
    %>
    
    
    
	<div id="header">
		<table width="1368">
			<tr>
				<td>
					<table align="left" id="leftTab">
						<tr>
							<td>
								<img src="logo_phixr.png" width="150" id="logo">
							</td>
							<td>
								<div class="search-box">
                                                                    <form action="search.jsp" method="Post">
									<input type="text" class="search-input" name="search" placeholder="Search User by First Name...">
									<button class="search-button">&#128269;</button>
                                                                    </form>    
								</div>
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table align="right">
						<tr>
							<td>
								<table>
									<tr>
										<td class="welcome_User">Welcome, <%=fn %></td> 
                                                                                <%
                                                                                    if(imgDataBase64==null || imgDataBase64==""){
                                                                                        out.write("<td><img src='vector.jpg' style='width: 40px; height: 40px; border-radius: 10px; padding: 5px;'></td>");
                                                                                    }
                                                                                    else{
                                                                                        out.write("<td><img src='data:image/jpeg;base64,"+imgDataBase64+"' style='width: 40px; height: 40px; border-radius: 10px; padding: 5px;'></td>");
                                                                                    }
                                                                                %>
										<!-- <td><img src="vector.jpg" style="width: 40px; height: 40px; border-radius: 10px; padding: 5px;"></td> -->
									</tr>
								</table>
							</td>
							<td>
								<nav class="navClass">
									<ul>
										<li>
											<a href="friendrequests.jsp" class="nav_Item"><img src="AddFriend.png" class="icon"></a>
										</li>
										<li>
											<a href="#/" class="nav_Item"><img src="settings-5-xxl.png" class="icon"></a>
											<div class="nav_Con">
												<div class="nav_Sub">
													<ul>
														<li><a href="changeprofilepic.jsp">Change Profile Picture</a></li>
														<li><a href="password.jsp">Change Password</a></li>
														<li><a href="editprofile.jsp">Edit Profile</a></li>
													</ul>
												</div>
											</div>
										</li>
										<li>
											<a href="logout.jsp" onclick="return confirm('Are you sure you want to LOGOUT?');" class="nav_Item"><img src="Logout-512.png" class="icon"></a>
										</li>
									</ul>
								</nav>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<div id="main">
		<div id="leftNav">
			<table>
				<tr>
                                    <td class="menu"><a href="profile.jsp" >Profile</a></td>
				</tr>
				<tr>
                                    <td class="menu"><a href="newsfeed.jsp" class="active">News Feed</a></td>
				</tr>
				<tr>
                                    <td class="menu"><a href="messagelist.jsp">Messages</a></td>
				</tr>
				<tr>
                                    <td class="menu"><a href="userphotos.jsp">Photos</a></td>
				</tr>
                                <tr>
                                    <td class="menu"><a href="friendlist.jsp">Friends</a></td>
				</tr>
			</table>
		</div>
		<div id="content">
                    <%
                        String uname;
                        String post;
                        String comment;
                        String temp=request.getParameter("postid"); 
                        int postid=Integer.parseInt(temp);
                        String fname=null;
                        String lname=null;
                        int likes;
                        String imgDB64=null;
                        PreparedStatement ps2;
                        ResultSet rs2;
                        Blob b1;
                        try{
                            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                            con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                            ps=con.prepareStatement("select username, post, likes from Newsfeed where post_id=?");
                            ps.setInt(1, postid);
                            rs=ps.executeQuery();
                            while(rs.next()){
                                uname=rs.getString(1);
                                post=rs.getString(2);
                                likes=rs.getInt(3);
                                ps2=con.prepareStatement("select first_name, last_name from Userdata where username=?");
                                ps2.setString(1, uname);
                                rs2=ps2.executeQuery();
                                while(rs2.next()){
                                    fname=rs2.getString(1);
                                    lname=rs2.getString(2);
                                }
                                rs2=null;
                                imgDB64=null;
                                ps2=con.prepareStatement("select nfphoto from Newsfeedphotos where post_id=?");
                                ps2.setInt(1, postid);
                                rs2=ps2.executeQuery();
                                while(rs2.next()){
                                    b1=rs2.getBlob(1);
                                    byte [] imgData=null;
                                    imgData=b1.getBytes(1,(int) b1.length());
                                    imgDB64=new String(Base64.getEncoder().encode(imgData));
                                }
                                out.println("<br>");
                                out.println("<table style='background-color: rgba(255,140,0,1); width: 760px; border: 1px solid white; border-radius: 10px;'>");
                                out.println("<tr><td style='padding-left: 15px; padding-top: 7px'>");
                                out.println("<a href='viewuserprofile.jsp?username="+uname+"'>"+fname+" "+lname+"</a> wrote:- <br><br/>");
                                out.println(post+"<br>");
                                if(imgDB64==null || imgDB64==""){
                                    out.write("</td></tr></table>");
                                }
                                else{
                                    out.write("<img src='data:image/jpeg;base64,"+imgDB64+"' align='center' height='480' width='640'><br>");
                                }
                                out.println("<br>&emsp;"+likes+" People liked this!");
                                out.println("<form action='addlike.jsp' method='post'>");
                                out.println("<input type='hidden' name='postid' value='"+postid+"'>");
                                out.println("<input type='submit' name='submit' value='Like It!' style='font-size: 20px; width: 70px; height: 30px; line-height: 10px; margin-left: 20px; padding-left: 15px;'></form>");
                                out.println("");
                            }
                            out.println("<table width='755'><tr><td align='left'>");
                            out.println("<form method='POST' action='addcomment.jsp'>");
                            out.println("<textarea rows='2' cols='10' name='comment' style='width: 520px;'>Write a comment...</textarea><br>");
                            out.println("<input type='hidden' name='postid' value='"+postid+"'>");
                            out.println("</td><td align='right'>");
                            out.println("<input type='submit' name='submit' value='Comment' style='width: 130px; padding-left: 20px;'>");
                            out.println("</form></td></tr></table>");
                            out.println("<br><div style='background-color: orange; width: 753px; height: 25px; font-size: 25px; text-align: center;'>Comments</div>");
                            ps=con.prepareStatement("select username, comment from Postcomments where post_id=?");
                            ps.setInt(1, postid);
                            rs=ps.executeQuery();
                            if(!rs.isBeforeFirst()){
                                out.println("<br> No Comments yet!");
                            }
                            else{
                                while(rs.next()){
                                    uname=rs.getString(1);
                                    comment=rs.getString(2);
                                    ps2=con.prepareStatement("select first_name, last_name from Userdata where username=?");
                                    ps2.setString(1, uname);
                                    rs2=ps2.executeQuery();
                                    while(rs2.next()){
                                        fname=rs2.getString(1);
                                        lname=rs2.getString(2);
                                    }
                                    out.println("&emsp;");
                                    out.println("<table width='755'><tr><td height='60' style='padding-left: 20px; border: 1px solid white; background-color: rgba(255,140,0,1);'>");
                                    out.println("<a href='viewuserprofile.jsp?username="+uname+"'>"+fname+" "+lname+"</a> wrote:- "+comment+"");
                                    out.println("</td></tr></table>");
                                }
                                
                            }
                        out.println("<br/>");
                        }
                        catch(Exception e){
                            out.println(e);
                        }
                %>
		</div>
		<div id="rightNav">
                    <%
                        try{
                            String[] names=new String[100];
                            int i=0; 
                            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                            con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                            ps=con.prepareStatement("select username from Session");
                            rs=ps.executeQuery();
                            PreparedStatement ps1;
                            ResultSet rs1;
                            while(rs.next()){
                                ps1=con.prepareStatement("select first_name, last_name from Userdata where username=?");
                                ps1.setString(1, rs.getString(1));
                                rs1=ps1.executeQuery();
                                while(rs1.next()){
                                    names[i]=rs1.getString(1)+" "+rs1.getString(2);
                                    i=i+1;
                                }
                            }
                            int j;
                            out.println("<h3>Online Users:-</h3>");
                            for(j=0; j<i; j++){
                                out.println(names[j]);
                                out.println("<br>");
                            }
                        }
                        catch(Exception e){
                            out.println(e);
                        }
                    %>
		</div>
	</div>

</body>
</html>

