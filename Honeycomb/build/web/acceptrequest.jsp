<%-- 
    Document   : acceptrequest
    Created on : 9 Apr, 2017, 9:42:13 PM
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
            int requestid=Integer.parseInt(request.getParameter("requestid"));
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
                ps=con.prepareStatement("insert into Friendspair(user1, user2) values(?,?)");
                ps.setString(1, un);
                ps.setString(2, uname);
                int i=ps.executeUpdate();
                if(i!=0){
                    ps=con.prepareStatement("delete from Pendingrequests where request_id=?");
                    ps.setInt(1, requestid);
                    ps.executeUpdate();
                    response.sendRedirect("friendrequests.jsp?msg=Request_accepted");
                }
                else{
                    response.sendRedirect("friendrequests.jsp?msg=Error_Accepting_Request");
                }
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
