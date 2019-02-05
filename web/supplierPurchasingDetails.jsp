<%-- 
    Document   : supplierPurchasingDetails
    Created on : Oct 13, 2016, 7:31:34 PM
    Author     : Randika Lakmal
--%>

<%@page import="org.hibernate.criterion.Order"%>
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
        <title>JSP Page</title>
    </head>
    <body>
        <!----- Heading part Start----->
        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Purchse Details </a>
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

                            }else{
                        response.sendRedirect("index.jsp");
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
                    }
                %>
            </div>
            <!----- Heading part Finish--->

            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-8">
                        <div class="panel panel-default">
                            <div class="panel panel-heading"><h4>Monthly Income</h4></div>
                            <div class="panel panel-body">
                                <%
                                    Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                    Criteria getinvoice = session1.createCriteria(POJOs.Invoice.class);
                                    getinvoice.addOrder(Order.desc("systemDate"));

                                    List<POJOs.Invoice> invoiceList = getinvoice.list();
                                    double Total =0;
                                    if (request.getSession().getAttribute("username") != null) {

                                        if (!invoiceList.isEmpty()) {

                                %>
                                <table class="table table-hover table-responsive">
                                    <thead>
                                    <th>NO</th>
                                    <th>Invoice #</th>
                                    <th>Price</th>
                                    <th>Date</th>
                                    </thead>
                                    <tbody>

                                        <%                                           for (int i = 0; i < invoiceList.size(); i++) {

                                                POJOs.Invoice invoice = invoiceList.get(i);

                                                Criteria getInvoiceItems = session1.createCriteria(POJOs.InvoiceItems.class);
                                                getInvoiceItems.add(Restrictions.eq("invoice", invoice));
                                                

                                                List<POJOs.InvoiceItems> invoiceItemseList = getInvoiceItems.list();

                                                if (!invoiceItemseList.isEmpty()) {

                                                    double price = 0;
                                                    for (int j = 0; j < invoiceItemseList.size(); j++) {

                                                        POJOs.InvoiceItems invoiceItems = invoiceItemseList.get(j);

                                                        POJOs.Supplier supplier = (POJOs.Supplier) request.getSession().getAttribute("username");
                                                        String email1 = supplier.getEmail();
                                                        String email2 = invoiceItems.getProduct().getSupplier().getEmail();

                                                        if (email1.equals(email2)) {

                                                            price += invoiceItems.getSellierProfit();

                                                        } else {

                                                        }

                                                    }
                                                    Total +=price;

                                        %>

                                        <tr>
                                            <td><%=i + 1%></td>
                                            <td><%=invoice.getInvoiceNo()%></td>
                                            <td><%=price%></td>
                                            <td><%=invoice.getSystemDate().getSysDate()%></td>

                                        </tr>

                                        <%
                                                }

                                            }
                                        %>
                                    </tbody>
                                </table>
                                <%
                                        }
                                    } else {
                                        response.sendRedirect("index.jsp");
                                    }

                                %>
                            </div>
                        </div>

                    </div>
                            <div class="col-md-4">
                                <div class="row">
                                    <div class="jumbotron">
                                        <h4>Monthly Income</h4>
                                        <h2 class="pull-right">Rs :<%=Total %></h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    
                                </div>
                            </div>

                </div>
            </div>


    </body>
</html>
