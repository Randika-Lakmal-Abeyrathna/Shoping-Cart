package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.HashMap;
import java.util.Vector;
import POJOs.Product;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.Order;
import POJOs.SubCategory;
import POJOs.TopCategory;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;

public final class Home_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
      out.write("        <title>Home Page</title>\n");
      out.write("\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("            $(document).ready(function() {\n");
      out.write("                $('.carousel').carousel({\n");
      out.write("                    interval: 3200\n");
      out.write("                })\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            function addToWatchList(id) {\n");
      out.write("                $.ajax({\n");
      out.write("                    url: \"addToWatchList\",\n");
      out.write("                    type: 'POST',\n");
      out.write("                    data: {\n");
      out.write("                        pid: id\n");
      out.write("                    },\n");
      out.write("                    success: function(data, textStatus, jqXHR) {\n");
      out.write("                        document.getElementById(\"watchList\").innerHTML = data;\n");
      out.write("//                        document.getElementById(\"message\").innerHTML=\"<div class=\"alert alert-success\"><a class=\"close\" data-dismiss=\"alert\" >&times;</a>Successfully Added to WatchList</div>\";\n");
      out.write("                    },\n");
      out.write("                    error: function(jqXHR, textStatus, errorThrown) {\n");
      out.write("                        alert(jqXHR);\n");
      out.write("                    }\n");
      out.write("\n");
      out.write("                });\n");
      out.write("\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("        <style type=\"text/css\">\n");
      out.write("            #searchdiv{\n");
      out.write("                margin-right: 10px;\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("        </style>\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body >\n");
      out.write("        ");


            if (request.getParameter("p") == null) {
                response.sendRedirect("pagination");

            }
        
      out.write("\n");
      out.write("        <!--Navigation Start-->\n");
      out.write("\n");
      out.write("        <nav class=\"navbar navbar-inverse\" style=\"margin-bottom: 0px;\">\n");
      out.write("            <div class=\"container-fluid\">\n");
      out.write("                <div class=\"navbar navbar-header\">\n");
      out.write("                    <a class=\"navbar-brand\" href=\"#\"><img src=\"img/logo_7_cakeshop.png\" width=\"170px\"></a>\n");
      out.write("                </div>\n");
      out.write("                <ul class=\"nav navbar-nav navbar-right \" >\n");
      out.write("                    ");

                        if (request.getSession().getAttribute("username") != null) {

                            try {
                                POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");
                                
                                 Session session1 =POJOs.session_pool_manager.getSessionFactory().openSession();
                                
                                POJOs.Customer supplier =(POJOs.Customer)session1.load(POJOs.Customer.class, customer.getEmail());
                                
                                String status =supplier.getStatus().getStatus();
                                
                                if(status.equals("deactive")){
                                    response.sendRedirect("logout");
                                }
                                
                    
      out.write("\n");
      out.write("                    <li><a href=\"Home.jsp\" >Home</a> </li>\n");
      out.write("                    <li><a name = \"username\" id = \"username\" ><span class=\"glyphicon glyphicon-user \">  ");
      out.print(customer.getEmail());
      out.write("</span> </a> </li>\n");
      out.write("                    <li><a href=\"logout\">Logout</a></li>\n");
      out.write("                        ");

                            } catch (Exception e) {

                            }

                        } else {
                        
      out.write("\n");
      out.write("                    <li><a href=\"index.jsp\">Login</a></li>\n");
      out.write("\n");
      out.write("                    ");

                        }
                    
      out.write("\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("        </nav>\n");
      out.write("\n");
      out.write("        <!--Navigation End-->\n");
      out.write("\n");
      out.write("\n");
      out.write("        ");

            if (request.getSession().getAttribute("username") != null) {


        
      out.write("\n");
      out.write("\n");
      out.write("        <nav class=\"navbar navbar-default \">\n");
      out.write("            <div class=\"container-fluid\">\n");
      out.write("                <div class=\"row\">\n");
      out.write("                    <ul class=\"nav navbar-nav navbar-right \" >\n");
      out.write("\n");
      out.write("                        ");
                            POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");
                        
      out.write("\n");
      out.write("\n");
      out.write("                        <li><a href=\"cart.jsp\">My Cart    <span class=\"badge\" id=\"cartList\">");
      out.print(new classess.getCartCount().getCartCount(customer));
      out.write("</span> </a></li>\n");
      out.write("                        <li><a href=\"CustomerLog.jsp \">History</a></li>\n");
      out.write("                        <li><a href=\"savedItems.jsp\">Saved Items   <span class=\"badge\" >");
      out.print(new classess.getSavedItems().getLaterCount(customer));
      out.write("</span></a></li>\n");
      out.write("                        <li><a href=\"WatchList.jsp\">Watch List <span class=\"badge\" id=\"watchList\">");
      out.print(new classess.getWatchListCount().getCount(customer));
      out.write("</span> </a></li>\n");
      out.write("                        <li><a href=\"CustomerAccountUpdate.jsp\">Account Update</a></li>\n");
      out.write("\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("        </nav>\n");
      out.write("        ");


            } else {

            }
        
      out.write("\n");
      out.write("        <hr>\n");
      out.write("\n");
      out.write("        <div class=\"row\" id=\"message\">\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("        <div class=\"row\">\n");
      out.write("\n");
      out.write("            <!--Main Slider-->\n");
      out.write("            <div class=\"container-fluid\">\n");
      out.write("                <div class=\"carousel slide\" id=\"mainSlider\" >\n");
      out.write("                    <!-- Carousel indicators -->\n");
      out.write("                    <ol class=\"carousel-indicators\">\n");
      out.write("                        <li data-target=\"#mainSlider\" data-slide-to=\"0\" class=\"active\"></li>\n");
      out.write("                        <li data-target=\"#mainSlider\" data-slide-to=\"1\" ></li>\n");
      out.write("                        <li data-target=\"#mainSlider\" data-slide-to=\"3\" ></li>\n");
      out.write("                        <li data-target=\"#mainSlider\" data-slide-to=\"4\" ></li>\n");
      out.write("                        <li data-target=\"#mainSlider\" data-slide-to=\"5\" ></li>\n");
      out.write("                        <li data-target=\"#mainSlider\" data-slide-to=\"6\" ></li>\n");
      out.write("                        <li data-target=\"#mainSlider\" data-slide-to=\"7\" ></li>\n");
      out.write("                    </ol>\n");
      out.write("\n");
      out.write("                    <div class=\"carousel-inner\">\n");
      out.write("                        <div class=\"item active\">\n");
      out.write("                            <img src=\"img/img1.jpg\" alt=\"First slide\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"item\">\n");
      out.write("                            <img src=\"img/img2.jpg\" alt=\"Second slide\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"item\">\n");
      out.write("                            <img src=\"img/img3.jpg\" alt=\"Third slide\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"item\">\n");
      out.write("                            <img src=\"img/img4.jpg\" alt=\"Fourth slide\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"item\">\n");
      out.write("                            <img src=\"img/img5.jpg\" alt=\"5 slide\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"item\">\n");
      out.write("                            <img src=\"img/img6.jpg\" alt=\"6 slide\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"item\">\n");
      out.write("                            <img src=\"img/img7.jpg\" alt=\"7 slide\">\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <a class=\"carousel-control left\" href=\"#mainSlider\"\n");
      out.write("                       data-slide=\"prev\">&lsaquo;</a>\n");
      out.write("                    <a class=\"carousel-control right\" href=\"#mainSlider\"\n");
      out.write("                       data-slide=\"next\">&rsaquo;</a>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <hr>\n");
      out.write("        <div class=\"row\">\n");
      out.write("\n");
      out.write("            <!--Left Side-->\n");
      out.write("            <div class=\"col-md-3\">\n");
      out.write("                <div class=\"panel panel-success\">\n");
      out.write("                    <div class=\"panel panel-heading\"><h4><a href=\"#search\" data-toggle=\"collapse\">Search</a></h4></div>\n");
      out.write("                    <div id=\"search\" class=\"collapse panel-collapse\">\n");
      out.write("                        <div class=\"panel panel-body\">\n");
      out.write("                            <div class=\"panel panel-default\">\n");
      out.write("                                <div class=\"panel panel-heading\"><a href=\"#cat\" data-toggle=\"collapse\">Category</a></div>\n");
      out.write("                                <div id=\"cat\" class=\"collapse panel-collapse in\">\n");
      out.write("                                    <div class=\"panel panel-body\">\n");
      out.write("                                        <ul class=\"list\">\n");
      out.write("                                            ");

                                                HashMap<String, Object> map = new classess.getProductSubDetails().getTopCategory();
                                                if (!map.isEmpty()) {
                                                    for (int i = 0; i < map.size(); i++) {
                                                        TopCategory topCategory = (TopCategory) map.get(i + "");

                                            
      out.write("\n");
      out.write("                                            <li><a href=\"pagination?msg=top&id=");
      out.print(topCategory.getTopCategory());
      out.write('"');
      out.write('>');
      out.print(topCategory.getTopCategory());
      out.write("</a></li>\n");
      out.write("                                                ");


                                                        }
                                                    }
                                                
      out.write("\n");
      out.write("                                        </ul>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"panel panel-default\">\n");
      out.write("                                <div class=\"panel panel-heading\"><a href=\"#cat\" data-toggle=\"collapse\">Flavers</a></div>\n");
      out.write("                                <div id=\"cat\" class=\"collapse panel-collapse in\">\n");
      out.write("                                    <div class=\"panel panel-body\">\n");
      out.write("                                        <ul class=\"list\">\n");
      out.write("                                            ");

                                                HashMap<String, Object> map1 = new classess.getProductSubDetails().getSubcategory();
                                                if (!map1.isEmpty()) {
                                                    for (int i = 0; i < map1.size(); i++) {
                                                        SubCategory SubCategory = (SubCategory) map1.get(i + "");

                                            
      out.write("\n");
      out.write("                                            <li><a href=\"pagination?msg=sub&id=");
      out.print(SubCategory.getSubCategory());
      out.write('"');
      out.write('>');
      out.print(SubCategory.getSubCategory());
      out.write("</a></li>\n");
      out.write("                                                ");


                                                        }
                                                    }
                                                
      out.write("\n");
      out.write("                                        </ul>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"panel panel-default\">\n");
      out.write("                                <div class=\"panel panel-heading\"><a href=\"#PR\" data-toggle=\"collapse\">Price Range</a></div>\n");
      out.write("                                <div id=\"PR\" class=\"collapse panel-collapse in\">\n");
      out.write("                                    <div class=\"panel panel-body\">\n");
      out.write("                                        <form action=\"pagination?msg=search\" method=\"post\">\n");
      out.write("\n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <label class=\"control-label \">Price Range</label><br>\n");
      out.write("                                                <label class=\"col-md-3\">Min</label><input  class=\"col-md-3 form-control\" type=\"number\" name=\"min\" value=\"00.00\"/>\n");
      out.write("                                                <label class=\"col-md-3\">Max</label><input class=\"col-md-3 form-control\" type=\"number\" name=\"max\" value=\"00.00\"/>\n");
      out.write("                                            </div> \n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <div class=\"pull-right\">\n");
      out.write("\n");
      out.write("                                                    <input type=\"submit\" value=\"Search\" class=\"btn btn-primary\" style=\"margin-top: 10px;\">\n");
      out.write("                                                </div>\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("                                        </form>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!--Right Side-->\n");
      out.write("            <div class=\"col-md-9\">\n");
      out.write("                <div class=\"panel panel-default\">\n");
      out.write("                    <div class=\"panel panel-heading\">Products</div>\n");
      out.write("                    <div class=\"panel panel-body\">\n");
      out.write("                        <div class=\"row\">\n");
      out.write("                            ");

                                if (request.getSession().getAttribute("items") != null) {

                                    Vector itemVector = (Vector) request.getSession().getAttribute("items");

                                    int pages = itemVector.size() / 3;

                                    if (request.getParameter("p") != null) {

                                        int currentPage = Integer.parseInt(request.getParameter("p"));

                                        if ((itemVector.size() % 3) != 0) {
                                            pages++;

                                        }
                                        for (int i = (currentPage - 1) * 3; i < currentPage * 3; i++) {

                                            if (itemVector.size() > i) {
                                            HashMap hm = (HashMap) itemVector.get(i);

                                            POJOs.Product product = (POJOs.Product) hm.get("product");
                                            POJOs.Supplier supplier = product.getSupplier();

                                            Session session3 = POJOs.session_pool_manager.getSessionFactory().openSession();
                                            Criteria criteria = session3.createCriteria(POJOs.ProductImage.class);
                                            criteria.add(Restrictions.eq("product", product));

                                            List<POJOs.ProductImage> productImageList = criteria.list();

                                            String path = "";
                                            if (!productImageList.isEmpty()) {

                                                POJOs.ProductImage productImage = productImageList.get(0);
                                                path = productImage.getProductImagePath();
                                            }


                            
      out.write("\n");
      out.write("                            <div class=\"col-md-4\">\n");
      out.write("                                <div class=\"panel panel-default\">\n");
      out.write("                                    <div class=\"panel panel-heading\"><h4>");
      out.print(product.getProductName());
      out.write("</h4></div>\n");
      out.write("                                    <div class=\"panel panel-body\">\n");
      out.write("                                        <div class=\"row text-center\">\n");
      out.write("                                            <img src=\"");
      out.print(path);
      out.write("\" class=\"img-thumbnail img-responsive col-md-10 col-lg-offset-1\" >\n");
      out.write("                                        </div>\n");
      out.write("                                        <hr>\n");
      out.write("                                        <div class=\"row\">\n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <label class=\"control-label col-md-5\">Price</label>\n");
      out.write("                                                <label class=\"control-label col-md-6 pull-right \"><strong>");
      out.print(product.getSellingPrice());
      out.write("</strong></label>\n");
      out.write("                                            </div>\n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <label class=\"control-label col-md-5\">Quantity</label>\n");
      out.write("                                                <label class=\"control-label pull-right col-md-6 \"><strong>");
      out.print(product.getQty());
      out.write("</strong></label>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("                                        <div class=\"row\">\n");
      out.write("                                            ");


                                                try {
                                                    POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");
                                                    if (customer != null) {
                                            
      out.write("\n");
      out.write("                                            <input type=\"button\" value=\"Add to Watch List\" class=\"btn btn-warning pull-left\" style=\"margin-left: 10px;\" onclick=\"addToWatchList(");
      out.print(product.getIdproduct());
      out.write(")\"> \n");
      out.write("\n");
      out.write("                                            ");

                                                    }
                                                } catch (Exception e) {

                                                }
                                            
      out.write("\n");
      out.write("                                            <a href=\"Product.jsp?id=");
      out.print(product.getIdproduct());
      out.write("\" class=\"btn btn-default pull-right\" style=\"margin-right: 10px;\">More Details</a>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("                            ");

                                    }
                                }
                            
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"panel panel-footer\">\n");
      out.write("\n");
      out.write("                        <div class=\"container-fluid\">\n");
      out.write("                            <div class=\"text-center\">\n");
      out.write("                                <ul class=\"pagination\">\n");
      out.write("                                    ");

                                        try {
                                            if (currentPage != 1) {
                                    
      out.write("\n");
      out.write("                                    <li class=\"previous\"><a href=\"Home.jsp?p=");
      out.print((currentPage - 1));
      out.write("\">Previous</a></li>\n");
      out.write("\n");
      out.write("                                    ");

                                        }

                                        for (int j = 1; j <= pages; j++) {

                                    
      out.write("\n");
      out.write("                                    <li class=\"");
 if (currentPage == j) {
                                            out.print("active");
                                        }
      out.write("\"><a href=\"Home.jsp?p=");
      out.print(j);
      out.write('"');
      out.write('>');
      out.print(j);
      out.write("</a></li>\n");
      out.write("                                        ");
                                                }

                                            if (currentPage != pages) {
                                        
      out.write("\n");
      out.write("                                    <li class=\"next\"><a href=\"Home.jsp?p=");
      out.print(currentPage + 1);
      out.write("\">Next</a></li>\n");
      out.write("                                        ");


                                                }
                                            } catch (Exception e) {
                                            }
                                        
      out.write("\n");
      out.write("                                </ul>\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    ");

                            }
                        }

                    
      out.write("\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("</body>\n");
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
