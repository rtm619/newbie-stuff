<%-- 
    Document   : friendlist
    Created on : 10 Apr, 2017, 9:51:39 PM
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
                        Your Friends
                    </h1>
                    <br/>
                    <%!
                       int count=0;
                       String[] usernames;
                       String fname, lname, gender, location; 
                       Blob b1;
                       String imgDB64;
                    %>
                    <%
                        try{
                            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                            con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                            ps=con.prepareStatement("select user1, user2 from Friendspair");
                            rs=ps.executeQuery();
                            count=0;
                            usernames=null;
                            usernames=new String[100];
                            if(!rs.isBeforeFirst()){
                                out.println("No Friends Yet!");
                            }
                            else{
                                while(rs.next()){
                                    if(un.equals(rs.getString(1))){
                                        usernames[count]=rs.getString(2);
                                        count=count+1;
                                    }
                                    if(un.equals(rs.getString(2))){
                                        usernames[count]=rs.getString(1);
                                        count=count+1;
                                    }
                                }
                            }
                            
                            int j;
                            for(j=0;j<count; j++){
                                ps=con.prepareStatement("select first_name, last_name, gender, cur_location from Userdata where username=?");
                                ps.setString(1, usernames[j]);
                                rs=ps.executeQuery();
                                while(rs.next()){
                                    fname=rs.getString(1);
                                    lname=rs.getString(2);
                                    gender=rs.getString(3);
                                    location=rs.getString(4);
                                    PreparedStatement ps3=con.prepareStatement("select profile_pic from Profileimage where username=?");
                                    ps3.setString(1, usernames[j]);
                                    ResultSet rs3=ps3.executeQuery();
                                    imgDB64=null;
                                    while(rs3.next()){
                                        b1=rs3.getBlob(1);
                                        byte [] imgData=b1.getBytes(1,(int) b1.length());
                                        imgDB64=new String(Base64.getEncoder().encode(imgData));
                                    }
                                }
                                    out.println("<table width='755'>");
                                    if(imgDB64==null || imgDB64==""){
                                    out.write("<tr><td rowspan='2' width='70'><img style='border-radius: 50px;' src='vector.jpg' width='60' height='60' align='left'></td>");
                                }
                                else{
                                    out.write("<td rowspan='2' width='70'><img style='border-radius: 50px;' src='data:image/jpeg;base64,"+imgDB64+"' width='60' height='60' align='left'></td>");
                                }
                                out.println("<td><a style='color: black; text-decoration: none;' href='viewuserprofile.jsp?username="+usernames[j]+"'>"+fname+" "+lname+"</a></td></tr>");
                                out.write("<tr><td style='padding-right: 550px;'>"+gender+", "+location+"</td></tr><br/>");
                                
                            }
                            out.println("</table>");
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
