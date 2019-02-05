<%-- 
    Document   : AdminShippingDetails
    Created on : Oct 15, 2016, 11:16:36 PM
    Author     : Randika Lakmal
--%>

<%@page import="java.util.HashMap"%>
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

        <!-- Custom CSS -->
        <link href="css/sb-admin-2.css" rel="stylesheet">

        <!-- Morris Charts CSS -->
        <link href="css/morris.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>

        <title>Shipping Details</title>

        <script type="text/javascript">

            function updatePendingStatus(i, id) {
                var s = document.getElementById("statusP" + i);
                var ss = s.options[s.selectedIndex].text;

                $.ajax({
                    url: "updateDeliverStatus",
                    type: 'POST',
                    data: {
                        id: id, value: ss
                    },
                    success: function(data, textStatus, jqXHR) {
                        location.reload(true);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });

            }
            function updateShippingStatus(i, id) {
                var s = document.getElementById("statusS" + i);
                var ss = s.options[s.selectedIndex].text;

                $.ajax({
                    url: "updateDeliverStatus",
                    type: 'POST',
                    data: {
                        id: id, value: ss
                    },
                    success: function(data, textStatus, jqXHR) {
                        location.reload(true);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });

            }
            function updateDelivredStatus(i, id) {
                var s = document.getElementById("statusD" + i);
                var ss = s.options[s.selectedIndex].text;

                $.ajax({
                    url: "updateDeliverStatus",
                    type: 'POST',
                    data: {
                        id: id, value: ss
                    },
                    success: function(data, textStatus, jqXHR) {
                        location.reload(true);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });

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
                    <div class="navbar navbar-header"><a class="navbar-brand" href="#">Shipping Details</a></div>
                    <ul class="nav navbar-nav navbar-right" >
                        <li><a href="AdminHome.jsp">Home</a></li>
                        <li><a href="logout">Logout</a></li>
                    </ul>
                </div>
            </nav>    
            <nav class="navbar navbar-default" >
                <ul class="nav navbar-nav navbar-right" >
                    <li><a href="allCustomers.jsp">Customer Details</a></li>
                    <li><a href="AdminSupplierDetails.jsp">Supplier Details <span class="badge" ><i>New  </i>  <%=new classess.GetPendingSupplier().getPendingSupplierCount()%> </span></a></li>
                    <li><a href="AdminAccountDetails.jsp">Account Details</a></li>
                    <li><a href="AdminShippingDetails.jsp">Shipping Details</a></li>
                </ul>
            </nav>    
        </div>
        <!--Navigation bar Finish-->

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel panel-heading"><h4><a href="#pendingItem" data-toggle="collapse">Pending Items</a></h4></div>
                                <div id="pendingItem" class="collapse panel-collapse">
                                    <div class="panel panel-body">
                                        <%                                Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                            Criteria getDiliverDetails = session1.createCriteria(POJOs.Deliver.class);
                                            getDiliverDetails.add(Restrictions.eq("deliverStatus", new classess.tools().getPendingDeliverStatus()));

                                            List<POJOs.Deliver> deliverList = getDiliverDetails.list();

                                            if (!deliverList.isEmpty()) {

                                        %>
                                        <table class="table table-hover table-responsive">
                                            <thead>
                                            <th>NO</th>
                                            <th>Invoice #</th>
                                            <th>Deliver Address</th>
                                            <th>Customer Name</th>
                                            <th>Customer Contact</th>
                                            <th>Item Details</th>
                                            <th>Status</th>
                                            <th></th>
                                            </thead>
                                            <tbody>
                                                <%                                            for (int i = 0; i < deliverList.size(); i++) {
                                                        POJOs.Deliver deliver = deliverList.get(i);
                                                %>
                                                <tr>
                                                    <td><%=i + 1%></td>
                                                    <td><%=deliver.getInvoice().getInvoiceNo()%></td>
                                                    <td>
                                                        <p><%=deliver.getFirstName()%></p>
                                                        <p><%=deliver.getAddressNo()%></p>
                                                        <p><%=deliver.getAddressStreet()%></p>
                                                        <p><%=deliver.getAddressStreet2()%></p>
                                                        <p><%=deliver.getCity()%></p>
                                                    </td>
                                                    <td><%=deliver.getInvoice().getCustomer().getFirstName() + "  " + deliver.getInvoice().getCustomer().getLastName()%> </td>
                                                    <td><%=deliver.getInvoice().getCustomer().getContactNumber1() + " / " + deliver.getInvoice().getCustomer().getContactNumber2()%> </td>

                                                    <td width="20%">
                                                        <table class="table-responsive table-striped">
                                                            <thead class="text-center">
                                                            <th class="text-center">Product Name </th>
                                                            <th class="text-center">Quantity</th>
                                                            </thead>
                                                            <tbody>

                                                                <%
                                                                    Criteria getInvoiceItems = session1.createCriteria(POJOs.InvoiceItems.class);
                                                                    getInvoiceItems.add(Restrictions.eq("invoice", deliver.getInvoice()));

                                                                    List<POJOs.InvoiceItems> invoiceItemseList = getInvoiceItems.list();

                                                                    if (!invoiceItemseList.isEmpty()) {
                                                                        for (int j = 0; j < invoiceItemseList.size(); j++) {
                                                                            POJOs.InvoiceItems invoiceItem = invoiceItemseList.get(j);

                                                                %>

                                                                <tr class="text-center" >

                                                                    <!--Product Name-->
                                                                    <td width="50%"><%=invoiceItem.getProduct().getProductName()%></td>

                                                                    <!--Quantity-->
                                                                    <td width="50%"><%=invoiceItem.getQty()%></td>


                                                                </tr>

                                                                <%

                                                                        }
                                                                    }

                                                                %>
                                                            </tbody>
                                                        </table>
                                                    </td>

                                                    <td><%=deliver.getDeliverStatus().getDeliverStatus()%> </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Change Status</label>
                                                            <select class="form-control" id="statusP<%=i%>">
                                                                <%
                                                                    Criteria getStatus = session1.createCriteria(POJOs.DeliverStatus.class);

                                                                    List<POJOs.DeliverStatus> deliverStatuses = getStatus.list();

                                                                    if (!deliverStatuses.isEmpty()) {
                                                                        for (int j = 0; j < deliverStatuses.size(); j++) {
                                                                            POJOs.DeliverStatus deliverStatus = deliverStatuses.get(j);
                                                                %>
                                                                <option><%=deliverStatus.getDeliverStatus()%></option>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </select>
                                                            <a onclick="updatePendingStatus(<%=i%>,<%=deliver.getIddeliver()%>)">Change</a>
                                                        </div>
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
                                        <div class="text-center text-warning">No Data Found !</div>
                                        <%
                                            }
                                        %>

                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel panel-heading"><h4><a href="#shippedItem" data-toggle="collapse">Shipped Items</a></h4></div>
                                <div id="shippedItem" class="collappendingItemse panel-collapse">
                                    <div class="panel panel-body">
                                        <%                                Session session2 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                            Criteria getDiliverDetails1 = session2.createCriteria(POJOs.Deliver.class);
                                            getDiliverDetails1.add(Restrictions.eq("deliverStatus", new classess.tools().getShippedDeliverStatus()));

                                            List<POJOs.Deliver> deliverList1 = getDiliverDetails1.list();

                                            if (!deliverList1.isEmpty()) {

                                        %>
                                        <table class="table table-hover table-responsive">
                                            <thead>
                                            <th>NO</th>
                                            <th>Invoice #</th>
                                            <th>Deliver Address</th>
                                            <th>Customer Name</th>
                                            <th>Customer Contact</th>
                                            <th>Item Details</th>
                                            <th>Status</th>
                                            <th></th>
                                            </thead>
                                            <tbody>
                                                <%                                            for (int i = 0; i < deliverList1.size(); i++) {
                                                        POJOs.Deliver deliver = deliverList1.get(i);
                                                %>
                                                <tr>
                                                    <td><%=i + 1%></td>
                                                    <td><%=deliver.getInvoice().getInvoiceNo()%></td>
                                                    <td>
                                                        <p><%=deliver.getFirstName()%></p>
                                                        <p><%=deliver.getAddressNo()%></p>
                                                        <p><%=deliver.getAddressStreet()%></p>
                                                        <p><%=deliver.getAddressStreet2()%></p>
                                                        <p><%=deliver.getCity()%></p>
                                                    </td>
                                                    <td><%=deliver.getInvoice().getCustomer().getFirstName() + "  " + deliver.getInvoice().getCustomer().getLastName()%> </td>
                                                    <td><%=deliver.getInvoice().getCustomer().getContactNumber1() + " / " + deliver.getInvoice().getCustomer().getContactNumber2()%> </td>

                                                    <td width="20%">
                                                        <table class="table-responsive table-striped">
                                                            <thead class="text-center">
                                                            <th class="text-center">Product Name </th>
                                                            <th class="text-center">Quantity</th>
                                                            </thead>
                                                            <tbody>

                                                                <%
                                                                    Criteria getInvoiceItems = session1.createCriteria(POJOs.InvoiceItems.class);
                                                                    getInvoiceItems.add(Restrictions.eq("invoice", deliver.getInvoice()));

                                                                    List<POJOs.InvoiceItems> invoiceItemseList = getInvoiceItems.list();

                                                                    if (!invoiceItemseList.isEmpty()) {
                                                                        for (int j = 0; j < invoiceItemseList.size(); j++) {
                                                                            POJOs.InvoiceItems invoiceItem = invoiceItemseList.get(j);

                                                                %>

                                                                <tr class="text-center" >

                                                                    <!--Product Name-->
                                                                    <td width="50%"><%=invoiceItem.getProduct().getProductName()%></td>

                                                                    <!--Quantity-->
                                                                    <td width="50%"><%=invoiceItem.getQty()%></td>


                                                                </tr>

                                                                <%

                                                                        }
                                                                    }

                                                                %>
                                                            </tbody>
                                                        </table>
                                                    </td>

                                                    <td><%=deliver.getDeliverStatus().getDeliverStatus()%> </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Change Status</label>
                                                            <select class="form-control" id="statusS<%=i%>">
                                                                <%
                                                                    Criteria getStatus = session1.createCriteria(POJOs.DeliverStatus.class);

                                                                    List<POJOs.DeliverStatus> deliverStatuses = getStatus.list();

                                                                    if (!deliverStatuses.isEmpty()) {
                                                                        for (int j = 0; j < deliverStatuses.size(); j++) {
                                                                            POJOs.DeliverStatus deliverStatus = deliverStatuses.get(j);
                                                                %>
                                                                <option><%=deliverStatus.getDeliverStatus()%></option>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </select>
                                                            <a onclick="updateShippingStatus(<%=i%>,<%=deliver.getIddeliver()%>)">Change</a>
                                                        </div>
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
                                        <div class="text-center text-warning">No Data Found !</div>
                                        <%
                                            }
                                        %>

                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel panel-heading"><h4><a href="#diliverdItem" data-toggle="collapse">Deliverd Items</a></h4></div>
                                <div id="diliverdItem" class="collappendingItemse panel-collapse">
                                    <div class="panel panel-body">
                                        <%                                Session session3 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                            Criteria getDiliverDetails2 = session3.createCriteria(POJOs.Deliver.class);
                                            getDiliverDetails2.add(Restrictions.eq("deliverStatus", new classess.tools().getDeliveredDeliverStatus()));

                                            List<POJOs.Deliver> deliverList2 = getDiliverDetails2.list();

                                            if (!deliverList2.isEmpty()) {

                                        %>
                                        <table class="table table-hover table-responsive">
                                            <thead>
                                            <th>NO</th>
                                            <th>Invoice #</th>
                                            <th>Deliver Address</th>
                                            <th>Customer Name</th>
                                            <th>Customer Contact</th>
                                            <th>Item Details</th>
                                            <th>Status</th>
                                            <th></th>
                                            </thead>
                                            <tbody>
                                                <%                                            for (int i = 0; i < deliverList2.size(); i++) {
                                                        POJOs.Deliver deliver = deliverList2.get(i);
                                                %>
                                                <tr>
                                                    <td><%=i + 1%></td>
                                                    <td><%=deliver.getInvoice().getInvoiceNo()%></td>
                                                    <td>
                                                        <p><%=deliver.getFirstName()%></p>
                                                        <p><%=deliver.getAddressNo()%></p>
                                                        <p><%=deliver.getAddressStreet()%></p>
                                                        <p><%=deliver.getAddressStreet2()%></p>
                                                        <p><%=deliver.getCity()%></p>
                                                    </td>
                                                    <td><%=deliver.getInvoice().getCustomer().getFirstName() + "  " + deliver.getInvoice().getCustomer().getLastName()%> </td>
                                                    <td><%=deliver.getInvoice().getCustomer().getContactNumber1() + " / " + deliver.getInvoice().getCustomer().getContactNumber2()%> </td>

                                                    <td width="20%">
                                                        <table class="table-responsive table-striped">
                                                            <thead class="text-center">
                                                            <th class="text-center">Product Name </th>
                                                            <th class="text-center">Quantity</th>
                                                            </thead>
                                                            <tbody>

                                                                <%
                                                                    Criteria getInvoiceItems = session1.createCriteria(POJOs.InvoiceItems.class);
                                                                    getInvoiceItems.add(Restrictions.eq("invoice", deliver.getInvoice()));

                                                                    List<POJOs.InvoiceItems> invoiceItemseList = getInvoiceItems.list();

                                                                    if (!invoiceItemseList.isEmpty()) {
                                                                        for (int j = 0; j < invoiceItemseList.size(); j++) {
                                                                            POJOs.InvoiceItems invoiceItem = invoiceItemseList.get(j);

                                                                %>

                                                                <tr class="text-center" >

                                                                    <!--Product Name-->
                                                                    <td width="50%"><%=invoiceItem.getProduct().getProductName()%></td>

                                                                    <!--Quantity-->
                                                                    <td width="50%"><%=invoiceItem.getQty()%></td>


                                                                </tr>

                                                                <%

                                                                        }
                                                                    }

                                                                %>
                                                            </tbody>
                                                        </table>
                                                    </td>

                                                    <td><%=deliver.getDeliverStatus().getDeliverStatus()%> </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Change Status</label>
                                                            <select class="form-control" id="statusD<%=i%>">
                                                                <%
                                                                    Criteria getStatus = session1.createCriteria(POJOs.DeliverStatus.class);

                                                                    List<POJOs.DeliverStatus> deliverStatuses = getStatus.list();

                                                                    if (!deliverStatuses.isEmpty()) {
                                                                        for (int j = 0; j < deliverStatuses.size(); j++) {
                                                                            POJOs.DeliverStatus deliverStatus = deliverStatuses.get(j);
                                                                %>
                                                                <option><%=deliverStatus.getDeliverStatus()%></option>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </select>
                                                            <a onclick="updateDelivredStatus(<%=i%>,<%=deliver.getIddeliver()%>)">Change</a>
                                                        </div>
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
                                        <div class="text-center text-warning">No Data Found !</div>
                                        <%
                                            }
                                        %>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="row">
                        <div class="panel panel-success">
                            <div class="panel panel-heading"><h4><a href="#shipingCost" data-toggle="collapse">Shipping Cost Per Unit</a></h4></div>
                            <div id="shipingCost" class="collapse panel-collapse">
                                <div class="panel panel-body">
                                    <%
                                        Session session4 = POJOs.session_pool_manager.getSessionFactory().openSession();

                                        Criteria getShipingCostCriteria = session4.createCriteria(POJOs.ShipingDetails.class);

                                        List<POJOs.ShipingDetails> detailses = getShipingCostCriteria.list();

                                        if (!detailses.isEmpty()) {
                                    %>
                                    <table class="table table-condensed">
                                        <thead>
                                        <th>City</th>
                                        <th>Cost</th>
                                        <th></th>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (int i = 0; i < detailses.size(); i++) {
                                                    POJOs.ShipingDetails shipingDetails = detailses.get(i);
                                            %>

                                            <tr>
                                                <td><%=shipingDetails.getCity()%></td>
                                                <td><%=shipingDetails.getCost()%></td>
                                                <td>
                                                    <form action="updateShippingCost" method="post" >
                                                        <div class="form-group">
                                                            <input type="hidden" name="id" value="<%=shipingDetails.getIdshipingDetails()%>">
                                                            <input type="hidden" name="value" id="p<%=shipingDetails.getIdshipingDetails()%>">
                                                            <a onclick="edit(<%=shipingDetails.getIdshipingDetails()%>)">Edit</a>
                                                            <input class="btn-xs btn-primary" type="hidden" id="s<%=shipingDetails.getIdshipingDetails()%>" value="Update" >
                                                        </div>

                                                    </form>
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
                                    <div class="text-center text-warning">Data Not Found</div>
                                    <%
                                        }
                                    %>


                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="container-fluid">
                            <div class="col-md-5 pull-right">
                                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#saveCity">Add New City</button>
                            </div>

                            <div class="modal fade" id="saveCity">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header"><h4>New City</h4></div>
                                        <div class="modal-body">
                                            <form action="saveShippingCity" method="post">
                                                <div class="form-group">
                                                    <label class="control-label">City</label>
                                                    <input class="form-control" type="text" name="city" placeholder="City" required/>
                                                    <label class="control-label">Price</label>
                                                    <input class="form-control" type="number" name="cost" placeholder="Price" required/>
                                                    <div class="row">
                                                        <aside style="float: right; margin-right: 10px; margin-top: 20px;">
                                                            <input type="submit" class="btn btn-success" value="Save City">
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

        </div>
        <script type="text/javascript">
            function edit(id) {
                document.getElementById("p" + id).removeAttribute("type");
                document.getElementById("s" + id).removeAttribute("type");
                document.getElementById("p" + id).setAttribute("type", "number");
                document.getElementById("s" + id).setAttribute("type", "submit");

            }
        </script>
    </body>
</html>
