<%-- 
    Document   : CustomerPanel
    Created on : Oct 13, 2016, 1:41:34 PM
    Author     : Randika Lakmal
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
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
        <script src="JS/Chart.js"></script>

        <title>Customer Log</title>
    </head>
    <body>
        <!--Navigation Start-->

        <nav class="navbar navbar-inverse"  style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">History </a>
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
                    response.sendRedirect("index.jsp");
                }
            }
        %>


        <!--Content Start-->
        <div class="container-fluid">
            <div class="row">
                <%
                    Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                    POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");

                    Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
                    getInvoice.add(Restrictions.eq("customer", customer));
                    getInvoice.addOrder(Order.desc("systemDate"));

                    List<POJOs.Invoice> invoiceList = getInvoice.list();
                    int pending = 0;
                    int shipped = 0;
                    int deliverd = 0;
                    if (!invoiceList.isEmpty()) {

                %>
                <div class="col-md-9">
                    <table class="table table-striped table-bordered col-md-9">
                        <thead class="text-center">
                            <tr>
                                <th class="text-center">No</th>
                                <th class="text-center" >Invoice No</th>
                                <th class="text-center" >Address</th>
                                <th class="text-center" >Date</th>
                                <th class="text-center" >Total Amount</th>
                                <th class="text-center" >Payment Type</th>
                                <th class="text-center" >Status</th>
                                <th class="text-center" ></th>
                                <th class="text-center" ></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%                            for (int i = 0; i < invoiceList.size(); i++) {
                                    POJOs.Invoice invoice = invoiceList.get(i);

                                    Criteria getDeliverDetailsCriteria = session1.createCriteria(POJOs.Deliver.class);
                                    getDeliverDetailsCriteria.add(Restrictions.eq("invoice", invoice));

                                    POJOs.Deliver deliver = (POJOs.Deliver) getDeliverDetailsCriteria.uniqueResult();

                                    if (deliver.getDeliverStatus().getDeliverStatus().equals("pending")) {
                                        pending++;
                                    } else if (deliver.getDeliverStatus().getDeliverStatus().equals("shipped")) {
                                        shipped++;
                                    } else if (deliver.getDeliverStatus().getDeliverStatus().equals("delivered")) {
                                        deliverd++;
                                    }
                            %>
                            <tr class="text-center">
                                <!--No-->
                                <td><%=i + 1%></td>

                                <!--Invoice Number-->
                                <td><%=invoice.getInvoiceNo()%></td>

                                <!--Address-->
                                <td>
                                    <label><%=deliver.getFirstName()%></label><br>
                                    <label><%=deliver.getAddressNo()%></label><br>
                                    <label><%=deliver.getAddressStreet()%></label><br>
                                    <label><%=deliver.getAddressStreet2()%></label><br>
                                    <label><%=deliver.getCity()%></label><br>
                                </td>

                                <!--Date-->
                                <td><%=invoice.getSystemDate().getSysDate()%></td>

                                <!--Total--> 
                                <td><%=invoice.getTotalAmount()%></td>

                                <!--Payment Type-->
                                <td><%=invoice.getPaymentType()%></td>

                                <!--Deliver Status-->
                                <td><%=deliver.getDeliverStatus().getDeliverStatus()%></td>

                                <!--Item Details-->
                                <td width="25%">
                                    <table class="table-responsive table-striped">
                                        <thead class="text-center">
                                        <th class="text-center">Product Name </th>
                                        <th class="text-center">Quantity</th>
                                        <th class="text-center">Price</th>
                                        </thead>
                                        <tbody>

                                            <%
                                                Criteria getInvoiceItems = session1.createCriteria(POJOs.InvoiceItems.class);
                                                getInvoiceItems.add(Restrictions.eq("invoice", invoice));

                                                List<POJOs.InvoiceItems> invoiceItemseList = getInvoiceItems.list();

                                                if (!invoiceItemseList.isEmpty()) {
                                                    for (int j = 0; j < invoiceItemseList.size(); j++) {
                                                        POJOs.InvoiceItems invoiceItem = invoiceItemseList.get(j);

                                            %>

                                            <tr class="text-center" >

                                                <!--Product Name-->
                                                <td width="33%"><%=invoiceItem.getProduct().getProductName()%></td>

                                                <!--Quantity-->
                                                <td width="33%"><%=invoiceItem.getQty()%></td>

                                                <!--Price-->
                                                <td width="33%"><%=invoiceItem.getPrice()%></td>



                                            </tr>

                                            <%

                                                    }
                                                }

                                            %>
                                        </tbody>
                                    </table>
                                </td>

                                <!--Show invoice-->
                                <td>
                                    <a href="invoiceCopy.jsp?id=<%=invoice.getInvoiceNo() %>">Duplicate Invoice</a>
                                </td>


                            </tr>
                            <%                        }
                            %>

                        </tbody>
                    </table>    


                </div>
                <div class="col-md-3">
                    <div class="panel panel-default">
                        <div class="panel panel-heading">Staticstics</div>
                        <div class="panel panel-body">
                            <div class="row">
                                <canvas id="myChart" width="200px" ></canvas>
                                <script>
                                    var ctx = document.getElementById("myChart");
                                    var myChart = new Chart(ctx, {
                                        type: 'doughnut',
                                        data: {
                                            labels: ["Pending Status", "Shipped Status","Deliverd Status"],
                                            datasets: [{
                                                    label: '# of Invoice',
                                                    data: [<%=pending %>, <%=shipped %>, <%=deliverd  %>],
                                                    backgroundColor: [
                                                        'rgba(255, 99, 132, 0.2)',
                                                        'rgba(54, 162, 235, 0.2)',
                                                        'rgba(54, 55, 235, 0.2)'
                                                    ],
                                                    borderColor: [
                                                        'rgba(255,99,132,1)',
                                                        'rgba(54, 162, 235, 1)',
                                                        'rgba(54, 55, 235, 1)'
                                                    ],
                                                    borderWidth: 1
                                                }]
                                        }

                                    });
                                </script>
                            </div>
                        </div>
                    </div>

                </div>
                <%
                    }
                %>
            </div>
        </div>
        <!--Content End-->

    </body>
</html>
