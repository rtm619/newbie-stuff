<%-- 
    Document   : sendrequest
    Created on : 7 Apr, 2017, 7:16:55 PM
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
        <%!
            String un;
            String uname;
            Connection con;
            PreparedStatement ps;
            ResultSet rs;
        %>
        <%
            uname=request.getParameter("username");
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                ps=con.prepareStatement("select username from Session where login_status=1");
                rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("insert into Pendingrequests(username, sent_by_user) values(?,?)");
                ps.setString(1, uname);
                ps.setString(2, un);
                ps.executeUpdate();
                response.sendRedirect("profile.jsp?msg=Friend_Request_Sent");
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
