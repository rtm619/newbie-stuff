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
 * @author Reetam
 */
@WebServlet(urlPatterns = {"/addpost"})
@MultipartConfig(maxFileSize = 16177215)
public class addpost extends HttpServlet {

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
            Connection con;
            PreparedStatement ps;
            ResultSet rs; 
            InputStream is=null;
            String un=null;
            Part p;
            int postid=0;
            String post;
            post=request.getParameter("post");
            p=request.getPart("nfphoto");
            if(p.getSize()==0){
                is=null;
            }
            else{
                is=p.getInputStream();
            }
            try{
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/Honeycomb/web/db.accdb");
                ps=con.prepareStatement("select username from Session where login_status=1");
                rs=ps.executeQuery();
                while(rs.next()){
                    un=rs.getString(1);
                }
                ps=con.prepareStatement("insert into Newsfeed(username, post) values(?,?)");
                ps.setString(1, un);
                ps.setString(2, post);
                ps.executeUpdate();
                ps=con.prepareStatement("select max(post_id) from Newsfeed");
                rs=ps.executeQuery();
                while(rs.next()){
                    postid=rs.getInt(1);
                }
                ps=con.prepareStatement("insert into Newsfeedphotos(post_id, nfphoto) values(?,?)");
                if(is!=null){
                    ps.setInt(1, postid);
                    ps.setBlob(2, is);
                    ps.executeUpdate();
                }
                response.sendRedirect("newsfeed.jsp");
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
