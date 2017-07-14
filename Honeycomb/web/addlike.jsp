<%-- 
    Document   : addlike
    Created on : 4 Apr, 2017, 9:20:13 PM
    Author     : Reetam
--%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Honeycomb</title>
    </head>
    <body>
        <%!
            int like;
            String tempid;
            int postid;
        %>
        <%
            tempid=request.getParameter("postid");
            postid=Integer.parseInt(tempid);
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                PreparedStatement ps=con.prepareStatement("select likes from Newsfeed where post_id=?");
                ps.setInt(1,postid);
                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                    like=rs.getInt(1);
                }
                like=like+1;
                ps=con.prepareStatement("update Newsfeed set likes=? where post_id=?");
                ps.setInt(1, like);
                ps.setInt(2, postid);
                ps.executeUpdate();
                response.sendRedirect("newsfeed.jsp");
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
