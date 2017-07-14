<%-- 
    Document   : viewuserprofile
    Created on : 5 Apr, 2017, 8:31:54 PM
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
        String uname=null;
        String fname=null;
        String lname=null;
        String em=null;
        String gen=null;
        String loc=null;
        String rel=null;
        String abm=null;
        int requestid;
        int flag=0;
        int flag1=0;
        int flag2=0;
        int flag3=0;
        Blob b=null;
        String imgDataBase64=null;
        Blob b1=null;
        String imgDB64=null;
        int day, month, year;
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
                    <table style="height: 350px;">
                    <h2>
                        <th style="font-size: 25px; padding-top: 5px; padding-left: -20px;" colspan="2" bgcolor="orange">Profile Information</th>
                    </h2>
                    <%
                        uname=request.getParameter("username");
                        try{
                            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                            con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                            ps=con.prepareStatement("select first_name, last_name, email, gender, cur_location, birth_date, birth_month, birth_year, reln_status, about_me from Userdata where username=?");
                            ps.setString(1, uname);
                            rs=ps.executeQuery();
                            while(rs.next()){
                                fname=rs.getString(1);
                                lname=rs.getString(2);
                                em=rs.getString(3);
                                gen=rs.getString(4);
                                loc=rs.getString(5);
                                day=rs.getInt(6);
                                month=rs.getInt(7);
                                year=rs.getInt(8);
                                rel=rs.getString(9);
                                abm=rs.getString(10); 
                            }
                            ps=con.prepareStatement("select profile_pic from Profileimage where username=?");
                            ps.setString(1, uname);
                            rs=ps.executeQuery();
                            imgDB64=null; 
                            while(rs.next()){
                                b1=rs.getBlob(1);
                                byte [] imgData=null;
                                imgData=b1.getBytes(1,(int) b1.length());
                                imgDB64=new String(Base64.getEncoder().encode(imgData));
                            }
                            ps=con.prepareStatement("select pair_id from Friendspair where user1=? AND user2=?");
                            ps.setString(1, un);
                            ps.setString(2, uname);
                            rs=ps.executeQuery();
                            if(!rs.isBeforeFirst()){
                                flag=1;
                            }
                            else{
                                flag=0;
                            }
                            ps=con.prepareStatement("select pair_id from Friendspair where user1=? AND user2=?");
                            ps.setString(1, uname);
                            ps.setString(2, un);
                            rs=ps.executeQuery();
                            if(!rs.isBeforeFirst()){
                                flag1=1;
                            }
                            else{
                                flag1=0;
                            }
                            ps=con.prepareStatement("select request_id from Pendingrequests where sent_by_user=? and username=?");
                            ps.setString(1, un);
                            ps.setString(2, uname);
                            rs=ps.executeQuery();
                            if(!rs.isBeforeFirst()){
                                flag2=1;
                            }
                            else{
                                flag2=0;
                            }
                            ps=con.prepareStatement("select request_id from Pendingrequests where sent_by_user=? and username=?");
                            ps.setString(1, uname);
                            ps.setString(2, un);
                            rs=ps.executeQuery();
                            if(!rs.isBeforeFirst()){
                                flag3=1;
                            }
                            else{
                                flag3=2;
                                while(rs.next()){
                                    requestid=rs.getInt(1);
                                }
                            }
                        }
                        catch(Exception e){
                            out.println(e);
                        }
                    %>
                    <%
                        out.println("<tr><td>");
                        out.println("Name:- "+fname+" "+lname+"<br></td>");
                        out.println("<td rowspan='7' align='right' style='padding-left: 50px;'>");
                        if(imgDB64==null || imgDB64==""){
                            out.write("<img src='vector.jpg' width='280' height='280' style='border: 7px solid white; border-radius: 20px;'>");
                        }
                        else{
                            out.write("<img src='data:image/jpeg;base64,"+imgDB64+"' width='280' height='280' style='border: 7px solid white; border-radius: 20px;'>");
                        }
                        out.println("</td></tr>");
                        out.println("<tr><td>Email:- "+em+"<br></td></tr>");
                        out.println("<tr><td>Date of Birth:- "+day+" - "+month+" - "+year+"<br></td></tr>"); 
                        out.println("<tr><td>Gender:- "+gen+"<br></td></tr>");
                        out.println("<tr><td>Current Location:- "+loc+"<br></td></tr>"); 
                        out.println("<tr><td>Relationship Status:- "+rel+"<br></td></tr>");
                        out.println("<tr><td width='400'>About Me:- "+abm+"<br></td></tr>");
                        out.println("</table>");
                        out.println("<table><tr><td align='center'>");
                        if(uname.equals(un) || flag==0 || flag1==0 || flag2==0 || flag3==0){
                            out.println("");
                        }
                        else if(flag3==2){
                            out.println("<form action='acceptrequest.jsp' method='post'>");
                            out.println("<input type='hidden' name='username' value='"+uname+"'>");
                            out.println("<input type='hidden' name='requestid' value='"+requestid+"'>");
                            out.println("<input type='submit' name='submit' value='Accept Friend Request' style='font-size: 29px; width: 250px;'></form>");
                            out.println("<form action='rejectrequest.jsp' method='post'>");
                            out.println("<input type='hidden' name='requestid' value='"+requestid+"'>");
                            out.println("<input type='submit' name='submit' value='Reject Friend Request' style='font-size: 29px; width: 250px;'></form>");
                        }
                        else{
                            out.println("<form action='sendrequest.jsp' method='post'>");
                            out.println("<input type='hidden' name='username' value='"+uname+"'>");
                            out.println("<input type='submit' name='submit' value='Send Friend Request' style='font-size: 30px; width: 240px;'></form>");
                        }
                        out.println("</td></tr></table>");
                    %>
                    </table>
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