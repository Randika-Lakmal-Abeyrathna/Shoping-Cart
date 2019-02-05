<%-- 
    Document   : CustomerAccountUpdate
    Created on : Oct 14, 2016, 11:27:34 PM
    Author     : Randika Lakmal
--%>

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
        <title>Update Details</title>
    </head>
    <body>
        <!--Navigation Start-->

        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Update Details </a>
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


        %>

        <nav class="navbar navbar-default ">
            <div class="container-fluid">
                <div class="row">
                    <ul class="nav navbar-nav navbar-right " >

                        <%                            POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");
                        %>

                        <li><a href="cart.jsp">My Cart    <span class="badge" id="cartList"><%=new classess.getCartCount().getCartCount(customer)%></span> </a></li>
                        <li><a href="CustomerLog.jsp ">History</a></li>
                        <li><a href="savedItems.jsp">Saved Items   <span class="badge" ><%=new classess.getSavedItems().getLaterCount(customer) %></span></a></li>
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

        <div class="container-fluid">
            <div class="row">
                
                <%
                if(request.getSession().getAttribute("username") != null){
                POJOs.Customer customer1 = (POJOs.Customer) request.getSession().getAttribute("username");
                
                Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                
                POJOs.Customer customer = (POJOs.Customer) session1.load(POJOs.Customer.class, customer1.getEmail());
                %>
                
                <form action="test123" method="post">
                    <div class="col-md-10">
                        <div class="panel panel-default">
                            <div class="panel panel-heading">Details</div>
                            <div class="panel panel-body">
                                <div class="row">
                                    <div class="form-group col-md-8">
                                        <label class="control-label">Email </label>
                                        <input disabled class="form-control col-lg-5" type="email" value="<%=customer.getEmail() %>"  >
                                        <input type="hidden" name="email" value="<%=customer.getEmail() %>">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-5">
                                        <label class="control-label">First Name </label>
                                        <input  class="form-control col-lg-5" type="text" value="<%=customer.getFirstName() %>" name="firstname" >
                                    </div>

                                    <div class="form-group col-md-5">
                                        <label class="control-label">Last Name</label>
                                        <input  class="form-control col-lg-5" type="text" value="<%=customer.getLastName() %>" name="lastname" >
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="panel panel-default">
                                        <div class="panel panel-body">
                                            <div class="row">
                                                <div class="form-group col-md-5">
                                                    <label class="control-label">Address No</label>
                                                    <input  class="form-control col-lg-5" type="text" value="<%=customer.getAddressNo() %>" name="addno" >
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label class="control-label">Street 1</label>
                                                    <input  class="form-control col-lg-5" type="text" value="<%=customer.getAddressStreet() %>" name="street1">
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label class="control-label">Street 2</label>
                                                    <input  class="form-control col-lg-5" type="text" value="<%=customer.getAddressStreet2() %>" name="street2">
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label class="control-label">City</label>
                                                    <input  class="form-control col-lg-5" type="text" value="<%=customer.getCity().getCity() %>" name="city">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="panel panel-default">
                                        <div class="panel panel-body">
                                            <div class="row">
                                                <div class="form-group col-md-5">
                                                    <label class="control-label">NIC Number</label>
                                                    <input  class="form-control col-lg-5" type="text" name="nic" value="<%=customer.getNicNumber() %>" >
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label class="control-label">Date Of Birth</label>
                                                    <input  class="form-control col-lg-5" type="date" name="dob" value="<%=customer.getDateOfBirth().toString() %>" >
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label class="control-label">Contact Number 1</label>
                                                    <input  class="form-control col-lg-5" type="number" name="contact1" value="<%=customer.getContactNumber1() %>" >
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label class="control-label">Contact Number 2</label>
                                                    <input  class="form-control col-lg-5" type="number" name="contact2"  value="<%=customer.getContactNumber2() %>" >
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3 col-md-offset-9 ">
                                        <input type="submit" value="Update Details" class="btn btn-success">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="col-md-2">
                    <div class="row">
                        <div class="col-md-2">
                            <a href="Change_Password.jsp?msg=c" class="btn btn-warning">Change Password</a>
                        </div>
                    </div>
                </div>
                                                <%
                                                }else{
                    response.sendRedirect("Home.jsp");
                }
                                                %>
            </div>
        </div>


    </body>
</html>
