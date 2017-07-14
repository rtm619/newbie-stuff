<%-- 
    Document   : profilesetup
    Created on : 9 Apr, 2017, 8:36:45 PM
    Author     : Reetam
--%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String un=null;
            String fn=request.getParameter("fname");
            String ln=request.getParameter("lname");
            String em=request.getParameter("email");
            String loc=request.getParameter("location");
            String rel=request.getParameter("Relationship");
            String abm=request.getParameter("aboutme");
            int day=Integer.parseInt(request.getParameter("Day"));
            int month=Integer.parseInt(request.getParameter("Month")); 
            int year=Integer.parseInt(request.getParameter("Year"));
            Connection con;
            PreparedStatement ps;
            ResultSet rs;
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                ps=con.prepareStatement("select username from Session where login_status=1");
                rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("update Userdata set first_name=?, last_name=?, email=?, cur_location=?, reln_status=?, about_me=?, birth_date=?, birth_month=?, birth_year=? where username=?");
                ps.setString(1, fn);
                ps.setString(2, ln);
                ps.setString(3, em);
                ps.setString(4, loc);
                ps.setString(5, rel);
                ps.setString(6, abm);
                ps.setInt(7, day);
                ps.setInt(8, month);
                ps.setInt(9, year);
                ps.setString(10,un);
                int i=ps.executeUpdate();
                if(i!=0){
                    response.sendRedirect("profile.jsp?msg=Profile_Edited");
                }
                else{
                    response.sendRedirect("editprofile.jsp?msg=Profile_Edit_Failed");
                }
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
