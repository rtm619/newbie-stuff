<%-- 
    Document   : rejectrequest
    Created on : 9 Apr, 2017, 9:42:39 PM
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
            int requestid=Integer.parseInt(request.getParameter("requestid"));
            Connection con;
            PreparedStatement ps;
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                ps=con.prepareStatement("delete from Pendingrequests where request_id=?");
                ps.setInt(1, requestid);
                int i=ps.executeUpdate();
                if(i!=0){
                    response.sendRedirect("friendrequests.jsp?msg=Request_Removed");
                }
                else{
                    response.sendRedirect("friendrequests.jsp?msg=Cannot_delete_request");
                }
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
