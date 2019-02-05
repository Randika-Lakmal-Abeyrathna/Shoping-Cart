<%-- 
    Document   : Product
    Created on : 06-Oct-2016, 23:11:26
    Author     : Randika Lakmal
--%>

<%@page import="POJOs.ProductImage"%>
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

        <style type="text/css">
            #priceDiv{
                box-shadow: 0 0 6px 1px #245269;
            }
            #ButtonDiv{
                float: right;

            }
            #buttons{
                margin-right: 15px;

            }
            #qtymsg{
                color: red;

            }
        </style>


        <script type="text/javascript">

            function addToWatchList(id) {
                
                $.ajax({
                    url: "addToWatchList",
                    type: 'POST',
                    data: {
                        pid: id
                    },
                    success: function(data, textStatus, jqXHR) {
                      
                        document.getElementById("watchList").innerHTML = data;
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });


            }

            function checkqty(qty) {
                var inputqty = parseInt(document.getElementById("qty").value);

                var availableqty = parseInt(document.getElementById("avqty").innerHTML);

                if (inputqty === availableqty) {
                    alert(inputqty);
                    alert(availableqty);

                }

                if (inputqty <= availableqty) {
                    document.getElementById("qtymsg").innerHTML = "";
                } else {
                    document.getElementById("qtymsg").innerHTML = "Quntity Not valid";

                }

            }

            function hideqtymsg() {
                document.getElementById("qtymsg").innerHTML = "";

            }

             function addToCart(id) {
               
                var pid = id;
                var availabelqty = parseInt(document.getElementById("avqty").innerHTML);
                var qty = parseInt(document.getElementById("qty").value);
                var balanceqty = availabelqty - qty;
                if (qty == "") {
                   
                    document.getElementById("qty").focus();
                } else if (qty > availabelqty) {
                   
            checkqty(qty);
                    document.getElementById("qty").focus();
                } else {
                  
                    $.ajax({
                        url: "addToCart",
                        type: 'POST',
                        data: {
                            pid: id, qty: qty
                        },
                        success: function(data, textStatus, jqXHR) {
                            
                            document.getElementById("avqty").innerHTML=balanceqty;
                            document.getElementById("cartList").innerHTML = data;
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            alert(jqXHR);
                        }

                    });

                }




            }


        </script>

        <title>Product Details</title>
    </head>
    <body>
        <!--Navigation Start-->

        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Product Details </a>
                </div>
                <ul class="nav navbar-nav navbar-right " >
                    <%
                        if (request.getSession().getAttribute("username") != null) {

                            try {
                                POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");

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


        <!--Content-->
        <div class="container-fluid">
            <div class="row">
                <%
                    try {
                        Session session1 = new classess.sessionConnect().testConnection();

                        Integer id = Integer.parseInt(request.getParameter("id"));

                        POJOs.Product product = (POJOs.Product) session1.load(POJOs.Product.class, id);

                        Criteria getCategoryDetails = session1.createCriteria(POJOs.CategoryDetails.class);
                        getCategoryDetails.add(Restrictions.eq("product", product));

                        POJOs.CategoryDetails categoryDetail = (POJOs.CategoryDetails) getCategoryDetails.uniqueResult();

                        Criteria getImageDetails = session1.createCriteria(POJOs.ProductImage.class);
                        getImageDetails.add(Restrictions.eq("product", product));

                        List<POJOs.ProductImage> productImageList = getImageDetails.list();

                %>
                <div class="col-md-5">
                    <%                        if (!productImageList.isEmpty()) {
                    %>
                    <div class="carousel slide" id="product" >
                        <ol class="carousel-indicators">
                            <%
                                for (int i = 0; i < productImageList.size(); i++) {

                                    ProductImage productImage = productImageList.get(i);

                                    if (i == 0) {
                            %>
                            <li data-target="#product" data-slide-to="<%=i%>" class="active"></li>
                                <%
                                } else {
                                %>
                            <li data-target="#product" data-slide-to="<%=i%>" ></li>
                                <%
                                    }
                                %>

                            <%
                                }
                            %>
                        </ol>
                        <div class="carousel-inner">

                            <%
                                for (int i = 0; i < productImageList.size(); i++) {
                                    ProductImage productImage = productImageList.get(i);
                                    if (i == 0) {
                            %>
                            <div class="item active">
                                <img src="<%=productImage.getProductImagePath()%>" alt="First slide">
                            </div>
                            <%
                            } else {
                            %>
                            <div class="item">
                                <img src="<%=productImage.getProductImagePath()%>" alt="First slide">
                            </div>
                            <%
                                    }

                                }

                            %>

                        </div>
                        <a class="carousel-control left" href="#mainSlider"
                           data-slide="prev">&lsaquo;</a>
                        <a class="carousel-control right" href="#mainSlider"
                           data-slide="next">&rsaquo;</a>


                    </div>

                </div>
                <div class="col-md-7">
                    <!--Details-->
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-8">
                               <!--////////////////////////////////////-->
                               <!--////////////////////////////////////-->
                               <!--////////////////////////////////////-->
                               
                               <div class="panel panel-default">
                                    <div class="panel panel-heading"><h2><%=product.getProductName()%></h2></div>
                                    <div class="panel panel-body">
                                        <form action="buyitnow" method="post">
                                            <div class="form-group">
                                                <lable><i>Category :</i></lable>
                                                <label><%=categoryDetail.getTopCategory().getTopCategory()%></label>
                                            </div>
                                            <div class="form-group">
                                                <lable><i>Sub Category :</i></lable>
                                                <label><%=categoryDetail.getSubCategory().getSubCategory()%></label>
                                            </div>
                                            <div class="form-inline">
                                                <lable class="control-label" ><i>Quantity :</i></lable>
                                                <input type="number" min="1" name="qty" value="1" id="qty" max="<%=product.getQty()%>" class="form-control input-sm" onclick="hideqtymsg()" onchange="checkqty(this.value)">
                                                <label id="qtymsg"></label>
                                            </div>
                                            <div class="form-group">
                                                <lable class="control-label" ><i>Available Quantity :</i></lable>
                                                <lable id="avqty" ><%=product.getQty()%></lable>
                                                <lable><i> /Sold:</i></lable>
                                                <lable><%=product.getSold()%></lable>
                                            </div>
                                            <div id="priceDiv" style="background-color: gainsboro">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="text-center">
                                                            <lable style="font-size: xx-large">Price :</lable>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        Rs :<lable style="font-size: xx-large"><%=product.getSellingPrice()%></lable>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                        <input name="id" type="hidden" value="<%=request.getParameter("id") %>">
                                            </div>
                                            <hr>
                                            <div>
                                                <aside id="ButtonDiv">
                                                    <a id="buttons" class="btn btn-primary pull-left" onclick="addToWatchList(<%=request.getParameter("id")%>)" ><span class="glyphicon glyphicon-heart-empty"></span> Add to Watch List</a>
                                                    <a id="buttons" class="btn btn-warning" onclick="addToCart(<%=request.getParameter("id")%>)" > <span class="glyphicon glyphicon-shopping-cart"></span>  Add to Cart</a>
                                                    
                                                    <button type="submit" class="btn btn-success pull-right">
                                                        <i class="glyphicon glyphicon-check"></i> Buy It Now
                                                    </button>
                                                </aside>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                               
                               
                               <!--////////////////////////////////////-->
                               <!--////////////////////////////////////-->
                               <!--////////////////////////////////////-->
                               <!--////////////////////////////////////-->
                               <!--////////////////////////////////////-->
                            </div>
                            <div class="col-md-4">
                                <div class="panel panel-warning">
                                    <div class="panel panel-heading">Supplier Details</div>
                                    <div class="panel panel-body">
                                        <div class="form-group">
                                            
                                            <label>Supplier Name :</label>
                                            <lable><%=product.getSupplier().getCompanyName()%></lable>
                                        </div>
                                        <div class="form-group">
                                            <label>Reg Number :</label>
                                            <lable><%=product.getSupplier().getCompanyRegNumber()%></lable>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>


            </div>
            <div class="row"> 

                <div class="container-fluid">
                    <div class="panel panel-default">
                        <div class="panel panel-heading">Other Details</div>
                        <div class="panel panel-body">
                            <aside>
                                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#description" >More Details About Product</button>
                                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#deliver" >Delivering And Conditions</button>
                            </aside>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="description">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header"><h4>Product Description </h4></div>
                            <div class="modal-body">
                                <p>
                                    <%=product.getDeiscription()%>
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal fade" id="deliver">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header"><h4>Deliver And Conditions</h4></div>
                            <div class="modal-body">
                                <p>
                                    We deliver within 10-20 business days.<br>
                                    Conditions<br>
                                    - The Product color may be differ according to your devices Performances<br>
                                    - No Returns allowed
                                </p>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
            <%                            }

                } catch (Exception e) {
                    response.sendRedirect("index.jsp");

                }
            %>
        </div>
    </body>
</html>
