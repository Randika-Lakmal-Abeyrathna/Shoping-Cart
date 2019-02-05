<%-- 
    Document   : AdminSupplierDetails
    Created on : Oct 16, 2016, 4:03:34 AM
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
        <title>Spplier Details</title>

        <script type="text/javascript">

            function test() {
                $.ajax({
                    url: "getSuppliers",
                    type: 'POST',
                    data: {
                        value: "All"
                    },
                    success: function(data, textStatus, jqXHR) {
                        document.getElementById("data").innerHTML = data;
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });

            }

        </script>

    </head>
    <body >
        <%
            if (request.getSession().getAttribute("admin") != null) {

                try {
                    POJOs.AdminDetails adminDetails = (POJOs.AdminDetails) request.getSession().getAttribute("admin");
                } catch (Exception e) {
                    response.sendRedirect("Admin_Login.jsp");
                }

            }

        %>

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
                <div class="container-fluid">
                    <div class="panel panel-default">
                        <div class="panel panel-heading"><h4><a href="#pendingS" data-toggle="collapse">Pending Suppliers</a></h4></div>
                        <div id="pendingS" class="collapse panel-collapse">
                            <div class="panel panel-body">
                                <%                               Session session2 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                    Criteria pendingSuppliersCriteria = session2.createCriteria(POJOs.Supplier.class);
                                    pendingSuppliersCriteria.add(Restrictions.eq("status", new classess.tools().getPendingStatus()));

                                    List<POJOs.Supplier> suppliers = pendingSuppliersCriteria.list();

                                    if (!suppliers.isEmpty()) {
                                %>
                                <table class="table table-hover table-responsive">
                                    <thead>
                                    <th>#</th>
                                    <th>Email</th>
                                    <th>Owner Name</th>
                                    <th>Owner Contact</th>
                                    <th>Company Reg #</th>
                                    <th></th>


                                    <%
                                        for (int j = 0; j < suppliers.size(); j++) {
                                            POJOs.Supplier supplier = suppliers.get(j);

                                    %>
                                    <tr>
                                        <td><%=j + 1%></td>
                                        <td><%=supplier.getEmail()%></td>
                                        <td><%=supplier.getSupplierName()%></td>
                                        <td><%=supplier.getOwnerContactno()%></td>
                                        <td><%=supplier.getCompanyRegNumber()%></td>
                                        <td><td><a class="btn btn-success" href="ativeSupplier?id=<%=supplier.getEmail()%>"> Active </a></td></td>

                                    </tr>

                                    <%

                                        }
                                    %>
                                    </thead>
                                </table>
                                <%
                                } else {

                                %>
                                <div class="text-primary text-center" > Ther is no Pending Suppliers ! </div>

                                <%                                        }


                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="container-fluid">
                    <div class="panel panel-default">
                        <div class="panel panel-heading"><h4><a href="#pendingA" data-toggle="collapse">All Suppliers</a></h4></div>
                        <div id="pendingA" class="collapse panel-collapse">
                            <div class="panel panel-body">
                                <%                        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                    Criteria getUsers = session1.createCriteria(POJOs.Supplier.class);
                                    getUsers.add(Restrictions.ne("status", new classess.tools().getPendingStatus()));

                                    List<POJOs.Supplier> supplierList = getUsers.list();

                                    if (!supplierList.isEmpty()) {
                                %>

                                <table class="table table-striped">
                                    <thead>
                                    <th>NO</th>
                                    <th>Email</th>
                                    <th>Owner Name</th>
                                    <th>Company Name</th>
                                    <th>Company Reg #</th>
                                    <th>Contact</th>
                                    <th>Status</th>
                                    <th></th>
                                    </thead>
                                    <tbody>



                                        <%
                                            for (int i = 0; i < supplierList.size(); i++) {
                                                POJOs.Supplier supplier = supplierList.get(i);

                                        %>
                                        <tr>
                                            <td><%=i + 1%></td>
                                            <td><%=supplier.getEmail()%></td>
                                            <td><%=supplier.getSupplierName()%></td>
                                            <td><%=supplier.getCompanyName()%></td>
                                            <td><%=supplier.getCompanyRegNumber()%></td>
                                            <td><%=supplier.getContactNumber()%></td>
                                            <td><%=supplier.getStatus().getStatus().toUpperCase()%></td>

                                            <%
                                                if (supplier.getStatus().getStatus().equals("active")) {

                                            %>
                                            <td><a class="btn btn-warning " href="deactiveSupplier?id=<%=supplier.getEmail()%>">Deactive</a></td>

                                            <%

                                            } else if (supplier.getStatus().getStatus().equals("deactive")) {
                                            %>
                                            <td><a class="btn btn-success" href="activeSupplier?id=<%=supplier.getEmail()%>"> Active </a></td>

                                            <%
                                                }
                                            %>

                                        </tr>
                                        <%
                                            }

                                        %>
                                    </tbody>
                                </table>
                                <%                    } else {

                                %>
                                <div class="text-primary text-center" > Ther is no Suppliers :( </div>

                                <%                                }
                                %>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
