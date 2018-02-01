<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SignIn</title>
    </head>
    <body>
        <%!
            Connection con=null; //initialization of jdbc elements
            PreparedStatement ps=null;
            ResultSet rs=null;
        %>
        <%
            String un=request.getParameter("username"); //fetch data from http request in signin html page
            String pass=request.getParameter("password");//same  as above
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver"); //State the jdbc driver name
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb"); //make connection to the database
                ps=con.prepareStatement("select password from Userdata where username=?"); //input SQL query to search for password saved inside database where the username matches the username inputed in the form
                ps.setString(1, un); //you put the value of un in the place where the ? was in the query (un is taken from http request, look above)
                rs=ps.executeQuery(); //execute your query and save the result in the resultset element
                if(!rs.isBeforeFirst()) //isBeforeFirst means if the resultset pointer doesn't point to any row (means resultset is empty and no such user exists)
                {
                    response.sendRedirect("login.html?msg=User not found!"); //if no user is found, we redirect back to the login page
                }
                while(rs.next()) //if we have a result row in the resultset, we ignore the if statement and come here (next function goes through each row of resultset in each iteration)
                {
                    if(pass.equals(rs.getString(1))) //getString(1) means getting the value of the 1st column of the row returned by the resultset, which is the password coulumn as selected in the query. Pass variable was taken from the http request and it is checked with the password stored in the database to see if they are the same
                    {
                        ps=con.prepareStatement("update session set login_status=1 where username=?"); //This is a flag in the database which sets to 1 when user logs in to retain session. 
                        ps.setString(1, un);
                        ps.executeUpdate();
                        response.sendRedirect("Profiles.jsp?msg=login succeeded"); //redirects to profile page
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
