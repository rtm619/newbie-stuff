<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>password</title>
    </head>
    <body>
        <%!
            String un=null;
            String op=null;
            String np=null;
            Connection con=null;
            PreparedStatement ps=null;
            ResultSet rs=null;
        %>
        <%
            op=request.getParameter("oldpass");
            np=request.getParameter("newpass");
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                ps=con.prepareStatement("select username from session where login_status=1");
                rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("select password from Userdata where username=?");
                ps.setString(1,un);
                rs=ps.executeQuery();
                while(rs.next()){
                    if(op.equals(rs.getString(1))){
                        ps=con.prepareStatement("update Userdata set password=? where username=?");
                        ps.setString(1, np);
                        ps.setString(2, un);
                        ps.executeUpdate();
                        response.sendRedirect("Profiles.jsp?msg=Password Changed!");
                    }
                    else{
                        response.sendRedirect("password change.jsp?msg=Invalid Old Password!");
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
