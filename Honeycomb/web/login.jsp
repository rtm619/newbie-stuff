<%-- 
    Document   : login
    Created on : 21 Mar, 2017, 2:54:17 PM
    Author     : Reetam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
           String un=request.getParameter("username");
           String pw=request.getParameter("password");
           try{
               Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
               Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
               PreparedStatement ps=con.prepareStatement("select password from Userlogin where username=?");
               ps.setString(1, un); 
               ResultSet rs=ps.executeQuery();
               if(!rs.isBeforeFirst()){
                   response.sendRedirect("login.html?msg=Username_does_not_exist");
               }
               while(rs.next()){
                   if(pw.equals(rs.getString(1))){
                       ps=con.prepareStatement("select username from Session");
                       ResultSet rs1=ps.executeQuery();
                       if(!rs1.isBeforeFirst()){
                            PreparedStatement ps1;
                            ps1=con.prepareStatement("insert into Session(username, login_status) values(?,?)");
                            ps1.setString(1,un);
                            ps1.setInt(2, 1);
                            ps1=con.prepareStatement("update Session set login_status=1 where username=?");
                            ps1.setString(1, un);
                            ps1.executeUpdate();
                            ps1.executeUpdate();
                            response.sendRedirect("profile.jsp");
                       }
                       int c=0;   
                       while(rs1.next()){
                            if(un.equals(rs1.getString(1))){
                                c=c+1;
                                PreparedStatement ps1;
                                ps1=con.prepareStatement("update Session set login_status=0");
                                ps1.executeUpdate();
                                ps1=con.prepareStatement("update Session set login_status=1 where username=?");
                                ps1.setString(1, un);
                                ps1.executeUpdate();
                                response.sendRedirect("profile.jsp");
                            }
                        }
                        if(c==0){
                            PreparedStatement ps1;
                            ps1=con.prepareStatement("update Session set login_status=0");
                            ps1.executeUpdate();
                            ps1=con.prepareStatement("insert into Session(username, login_status) values(?,?)");
                            ps1.setString(1,un);
                            ps1.setInt(2, 1);
                            ps1.executeUpdate();
                            ps1=con.prepareStatement("update Session set login_status=1 where username=?");
                            ps1.setString(1, un);
                            ps1.executeUpdate();
                            response.sendRedirect("profile.jsp");
                        }
                    }
                   else{
                       response.sendRedirect("login.html?msg=Incorrect_Password");
                   }
               }
               ps.close();
               con.close();
           }
           catch(Exception e){
               out.println(e);
           }
        %>    
    </body>
</html>