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
            int postid;
            String un;
            String tempid;
            String comm;
        %>
        <%
            comm=request.getParameter("comm");
            tempid=request.getParameter("id");
            postid=Integer.parseInt(tempid);
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                PreparedStatement ps=con.prepareStatement("select username from session where login_status=1");
                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("insert into comments(username,comment,post_id) values (?,?,?)");
                ps.setString(1,un);
                ps.setString(2,comm);
                ps.setInt(3, postid);
                ps.executeUpdate();
                response.sendRedirect("comments.jsp?msg=Comment Added&id="+postid);
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }    
        %>
    </body>
</html>
