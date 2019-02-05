<%-- 
    Document   : Supplier_Main_Home
    Created on : 04-Jan-2016, 00:10:56
    Author     : USER
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="POJOs.ProductImage"%>
<%@page import="POJOs.ProductHasCartDetails"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Supplier Home </title>

        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>

        <!-- CSS--->
        <style type="text/css">
            #solidLine{
                background-color: goldenrod;
                width: auto;
                height: 5px;
                padding: 0;
            }

        </style>

    </head>
    <body>


        <!----- Heading part Start----->
        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#"><img src="img/logo_7_cakeshop.png" width="170px"></a>
                </div>
                <ul class="nav navbar-nav navbar-right " >
                    <%
                        if (request.getSession().getAttribute("username") != null) {

                            try {
                                POJOs.Supplier customer = (POJOs.Supplier) request.getSession().getAttribute("username");
                                
                                Session session1 =POJOs.session_pool_manager.getSessionFactory().openSession();
                                
                                POJOs.Supplier supplier =(POJOs.Supplier)session1.load(POJOs.Supplier.class, customer.getEmail());
                                
                                String status =supplier.getStatus().getStatus();
                                
                                if(status.equals("deactive")){
                                    response.sendRedirect("logout");
                                }
                                
                                        
                                
                    %>
                    <li><a name = "username" id = "username" ><span class="glyphicon glyphicon-user ">  <%=customer.getEmail()%></span> </a> </li>
                    <li><a href="logout">Logout</a></li>
                        <%
                                } catch (Exception e) {
                                    response.sendRedirect("index.jsp");
                                }

                            }
                        %>
                </ul>
            </div>
        </nav>
        <div class="container-fluid">
            <div class="row">
                <%
                    if (request.getSession().getAttribute("username") != null) {
                        try {
                            POJOs.Supplier supplier = (POJOs.Supplier) request.getSession().getAttribute("username");

                %>
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <ul class="nav navbar-nav navbar-right " >
                            <li><a href="Supplier_Main_Home.jsp">All Products</a></li>
                            <li><a href="SupplierNewOrders.jsp">New Orders  <span class="badge" ><%=new classess.getNewOrder().getNewOrderCount(supplier) %></span></a></li>
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
                    }else{
                        response.sendRedirect("index.jsp");
                    }
                %>
            </div>
            <!----- Heading part Finish--->

            <!---- Main content start----->
            <div class="row">
                <div class="col-md-8 col-md-offset-1">
                    <div class="panel-default">
                        <div class="panel-heading">Supplier Products</div>
                        <div class="panel-body">
                            <%
                                if (request.getSession().getAttribute("username") != null) {
                                    int itemCount = 0;
                                    double price = 0;
                                    POJOs.Supplier supplier1 = (POJOs.Supplier) request.getSession().getAttribute("username");
                                    Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                                    POJOs.Supplier supplier = (POJOs.Supplier) session1.load(POJOs.Supplier.class, supplier1.getEmail());

                                    Criteria getProductsCriteria = session1.createCriteria(POJOs.Product.class);
                                    getProductsCriteria.add(Restrictions.eq("supplier", supplier));
                                    getProductsCriteria.add(Restrictions.eq("productStatus", new classess.tools().getProductActiveStatus()));
                                    getProductsCriteria.addOrder(Order.desc("systemDate"));

                                    List<POJOs.Product> productList = getProductsCriteria.list();

                                    if (!productList.isEmpty()) {
                            %>
                            <table class="table table-responsive col-md-10">
                                <thead >
                                    <tr>
                                        <th></th>
                                        <th class="text-center" >Details</th>
                                        <th class="text-center" ></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < productList.size(); i++) {
                                            POJOs.Product product = productList.get(i);

                                            Criteria imagedataCriteria = session1.createCriteria(POJOs.ProductImage.class);
                                            imagedataCriteria.add(Restrictions.eq("product", product));

                                            List<POJOs.ProductImage> productImageList = imagedataCriteria.list();
                                    %>
                                    <tr>
                                        <%
                                            if (!productImageList.isEmpty()) {
                                                ProductImage productImage = productImageList.get(0);
                                        %>



                                        <td> <img src="<%=productImage.getProductImagePath()%>" class="img-responsive img-thumbnail" width="150px" height="200px"></td>

                                        <%
                                            }
                                        %>
                                        <td class="text-center">
                                <lable>Product Name :</lable>
                                <lable><%=product.getProductName()%></lable><br>
                                <label>Quantity :</label>
                                <label><%=product.getQty()%></label><br>
                                <label>Sold Quantity :</label>
                                <label><%=product.getSold()%></label><br>
                                <label>Price :</label>
                                <label><%=product.getPrice()%></label><br>


                                </td>
                                <td>
                                    <a class="btn btn-warning" href="editProduct.jsp?id=<%=product.getIdproduct()%>">Edit Details</a>
                                    <a class="btn btn-success" href="viewProduct.jsp?id=<%=product.getIdproduct()%>">View Details</a>

                                </td>
                                </tr>
                                <%
                                    }
                                %>

                                </tbody>
                            </table>
                            <%
                            } else {
                            %>
                            <center class="text-warning">No Data Found !</center>
                                <%
                                        }
                                    } else {

                                        response.sendRedirect("index.jsp");
                                    }

                                %>


                        </div>
                    </div>
                </div>
                <div class="col-md-2">

                </div>
            </div>

        </div>
    </body>
</html>
