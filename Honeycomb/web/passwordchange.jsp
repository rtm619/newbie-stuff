<%-- 
    Document   : passwordchange
    Created on : 9 Apr, 2017, 9:12:45 PM
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
            String op=request.getParameter("oldpass");
            String np=request.getParameter("newpass");
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
                ps=con.prepareStatement("select password from Userlogin where username=?");
                ps.setString(1, un);
                rs=ps.executeQuery();
                while(rs.next()){
                    if(op.equals(rs.getString(1))){
                        ps=con.prepareStatement("update Userlogin set password=? where username=?");
                        ps.setString(1, np);
                        ps.setString(2, un);
                        ps.executeUpdate();
                        response.sendRedirect("profile.jsp?msg=Password_Changed");
                    }
                    else{
                        response.sendRedirect("password.jsp?msg=Entered_current_password_is_invalid");
                    }
                }
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
