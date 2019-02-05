<%-- 
    Document   : cart
    Created on : 11-Oct-2016, 04:01:00
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
        <title>My Cart</title>

        <style type="text/css">

            #cartItems{

                box-shadow: 0 0 6px 1px #245269;
            }

            #extraButtons{
                margin-right: 20px;

            }
            #qtymsg{
                color: #ff6666;

            }

        </style>

        <script type="text/javascript">

            function  Update(id) {
                var qty = parseInt(document.getElementById("qty" + id).value);
                var avqty = parseInt(document.getElementById("lbl" + id).innerHTML.split("-")[1]);

                if (qty <= avqty) {
                    $.ajax({
                        url: "updateCart",
                        type: 'POST',
                        data: {
                            id: id, qty: qty
                        },
                        success: function(data, textStatus, jqXHR) {
                            //document.getElementById("avqty").innerHTML=balanceqty;
                            location.reload(true);
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            alert(jqXHR);
                        }

                    });

                } else {

                    document.getElementById("qtymsg").innerHTML = "Please Check the Quantity";

                }

            }

            function edit(id) {

                document.getElementById(id).removeAttribute("hidden");
                document.getElementById("qty" + id).removeAttribute("disabled");
                document.getElementById("lbl" + id).removeAttribute("hidden");

            }

        </script>

    </head>
    <body>

        <!--Navigation Start-->

        <nav class="navbar navbar-inverse"  style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">My Cart </a>
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


        <!--Content Start-->

        <div class="container-fluid">
            <!--Item list-->
            <div class="col-md-9">
                <label style="font-size: xx-large">Cart Details</label>
                <div id="cartList">

                    <%
                        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                        Criteria getcartDetailsCriteria = session1.createCriteria(POJOs.CartDetails.class);
                        getcartDetailsCriteria.add(Restrictions.eq("customer", (POJOs.Customer) request.getSession().getAttribute("username")));

                        POJOs.CartDetails cartDetail = (POJOs.CartDetails) getcartDetailsCriteria.uniqueResult();

                        Criteria getCartItemsCriteria = session1.createCriteria(POJOs.ProductHasCartDetails.class);
                        getCartItemsCriteria.add(Restrictions.eq("cartDetails", cartDetail));
                        getCartItemsCriteria.add(Restrictions.eq("status", new classess.tools().getActiveStatus()));

                        List<POJOs.ProductHasCartDetails> productHasCartDetailses = getCartItemsCriteria.list();

                        if (!productHasCartDetailses.isEmpty()) {
                    %>
                    <table class="table table-striped col-md-11">
                        <thead >
                            <tr>
                                <th></th>
                                <th class="text-center" >Details</th>
                                <th class="text-center" >Payment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < productHasCartDetailses.size(); i++) {
                                    ProductHasCartDetails productHasCartDetail = productHasCartDetailses.get(i);
                                    POJOs.Product product = productHasCartDetail.getProduct();
                                    
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
                        <label>Date :</label>
                        <label><%=productHasCartDetail.getSystemDate().getSysDate()%></label><br>
                        <label>Quantity :</label>
                        <input id="qty<%=productHasCartDetail.getIdproductHasCartDetails()%>" type="number" name="qty" min="1" value="<%=productHasCartDetail.getQty()%>" max="<%=product.getQty()%>" disabled/><br>
                        <label id="lbl<%=productHasCartDetail.getIdproductHasCartDetails()%>" hidden>Available Qty -<%=product.getQty()%></label><br>
                        <label id="qtymsg"></label><br>
                        <input type="hidden" name="cartID" value="<%=productHasCartDetail.getIdproductHasCartDetails()%>" >

                        </td>
                        <td class="text-center">
                            <%
                                double sellingPrice = product.getSellingPrice();
                                int qty = productHasCartDetail.getQty();
                                double totalPrice = sellingPrice * qty;

                            %>
                            <label style="font-size: xx-large">Rs :  <%=totalPrice%></label>
                            <aside id="extraButtons">
                                <div class="row">
                                    <a style="text-decoration: none" href="cartRemove?id=<%=productHasCartDetail.getIdproductHasCartDetails()%>" >Remove</a>  |  
                                    <a style="text-decoration: none" href="saveForLater?id=<%=productHasCartDetail.getIdproductHasCartDetails()%>" >Later</a>
                                </div>
                                <div class="row">
                                    <a style="text-decoration: none" onclick="edit(<%=productHasCartDetail.getIdproductHasCartDetails()%>)" >Edit</a>  |
                                    <a id="<%=productHasCartDetail.getIdproductHasCartDetails()%>" hidden style="text-decoration: none" onclick="Update(<%=productHasCartDetail.getIdproductHasCartDetails()%>)">Save</a>
                                </div>

                            </aside>
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

                    <p class="text-center text-warning">Your Cart is Empty !</p>

                    <%
                        }

                    %>
                </div>

            </div>
            <!--Payment Details-->
            <div class="col-md-3" style="margin-top: 45px;">
                <div class="panel panel-success">
                    <div class="panel panel-heading"><h4>Cart Summery</h4></div>
                    <div class="panel panel-body">
                        <div class="form-group">
                            <%                                POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");

                                Criteria getcartDetailsCriteria1 = session1.createCriteria(POJOs.CartDetails.class);
                                getcartDetailsCriteria1.add(Restrictions.eq("customer", customer));

                                POJOs.CartDetails cartDetail1 = (POJOs.CartDetails) getcartDetailsCriteria.uniqueResult();

                                Criteria getCartItemsCriteria1 = session1.createCriteria(POJOs.ProductHasCartDetails.class);
                                getCartItemsCriteria1.add(Restrictions.eq("cartDetails", cartDetail1));
                                getCartItemsCriteria1.add(Restrictions.eq("status", new classess.tools().getActiveStatus()));

                                List<POJOs.ProductHasCartDetails> hasCartDetailses = getCartItemsCriteria1.list();

                                double total = 0;
                                String to = "";
                                if (!hasCartDetailses.isEmpty()) {

                                    for (int i = 0; i < hasCartDetailses.size(); i++) {
                                        ProductHasCartDetails details = hasCartDetailses.get(i);
                                        int qty = details.getQty();
                                        double price = details.getProduct().getSellingPrice();
                                        double price1 = qty * price;
                                        total += price1;
                                        to = String.format("%1$.2f", total);
                                    }
                                }

                            %>
                            <label style="font-size: larger">Total Payment </label>
                            <label class="text-info" style="font-size: xx-large" id="totalPayment"><%=to%></label>
                        </div>
                        <div class="form-group">
                            <a class="btn btn-primary pull-right" href="chekout.jsp" >Check Out</a>
                        </div>
                        <div class="form-group">
                            <p class="pull-right" > Covers your purchase price plus original shipping on virtually all items.</p>
                        </div>

                    </div>
                </div>

            </div>
        </div>


        <!--Content End-->



    </body>
</html>
