<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Feeder</title>
    </head>
    <body>
        <%!
            int likes;
            String tempid;
            int postid;
        %>
        <%
            tempid=request.getParameter("id");
            postid=Integer.parseInt(tempid);
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                PreparedStatement ps=con.prepareStatement("select likes from timeline where id=?");
                ps.setInt(1, postid);
                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                    likes=rs.getInt(1);
                }
                likes=likes+1;
                ps=con.prepareStatement("update timeline set likes=? where id=?");
                ps.setInt(1,likes);
                ps.setInt(2,postid);
                ps.executeUpdate();
                response.sendRedirect("Timelines.jsp?msg=Liked Post");
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }    
        %>
    </body>
</html>
