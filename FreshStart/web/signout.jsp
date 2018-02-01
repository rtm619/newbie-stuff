<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="./css/style.css"/>
        <title>Sign Out</title>
    </head>
    <body>
        <%!
            String un=null;
        %>
        <%
             try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                PreparedStatement ps=con.prepareStatement("select username from session where login_status=1");
                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("update session set login_status=0 where username=?");
                ps.setString(1, un);
                int i=ps.executeUpdate();
                if(i!=0){
                response.sendRedirect("login.html?msg=Successfully Signed Out");
                }
                else{
                    response.sendRedirect("Profile.jsp?msg=Problem signing out");
                }
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
