<%-- 
    Document   : logout
    Created on : 3 Apr, 2017, 10:28:41 PM
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
        <%
            String un=null;
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                PreparedStatement ps=con.prepareStatement("select username from Session where login_status=1");
                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("delete from Session where username=?");
                ps.setString(1, un);
                int i=ps.executeUpdate();
                if(i!=0){
                    response.sendRedirect("login.html?msg=Successfully_Signed_Out");
                }
                else{
                    response.sendRedirect("profile.jsp?msg=Signout_Unsuccessful");
                }
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
