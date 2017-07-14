<%-- 
    Document   : addcomment
    Created on : 7 Apr, 2017, 5:54:54 PM
    Author     : Reetam
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
            int postid;
            String tempid;
            String un;
            String comment;
            Connection con;
            PreparedStatement ps;
            ResultSet rs;
        %>
        <%
            tempid=request.getParameter("postid");
            postid=Integer.parseInt(tempid);
            comment=request.getParameter("comment");
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                ps=con.prepareStatement("select username from Session where login_status=1");
                rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("insert into Postcomments(post_id, username, comment) values(?,?,?)");
                ps.setInt(1, postid);
                ps.setString(2, un);
                ps.setString(3, comment);
                ps.executeUpdate();
                response.sendRedirect("comments.jsp?msg=Comment_Added&postid="+postid);
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
