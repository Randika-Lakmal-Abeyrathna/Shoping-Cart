package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import org.hibernate.Criteria;

public final class RegistrationForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"utf-8\">\n");
      out.write("        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->\n");
      out.write("        <title>Registration Form</title>\n");
      out.write("\n");
      out.write("          <!-- Bootstrap -->\n");
      out.write("        <link href=\"bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <script src=\"JS/jquery-1.11.3.js\"></script>\n");
      out.write("        <script src=\"bootstrap/js/bootstrap.js\"></script>\n");
      out.write("\n");
      out.write("        <style type=\"text/css\">\n");
      out.write("\n");
      out.write("            #buttonsSide{\n");
      out.write("                float: right;\n");
      out.write("                margin-right: 20px;\n");
      out.write("                margin-bottom: 10px;\n");
      out.write("\n");
      out.write("            }\n");
      out.write("            #passwordmsg{\n");
      out.write("                color: red;\n");
      out.write("            }\n");
      out.write("            #emailMsg{\n");
      out.write("                color: red;\n");
      out.write("                \n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("\n");
      out.write("            function checkEmailSupplier() {\n");
      out.write("                var email = document.getElementById(\"email\").value;\n");
      out.write("                $.ajax({\n");
      out.write("                    url: \"checkEmail\",\n");
      out.write("                    type: 'POST',\n");
      out.write("                    data: {\n");
      out.write("                        value: email\n");
      out.write("                    },\n");
      out.write("                    success: function(data, textStatus, jqXHR) {\n");
      out.write("                        if (data === \"0\") {\n");
      out.write("                         \n");
      out.write("                            document.getElementById(\"emailCheck\").value=\"1\";\n");
      out.write("                            document.getElementById(\"emailMsg\").innerHTML = \"\";\n");
      out.write("\n");
      out.write("                        } else {\n");
      out.write("                            document.getElementById(\"emailMsg\").innerHTML = \"Email Already Exist !\";\n");
      out.write("                            document.getElementById(\"emailCheck\").value=\"0\";\n");
      out.write("                        }\n");
      out.write("                    },\n");
      out.write("                    error: function(jqXHR, textStatus, errorThrown) {\n");
      out.write("                      alert(jqXHR)\n");
      out.write("                    }\n");
      out.write("\n");
      out.write("                });\n");
      out.write("\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function checkPasswordSupplier() {\n");
      out.write("               \n");
      out.write("                var value1 = document.getElementById(\"password\").value;\n");
      out.write("                var value2 = document.getElementById(\"conformpassword\").value;\n");
      out.write("                var value3 =document.getElementById(\"emailCheck\").value;\n");
      out.write("                \n");
      out.write("                if(value3 == 1){\n");
      out.write("                    if (value1 === value2) {\n");
      out.write("                    return true;\n");
      out.write("                } else {\n");
      out.write("                    document.getElementById(\"passwordmsg\").innerHTML = \"Password dosn't Match !\";\n");
      out.write("                    return false;\n");
      out.write("\n");
      out.write("                }\n");
      out.write("                    \n");
      out.write("                }else{\n");
      out.write("                    return false;\n");
      out.write("                    \n");
      out.write("                }\n");
      out.write("                \n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function hideEmailMsg() {\n");
      out.write("                document.getElementById(\"emailMsg\").innerHTML = \"\";\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function hidePasswordMsg() {\n");
      out.write("                document.getElementById(\"passwordmsg\").innerHTML = \"\";\n");
      out.write("            }\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <!--navigation Bar-->\n");
      out.write("        <nav class=\"navbar navbar-inverse\">\n");
      out.write("            <div class=\"container-fluid\">\n");
      out.write("                <div class=\"naFvbar navbar-header\"><a class=\"navbar-brand\" href=\"#\">User Registration</a></div>\n");
      out.write("                <ul class=\"nav navbar-nav navbar-right\">\n");
      out.write("                    <li><a href=\"index.jsp\">Login</a></li>\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("        </nav>\n");
      out.write("        <div class=\"container-fluid\">\n");
      out.write("\n");
      out.write("            ");

                if (request.getParameter("msg") != null) {
                    String message = request.getParameter("msg");

                    if (message.equals("Successfuly Saved !")) {
            
      out.write("\n");
      out.write("            <div class=\"alert alert-success\"><a class=\"close\" data-dismiss=\"alert\" >&times;</a>");
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
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-lg-2\" id=\"col2\" >\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-lg-8\">\n");
      out.write("                    <!---- Registration Form ------>\n");
      out.write("                    <form action=\"user_registration\" method=\"post\" onsubmit=\"return checkPasswordSupplier()\">\n");
      out.write("                        <div class=\"row\">\n");
      out.write("                             <input type=\"hidden\" id=\"emailCheck\" value=\"0\">\n");
      out.write("                            <div class=\"panel panel-default\">\n");
      out.write("                                <div class=\"panel-heading\"> Basic Information </div>\n");
      out.write("                                <div class=\"panel-body\">\n");
      out.write("\n");
      out.write("\n");
      out.write("                                    <!-----basic information Panel ----->\n");
      out.write("                                    <div class=\"row\">\n");
      out.write("                                        <div class=\"col-lg-6\">\n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <label>Salutation</label>\n");
      out.write("                                                <select class=\"form-control\" name=\"salutaion\">\n");
      out.write("                                                    ");
                                                        Criteria c = new classess.sessionConnect().testConnection().createCriteria(POJOs.Salutation.class);
                                                        List<POJOs.Salutation> salutationList = c.list();

                                                        if (!salutationList.isEmpty()) {

                                                            for (int i = 0; i < salutationList.size(); i++) {
                                                                POJOs.Salutation salutation = salutationList.get(i);
                                                                String salutation1 = salutation.getSalutation();


                                                    
      out.write("\n");
      out.write("                                                    <option>");
      out.print(salutation1);
      out.write("</option>\n");
      out.write("                                                    ");

                                                            }
                                                        }
                                                    
      out.write("\n");
      out.write("                                                </select>\n");
      out.write("                                                <hr>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"row\">\n");
      out.write("                                        <div class=\"col-lg-6\">\n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <label>First Name</label>\n");
      out.write("                                                <input type=\"text\" class=\"form-control\" id=\"fname\"  name=\"fname\" placeholder=\"First Name\">\n");
      out.write("\n");
      out.write("                                                <hr>\n");
      out.write("                                                <label>Date Of Birth</label>\n");
      out.write("                                                <input type=\"date\" class=\"form-control\" id=\"dateofbirth\" name=\"dateofbirth\" >\n");
      out.write("                                                <hr>\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"col-lg-6\">\n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <label>Last Name</label>\n");
      out.write("                                                <input type=\"text\" class=\"form-control\" id=\"lname\" name=\"lname\" placeholder=\"Last Name\">\n");
      out.write("                                                <hr>\n");
      out.write("                                                <label>Gender</label>\n");
      out.write("                                                <select class=\"form-control\" id=\"gender\" name=\"gender\">\n");
      out.write("                                                    <option>Male</option>\n");
      out.write("                                                    <option>Female</option>\n");
      out.write("                                                </select>\n");
      out.write("                                                <hr>\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("                                        </div>\n");
      out.write("                                        <p> <br/></p>\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"row\">\n");
      out.write("                                        <div class=\"col-lg-6\">\n");
      out.write("                                            <label>NIC Number</label>\n");
      out.write("                                            <input type=\"text\" class=\"form-control\" id=\"nic\" name=\"nic\" placeholder=\"NIC Number\">\n");
      out.write("                                            <hr>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>                \n");
      out.write("                                    <!----- End of basic information Panel ----->\n");
      out.write("\n");
      out.write("\n");
      out.write("                                    <!--- Address panel--->\n");
      out.write("\n");
      out.write("                                    <div class=\"panel panel-default\">\n");
      out.write("                                        <div class=\"panel-heading\"> Address </div>\n");
      out.write("                                        <div class=\"panel-body\">\n");
      out.write("                                            <div class=\"row\">\n");
      out.write("                                                <div class=\"col-lg-6\">\n");
      out.write("                                                    <div class=\"form-group\">\n");
      out.write("                                                        <label> Address No</label>\n");
      out.write("                                                        <input type=\"text\" class=\"form-control\" id=\"addressno\"  name=\"addressno\">\n");
      out.write("                                                        <hr>\n");
      out.write("                                                        <label> Street 2</label>\n");
      out.write("                                                        <input type=\"text\" class=\"form-control\" id=\"street2\" name=\"street2\" >\n");
      out.write("                                                        <hr>\n");
      out.write("                                                    </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                                                </div>\n");
      out.write("                                                <div class=\"col-lg-6\">\n");
      out.write("                                                    <div class=\"form-group\">\n");
      out.write("                                                        <label> Street 1</label>\n");
      out.write("                                                        <input type=\"text\" class=\"form-control\" id=\"street1\" name=\"street1\" >\n");
      out.write("                                                        <hr>\n");
      out.write("                                                        <label> City</label>\n");
      out.write("                                                        <input type=\"text\" class=\"form-control\" id=\"City1\" name=\"city\" >\n");
      out.write("                                                        <hr>\n");
      out.write("                                                    </div>\n");
      out.write("\n");
      out.write("                                                </div>\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <!----- End of Address Panel---->\n");
      out.write("\n");
      out.write("                                    <!---- contact details Panel---->\n");
      out.write("                                    <div class=\"panel panel-default\">\n");
      out.write("                                        <div class=\"panel-heading\"> Contact Details </div>\n");
      out.write("                                        <div class=\"panel-body\">\n");
      out.write("                                            <div class=\"row\">\n");
      out.write("                                                <div class=\"col-lg-6\">\n");
      out.write("                                                    <div class=\"form-group\">\n");
      out.write("\n");
      out.write("                                                        <label> Mobile Number</label>\n");
      out.write("                                                        <input type=\"tel\" class=\"form-control\" id=\"mobileno\" name=\"mobileno\" >\n");
      out.write("                                                        <hr>\n");
      out.write("                                                        <label> Email Address</label>\n");
      out.write("                                                        <input type=\"email\" class=\"form-control\" id=\"email\" name=\"email\" onchange=\"checkEmailSupplier()\" onclick=\"hideEmailMsg()\">\n");
      out.write("                                                        <label id=\"emailMsg\"></label>\n");
      out.write("                                                        <hr>\n");
      out.write("                                                    </div>\n");
      out.write("\n");
      out.write("                                                </div>\n");
      out.write("                                                <div class=\"col-lg-6\">\n");
      out.write("                                                    <div class=\"form-group\">\n");
      out.write("                                                        <label> Home or Office Number</label>\n");
      out.write("                                                        <input type=\"tel\" class=\"form-control\" id=\"homeno\" name=\"homeno\" >\n");
      out.write("                                                        <hr>\n");
      out.write("                                                    </div>\n");
      out.write("\n");
      out.write("                                                </div>\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                    </div>\n");
      out.write("                                    <!---- End of contact details Panel---->\n");
      out.write("\n");
      out.write("                                    <!--- Password and userName panel --->\n");
      out.write("                                    <div class=\"panel panel-danger\">\n");
      out.write("                                        <div class=\"panel-heading\"> Password  </div>\n");
      out.write("                                        <div class=\"panel-body\">\n");
      out.write("                                            <div class=\"row\">\n");
      out.write("                                                <div class=\"col-lg-6\">\n");
      out.write("                                                    <div class=\"form-group\">\n");
      out.write("                                                        <label> Password</label>\n");
      out.write("                                                        <input type=\"password\" class=\"form-control\" id=\"password\" name=\"password\">\n");
      out.write("                                                        <hr>\n");
      out.write("                                                    </div>\n");
      out.write("\n");
      out.write("                                                </div>\n");
      out.write("                                                <div class=\"col-lg-6\">\n");
      out.write("                                                    <div class=\"form-group\">\n");
      out.write("                                                        <label>  Conform Password</label>\n");
      out.write("                                                        <input type=\"password\" class=\"form-control\" id=\"conformpassword\" name=\"conformpassword\" onclick=\"hidePasswordMsg()\">\n");
      out.write("                                                        <label id=\"passwordmsg\"></label>\n");
      out.write("                                                        <hr>\n");
      out.write("                                                    </div>\n");
      out.write("\n");
      out.write("                                                </div>\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("                                    <!--- End  of Password and userName panel --->\n");
      out.write("\n");
      out.write("\n");
      out.write("                                </div>\n");
      out.write("                                <!----Submit Button ---->\n");
      out.write("                                <div class=\"row\">\n");
      out.write("                                    <aside id=\"buttonsSide\">\n");
      out.write("                                        <input type=\"submit\" class=\"btn btn-primary\" value=\"Submit Data\">\n");
      out.write("                                        <input type=\"button\" class=\"btn btn-warning\" value=\"Cancel\"  >\n");
      out.write("                                    </aside>\n");
      out.write("                                </div>\n");
      out.write("                                <!---- End of Submit Button ---->\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                    </form>\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"col-lg-2\" id=\"col2\">\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
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
