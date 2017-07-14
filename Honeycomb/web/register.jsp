<%-- 
    Document   : register
    Created on : 21 Mar, 2017, 1:22:20 PM
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
            String fn=request.getParameter("fname");
            String ln=request.getParameter("lname");
            String pw=request.getParameter("password");
            String em=request.getParameter("email");
            String gen=request.getParameter("gender");
            int day=Integer.parseInt(request.getParameter("day"));
            int month=Integer.parseInt(request.getParameter("month"));
            int year=Integer.parseInt(request.getParameter("year"));
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                PreparedStatement ps=con.prepareStatement("select username from Userdata");
                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                    if(un.equals(rs.getString(1))){
                        response.sendRedirect("register.html?msg=Username_already_exists");
                    }
                }
                ps=con.prepareStatement("insert into Userdata(username, first_name, last_name, email, birth_date, birth_month, birth_year, gender) values(?,?,?,?,?,?,?,?)");
                ps.setString(1, un);
                ps.setString(2, fn);
                ps.setString(3, ln);
                ps.setString(4, em);
                ps.setInt(5, day);
                ps.setInt(6, month);
                ps.setInt(7, year);
                ps.setString(8, gen); 
                int i=ps.executeUpdate();
                ps=con.prepareStatement("insert into Userlogin(username,password) values(?,?)");
                ps.setString(1, un);
                ps.setString(2, pw);
                int j=ps.executeUpdate();
                if((i!=0)&&(j!=0)){
                    response.sendRedirect("login.html?msg=Registration_Complete");
                }
                else{
                    response.sendRedirect("register.html?msg=Registration_Incomplete_Please_Try_Again");
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
