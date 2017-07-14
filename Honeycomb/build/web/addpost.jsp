<%-- 
    Document   : addpost
    Created on : 6 Apr, 2017, 3:02:54 PM
    Author     : Reetam
--%>

<%@page import="java.io.*"%>
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
            Connection con;
            PreparedStatement ps;
            ResultSet rs; 
            InputStream is=null;
            String un=null;
            Part p=null;
            int postid;
            String post;
        %>
        <%
            post=request.getParameter("post");
            p=request.getPart("newsfeedphoto");
            if(p!=null){
                is=p.getInputStream();
            }
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                ps=con.prepareStatement("select username from Session where login_status=1");
                rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("insert into Newsfeed(username, post) values(?,?)");
                ps.setString(1, un);
                ps.setString(2, post);
                ps.executeUpdate();
                if(is!=null){
                    ps=con.prepareStatement("select max(post_id) from Newsfeed");
                    rs=ps.executeQuery();
                    while(rs.next()){
                        postid=rs.getInt(1);
                    }
                    ps=con.prepareStatement("insert into Newsfeedphotos(post_id,nfphoto) values(?,?)");
                    ps.setInt(1, postid);
                    ps.setBlob(2, is);
                }
                response.sendRedirect("newsfeed.jsp");
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
