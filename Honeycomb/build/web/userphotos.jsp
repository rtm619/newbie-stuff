<%-- 
    Document   : userphotos
    Created on : 11 Apr, 2017, 11:31:21 PM
    Author     : Reetam
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
	<title>Honeycomb</title>
	<link rel="stylesheet" type="text/css" href="user.css">
        <link rel="stylesheet" href="lightbox.css">  
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
            ps=con.prepareStatement("select first_name, last_name, email, gender, cur_location, birth_date, birth_month, birth_year, reln_status, about_me from Userdata where username=?");
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
                                    <td class="menu"><a href="profile.jsp" class="active">Profile</a></td>
				</tr>
				<tr>
                                    <td class="menu"><a href="newsfeed.jsp">News Feed</a></td>
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
                    <div id="formdiv" style="width: 750px;">
                        <form action="adduserphoto" method="post" enctype="multipart/form-data">
                            <h3 style="font-size: 24px; padding-top: 5px; width: 750px; text-align: center; background-color: orange;">Add A Photo</h3><br>
                            <input type="file" name="photo"><br>
                            <input type="name" name="caption" placeholder="Write a caption about photo..."><br>
                            <input type="submit" name="submit" value="Add Photo" style="font-size: 25px; padding-top: 5px; width: 150px; height: 40px;">
                        </form>
                        
                    </div>    
                    <%!
                        Blob b1;
                        String imgDB64;
                        String caption;
                        int count=0;
                    %>
                    <%
                        count=0;
                        try{
                            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                            con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                            ps=con.prepareStatement("select photo, caption from Userphotos where username=?");
                            ps.setString(1, un);
                            rs=ps.executeQuery();
                            if(!rs.isBeforeFirst()){
                                out.println("<br>No Photos yet!");
                            }
                            else{
                                out.println("<br>");
                                out.println("<table width='750'>");
                                out.println("<th colspan='4' style='font-size: 24px; padding-top: 5px; width: 750px; text-align: center; background-color: orange;'>Your Photos</th>");
                                out.println("<tr><td><br/></td></tr>");
                                out.println("<tr>");
                                while(rs.next()){
                                    b1=rs.getBlob(1);
                                    caption=rs.getString(2);
                                    byte[] imgData=null;
                                    imgData=b1.getBytes(1,(int) b1.length());
                                    imgDB64=new String(Base64.getEncoder().encode(imgData));
                                    count=count+1;
                                    out.println("<td align='center'>");
                                    out.println("<a href='data:image/jpeg;base64,"+imgDB64+"' data-lightbox='gallery' data-title='"+caption+"'>");
                                    out.println("<img id='myImg' src='data:image/jpeg;base64,"+imgDB64+"' width='180' height='180'></a>"); 
                                    out.println("</td>");
                                    if(count==4){
                                        count=0;
                                        out.println("</tr>");
                                        out.println("<tr><td><br/></td></tr>");
                                        out.println("<tr>");
                                    }
                                }
                                out.println("</tr>");
                                out.println("</table>");
                            }
                        }
                            catch(Exception e){
                            out.println(e);
                        }
                    %>
                    <br/>
                    <br/>
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
    <script src="lightbox-plus-jquery.js"></script>            
</body>
</html>
