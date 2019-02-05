package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class Admin_005fLogin_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("\n");
      out.write("        <!-- Bootstrap -->\n");
      out.write("        <link href=\"bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <script src=\"JS/jquery-1.11.3.js\"></script>\n");
      out.write("        <script src=\"bootstrap/js/bootstrap.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <style type=\"text/css\">\n");
      out.write("\n");
      out.write("            #loginDiv{\n");
      out.write("                margin-top: 20px;\n");
      out.write("                box-shadow: 0 0 6px 1px #245269;\n");
      out.write("                margin-left: calc;\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            #loginButton{\n");
      out.write("                float: right;\n");
      out.write("                margin-right: 20px;\n");
      out.write("\n");
      out.write("            }\n");
      out.write("            #forgottenPassword{\n");
      out.write("                border: none;\n");
      out.write("                background: none;\n");
      out.write("                color: #269abc\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("        </style>\n");
      out.write("\n");
      out.write("        <title>Admin Login</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            Cookie[] cookies = request.getCookies();

            for (Cookie co : cookies) {
                if (co.getName().equals("admin")) {
                    out.write(co.getValue());
                    HttpSession session1 = request.getSession();
                    session1.setAttribute("admin", (POJOs.AdminDetails) new classess.tools().getAdmin(co.getValue()));

                    response.sendRedirect("AdminHome.jsp");

                }

            }


        
      out.write("\n");
      out.write("\n");
      out.write("        <div class=\"container-fluid\">\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-md-3\"></div>\n");
      out.write("                <div class=\"col-md-6\">\n");
      out.write("\n");
      out.write("                    ");
                        if (request.getParameter("msg") != null) {
                            if (request.getParameter("msg").equals("User Name or Password Incorrect")) {
                                String message = request.getParameter("msg").toString();
                    
      out.write("\n");
      out.write("                    <div class=\"alert alert-danger\"><a class=\"close\" data-dismiss=\"alert\" >&times;</a>");
      out.print(message);
      out.write("</div>\n");
      out.write("                    ");

                            }

                        }

                    
      out.write("\n");
      out.write("                    <div id=\"loginDiv\" class=\"panel panel-success\">\n");
      out.write("                        <div  class=\"panel panel-heading\"><h4>Admin Login</h4></div>\n");
      out.write("                        <div class=\"panel panel-body\">\n");
      out.write("                            <form class=\"form-horizontal\" action=\"adminLogin\" method=\"post\">\n");
      out.write("                                <div class=\"form-group\">\n");
      out.write("                                    <label class=\"control-label col-sm-2\" for=\"email\">Email:</label>\n");
      out.write("                                    <div class=\"col-sm-10\">\n");
      out.write("                                        <input type=\"email\" class=\"form-control\" id=\"email\" name=\"userName\" placeholder=\"Enter email\" required>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                                <div class=\"form-group\">\n");
      out.write("                                    <label class=\"control-label col-sm-2\" for=\"pwd\">Password:</label>\n");
      out.write("                                    <div class=\"col-sm-10\"> \n");
      out.write("                                        <input type=\"password\" class=\"form-control\" id=\"pwd\" name=\"password\" placeholder=\"Enter password\" required >\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                                <div class=\"form-group\"> \n");
      out.write("                                    <div class=\"col-sm-offset-2 col-sm-10\">\n");
      out.write("                                        <div class=\"checkbox\">\n");
      out.write("                                            <label><input type=\"checkbox\" name=\"remember\"> Remember me</label>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                                <div class=\"form-group\"> \n");
      out.write("                                    <aside id=\"loginButton\">\n");
      out.write("                                        <button type=\"submit\" class=\"btn btn-primary\">Login</button>\n");
      out.write("                                    </aside>\n");
      out.write("                                </div>\n");
      out.write("                            </form>\n");
      out.write("                            \n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-3\"></div>\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("            <center>\n");
      out.write("                <div class=\"row\">\n");
      out.write("                    <div  class=\"col-md-5 center-block\">\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </center>\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
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
