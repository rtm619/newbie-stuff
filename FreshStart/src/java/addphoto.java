/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.InputStream;
import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author user
 */
@WebServlet(urlPatterns = {"/addphoto"})
@MultipartConfig(maxFileSize = 16177215)
public class addphoto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            Connection con=null;
            PreparedStatement ps=null;
            InputStream is=null;
            String un=null;
            Part p=request.getPart("img");
            if(p!=null){
                is=p.getInputStream();
            }
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                ps=con.prepareStatement("select username from session where login_status=1");
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("insert into photos(username,photo) values (?,?)");
                if(is!=null){
                    ps.setString(1, un);
                    ps.setBlob(2, is);
                }
                int i=ps.executeUpdate();
                if(i>0){
                    response.sendRedirect("Photos.jsp?msg=Picture successfully saved");
                }
                else{
                    response.sendRedirect("Photos.jsp?msg=Cannot save Picture");
                }
                ps.close();
                con.close();
             }
             catch(Exception e){
                 PrintWriter out=response.getWriter();
                 out.println(e);
             }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
