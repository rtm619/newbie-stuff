<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
    </head>
    <body>
        <%
            String un=request.getParameter("username"); //get variable values from http request
            String fn=request.getParameter("fname");
            String ln=request.getParameter("lname");
            String emid=request.getParameter("email");
            String pass=request.getParameter("password");
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver"); //set name of jdbc driver
                Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb"); //make connection to the database
                PreparedStatement ps=con.prepareStatement("select username from Userdata"); //get all the usernames stored in the database
                ResultSet rs=ps.executeQuery(); 
                while(rs.next()){ //goes through each row in the resultset, which is each username since there is only one column selected
                    if(un.equals(rs.getString(1))){ //if the username given in registration is already present in the database,
                        out.write("<script type='text/javascript'>");
                        out.write("alert('Username already exists');"); //give an alert via javascript
                        out.write("</script>");
                        response.sendRedirect("index.html?msg=Registration incomplete"); //redirect to registration page again
                    }
                } //if this block doesn't execute, then the username doesn't exist in the database and the following code is taken
                ps=con.prepareStatement("insert into Userdata (username,first_name,last_name,email,password) values(?,?,?,?,?)"); //we input the data given in the registration form into the database
                ps.setString(1,un); //un value taken above replaces the first ? in the query
                ps.setString(2,fn); //fn value taken above replaces the second ? in the query
                ps.setString(3,ln); //so on
                ps.setString(4,emid);
                ps.setString(5,pass);
                int i=ps.executeUpdate(); //since we are inputing data or updating data in the database, we use executeUpdate() function
                ps=con.prepareStatement("insert into session (username) values (?)"); //there is a session table that takes in flags to retain user session, 1 for logged in, 0 (default) for logged out. We input our new user's username to keep track of his session
                ps.setString(1, un);
                int j=ps.executeUpdate();
                if((i!=0)&&(j!=0)) //if both queries execute perfectly, then 1 is returned in the variables i and j, so if i and j are not equal to 0, then that means registration was successful
                {
                    response.sendRedirect("login.html?msg=Registration Complete"); //redirect to login for user to login with his newly made id
                }
                else
                {
                    response.sendRedirect("index.html?msg=Registration Incomplete"); //if queries are not executed properly, then registration remains incomplete and the user is redirected back to the page.
                }
                con.close();
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
