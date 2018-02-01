<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
            Connection con=null; //initialization of jdbc elements
            PreparedStatement ps=null;
            ResultSet rs=null;
        %>
        <%
            String un=request.getParameter("username"); //fetch data from http request in signin html page
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver"); //State the jdbc driver name
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb"); //make connection to the database
                ps=con.prepareStatement("create table "+un+"(friendname varchar2(30), primary key(friendname))" ); //input SQL query to search for password saved inside database where the username matches the username inputed in the form
                ps.executeUpdate();
                ps=con.prepareStatement("SELECT MSysObjects.Name AS table_name FROM MSysObjects WHERE (((Left([Name],1))<>'~') AND ((Left([Name],4))<>'MSys') AND ((MSysObjects.Type) In (1,4,6)) AND ((MSysObjects.Flags)=0)) order by MSysObjects.Name");
                rs=ps.executeQuery();
                while(rs.next()){
                    out.write(rs.getString(1)+"\n");
                }
                con.close();
                
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </body>
</html>
