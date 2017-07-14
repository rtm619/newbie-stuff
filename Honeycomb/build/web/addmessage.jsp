<%-- 
    Document   : addmessage
    Created on : 11 Apr, 2017, 9:15:49 PM
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
            String uname=request.getParameter("username");
            String message=request.getParameter("message");
            int pairid=Integer.parseInt(request.getParameter("pairid"));
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
                ps=con.prepareStatement("insert into Messages(pair_id, message, sent_by) values(?,?,?)");
                ps.setInt(1, pairid);
                ps.setString(2, message);
                ps.setString(3, un);
                ps.executeUpdate();
                response.sendRedirect("messages.jsp?pairid="+pairid+"&username="+uname);
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
