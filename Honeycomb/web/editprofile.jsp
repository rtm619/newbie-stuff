<%-- 
    Document   : editprofile
    Created on : 9 Apr, 2017, 20:07:59 PM
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
        String em=null;
        String gen=null;
        String loc=null;
        String rel=null;
        String abm=null;
        int day, month, year;
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
                        try{
                            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                            con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                            ps=con.prepareStatement("select email, cur_location, birth_date, birth_month, birth_year, reln_status, about_me from Userdata where username=?");
                            ps.setString(1, un);
                            rs=ps.executeQuery();
                            while(rs.next()){
                                em=rs.getString(1);
                                loc=rs.getString(2);
                                day=rs.getInt(3);
                                month=rs.getInt(4);
                                year=rs.getInt(5);
                                rel=rs.getString(6);
                                abm=rs.getString(7);
                            }
                        }
                        catch(Exception e){
                            out.println(e);
                        }
                    %>
                    <form method="post" action="profilesetup.jsp">
                    <table width="793">
                        
				<th style="color: black; font-size: 30px; font-weight: normal;" colspan="4">Edit Profile</th>
				<tr>
					<td colspan="4"><hr/></td>
                                </tr>
				<tr>
                                    <td align="center" colspan="4">&ensp;&nbsp;&nbsp;<label>First Name</label> &nbsp; <input type="name" name="fname" value="<%=fn %>"></td>
				</tr>
				<tr>
                                    <td align="center" colspan="4">&ensp;&nbsp;&nbsp;<label>Last Name</label> &nbsp; <input type="name" name="lname" value="<%=ln %>"></td>
				</tr>
				<tr>
                                    <td align="left" colspan="4">&nbsp; &emsp;&emsp; &emsp;&emsp;&nbsp;&nbsp; &emsp;&emsp;&ensp;&nbsp;<label>Email</label> &nbsp; <input type="email" name="email" value="<%=em %>"></td>
				</tr>
				<tr>
                                    <td align="left" colspan="4"><label>&nbsp; &emsp;&emsp; &emsp;Current Location</label> &nbsp; <input type="name" name="location" value="<%=loc %>"></td>
				</tr>
				<tr>
                                    <td align="right" width="25%" style="padding-right: 8px;"><label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Birthday</label></td>
                                    <td align="right" width="20%"><select name="Day" >&nbsp;
                                        <option value="<%=day%>" selected data-default><%=day%></option>
					<option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                        <option value="25">25</option>
                                        <option value="26">26</option>
                                        <option value="27">27</option>
                                        <option value="28">28</option>
                                        <option value="29">29</option>
                                        <option value="30">30</option>
                                        <option value="31">31</option>
					</select>
				</td>
				<td align="center" width="20%">
                                    <select name="Month">
                                        <option value="<%=month%>" selected data-default><%=month%></option>
					<option value="01">January</option>
                                        <option value="02">February</option>
                                        <option value="03">March</option>
                                        <option value="04">April</option>
                                        <option value="05">May</option>
                                        <option value="06">June</option>
                                        <option value="07">July</option>
                                        <option value="08">August</option>
                                        <option value="09">September</option>
                                        <option value="10">October</option>
                                        <option value="11">November</option>
                                        <option value="12">December</option>
                                    </select>
				</td>
				<td align="left" width="35%">
                                    <select name="Year">
					<option value="<%=year%>" selected data-default><%=year%></option>
					<option value="1970">1970</option>
					<option value="1971">1971</option>
					<option value="1972">1972</option>
					<option value="1973">1973</option>
					<option value="1974">1974</option>
					<option value="1975">1975</option>
					<option value="1976">1976</option>
					<option value="1977">1977</option>
					<option value="1978">1978</option>
					<option value="1979">1979</option>
					<option value="1980">1980</option>
					<option value="1981">1981</option>
					<option value="1982">1982</option>
					<option value="1983">1983</option>
					<option value="1984">1984</option>
					<option value="1985">1985</option>
					<option value="1986">1986</option>
					<option value="1987">1987</option>
					<option value="1988">1988</option>
					<option value="1989">1989</option>
					<option value="1990">1990</option>
					<option value="1991">1991</option>
					<option value="1992">1992</option>
					<option value="1993">1993</option>
					<option value="1994">1994</option>
					<option value="1995">1995</option>
					<option value="1996">1996</option>
					<option value="1997">1997</option>
					<option value="1998">1998</option>
					<option value="1999">1999</option>
                                    </select>
                                </td>
               		    </tr>
                            <tr>
				<td align="right" width="25%" style="padding-right: 7px;"><label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Relationship Status</label></td>
				<td align="left" width="75%" colspan="3">
                                    <select name="Relationship">&nbsp;
                                        <option value="<%=rel%>" selected data-default><%=rel%></option>
                                        <option value="Single">Single</option>
                                        <option value="Married">Married</option>
                                        <option value="In a Relationship">In a Relationship</option>
                                        <option value="Complicated">Complicated</option>
                                        <option value="In an Open Relationship">In an Open Relationship</option>
                                        <option value="Divorced">Divorced</option>
                                        <option value="Widowed">Widowed</option>
                                    </select>
                                </td>
                            </tr>
				<tr>
                                    <td align="right" width="25%" style="padding-right: 7px;"><label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;About Me</label></td>
                                    <td colspan="3">
                                        <textarea name="aboutme"><%=abm%></textarea>
                                    </td>
				</tr>
				<tr>
                                    <td align="center" colspan="4">
					<input type="submit" name="submit" value="Save Changes" onclick="return confirm('Are you sure you want to modify your Profile?');">
                                    </td>
				</tr>
			</table>
                    </form>
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
