package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.Base64;

public final class EditProfile_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


                String un;
                String fn;
                String ln;
                String imgDataBase64;
            
  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n");
      out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\">\n");
      out.write("<head>\n");
      out.write("<title>SocialNet</title>\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n");
      out.write("<link href=\"style.css\" rel=\"stylesheet\" type=\"text/css\" />\n");
      out.write("<script type=\"text/javascript\" src=\"js/jquery-1.3.2.min.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"js/script.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"js/cufon-yui.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"js/arial.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"js/cuf_run.js\"></script>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("<div class=\"main\">\n");
      out.write("  <div class=\"main_resize\">\n");
      out.write("    <div class=\"header\">\n");
      out.write("      <div class=\"logo\">\n");
      out.write("        <h1><a href=\"#\"><span>Social</span>Blog<small>Simple social blog</small></a></h1>\n");
      out.write("      </div>\n");
      out.write("      <div class=\"search\">\n");
      out.write("        <form method=\"post\" id=\"search\" action=\"search.jsp\">\n");
      out.write("          <span>\n");
      out.write("          <input type=\"text\" value=\"Search Users...\" name=\"search\" id=\"s\" />\n");
      out.write("          <input name=\"searchsubmit\" type=\"image\" src=\"images/search.gif\" value=\"Go\" id=\"searchsubmit\" class=\"btn\"  />\n");
      out.write("          </span>\n");
      out.write("        </form>\n");
      out.write("        <!--/searchform -->\n");
      out.write("        <div class=\"clr\"></div>\n");
      out.write("      </div>\n");
      out.write("      <div class=\"clr\"></div>\n");
      out.write("      <div class=\"menu_nav\">\n");
      out.write("        <ul>\n");
      out.write("          <li class=\"active\"><a href=\"#\">Home</a></li>\n");
      out.write("          <li><a href=\"signout.jsp\" onclick=\"return confirm('Are you sure you want to Sign Out?');\">Sign Out</a></li>\n");
      out.write("        </ul>\n");
      out.write("        <div class=\"clr\"></div>\n");
      out.write("      </div>\n");
      out.write("      <div class=\"hbg\"><img src=\"images/header_images.jpg\" width=\"923\" height=\"291\" alt=\"\" /></div>\n");
      out.write("    </div>\n");
      out.write("    <div class=\"content\">\n");
      out.write("      <div class=\"content_bg\">\n");
      out.write("        <div class=\"mainbar\">\n");
      out.write("            <h2><span>Edit Your Profile</span></h2>\n");
      out.write("            <div class='article'>\n");
      out.write("                <form action=\"profilesetup.jsp\" method=\"post\">\n");
      out.write("                    <h3>First Name:</h3> <input type=\"text\" name=\"fname\" ></input><br></br>\n");
      out.write("                    <h3>Last Name:</h3> <input type=\"text\" name=\"lname\" ></input><br></br>\n");
      out.write("                    <h3>Date of Birth:</h3> <input type=\"text\" name=\"dateofbirth\" ></input><br></br>\n");
      out.write("                    <h3>Gender:</h3>\n");
      out.write("                    <h4><input type=\"radio\" name=\"gender\" value=\"Male\" checked=\"checked\"></input> Male</h4>\n");
      out.write("                    <h4><input type=\"radio\" name=\"gender\" value=\"Female\"></input> Female</h4><br></br>\n");
      out.write("                    <h3>Mobile Number:</h3> <input type=\"text\" name=\"mobile\" ></input><br></br>\n");
      out.write("                    <h3>Current Location:</h3> <input type=\"text\" name=\"location\" ></input><br></br>\n");
      out.write("                    <h3>Relationship Status:</h3>\n");
      out.write("                    <h4><input type=\"radio\" name=\"relationship\" value=\"Single\" checked=\"checked\"></input> Single</h4>\n");
      out.write("                    <h4><input type=\"radio\" name=\"relationship\" value=\"In a Relationship\"></input> In a Relationship</h4>\n");
      out.write("                    <h4><input type=\"radio\" name=\"relationship\" value=\"Married\"></input> Married</h4>\n");
      out.write("                    <h4><input type=\"radio\" name=\"relationship\" value=\"Divorced\"></input> Divorced</h4><br></br>\n");
      out.write("                    <h3>Write your bio: </h3>\n");
      out.write("                    <textarea name=\"abm\" rows=\"3\" cols=\"50\">About Me...</textarea><br></br>\n");
      out.write("                    <input type=\"submit\" name=\"submit\" value=\"Submit\"></input><br></br>    \n");
      out.write("                </form>\n");
      out.write("                <div class='clr'></div>\n");
      out.write("            </div>\n");
      out.write("            ");
      out.write("\n");
      out.write("        </div>\n");
      out.write("        <div class=\"sidebar\">\n");
      out.write("            ");

                try{
                    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                    Connection con=DriverManager.getConnection("jdbc:ucanaccess://C:/Users/Reetam/Documents/NetBeansProjects/FreshStart/web/userdata.accdb");
                    PreparedStatement ps=con.prepareStatement("select username from session where login_status=1");
                    ResultSet rs=ps.executeQuery();
                    while(rs.next()){
                        un=rs.getString(1);
                    }
                    ps=con.prepareStatement("select first_name, last_name,profile_img_location from Userdata where username=?");
                    ps.setString(1, un);
                    rs=ps.executeQuery();
                    while(rs.next()){
                        fn=rs.getString(1);
                        ln=rs.getString(2);
                        Blob b=rs.getBlob(3);
                        byte [] imgData=null;
                        imgData=b.getBytes(1,(int) b.length());
                        imgDataBase64=new String(Base64.getEncoder().encode(imgData));
                    }
                }
                catch(Exception e){
                    out.println(e);
                }
            
      out.write("\n");
      out.write("\t\t  <div class=\"gadget\">\n");
      out.write("                      <h2 class=\"star\"><span>Hi, </span>");
