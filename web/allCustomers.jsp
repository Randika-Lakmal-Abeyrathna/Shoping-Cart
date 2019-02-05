<%-- 
    Document   : allCustomers
    Created on : 04-Oct-2016, 22:48:43
    Author     : Randika Lakmal
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="bootstrap/js/bootstrap.js"></script>

        <script src="JS/jquery-1.11.3.js"></script>

        <!--Scripts-->

        <script type="text/javascript">

            function getAllDetails() {

                $.ajax({
                    url: "getCustomers",
                    type: 'POST',
                    data: {
                        type: "all"
                    },
                    success: function(data, textStatus, jqXHR) {

                        document.getElementById("dataTable").innerHTML = data;
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });


            }

            function getSelectedDetails(value) {
                alert(value);
                if (value === "All") {
                    getAllDetails();
                }
                if (value === "Active") {

                    $.ajax({
                        url: "getCustomers",
                        type: 'POST',
                        data: {
                            type: "active"
                        },
                        success: function(data, textStatus, jqXHR) {

                            document.getElementById("dataTable").innerHTML = data;
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            alert(jqXHR);
                        }

                    });
                }
                if (value === "Inactive") {

                    $.ajax({
                        url: "getCustomers",
                        type: 'POST',
                        data: {
                            type: "inactive"
                        },
                        success: function(data, textStatus, jqXHR) {

                            document.getElementById("dataTable").innerHTML = data;
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            alert(jqXHR);
                        }

                    });
                }
                if (value === "Black List") {

                    $.ajax({
                        url: "getCustomers",
                        type: 'POST',
                        data: {
                            type: "blacklist"
                        },
                        success: function(data, textStatus, jqXHR) {

                            document.getElementById("dataTable").innerHTML = data;
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            alert(jqXHR);
                        }

                    });
                }

            }

        </script>

        <title>Customer Details</title>
    </head>
    <body>

        <!--Navigation bar Start-->
        <div>
            <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
                <div class="container-fluid">
                    <div class="navbar navbar-header"><a class="navbar-brand" href="#">Suppler Details</a></div>
                    <ul class="nav navbar-nav navbar-right" >
                        <li><a href="AdminHome.jsp">Home</a></li>
                        <li><a href="logout">Logout</a></li>
                    </ul>
                </div>
            </nav>    
            <nav class="navbar navbar-default" >
                <ul class="nav navbar-nav navbar-right" >
                    <li><a href="allCustomers.jsp">Customer Details</a></li>
                        <li><a href="AdminSupplierDetails.jsp">Supplier Details <span class="badge" ><i>New  </i>  <%=new classess.GetPendingSupplier().getPendingSupplierCount() %> </span></a></li>
                        <li><a href="AdminAccountDetails.jsp">Account Details</a></li>
                        <li><a href="AdminShippingDetails.jsp">Shipping Details</a></li>
                </ul>
            </nav>    
        </div>
        <!--Navigation bar Finish-->


        <div class="container-fluid">
            <div class="row">
                <div class="col-md-11">
                    <%
                        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                        Criteria getCustomers = session1.createCriteria(POJOs.Customer.class);

                        List<POJOs.Customer> customerList = getCustomers.list();

                        if (!customerList.isEmpty()) {

                    %>
                    <table class="table table-striped">
                        <thead>
                        <th>#</th>
                        <th>Customer Email</th>
                        <th>Customer Name</th>
                        <th>Customer NIC #</th>
                        <th>Customer Contact</th>
                        <th>Customer Status</th>
                        <th></th>
                        </thead>
                        <tbody>



                            <%                            for (int i = 0; i < customerList.size(); i++) {

                                    POJOs.Customer customer = customerList.get(i);

                            %>
                            <tr>
                                <td><%=i + 1%></td>
                                <td><%=customer.getEmail()%></td>
                                <td><%=customer.getFirstName() + " " + customer.getLastName()%></td>
                                <td><%=customer.getNicNumber()%></td>
                                <td><%=customer.getContactNumber1() + " " + customer.getContactNumber2()%></td>
                                <td><strong><%=customer.getStatus().getStatus().toUpperCase()%></strong></td>

                                <%

                                    if (customer.getStatus().getStatus().equals("active")) {

                                %>
                                <td><a class="btn btn-warning" href="deactiveCustomer?id=<%=customer.getEmail()%>">Deactive</a></td>
                                <%

                                } else if (customer.getStatus().getStatus().equals("deactive")) {
                                %>
                                <td><a class="btn btn-success" href="activeCustomer?id=<%=customer.getEmail()%>">Active</a></td>
                                <%
                                    }

                                %>



                            </tr>
                            <%                                    }
                            %>

                        </tbody>
                    </table>
                    <%
                        } else {

                        }

                    %>
                </div>
            </div>
        </div>

    </body>
</html>
