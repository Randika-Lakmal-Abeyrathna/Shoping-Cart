<%-- 
    Document   : Home
    Created on : 05-Oct-2016, 12:31:31
    Author     : Randika Lakmal
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Vector"%>
<%@page import="POJOs.Product"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="POJOs.SubCategory"%>
<%@page import="POJOs.TopCategory"%>
<%@page import="java.util.List"%>
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

        <title>Home Page</title>

        <script type="text/javascript">
            $(document).ready(function() {
                $('.carousel').carousel({
                    interval: 3200
                })
            });

            function addToWatchList(id) {
                $.ajax({
                    url: "addToWatchList",
                    type: 'POST',
                    data: {
                        pid: id
                    },
                    success: function(data, textStatus, jqXHR) {
                        document.getElementById("watchList").innerHTML = data;
//                        document.getElementById("message").innerHTML="<div class="alert alert-success"><a class="close" data-dismiss="alert" >&times;</a>Successfully Added to WatchList</div>";
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });


            }

        </script>

        <style type="text/css">
            #searchdiv{
                margin-right: 10px;

            }

        </style>

    </head>
    <body >
        <%

            if (request.getParameter("p") == null) {
                response.sendRedirect("pagination");

            }
        %>
        <!--Navigation Start-->

        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#"><img src="img/logo_7_cakeshop.png" width="170px"></a>
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

                            }

                        } else {
                        %>
                    <li><a href="index.jsp">Login</a></li>

                    <%
                        }
                    %>
                </ul>
            </div>
        </nav>

        <!--Navigation End-->


        <%
            if (request.getSession().getAttribute("username") != null) {


        %>

        <nav class="navbar navbar-default ">
            <div class="container-fluid">
                <div class="row">
                    <ul class="nav navbar-nav navbar-right " >

                        <%                            POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");
                        %>

                        <li><a href="cart.jsp">My Cart    <span class="badge" id="cartList"><%=new classess.getCartCount().getCartCount(customer)%></span> </a></li>
                        <li><a href="CustomerLog.jsp ">History</a></li>
                        <li><a href="savedItems.jsp">Saved Items   <span class="badge" ><%=new classess.getSavedItems().getLaterCount(customer)%></span></a></li>
                        <li><a href="WatchList.jsp">Watch List <span class="badge" id="watchList"><%=new classess.getWatchListCount().getCount(customer)%></span> </a></li>
                        <li><a href="CustomerAccountUpdate.jsp">Account Update</a></li>

                    </ul>
                </div>

            </div>

        </nav>
        <%

            } else {

            }
        %>
        <hr>

        <div class="row" id="message">

        </div>
        <div class="row">

            <!--Main Slider-->
            <div class="container-fluid">
                <div class="carousel slide" id="mainSlider" >
                    <!-- Carousel indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#mainSlider" data-slide-to="0" class="active"></li>
                        <li data-target="#mainSlider" data-slide-to="1" ></li>
                        <li data-target="#mainSlider" data-slide-to="3" ></li>
                        <li data-target="#mainSlider" data-slide-to="4" ></li>
                        <li data-target="#mainSlider" data-slide-to="5" ></li>
                        <li data-target="#mainSlider" data-slide-to="6" ></li>
                        <li data-target="#mainSlider" data-slide-to="7" ></li>
                    </ol>

                    <div class="carousel-inner">
                        <div class="item active">
                            <img src="img/img1.jpg" alt="First slide">
                        </div>
                        <div class="item">
                            <img src="img/img2.jpg" alt="Second slide">
                        </div>
                        <div class="item">
                            <img src="img/img3.jpg" alt="Third slide">
                        </div>
                        <div class="item">
                            <img src="img/img4.jpg" alt="Fourth slide">
                        </div>
                        <div class="item">
                            <img src="img/img5.jpg" alt="5 slide">
                        </div>
                        <div class="item">
                            <img src="img/img6.jpg" alt="6 slide">
                        </div>
                        <div class="item">
                            <img src="img/img7.jpg" alt="7 slide">
                        </div>
                    </div>
                    <a class="carousel-control left" href="#mainSlider"
                       data-slide="prev">&lsaquo;</a>
                    <a class="carousel-control right" href="#mainSlider"
                       data-slide="next">&rsaquo;</a>
                </div>
            </div>
        </div>
        <hr>
        <div class="row">

            <!--Left Side-->
            <div class="col-md-3">
                <div class="panel panel-success">
                    <div class="panel panel-heading"><h4><a href="#search" data-toggle="collapse">Search</a></h4></div>
                    <div id="search" class="collapse panel-collapse">
                        <div class="panel panel-body">
                            <div class="panel panel-default">
                                <div class="panel panel-heading"><a href="#cat" data-toggle="collapse">Category</a></div>
                                <div id="cat" class="collapse panel-collapse in">
                                    <div class="panel panel-body">
                                        <ul class="list">
                                            <%
                                                HashMap<String, Object> map = new classess.getProductSubDetails().getTopCategory();
                                                if (!map.isEmpty()) {
                                                    for (int i = 0; i < map.size(); i++) {
                                                        TopCategory topCategory = (TopCategory) map.get(i + "");

                                            %>
                                            <li><a href="pagination?msg=top&id=<%=topCategory.getTopCategory()%>"><%=topCategory.getTopCategory()%></a></li>
                                                <%

                                                        }
                                                    }
                                                %>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel panel-heading"><a href="#cat" data-toggle="collapse">Flavers</a></div>
                                <div id="cat" class="collapse panel-collapse in">
                                    <div class="panel panel-body">
                                        <ul class="list">
                                            <%
                                                HashMap<String, Object> map1 = new classess.getProductSubDetails().getSubcategory();
                                                if (!map1.isEmpty()) {
                                                    for (int i = 0; i < map1.size(); i++) {
                                                        SubCategory SubCategory = (SubCategory) map1.get(i + "");

                                            %>
                                            <li><a href="pagination?msg=sub&id=<%=SubCategory.getSubCategory()%>"><%=SubCategory.getSubCategory()%></a></li>
                                                <%

                                                        }
                                                    }
                                                %>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel panel-heading"><a href="#PR" data-toggle="collapse">Price Range</a></div>
                                <div id="PR" class="collapse panel-collapse in">
                                    <div class="panel panel-body">
                                        <form action="pagination?msg=search" method="post">

                                            <div class="form-group">
                                                <label class="control-label ">Price Range</label><br>
                                                <label class="col-md-3">Min</label><input  class="col-md-3 form-control" type="number" name="min" value="00.00"/>
                                                <label class="col-md-3">Max</label><input class="col-md-3 form-control" type="number" name="max" value="00.00"/>
                                            </div> 
                                            <div class="form-group">
                                                <div class="pull-right">

                                                    <input type="submit" value="Search" class="btn btn-primary" style="margin-top: 10px;">
                                                </div>
                                            </div>

                                        </form>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>

            <!--Right Side-->
            <div class="col-md-9">
                <div class="panel panel-default">
                    <div class="panel panel-heading">Products</div>
                    <div class="panel panel-body">
                        <div class="row">
                            <%
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


                            %>
                            <div class="col-md-4">
                                <div class="panel panel-default">
                                    <div class="panel panel-heading"><h4><%=product.getProductName()%></h4></div>
                                    <div class="panel panel-body">
                                        <div class="row text-center">
                                            <img src="<%=path%>" class="img-thumbnail img-responsive col-md-10 col-lg-offset-1" >
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="control-label col-md-5">Price</label>
                                                <label class="control-label col-md-6 pull-right "><strong><%=product.getSellingPrice()%></strong></label>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-5">Quantity</label>
                                                <label class="control-label pull-right col-md-6 "><strong><%=product.getQty()%></strong></label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <%

                                                try {
                                                    POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");
                                                    if (customer != null) {
                                            %>
                                            <input type="button" value="Add to Watch List" class="btn btn-warning pull-left" style="margin-left: 10px;" onclick="addToWatchList(<%=product.getIdproduct()%>)"> 

                                            <%
                                                    }
                                                } catch (Exception e) {

                                                }
                                            %>
                                            <a href="Product.jsp?id=<%=product.getIdproduct()%>" class="btn btn-default pull-right" style="margin-right: 10px;">More Details</a>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                    <div class="panel panel-footer">

                        <div class="container-fluid">
                            <div class="text-center">
                                <ul class="pagination">
                                    <%
                                        try {
                                            if (currentPage != 1) {
                                    %>
                                    <li class="previous"><a href="Home.jsp?p=<%=(currentPage - 1)%>">Previous</a></li>

                                    <%
                                        }

                                        for (int j = 1; j <= pages; j++) {

                                    %>
                                    <li class="<% if (currentPage == j) {
                                            out.print("active");
                                        }%>"><a href="Home.jsp?p=<%=j%>"><%=j%></a></li>
                                        <%                                                }

                                            if (currentPage != pages) {
                                        %>
                                    <li class="next"><a href="Home.jsp?p=<%=currentPage + 1%>">Next</a></li>
                                        <%

                                                }
                                            } catch (Exception e) {
                                            }
                                        %>
                                </ul>
                            </div>

                        </div>


                    </div>

                    <%
                            }
                        }

                    %>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="Footer.jsp" %>
</html>
