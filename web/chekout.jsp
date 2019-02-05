<%-- 
    Document   : chekout
    Created on : Oct 12, 2016, 12:00:42 PM
    Author     : Randika Lakmal
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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

        <style type="text/css">
            #paymentType{

                box-shadow: 0 0 6px 1px #245269;

            }
            #citymsg{
                color: #fd6565;

            }
            #status{
                color: #fd6565;

            }
        </style>


        <script type="text/javascript">
             function preventBack() {
                window.history.forward();
            }
            setTimeout("preventBack()", 0);
            window.onunload = function() {
                null
            };

            function checkCity() {
                var city = document.getElementById("city11").value;
                $.ajax({
                    url: "checkShippingCity",
                    type: 'POST',
                    data: {
                        city: city
                    },
                    success: function(data, textStatus, jqXHR) {

                        if (data == "0") {
                            document.getElementById("citymsg").innerHTML = "This product Will not Be Deliver To This Address, Try Changeing your Address";
                            document.getElementById("saveButton").setAttribute("disabled", "true");
                            document.getElementById("unitDeliverCost").value = data;
                            document.getElementById("GrandTotal").innerHTML = "00.00";
                            document.getElementById("DeliverCost").innerHTML = 0;
                        } else {
                            document.getElementById("citymsg").innerHTML = "";
                            document.getElementById("saveButton").removeAttribute("disabled");
                            document.getElementById("unitDeliverCost").value = data;

                            GrandTotal();

                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });

            }

            function GrandTotal() {
                var unitDeliverCost = parseFloat(document.getElementById("unitDeliverCost").value);
                var itemCount = parseFloat(document.getElementById("totalItemCount").value);

                var deliverCost = unitDeliverCost * itemCount;

                document.getElementById("DeliverCost").innerHTML = deliverCost;

                var totalPrice = parseFloat(document.getElementById("totalPrice").value);

                var GrandPrice = deliverCost + totalPrice;

                document.getElementById("GrandTotal").innerHTML = GrandPrice;


            }

            function calculateH() {
                var h = document.getElementById("item123").innerHTML;
                var h1 = document.getElementById("per1").innerHTML;

                var shipping = document.getElementById("shippingCost").innerHTML = h * h1;

                var tot = document.getElementById("price1").innerHTML;

                var Total = parseFloat(shipping) + parseFloat(tot);

                document.getElementById("total").innerHTML = Total;

            }

            function hiteCityLabelText() {
                document.getElementById("citymsg").innerHTML = "";

            }

            function setEditable() {
                document.getElementById("Cname").removeAttribute("disabled");
                document.getElementById("Ano").removeAttribute("disabled");
                document.getElementById("s1").removeAttribute("disabled");
                document.getElementById("s2").removeAttribute("disabled");
                document.getElementById("city1").removeAttribute("disabled");
                document.getElementById("savelink").removeAttribute("hidden");
                document.getElementById("divider").removeAttribute("hidden");


            }
            function enableEditable() {

                document.getElementById("Cname1").value = document.getElementById("Cname").value;
                document.getElementById("Ano1").value = document.getElementById("Ano").value;
                document.getElementById("s11").value = document.getElementById("s1").value;
                document.getElementById("s21").value = document.getElementById("s2").value;
                document.getElementById("city11").value = document.getElementById("city1").value;

                document.getElementById("city1").setAttribute("disabled", "true");
                document.getElementById("Cname").setAttribute("disabled", "true");
                document.getElementById("Ano").setAttribute("disabled", "true");
                document.getElementById("s1").setAttribute("disabled", "true");
                document.getElementById("s2").setAttribute("disabled", "true");
                document.getElementById("city1").setAttribute("disabled", "true");
                document.getElementById("savelink").setAttribute("hidden", "true");
                document.getElementById("divider").setAttribute("hidden", "true");

                checkCity();

            }

        </script>
        <title>Check Out</title>
    </head>
    <body>

        <!--Navigation Start-->

        <nav class="navbar navbar-inverse"  style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a  class="navbar-brand" href="#">My Cart </a>
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
                    `

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
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        %>


        <div class="container-fluid">
            <div class="row">
                <%
                    if (request.getParameter("id") == null) {
                        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                        POJOs.Customer customer1 = (POJOs.Customer) request.getSession().getAttribute("username");

                        POJOs.Customer customer = (POJOs.Customer) session1.load(POJOs.Customer.class, customer1.getEmail());

                %>
                <form action="chekout" method="post" >   
                    <!--Cart Details-->
                    <div class="col-md-9">
                        <div class="panel panel-default ">
                            <div class="panel panel-heading">Main Details</div>
                            <div class="panel panel-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="panel panel-default">
                                            <div class="panel panel-heading">Deliver Details</div>
                                            <div class="panel panel-body">
                                                <div class="form-group">
                                                    <label>Customer Name</label>
                                                    <input id="Cname" disabled type="text" class="form-control name" value="<%=customer.getFirstName() + " " + customer.getLastName()%>">
                                                    <input  id="Cname1"type="hidden" name="name" class="name" value="<%=customer.getFirstName() + " " + customer.getLastName()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label>Address No</label>
                                                    <input id="Ano" disabled type="text" class="form-control addno" value="<%=customer.getAddressNo()%>">
                                                    <input id="Ano1" type="hidden" name="addno" class="addno" value="<%=customer.getAddressNo()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label>Street 1</label>
                                                    <input id="s1" disabled type="text" class="form-control st1" value="<%=customer.getAddressStreet()%>">
                                                    <input id="s11" type="hidden" name="st1" class="st1" value="<%=customer.getAddressStreet()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label>Street 2</label>
                                                    <input id="s2" disabled type="text" class="form-control st2" value="<%=customer.getAddressStreet2()%>">
                                                    <input id="s21" type="hidden" name="st2" class="st2" value="<%=customer.getAddressStreet2()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label>City</label>
                                                    <input id="city1" disabled type="text" class="form-control city" value="<%=customer.getCity().getCity()%>" onfocus="hiteCityLabelText()" onclick="hiteCityLabelText()">
                                                    <input id="city11" type="hidden" name="city" class="city" value="<%=customer.getCity().getCity()%> " >

                                                </div>
                                                <div class="form-group">
                                                    <%

                                                        Criteria getShipingCity = session1.createCriteria(POJOs.ShipingDetails.class);
                                                        getShipingCity.add(Restrictions.eq("city", customer.getCity().getCity()));

                                                        List<POJOs.ShipingDetails> shipingDetailses = getShipingCity.list();
                                                        double shippingCostPerUnit = 0;
                                                        String msg = "";
                                                        if (!shipingDetailses.isEmpty()) {
                                                            for (int i = 0; i < shipingDetailses.size(); i++) {
                                                                POJOs.ShipingDetails details = shipingDetailses.get(i);
                                                                shippingCostPerUnit = details.getCost();
                                                                msg = "";
                                                            }
                                                        } else {
                                                            msg = "This product Will not Be Deliver To This Address, Try Changeing your Address";
                                                        }
                                                    %>
                                                    <label id="citymsg"><%=msg%></label>
                                                    <%
                                                    %>
                                                    <input id="unitDeliverCost" type="hidden" value="<%=shippingCostPerUnit%>"  >

                                                    <div class="row">
                                                        <div class="col-md-5 text-right" ><a id="savelink" hidden onclick="enableEditable()">Save</a> </div>
                                                        <div class="col-md-1 text-right" ><div id="divider" hidden> | </div></div>
                                                        <div class="col-md-6" ><a onclick="setEditable()">Chenge Deliver Address</a></div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="panel panel-default">
                                            <div class="panel panel-heading">Payment Method</div>
                                            <div class="panel panel-body">
                                                <div class="form-group">
                                                    <input type="radio" name="cradit" class="radio radio-inline col-md-2" checked><lable class="control-label col-md-5" >Cradit Card</lable>
                                                    <!--<img class="col-md-4" src="img/1.jpg" height="50px" width="150px">-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="container-fluid">
                                        <div class="panel panel-default">
                                            <div class="panel panel-heading">Item Details</div>
                                            <div class="panel panel-body">
                                                <%

                                                    int itemCount = 0;
                                                    double price = 0;

                                                    Criteria getCartDetails = session1.createCriteria(POJOs.CartDetails.class);
                                                    getCartDetails.add(Restrictions.eq("customer", customer));

                                                    POJOs.CartDetails cartDetails = (POJOs.CartDetails) getCartDetails.uniqueResult();

                                                    Criteria getCartItems = session1.createCriteria(POJOs.ProductHasCartDetails.class);
                                                    getCartItems.add(Restrictions.eq("cartDetails", cartDetails));
                                                    getCartItems.add(Restrictions.eq("status", new classess.tools().getActiveStatus()));

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
                                                    </tr>
                                                    <%
                                                        }
                                                    %>

                                                    </tbody>
                                                </table>
                                                <%
                                                    } else {

                                                        response.sendRedirect("cart.jsp");
                                                    }

                                                %>



                                                <input id="totalItemCount" type="hidden" value="<%=itemCount%>">
                                                <input id="totalPrice" type="hidden" value="<%=price%>">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>

                    <!--Full Total-->
                    <div class="col-md-3">

                        <div class="container-fluid">
                            <div class="row">
                                <div class="panel panel-primary">
                                    <div class="panel panel-heading"> Payment Details</div>
                                    <div class="panel panel-body">

                                        <div class="form-group">
                                            <i>Item(s) Count</i><label class="pull-right"><%=itemCount%></label>
                                        </div>
                                        <div class="form-group">
                                            <%
                                                if (shippingCostPerUnit == 0) {

                                            %>
                                            <i>Diliver Cost</i><label class="pull-right" id="DeliverCost">0</label>

                                            <%                                            } else {

                                                double shipingcost = itemCount * shippingCostPerUnit;

                                            %>
                                            <i>Diliver Cost</i><label class="pull-right" id="DeliverCost"><%=shipingcost%></label>

                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="form-group">
                                            <i>Price</i><label class="pull-right"><%=price%></label>
                                        </div>
                                        <hr>
                                        <div class="form-group">
                                            <%
                                                if (shippingCostPerUnit == 0) {

                                            %>
                                            <label style="font-size: x-large;">Grand Total</label><label style="font-size: x-large;" class="pull-right" id="GrandTotal">0</label>

                                            <%                                            } else {

                                                double Gtotal = (itemCount * shippingCostPerUnit) + price;

                                            %>
                                            <label style="font-size: x-large;">Grand Total</label><label style="font-size: x-large;" class="pull-right" id="GrandTotal"><%=Gtotal%></label>

                                            <%
                                                }
                                            %>
                                        </div>

                                    </div>
                                    <div class="panel panel-footer">
                                        <%
                                            if (!shipingDetailses.isEmpty()) {
                                        %>
                                        <input id="saveButton" class="btn btn-primary pull-right" type="submit" value="Payment" >
                                        <%
                                        } else {
                                        %>
                                        <input id="saveButton" class="btn btn-primary pull-right" disabled type="submit" value="Payment" >

                                        <%
                                            }

                                        %>    
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </form>
                <%                } else {
                        
                    Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                    POJOs.Customer customer1 = (POJOs.Customer) request.getSession().getAttribute("username");

                    POJOs.Customer customer = (POJOs.Customer) session1.load(POJOs.Customer.class, customer1.getEmail());

                %>
                <form action="chekout" method="post" >   
                    <!--Cart Details-->
                    <div class="col-md-9">
                        <div class="panel panel-default ">
                            <div class="panel panel-heading">Main Details</div>
                            <div class="panel panel-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="panel panel-default">
                                            <div class="panel panel-heading">Deliver Details</div>
                                            <div class="panel panel-body">
                                                <div class="form-group">
                                                    <label>Customer Name</label>
                                                    <input id="Cname" disabled type="text" class="form-control name" value="<%=customer.getFirstName() + " " + customer.getLastName()%>">
                                                    <input  id="Cname1"type="hidden" name="name" class="name" value="<%=customer.getFirstName() + " " + customer.getLastName()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label>Address No</label>
                                                    <input id="Ano" disabled type="text" class="form-control addno" value="<%=customer.getAddressNo()%>">
                                                    <input id="Ano1" type="hidden" name="addno" class="addno" value="<%=customer.getAddressNo()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label>Street 1</label>
                                                    <input id="s1" disabled type="text" class="form-control st1" value="<%=customer.getAddressStreet()%>">
                                                    <input id="s11" type="hidden" name="st1" class="st1" value="<%=customer.getAddressStreet()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label>Street 2</label>
                                                    <input id="s2" disabled type="text" class="form-control st2" value="<%=customer.getAddressStreet2()%>">
                                                    <input id="s21" type="hidden" name="st2" class="st2" value="<%=customer.getAddressStreet2()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label>City</label>
                                                    <input id="city1" disabled type="text" class="form-control city" value="<%=customer.getCity().getCity()%>" onfocus="hiteCityLabelText()" onclick="hiteCityLabelText()">
                                                    <input id="city11" type="hidden" name="city" class="city" value="<%=customer.getCity().getCity()%> " >

                                                </div>
                                                <div class="form-group">
                                                    <%

                                                        Criteria getShipingCity = session1.createCriteria(POJOs.ShipingDetails.class);
                                                        getShipingCity.add(Restrictions.eq("city", customer.getCity().getCity()));

                                                        List<POJOs.ShipingDetails> shipingDetailses = getShipingCity.list();
                                                        double shippingCostPerUnit = 0;
                                                        String msg = "";
                                                        if (!shipingDetailses.isEmpty()) {
                                                            for (int i = 0; i < shipingDetailses.size(); i++) {
                                                                POJOs.ShipingDetails details = shipingDetailses.get(i);
                                                                shippingCostPerUnit = details.getCost();
                                                                msg = "";
                                                            }
                                                        } else {
                                                            msg = "This product Will not Be Deliver To This Address, Try Changeing your Address";
                                                        }
                                                    %>
                                                    <label id="citymsg"><%=msg%></label>
                                                    <%
                                                    %>
                                                    <input id="unitDeliverCost" type="hidden" value="<%=shippingCostPerUnit%>"  >

                                                    <div class="row">
                                                        <div class="col-md-5 text-right" ><a id="savelink" hidden onclick="enableEditable()">Save</a> </div>
                                                        <div class="col-md-1 text-right" ><div id="divider" hidden> | </div></div>
                                                        <div class="col-md-6" ><a onclick="setEditable()">Chenge Deliver Address</a></div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="panel panel-default">
                                            <div class="panel panel-heading">Payment Method</div>
                                            <div class="panel panel-body">
                                                <div class="form-group">
                                                    <input type="radio" name="cradit" class="radio radio-inline col-md-2" checked><lable class="control-label col-md-5" >Cradit Card</lable>
                                                    <!--<img class="col-md-4" src="img/1.jpg" height="50px" width="150px">-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="container-fluid">
                                        <div class="panel panel-default">
                                            <div class="panel panel-heading">Item Details</div>
                                            <div class="panel panel-body">
                                                <%

                                                    int itemCount = 0;
                                                    double price = 0;
                                                    String id = request.getParameter("id");
                                                    String qty = request.getParameter("qty");
                                                    
                                                    int quntity = Integer.parseInt(qty);
                                                    
                                                    POJOs.Product product = (POJOs.Product)session1.load(POJOs.Product.class, Integer.parseInt(id));

                                                %>
                                                
                                                <input name="byuitnow" type="hidden" value="">
                                                <input name="id" type="hidden" value="<%=id %>">
                                                <input name="qty" type="hidden" value="<%=qty %>">
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
                                                            

                                                                itemCount = quntity;

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
                                                    <label><%=quntity %></label><br>
                                                    <label>Date :</label>
                                                    <label><%=new SimpleDateFormat("YYYY-MM-dd").format(new Date()) %></label><br>


                                                    </td>
                                                    <td class="text-center">
                                                        <%
                                                            double sellingPrice = product.getSellingPrice();
                                                           
                                                            double totalPrice = sellingPrice * quntity;

                                                            price += totalPrice;
                                                        %>
                                                        <label style="font-size: xx-large">Rs :  <%=totalPrice%></label>

                                                    </td>
                                                    </tr>
                                                   

                                                    </tbody>
                                                </table>
                                                <%
                                                   

                                                %>



                                                <input id="totalItemCount" type="hidden" value="<%=itemCount%>">
                                                <input id="totalPrice" type="hidden" value="<%=price%>">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>

                    <!--Full Total-->
                    <div class="col-md-3">

                        <div class="container-fluid">
                            <div class="row">
                                <div class="panel panel-primary">
                                    <div class="panel panel-heading"> Payment Details</div>
                                    <div class="panel panel-body">

                                        <div class="form-group">
                                            <i>Item(s) Count</i><label class="pull-right"><%=itemCount%></label>
                                        </div>
                                        <div class="form-group">
                                            <%
                                                if (shippingCostPerUnit == 0) {

                                            %>
                                            <i>Diliver Cost</i><label class="pull-right" id="DeliverCost">0</label>

                                            <%                                            } else {

                                                double shipingcost = itemCount * shippingCostPerUnit;

                                            %>
                                            <i>Diliver Cost</i><label class="pull-right" id="DeliverCost"><%=shipingcost%></label>

                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="form-group">
                                            <i>Price</i><label class="pull-right"><%=price%></label>
                                        </div>
                                        <hr>
                                        <div class="form-group">
                                            <%
                                                if (shippingCostPerUnit == 0) {

                                            %>
                                            <label style="font-size: x-large;">Grand Total</label><label style="font-size: x-large;" class="pull-right" id="GrandTotal">0</label>

                                            <%                                            } else {

                                                double Gtotal = (itemCount * shippingCostPerUnit) + price;

                                            %>
                                            <label style="font-size: x-large;">Grand Total</label><label style="font-size: x-large;" class="pull-right" id="GrandTotal"><%=Gtotal%></label>

                                            <%
                                                }
                                            %>
                                        </div>

                                    </div>
                                    <div class="panel panel-footer">
                                        <%
                                            if (!shipingDetailses.isEmpty()) {
                                        %>
                                        <input id="saveButton" class="btn btn-primary pull-right" type="submit" value="Payment" >
                                        <%
                                        } else {
                                        %>
                                        <input id="saveButton" class="btn btn-primary pull-right" disabled type="submit" value="Payment" >

                                        <%
                                            }

                                        %>    
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </form>  
                <%                                            }
                %>
            </div>
        </div>

    </body>
</html>
