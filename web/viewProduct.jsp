<%-- 
    Document   : viewProduct
    Created on : Oct 13, 2016, 8:59:05 PM
    Author     : Randika Lakmal
--%>

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
        <script src="JS/Chart.js"></script>

        <title>Product Details</title>
    </head>
    <body>
        <%
            if (request.getParameter("id") != null) {
        %>
        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="">View Product Details</a>
                </div>
                <ul class="nav navbar-nav navbar-right " >
                    <%
                        if (request.getSession().getAttribute("username") != null) {

                            try {
                                POJOs.Supplier supplier = (POJOs.Supplier) request.getSession().getAttribute("username");
                                 Session session1 =POJOs.session_pool_manager.getSessionFactory().openSession();
                                
                                POJOs.Supplier supplier1 =(POJOs.Supplier)session1.load(POJOs.Supplier.class, supplier.getEmail());
                                
                                String status =supplier1.getStatus().getStatus();
                                
                                if(status.equals("deactive")){
                                    response.sendRedirect("logout");
                                }
                    %>
                    <li><a name="username" id="username"><span class="glyphicon glyphicon-user ">   <%=supplier.getEmail()%></span></a></li>


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

        <%
            if (request.getSession().getAttribute("username") != null) {
                try {
                    POJOs.Supplier supplier = (POJOs.Supplier) request.getSession().getAttribute("username");

        %>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <ul class="nav navbar-nav navbar-right " >
                    <li><a href="Supplier_Main_Home.jsp">All Products</a></li>
                    <li><a href="SupplierNewOrders.jsp">New Orders  <span class="badge" ><%=new classess.getNewOrder().getNewOrderCount(supplier)%></span></a></li>
                    <li><a href="supplierStockDetails.jsp">Stock Details  </a></li>
                    <li><a href="Product_Registeration.jsp">Register Product </a></li>
                    <li><a href="supplierPurchasingDetails.jsp">Purchasing Details </a></li>
                    <li><a href="supplierAccountupdate.jsp">Account Update</a></li>
                </ul>
            </div>
        </nav>
        <%                        } catch (Exception e) {
                        response.sendRedirect("index.jsp");
                    }
                }

            } else {
                response.sendRedirect("Supplier_Main_Home.jsp");
            }
        %>
        <%
            Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
            int id = Integer.parseInt(request.getParameter("id"));

            POJOs.Product product = (POJOs.Product) session1.load(POJOs.Product.class, id);

            String status = product.getProductStatus().getProductStatus();
            String showStatus = "";
            if (status.equals("active")) {
                showStatus = "Active";
            } else if (status.equals("deactive")) {
                showStatus = "Deactive";
            }

            Criteria getCategoryCriteria = session1.createCriteria(POJOs.CategoryDetails.class);
            getCategoryCriteria.add(Restrictions.eq("product", product));

            POJOs.CategoryDetails categoryDetail = (POJOs.CategoryDetails) getCategoryCriteria.uniqueResult();

            Criteria getImageDetailsCriteria = session1.createCriteria(POJOs.ProductImage.class);
            getImageDetailsCriteria.add(Restrictions.eq("product", product));

            List<POJOs.ProductImage> productImageList = getImageDetailsCriteria.list();

        %>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-7">
                    <div class="panel panel-default">
                        <div class="panel panel-heading">
                            <div class="pull-left">
                                <h4><%=product.getProductName()%></h4>
                            </div>
                            <div class="pull-right">
                                <h4>Prodcut Status : <%=showStatus%></h4>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="panel panel-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <!--Image Slider-->

                                    <%
                                        if (!productImageList.isEmpty()) {
                                    %>
                                    <!-- Carousel Start -->
                                    <div class="carousel slide" id="carosel1" >
                                        <!-- Carousel indicators -->
                                        <ol class="carousel-indicators">
                                            <%
                                                for (int i = 0; i < productImageList.size(); i++) {
                                                    POJOs.ProductImage productImage = productImageList.get(i);

                                            %>

                                            <%                                                if (i == 0) {
                                            %>
                                            <li data-target="#carosel1" data-slide-to="0" class="active"></li>

                                            <%
                                            } else {
                                            %>
                                            <li data-target="#carosel1" data-slide-to="<%=i%>" ></li>
                                                <%
                                                        }
                                                    }
                                                %>

                                        </ol>

                                        <div class="carousel-inner">
                                            <%
                                                for (int i = 0; i < productImageList.size(); i++) {
                                                    POJOs.ProductImage productImage = productImageList.get(i);

                                            %>

                                            <%                                                if (i == 0) {
                                            %>
                                            <div class="item active">
                                                <img src="<%=productImage.getProductImagePath()%>" class="img-responsive"  >
                                            </div>

                                            <%
                                            } else {
                                            %>
                                            <div class="item">
                                                <img src="<%=productImage.getProductImagePath()%>" class="img-responsive"  >
                                            </div>
                                            <%
                                                    }
                                                }
                                            %>

                                        </div>
                                        <%
                                            }
                                        %>
                                        <a class="carousel-control left" href="#carosel1"
                                           data-slide="prev">&lsaquo;</a>
                                        <a class="carousel-control right" href="#carosel1"
                                           data-slide="next">&rsaquo;</a>
                                    </div>
                                    <!-- Carousel End -->


                                </div>
                                <div class="col-md-8">
                                    <div class="row text-center">
                                        <div class="form-group col-md-9 col-md-offset-1">
                                            <label class="col-md-5">Unit Price :</label>
                                            <label class="col-md-4" style="font-size: large"><%=product.getPrice()%></label>
                                        </div>
                                        <div class="form-group col-md-9 col-md-offset-1">
                                            <label class="col-md-5">Availabel Quantity :</label>
                                            <label class="col-md-4" style="font-size: large"><%=product.getQty()%></label>
                                        </div>
                                        <div class="form-group col-md-9 col-md-offset-1">
                                            <label class="col-md-5">Soled Quantity :</label>
                                            <label class="col-md-4" style="font-size:large"><%=product.getSold()%></label>
                                        </div>

                                    </div>

                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="form-group col-md-6  pull-left">
                                    <label class="col-md-5">Top Category :</label>
                                    <label class="col-md-4" style="font-size: large"><%=categoryDetail.getTopCategory().getTopCategory()%></label>
                                </div>
                                <div class="form-group col-md-6  pull-right">
                                    <label class="col-md-5">Sub Category :</label>
                                    <label class="col-md-4" style="font-size: large"><%=categoryDetail.getSubCategory().getSubCategory()%></label>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <label class="col-md-offset-1">Product Description</label>
                                <textarea class="col-md-8 col-md-offset-2" disabled="true" rows="10" >
                                    <%=product.getDeiscription()%>
                                </textarea>
                            </div>

                        </div>
                    </div>

                </div>
                <div class="col-md-5">
                    <div class="panel panel-success">
                        <div class="panel panel-heading"><h3>Statistic</h3></div>
                        <div class="panel panel-body">
                            <div class="row">
                                <canvas id="myChart" ></canvas>
                                <script>
                                    var ctx = document.getElementById("myChart");
                                    var myChart = new Chart(ctx, {
                                        type: 'doughnut',
                                        data: {
                                            labels: ["Availabel Quantity", "Soled Quantity"],
                                            datasets: [{
                                                    label: '# of Items',
                                                    data: [<%=product.getQty()%>, <%=product.getSold()%>],
                                                    backgroundColor: [
                                                        'rgba(255, 99, 132, 0.2)',
                                                        'rgba(54, 162, 235, 0.2)'
                                                    ],
                                                    borderColor: [
                                                        'rgba(255,99,132,1)',
                                                        'rgba(54, 162, 235, 1)'
                                                    ],
                                                    borderWidth: 1
                                                }]
                                        }

                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%

        %>

    </body>
</html>
