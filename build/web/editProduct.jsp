<%-- 
    Document   : editProduct
    Created on : Oct 13, 2016, 8:45:50 PM
    Author     : Randika Lakmal
--%>

<%@page import="java.util.List"%>
<%@page import="POJOs.SubCategory"%>
<%@page import="POJOs.TopCategory"%>
<%@page import="java.util.HashMap"%>
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
        <title>Edit Product Details</title>

        <script type="text/javascript">

            function setSellingPrice(value) {
                $.ajax({
                    url: "Importent",
                    type: 'POST',
                    data: {
                        value: value, msg: "sellingPrice"
                    },
                    success: function(data, textStatus, jqXHR) {
                        document.getElementById("sellingPrice").innerHTML = " " + data;
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });
            }

        </script>

    </head>
    <body>
        <%
            if (request.getParameter("id") != null) {
        %>
        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="">Edit Product Details</a>
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

        <!--Content Area Start-->
        <div class="container-fluid">
            <%
                Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                POJOs.Product product = (POJOs.Product) session1.load(POJOs.Product.class, Integer.parseInt(request.getParameter("id")));

                Criteria getCategoryDetailsCriteria = session1.createCriteria(POJOs.CategoryDetails.class);
                getCategoryDetailsCriteria.add(Restrictions.eq("product", product));

                POJOs.CategoryDetails categoryDetails = (POJOs.CategoryDetails) getCategoryDetailsCriteria.uniqueResult();

                String Top = categoryDetails.getTopCategory().getTopCategory();
                String Sub = categoryDetails.getSubCategory().getSubCategory();
            %>
            <form action="updateProduct" method="post">
                <input type="hidden" name="id"value="<%=request.getParameter("id")%>">
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel panel-heading">Image Details</div>
                        <div class="panel panel-body">
                            <div class="row">
                                <%
                                    Criteria getImageCriteria = session1.createCriteria(POJOs.ProductImage.class);
                                    getImageCriteria.add(Restrictions.eq("product", product));

                                    List<POJOs.ProductImage> productImageList = getImageCriteria.list();

                                    if (!productImageList.isEmpty()) {

                                        for (int i = 0; i < productImageList.size(); i++) {

                                            POJOs.ProductImage productImage = productImageList.get(i);

                                %>
                                <div class="col-md-3">
                                    <img src="<%=productImage.getProductImagePath()%>" class="img-thumbnail">


                                </div>
                                <%

                                        }

                                    }

                                %>

                            </div>
                        </div>

                    </div>
                    <div class="panel">
                        <div class="panel panel-body">
                            <div class="form-group col-md-9">
                                <label class="control-label ">Description</label>
                                <textarea class="form-control col-md-9" name="description" rows="10"><%=product.getDeiscription()%></textarea>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-md-6">

                    <div class="row">
                        <div class="panel panel-default">
                            <div class="panel panel-heading">Basic Information</div>
                            <div class="panel panel-body">
                                <div class="form-group col-md-9">
                                    <label class="control-label ">Product Name</label>
                                    <input type="text" class="form-control col-md-4" name="name" value="<%=product.getProductName()%>"/>
                                </div>
                                <div class="form-group col-md-9">
                                    <label class="control-label ">Quantity</label>
                                    <input type="number" class="form-control col-md-4" name="qty" value="<%=product.getQty()%>"/>
                                </div>
                                <div class="form-group col-md-9">
                                    <label class="control-label ">Price</label>
                                    <input type="number" class="form-control col-md-4" name="price"  value="<%=product.getPrice()%>" onchange="setSellingPrice(this.value)" />
                                    <div>
                                        <i>Selling Price </i><label id="sellingPrice"><%=product.getSellingPrice()%></label>
                                    </div>
                                </div>
                                <div class="form-group col-md-9">
                                    <label class="control-label ">Top Category</label>
                                    <select class="form-control col-md-4" name="topCategory">
                                        <%
                                            HashMap<String, Object> map = new classess.getProductSubDetails().getTopCategory();

                                            if (!map.isEmpty()) {
                                                for (int i = 0; i < map.size(); i++) {
                                                    TopCategory topCategory = (TopCategory) map.get(i + "");

                                                    if (topCategory.getTopCategory().equals(Top)) {


                                        %>
                                        <option selected><%=topCategory.getTopCategory()%></option>
                                        <%
                                        } else {
                                        %>
                                        <option><%=topCategory.getTopCategory()%></option>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </select>

                                </div>
                                <div class="form-group col-md-9">
                                    <label class="control-label ">Sub Category</label>
                                    <select class="form-control col-md-4" name="subCategory">
                                        <%
                                            HashMap<String, Object> map1 = new classess.getProductSubDetails().getSubcategory();

                                            if (!map.isEmpty()) {
                                                for (int i = 0; i < map1.size(); i++) {
                                                    SubCategory subCategory = (SubCategory) map1.get(i + "");

                                                    if (subCategory.getSubCategory().equals(Sub)) {


                                        %>
                                        <option selected ><%=subCategory.getSubCategory()%></option>
                                        <%
                                        } else {
                                        %>
                                        <option><%=subCategory.getSubCategory()%></option>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </select>

                                </div>
                                <div class="form-group col-md-9">
                                    <label class="control-label ">Product Status</label>
                                    <select class="form-control col-md-4" name="status">
                                        <option>Active</option>
                                        <option>Deactive</option>
                                    </select>

                                </div>
                                <div class="form-group col-md-9">
                                    <aside style="float: right; margin-right: 10px; margin-top: 20px;">
                                        <input type="submit" class="btn btn-success" value="Update Details">
                                    </aside>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </form>
        </div>


        <!--Content Area End-->

    </body>
</html>
