<%-- 
    Document   : AdminAccountDetails
    Created on : Oct 17, 2016, 6:44:42 AM
    Author     : Randika Lakmal
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
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
        <title>Account Details</title>

        <script>
            function printData() {
                var prtContent = document.getElementById("print");
                var WinPrint = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
            }
        </script>

    </head>
    <body>
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
                    <div class="navbar navbar-header"><a class="navbar-brand" href="#">Admin Main Page</a></div>
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
                <div class="col-md-9" id="print">
                    <div class="panel panel-default">
                        <div class="panel panel-heading">Monthly Income</div>
                        <div class="panel panel-body">
                            <%                                Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
                                getInvoice.addOrder(Order.desc("systemDate"));

                                List<POJOs.Invoice> invoiceList = getInvoice.list();
                                double TotalShipping = 0;
                                double TotalProfit = 0;
                                if (!invoiceList.isEmpty()) {

                            %>
                            <table class="table table-bordered col-md-9">
                                <thead>
                                <th>#</th>
                                <th>Invoice #</th>
                                <th>Customer Email</th>
                                <th>Delivery Cost</th>
                                <th>Details</th>
                                </thead>
                                <tbody>


                                    <%                                        for (int i = 0; i < invoiceList.size(); i++) {
                                            POJOs.Invoice invoice = invoiceList.get(i);

                                    %>
                                    <tr>
                                        <td><%=i + 1%></td>
                                        <td><%=invoice.getInvoiceNo()%></td>
                                        <td><%=invoice.getCustomer().getEmail()%></td>
                                        <td><%=invoice.getShippingCost()%></td>
                                        <%
                                            TotalShipping += invoice.getShippingCost();
                                            Criteria getItems = session1.createCriteria(POJOs.InvoiceItems.class);
                                            getItems.add(Restrictions.eq("invoice", invoice));

                                            List<POJOs.InvoiceItems> invoiceItemseList = getItems.list();

                                            if (!invoiceItemseList.isEmpty()) {
                                        %>
                                        <td>
                                            <table class="table table-hover" >
                                                <thead>
                                                <th>#</th>
                                                <th>Product</th>
                                                <th>Supplier Email</th>
                                                <th>Profit</th>
                                                </thead>
                                                <tbody>

                                                    <%
                                                        for (int j = 0; j < invoiceItemseList.size(); j++) {

                                                            POJOs.InvoiceItems invoiceItems = invoiceItemseList.get(j);
                                                            TotalProfit += invoiceItems.getProfit();
                                                    %>
                                                    <tr>
                                                        <td><%=j + 1%></td>
                                                        <td><%=invoiceItems.getProduct().getProductName()%></td>
                                                        <td><%=invoiceItems.getProduct().getSupplier().getEmail()%></td>
                                                        <td><%=invoiceItems.getProfit()%></td>

                                                    </tr>

                                                    <%

                                                        }
                                                    %>

                                                </tbody>
                                            </table>
                                        </td>
                                        <%
                                            }
                                        %>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                            <%
                            } else {
                            %>
                            <div class="text-center text-warning">No Data Found !</div>

                            <%
                                }

                            %>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="row">
                        <div class="panel panel-success">
                            <div class="panel panel-heading"><h4><a href="#commition" data-toggle="collapse">Commition Rate</a></h4></div>
                            <div id="commition" class="collapse panel-collapse in" >
                                <div class="panel panel-body">
                                    <%                                        Session session2 = POJOs.session_pool_manager.getSessionFactory().openSession();
                                        Criteria getCommition = session2.createCriteria(POJOs.CommisionRate.class);

                                        List<POJOs.CommisionRate> commisionRate = getCommition.list();

                                        if (!commisionRate.isEmpty()) {
                                    %>
                                    <table class="table table-bordered">


                                        <%
                                            for (int i = 0; i < commisionRate.size(); i++) {
                                                POJOs.CommisionRate cr = commisionRate.get(i);
                                                double c = cr.getCommision();
                                                String cc = String.format("%1$.2f", c);
                                                cc = cc + " %";

                                        %>
                                        <tr>
                                            <td>Commition Rate  : <%=cc%></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </table>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="row">

                        <button class="btn btn-warning" onclick="printData()">Print Details</button>
                        <button class="btn btn-default" type="button" data-toggle="modal" data-target="#updateCommition">Update Commition Rate</button>
                        <div class="modal fade" id="updateCommition">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header"><h4>Update Commition Rate</h4></div>
                                    <div class="modal-body">
                                        <form action="updateCommition" method="post">
                                            <div class="form-group">
                                                    <label class="control-label">Commition Rate</label>
                                                    <input class="form-control" type="number" name="commition" placeholder="Rate" required/>
                                                    <div class="row">
                                                        <aside style="float: right; margin-right: 10px; margin-top: 20px;">
                                                            <input type="submit" class="btn btn-success" value="Update Rate">
                                                        </aside>
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
        </div>



    </body>
</html>
