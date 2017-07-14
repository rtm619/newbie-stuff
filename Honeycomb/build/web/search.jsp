<%-- 
    Document   : search
    Created on : 5 Apr, 2017, 7:49:01 PM
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
                    <h1 style="font-size: 25px; padding-top: 5px; width: 750px; text-align: center; background-color: orange;">
                        Search Results
                    </h1>
                    <br/>
                    <%!
                        String fname;
                        String uname, lname, gender, location;
                        Blob b1;
                        String imgDB64=null;
                        PreparedStatement ps2;
                        ResultSet rs2;
                    %>
                    <%  
                        fname=request.getParameter("search");
                        try{
                            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                            con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                            ps2=con.prepareStatement("select username, last_name, gender, cur_location from Userdata where first_name=?");
                            ps2.setString(1,fname);
                            rs2=ps2.executeQuery();
                            if(!rs2.isBeforeFirst()){
                                out.write("<h3>Sorry! No users found!</h3>");
                            }
                            else{
                                out.println("<h3 style='padding-left: 22px;'>Users found<h3>");
                                out.println("<br/>");
                                while(rs2.next()){
                                    uname=rs2.getString(1);
                                    lname=rs2.getString(2);
                                    gender=rs2.getString(3);
                                    location=rs2.getString(4);
                                    PreparedStatement ps3=con.prepareStatement("select profile_pic from Profileimage where username=?");
                                    ps3.setString(1, uname);
                                    ResultSet rs3=ps3.executeQuery();
                                    imgDB64=null;
                                    while(rs3.next()){
                                        b1=rs3.getBlob(1);
                                        byte [] imgData=b1.getBytes(1,(int) b1.length());
                                        imgDB64=new String(Base64.getEncoder().encode(imgData));
                                    }
                                    out.println("<table width='750'>");
                                    out.println("<tr>");
                                    if(imgDB64==null || imgDB64==""){
                                        out.write("<td rowspan='2' width='70'><img style='border-radius: 50px;' src='vector.jpg' width='60' height='60' align='left'></td>");
                                    }
                                    else{
                                        out.write("<td rowspan='2'><img style='border-radius: 50px;' src='data:image/jpeg;base64,"+imgDB64+"' width='60' height='60' align='left'></td>");
                                    }
                                    out.println("<td>");
                                    out.write("<a style='font-size: 25px; text-decoration: none;' href='viewuserprofile.jsp?username="+uname+"' > "+fname+" "+lname+"</a></td>");
                                    out.println("</tr><tr><td style='font-size: 25px;'>");
                                    out.write(gender+", "+location);
                                    out.println("</td></tr><br/>");
                                }
                                out.println("</table>");
                            }
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
