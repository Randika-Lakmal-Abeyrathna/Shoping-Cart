<%-- 
    Document   : SupplierNewOrders
    Created on : Oct 16, 2016, 10:21:53 PM
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
                    <a class="navbar-brand" href="#">New Orders </a>
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
                    <div class="col-md-11">
                        <div class="panel panel-default">
                            <div class="panel panel-heading"><h4>New Orders</h4></div>
                            <div class="panel panel-body">
                                <%
                                    Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                    Criteria getDiliver = session1.createCriteria(POJOs.Deliver.class);
                                    getDiliver.add(Restrictions.eq("deliverStatus", new classess.tools().getPendingDeliverStatus()));

                                    List<POJOs.Deliver> deliverList = getDiliver.list();

                                    if (!deliverList.isEmpty()) {

                                %>
                                <table class="table table-hover table-responsive">
                                    <thead>
                                    <th>NO</th>
                                    <th>Invoice #</th>
                                    <th>Detail</th>
                                    <th>Date</th>

                                    </thead>
                                    <tbody>

                                        <%                                            for (int i = 0; i < deliverList.size(); i++) {

                                                POJOs.Deliver deliver = deliverList.get(i);

                                                Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
                                                getInvoice.add(Restrictions.eq("idinvoice", deliver.getInvoice().getIdinvoice()));
                                                getInvoice.addOrder(Order.desc("systemDate"));

                                                List<POJOs.Invoice> invoiceList = getInvoice.list();

                                                double Total = 0;
                                                if (request.getSession().getAttribute("username") != null) {

                                                    if (!invoiceList.isEmpty()) {

                                                        for (int x = 0; x < invoiceList.size(); x++) {

                                                            POJOs.Invoice invoice = invoiceList.get(x);

                                                            Criteria getInvoiceItems = session1.createCriteria(POJOs.InvoiceItems.class);
                                                            getInvoiceItems.add(Restrictions.eq("invoice", invoice));

                                                            List<POJOs.InvoiceItems> invoiceItemseList = getInvoiceItems.list();

                                        %>
                                        <tr>
                                            <td><%=i + 1%></td>
                                            <td><%=invoice.getInvoiceNo()%></td>
                                            <%

                                                if (!invoiceItemseList.isEmpty()) {

                                            %>
                                            <td>
                                                <table class="table table-striped">
                                                    <thead>
                                                    <th>Product Name</th>
                                                    <th>Quantity</th>
                                                    </thead>
                                                    <tbody>


                                                        <%                   
                                                            for (int j = 0; j < invoiceItemseList.size(); j++) {

                                                                POJOs.InvoiceItems invoiceItems = invoiceItemseList.get(j);

                                                                POJOs.Supplier supplier = (POJOs.Supplier) request.getSession().getAttribute("username");
                                                                String email1 = supplier.getEmail();
                                                                String email2 = invoiceItems.getProduct().getSupplier().getEmail();

                                                                if (email1.equals(email2)) {
                                                                    %>
                                                                    <tr>
                                                                        <td><%=invoiceItems.getProduct().getProductName() %></td>
                                                                        <td><%=invoiceItems.getQty() %></td>
                                                                    </tr>
                                                                    
                                                                    <%
                                                                   

                                                                } else {

                                                                }

                                                            }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </td>

                                            <td><%=invoice.getSystemDate().getSysDate()%></td>

                                        </tr>

                                        <%
                                                            }

                                                        }

                                                    }

                                                }

                                            }
                                        %>
                                    </tbody>
                                </table>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

    </body>
</html>
