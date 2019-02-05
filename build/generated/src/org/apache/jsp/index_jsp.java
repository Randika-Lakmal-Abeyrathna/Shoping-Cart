package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(1);
    _jspx_dependants.add("/Footer.jsp");
  }

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
      out.write("        <title>Login Page</title>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width\">\n");
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
      out.write("                box-shadow: 0 0 6px 1px #245269;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            #loginButton{\n");
      out.write("                float: right;\n");
      out.write("                margin-right: 20px;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("        </style>\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("            $(document).ready(function() {\n");
      out.write("                $('.carousel').carousel({\n");
      out.write("                    interval: 3200\n");
      out.write("                })\n");
      out.write("            });\n");
      out.write("            function check() {\n");
      out.write("\n");
      out.write("                $.ajax({\n");
      out.write("                    url: \"\",\n");
      out.write("                    type: 'POST',\n");
      out.write("                    data: {\n");
      out.write("                        text: \"Randika\",\n");
      out.write("                    },\n");
      out.write("                    success: function(data, textStatus, jqXHR) {\n");
      out.write("                        alert(data);\n");
      out.write("                    },\n");
      out.write("                    error: function(jqXHR, textStatus, errorThrown) {\n");
      out.write("                        alert(jqXHR);\n");
      out.write("                    }\n");
      out.write("\n");
      out.write("                });\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        ");

            Cookie[] cookies = request.getCookies();

            for (Cookie co : cookies) {
                if (co.getName().equals("username")) {

                    if (co.getValue() != null) {
                        if (new classess.tools().checkUserExist(co.getValue())) {
                            POJOs.Customer customer = new classess.tools().getCustomer(co.getValue());
                            HttpSession session1 = request.getSession();
                            session1.setAttribute("username", customer);

                            response.sendRedirect("Home.jsp");
                        } else if (new classess.tools().checkSupplierExist(co.getValue())) {
                            POJOs.Supplier supplier = new classess.tools().getSupplier(co.getValue());
                            HttpSession session1 = request.getSession();
                            session1.setAttribute("username", supplier);

                            response.sendRedirect("Supplier_Main_Home.jsp");

                        }
                    }

                }

            }
        
      out.write("\n");
      out.write("\n");
      out.write("        <!--Navigation bar Start-->\n");
      out.write("        <div>\n");
      out.write("            <nav class=\"navbar navbar-inverse\">\n");
      out.write("                <div class=\"container-fluid\">\n");
      out.write("                    <div class=\"navbar navbar-header\"><a class=\"navbar-brand\" href=\"#\"><img src=\"img/logo_7_cakeshop.png\" width=\"170px\"></a></div>\n");
      out.write("                    <ul class=\"nav navbar-nav navbar-right \" >\n");
      out.write("                        <li><a href=\"RegistrationForm.jsp\">User Registration</a></li>\n");
      out.write("                        <li><a href=\"supplier_registration.jsp\">Shop Registration</a></li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("            </nav>    \n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!--Navigation bar Finish-->\n");
      out.write("\n");
      out.write("        <!--Content Area Start-->\n");
      out.write("\n");
      out.write("        <div class=\"container-fluid\">\n");
      out.write("\n");
      out.write("            ");

                if (request.getParameter("msg") != null) {
                    String message = request.getParameter("msg");

                    if (message.equals("Error in User Name Or Password")) {
            
      out.write("\n");
      out.write("            <div class=\"alert alert-danger\"><a class=\"close\" data-dismiss=\"alert\" >&times;</a>");
      out.print(message);
      out.write("</div>\n");
      out.write("            ");

            } else {
            
      out.write("\n");
      out.write("            <div class=\"alert alert-danger\"><a class=\"close\" data-dismiss=\"alert\" >&times;</a>");
      out.print(message);
      out.write("</div>\n");
      out.write("            ");

                    }
                }

            
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-md-7\">\n");
      out.write("                    <!--Images Here-->\n");
      out.write("                    <div class=\"container-fluid\">\n");
      out.write("                        <div class=\"row\">\n");
      out.write("                            <!-- Carousel Start -->\n");
      out.write("                            <div class=\"carousel slide\" id=\"carosel1\" >\n");
      out.write("                                <!-- Carousel indicators -->\n");
      out.write("                                <ol class=\"carousel-indicators\">\n");
      out.write("                                    <li data-target=\"#carosel1\" data-slide-to=\"0\" class=\"active\"></li>\n");
      out.write("                                    <li data-target=\"#carosel1\" data-slide-to=\"1\" ></li>\n");
      out.write("                                    <li data-target=\"#carosel1\" data-slide-to=\"2\" ></li>\n");
      out.write("                                    <li data-target=\"#carosel1\" data-slide-to=\"3\" ></li>\n");
      out.write("                                </ol>\n");
      out.write("\n");
      out.write("                                <div class=\"carousel-inner\">\n");
      out.write("                                    <div class=\"item active\">\n");
      out.write("                                        <img src=\"img/iamge 4.jpg\" alt=\"First slide\">\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"item\">\n");
      out.write("                                        <img src=\"img/image 5.jpg\" alt=\"Second slide\">\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"item\">\n");
      out.write("                                        <img src=\"img/image 6.jpg\" alt=\"Third slide\">\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"item\">\n");
      out.write("                                        <img src=\"img/edit.jpg\" alt=\"4th slide\">\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                                <a class=\"carousel-control left\" href=\"#carosel1\"\n");
      out.write("                                   data-slide=\"prev\">&lsaquo;</a>\n");
      out.write("                                <a class=\"carousel-control right\" href=\"#carosel1\"\n");
      out.write("                                   data-slide=\"next\">&rsaquo;</a>\n");
      out.write("                            </div>\n");
      out.write("                            <!-- Carousel End -->\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div  class=\"col-md-5\">\n");
      out.write("                    <div id=\"loginDiv\" class=\"panel panel-success\">\n");
      out.write("                        <div class=\"panel panel-heading\"><h4>Login</h4></div>\n");
      out.write("                        <div class=\"panel-body\">\n");
      out.write("                            <form class=\"form-horizontal\" action=\"login\" method=\"post\">\n");
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
      out.write("                            <div class=\"form-group\">\n");
      out.write("                                <div class=\"col-sm-offset-2\">\n");
      out.write("                                    <a href=\"EmailRecover.jsp\">forgotten Password ?</a>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <!--Content Area Finish-->\n");
      out.write("        \n");
      out.write("<!--        <footer class=\"panel panel-footer text-center\" style=\"margin-bottom: 0px; padding-bottom: 0px;\">\n");
      out.write("            <a href=\"Admin_Login.jsp\">Admin Login</a>\n");
      out.write("        </footer>-->\n");
      out.write("    </body>\n");
      out.write("    ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <!-- Bootstrap -->\n");
      out.write("        <link href=\"bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <script src=\"JS/jquery-1.11.3.js\"></script>\n");
      out.write("        <script src=\"bootstrap/js/bootstrap.js\"></script>\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("       \n");
      out.write("    </body>\n");
      out.write("    <footer>\n");
      out.write("        <center><p>Copyright © 2016</p></center>\n");
      out.write("    </footer>\n");
      out.write("</html>\n");
      out.write("\n");
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