out.print(fn+" "+ln); 
      out.write(" </h2>\n");
      out.write("                  <img src=\"data:image/jpeg;base64,");
      out.print(imgDataBase64 );
      out.write("\" alt=\"profile picture not available\" width=\"100\" height=\"100\"></img>\n");
      out.write("\t\t  </div>\n");
      out.write("          <div class=\"gadget\">\n");
      out.write("            <h2 class=\"star\"><span>Profile</span> Menu</h2>\n");
      out.write("            <div class=\"clr\"></div>\n");
      out.write("            <ul class=\"sb_menu\">\n");
      out.write("              <li><a href=\"Profiles.jsp\">Profile</a></li>\n");
      out.write("              <li><a href=\"Timelines.jsp\">Timeline</a></li>\n");
      out.write("              <li><a href=\"Photos.jsp\">Photos</a></li>\n");
      out.write("              <li class=\"active\"><a href=\"EditProfile.jsp\">Edit Profile</a></li>\n");
      out.write("              <li><a href=\"EditProfilePic.jsp\">Change Profile Picture</a></li>\n");
      out.write("              <li><a href=\"password change.jsp\">Change Password</a></li>\n");
      out.write("            </ul>\n");
      out.write("          </div>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"clr\"></div>\n");
      out.write("      </div>\n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("  <div class=\"fbg\">\n");
      out.write("    <div class=\"fbg_resize\">\n");
      out.write("      <div class=\"col c1\">\n");
      out.write("        <h2><span>The Devs</span></h2>\n");
      out.write("        <a href=\"#\"><img src=\"images/pic_1.jpg\" width=\"58\" height=\"58\" alt=\"\" /></a> <a href=\"#\"><img src=\"images/pic_2.jpg\" width=\"58\" height=\"58\" alt=\"\" /></a> <a href=\"#\"><img src=\"images/pic_3.jpg\" width=\"58\" height=\"58\" alt=\"\" /></a> <a href=\"#\"><img src=\"images/pic_4.jpg\" width=\"58\" height=\"58\" alt=\"\" /></a> <a href=\"#\"><img src=\"images/pic_5.jpg\" width=\"58\" height=\"58\" alt=\"\" /></a> <a href=\"#\"><img src=\"images/pic_6.jpg\" width=\"58\" height=\"58\" alt=\"\" /></a> </div>\n");
      out.write("      <div class=\"col c2\">\n");
      out.write("        <h2><span>About Website</span></h2>\n");
      out.write("        <p>SocialBlog is an initiative proposed by the devs to help with the communication among college classmates. Although this site is still in its initial phases, we are trying our best to include more exciting features to make it more user friendly.</p>\n");
      out.write("      </div>\n");
      out.write("      <div class=\"col c3\">\n");
      out.write("        <h2><span>Inspirations</span></h2>\n");
      out.write("        <p>Reetam Chatterjee<br>Sambuddha Ghosh<br>Saswata Dasgupta<br>Sayak Chatterjee<br>Subhadeep Chowdhury</p>\n");
      out.write("      </div>\n");
      out.write("      <div class=\"clr\"></div>\n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("</div>\n");
      out.write("<div class=\"footer\">\n");
      out.write("  <div class=\"footer_resize\">\n");
      out.write("    <p class=\"lf\">Copyright &copy; NetbeansHost. All Rights Reserved</p>\n");
      out.write("    <p class=\"rf\">Design by Netbeans</p>\n");
      out.write("    <div class=\"clr\"></div>\n");
      out.write("  </div>\n");
      out.write("</div>\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
