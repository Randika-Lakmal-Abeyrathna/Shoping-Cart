<%-- 
    Document   : WatchList
    Created on : 10-Oct-2016, 18:58:48
    Author     : Randika Lakmal
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>

        <script type="text/javascript">

        </script>

        <title>Watch List</title>
    </head>
    <body>
        <!--Navigation Start-->

        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand">Watch List </a>
                </div>
                <ul class="nav navbar-nav navbar-right " >
                    <%
                        if (request.getSession().getAttribute("username") != null) {

                            try {
                                POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");

                                Session session1 =POJOs.session_pool_manager.getSessionFactory().openSession();
                                
                                POJOs.Customer supplier =(POJOs.Customer)session1.load(POJOs.Customer.class, customer.getEmail());
                                
                                String status =supplier.getStatus().getStatus();
                                
                                if(status.equals("deactive")){
                                    response.sendRedirect("logout");
                                }
                                
                    %>
                    <li><a href="Home.jsp" >Home</a> </li>
                    <li><a name = "username" id = "username" ><span class="glyphicon glyphicon-user ">  <%=customer.getEmail()%></span> </a> </li>
                    <li><a href="logout">Logout</a></li>
                        <%
                                } catch (Exception e) {
                                    response.sendRedirect("index.jsp");
                                }

                            } else {
                                response.sendRedirect("index.jsp");
                            }
                        %>


                </ul>


            </div>
        </nav>

        <!--Navigation End-->
        <%
            if (request.getSession().getAttribute("username") != null) {
                try {
                    POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");

        %>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <ul class="nav navbar-nav navbar-right " >
                    <li><a href="cart.jsp">My Cart    <span class="badge" id="cartList"><%=new classess.getCartCount().getCartCount(customer)%></span> </a></li>
                    <li><a href="CustomerLog.jsp ">History</a></li>
                    <li><a href="savedItems.jsp">Saved Items   <span class="badge" ><%=new classess.getSavedItems().getLaterCount(customer)%></span></a></li>
                    <li><a href="WatchList.jsp">Watch List <span class="badge" id="watchList"><%=new classess.getWatchListCount().getCount(customer)%></span> </a></li>
                    <li><a href="CustomerAccountUpdate.jsp">Account Update</a></li>
                </ul>
            </div>
        </nav>
        <%                        } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("index.jsp");
                }
            }
        %>

        <div class="container-fluid">
            <div class="row">
                <div class="panel panel-info">
                    <div class="panel panel-heading">Items</div>
                    <div class="panel panel-body">

                        <%
                            Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                            Criteria getWatchListCriteria = session1.createCriteria(POJOs.WatchList.class);
                            getWatchListCriteria.add(Restrictions.eq("customer", (POJOs.Customer) request.getSession().getAttribute("username")));
                            getWatchListCriteria.addOrder(Order.desc("systemDate"));
                            List<POJOs.WatchList> watchList = getWatchListCriteria.list();

                            if (!watchList.isEmpty()) {
                        %>
                        <table id="Prodcutitem" class="table table-striped text-center"> 
                            <tr>
                                <th class="text-center"></th>
                                <th class="text-center">Details</th>
                                <th class="text-center"></th>
                            </tr>
                            <%
                                for (int i = 0; i < watchList.size(); i++) {
                                    POJOs.WatchList watchList1 = watchList.get(i);
                                    String status = watchList1.getProduct().getProductStatus().getProductStatus();
                                    if (status.equals("active")) {

                            %>
                            <tr>
                                <td class="col-md-4">

                                    <!-- Carousel Start -->
                                    <div class="carousel slide" id="carosel<%=i%>" >
                                        <!-- Carousel indicators -->
                                        <ol class="carousel-indicators">
                                            <%
                                                Criteria getImageCriteria = session1.createCriteria(POJOs.ProductImage.class);
                                                getImageCriteria.add(Restrictions.eq("product", watchList1.getProduct()));

                                                List<POJOs.ProductImage> ImageList = getImageCriteria.list();

                                                if (!ImageList.isEmpty()) {

                                                    for (int j = 0; j < ImageList.size(); j++) {

                                                        if (j == 0) {
                                            %>
                                            <li data-target="#carosel<%=i%>" data-slide-to="<%=j%>" class="active"></li>
                                                <%
                                                } else {
                                                %>
                                            <li data-target="#carosel<%=i%>" data-slide-to="<%=j%>" ></li>
                                                <%
                                                            }

                                                        }

                                                    }
                                                %>
                                        </ol>

                                        <div class="carousel-inner">

                                            <%
                                                Criteria getImageCriteria1 = session1.createCriteria(POJOs.ProductImage.class);
                                                getImageCriteria1.add(Restrictions.eq("product", watchList1.getProduct()));

                                                List<POJOs.ProductImage> ImageList1 = getImageCriteria1.list();

                                                if (!ImageList1.isEmpty()) {

                                                    for (int j = 0; j < ImageList1.size(); j++) {
                                                        POJOs.ProductImage productImage = ImageList1.get(j);
                                                        if (j == 0) {
                                            %>
                                            <div class="item active">
                                                <img src="<%=productImage.getProductImagePath()%>" class="img-thumbnail img-responsive"  alt="">
                                            </div>
                                            <%
                                            } else {
                                            %>
                                            <div class="item">
                                                <img src="<%=productImage.getProductImagePath()%>" class="img-thumbnail img-responsive"alt="">
                                            </div>
                                            <%
                                                        }

                                                    }

                                                }
                                            %>
                                        </div>
                                        <a class="carousel-control left" href="#carosel<%=i%>"
                                           data-slide="prev">&lsaquo;</a>
                                        <a class="carousel-control right" href="#carosel<%=i%>"
                                           data-slide="next">&rsaquo;</a>
                                    </div>
                                    <!-- Carousel End -->

                                </td>
                                <td class="col-md-4">
                                    <div class="form-group">
                                        <label>Product Name :</label>
                                        <label><%=watchList1.getProduct().getProductName()%></label> 
                                    </div>
                                    <div class="form-group">
                                        <label>Supplier :</label>
                                        <label><%=watchList1.getProduct().getSupplier().getCompanyName()%>  </label> 
                                    </div>
                                    <div class="form-group">
                                        <label>Available Quantity:</label>
                                        <label><%=watchList1.getProduct().getQty()%>  </label> 
                                    </div>
                                </td>
                                <td class="col-md-4">
                                    <aside style="float: right; margin-right: 20px; margin-top: 25px; ">
                                        <a class="btn btn-warning" href="removeWatchListItem?id=<%=watchList1.getIdwatchList()%>">Remove</a>
                                        <a class="btn btn-primary" href="Product.jsp?id=<%=watchList1.getProduct().getIdproduct()%>">Add To Cart</a>
                                    </aside>

                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </table>
                        <%
                        } else {
                        %>
                        <p class="text-center" style="font-size: xx-large">No Data Found !</p>
                        <%
                            }
                        %>


                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
