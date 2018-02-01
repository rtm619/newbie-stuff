<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Profile JSP</title>
    </head>
    <body>
        <%!
            String un=null;
        %>
        <%
            String fn=request.getParameter("fname");
            String ln=request.getParameter("lname");
            String bd=request.getParameter("dateofbirth");
            String gen=request.getParameter("gender");
            String mob=request.getParameter("mobile");
            String loc=request.getParameter("location");
            String rel=request.getParameter("relationship");
            String bio=request.getParameter("abm");
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                PreparedStatement ps=con.prepareStatement("select username from session where login_status=1");
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("update Userdata set first_name=?,last_name=?,date_of_birth=?,gender=?,contact_number=?,location=?,relationship_status=?,about_me=? where username=?");
                ps.setString(1, fn);
                ps.setString(2, ln);
                ps.setString(3, bd);
                ps.setString(4, gen);
                ps.setString(5, mob);
                ps.setString(6, loc);
                ps.setString(7, rel);
                ps.setString(8, bio);
                ps.setString(9, un);
                int i=ps.executeUpdate();
                if(i!=0)
                {
                 response.sendRedirect("Profiles.jsp?msg=Edit Complete");
                }
                else
                {
                    response.sendRedirect("EditProfile.jsp?msg=Edit Incomplete");
                } 
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>    
    </body>
</html>
