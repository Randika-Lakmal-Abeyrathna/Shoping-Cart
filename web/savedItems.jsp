<%-- 
    Document   : savedItems
    Created on : Oct 13, 2016, 2:14:33 PM
    Author     : Randika Lakmal
--%>

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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>

        <title>Saved Items</title>
    </head>
    <body>

        <!--Navigation Start-->

        <nav class="navbar navbar-inverse"  style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Saved Items </a>
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
                        <li><a href="savedItems.jsp">Saved Items   <span class="badge" ><%=new classess.getSavedItems().getLaterCount(customer) %></span></a></li>
                        <li><a href="WatchList.jsp">Watch List <span class="badge" id="watchList"><%=new classess.getWatchListCount().getCount(customer)%></span> </a></li>
                        <li><a href="CustomerAccountUpdate.jsp">Account Update</a></li>
                </ul>
            </div>
        </nav>
        <%                        } catch (Exception e) {
                    response.sendRedirect("index.jsp");
                }
            }
        %>

        <!--Content Start-->

        <div class="container-fluid">

            <div class="row">
                <div class="col-md-10 col-md-offset-1">


                    <%
                        if (request.getSession().getAttribute("username") != null) {
                            int itemCount = 0;
                            double price = 0;
                            POJOs.Customer customer1 = (POJOs.Customer) request.getSession().getAttribute("username");
                            Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                            POJOs.Customer customer = (POJOs.Customer) session1.load(POJOs.Customer.class, customer1.getEmail());

                            Criteria getCartDetails = session1.createCriteria(POJOs.CartDetails.class);
                            getCartDetails.add(Restrictions.eq("customer", customer));

                            POJOs.CartDetails cartDetails = (POJOs.CartDetails) getCartDetails.uniqueResult();

                            Criteria getCartItems = session1.createCriteria(POJOs.ProductHasCartDetails.class);
                            getCartItems.add(Restrictions.eq("cartDetails", cartDetails));
                            getCartItems.add(Restrictions.eq("status", new classess.tools().getLaterStatus()));

                            List<POJOs.ProductHasCartDetails> productHasCartDetailseList = getCartItems.list();

                            if (!productHasCartDetailseList.isEmpty()) {
                    %>
                    <table class="table table-responsive col-md-10">
                        <thead >
                            <tr>
                                <th></th>
                                <th class="text-center" >Details</th>
                                <th class="text-center" >Payment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < productHasCartDetailseList.size(); i++) {
                                    ProductHasCartDetails productHasCartDetail = productHasCartDetailseList.get(i);
                                    POJOs.Product product = productHasCartDetail.getProduct();

                                    itemCount += productHasCartDetail.getQty();

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
                        <label>Supplier :</label>
                        <label><%=product.getSupplier().getCompanyName()%></label><br>
                        <label>Quantity :</label>
                        <label><%=productHasCartDetail.getQty()%></label><br>
                        <label>Date :</label>
                        <label><%=productHasCartDetail.getSystemDate().getSysDate()%></label><br>


                        </td>
                        <td class="text-center">
                            <%
                                double sellingPrice = product.getSellingPrice();
                                int qty = productHasCartDetail.getQty();
                                double totalPrice = sellingPrice * qty;

                                price += totalPrice;
                            %>
                            <label style="font-size: xx-large">Rs :  <%=totalPrice%></label>

                        </td>
                        <td>
                            <a class="btn btn-warning" href="savedItemRemove?id=<%=productHasCartDetail.getIdproductHasCartDetails() %>">Remove</a>
                            <a class="btn btn-primary" href="savedItemAddToCart?id=<%=productHasCartDetail.getIdproductHasCartDetails()  %>">Add To Cart</a>

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

                                response.sendRedirect("Home.jsp");
                            }

                        %>

                </div>
            </div>


        </div>
        <!--Content End-->

    </body>
</html>
