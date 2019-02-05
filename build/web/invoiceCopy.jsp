<%-- 
    Document   : invoiceCopy
    Created on : Oct 14, 2016, 10:06:42 PM
    Author     : Randika Lakmal
--%>

<%@page import="POJOs.ProductImage"%>
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
        
        <script>
            function printData() {
                var prtContent = document.getElementById("invoice");
                var WinPrint = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
            }
        </script>
        <style>
            .bgImage{
                
                background-image: url('img/Duplicate.gif');
}
            
        </style>
        <title>Invoice</title>
    </head>
    <body>

        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Invoice </a>
                </div>
                <ul class="nav navbar-nav navbar-right " >
                    <%
                        if (request.getSession().getAttribute("username") != null) {

                            try {
                                POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");

                    %>
                    <li><a name = "username" id = "username" ><span class="glyphicon glyphicon-user ">  <%=customer.getEmail()%></span> </a> </li>
                    <li><a href="CustomerLog.jsp">Continue</a></li>
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
        <%
            if (request.getParameter("id") !=null) {
        %>
        <div class="container-fluid">
            <div class="row">
                <div id="invoice" class="col-md-10">
                    <%
                        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

                        String invoiceNumber = request.getParameter("id");

                        Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
                        getInvoice.add(Restrictions.eq("invoiceNo", invoiceNumber));

                        POJOs.Invoice invoice = (POJOs.Invoice) getInvoice.uniqueResult();

                        Criteria getItemDetailsCriteria = session1.createCriteria(POJOs.InvoiceItems.class);
                        getItemDetailsCriteria.add(Restrictions.eq("invoice", invoice));

                        List<POJOs.InvoiceItems> invoiceItemseList = getItemDetailsCriteria.list();

                    %>
                    <div  class="panel panel-default">
                        <div class="panel panel-heading">
                            <div class="pull-left">
                                <img src="img/logo_7_cakeshop.png" height="50px" class="pull-left"><h3 class="pull-right">Cake Shop</h3>
                            </div>
                            <div class="pull-right">
                                <h2>Invoice Copy</h4></h2><h4>Invoice # : <%=invoiceNumber%>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="panel panel-body bgImage">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="panel panel-default">
                                        <div class="panel panel-heading">Item Details</div>
                                        <div  class="panel panel-body bgImage" >
                                            <%                                                if (!invoiceItemseList.isEmpty()) {
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
                                                        for (int i = 0; i < invoiceItemseList.size(); i++) {
                                                            POJOs.InvoiceItems invoiceItem = invoiceItemseList.get(i);
                                                            POJOs.Product product = invoiceItem.getProduct();

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
                                                <label><%=invoiceItem.getQty()%></label><br>


                                                </td>
                                                <td class="text-center">
                                                    <label style="font-size: xx-large">Rs :  <%=invoiceItem.getPrice()%></label>

                                                </td>
                                                </tr>
                                                <%
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
                                <div class="col-md-4">
                                    <div class="panel panel-default">
                                        <div class="panel panel-heading">Payment</div>
                                        <div class="panel panel-body bgImage">
                                            <div class="form-group">
                                                <label style="font-size: xx-large" class="control-label ">Grand Total</label>
                                                <label style="font-size: xx-large" class="pull-right"><%=invoice.getTotalAmount()%> </label>
                                            </div>
                                            <div class="form-group">
                                                <i>Product Cost</i>
                                                <label class="pull-right"><%=invoice.getTotal()%> </label>
                                            </div>
                                            <div class="form-group">
                                                <i>Shipping Cost</i>
                                                <label class="pull-right"><%=invoice.getShippingCost()%> </label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-5">
                                    <%
                                        Criteria getdeliverDetails = session1.createCriteria(POJOs.Deliver.class);
                                        getdeliverDetails.add(Restrictions.eq("invoice", invoice));

                                        POJOs.Deliver deliver = (POJOs.Deliver) getdeliverDetails.uniqueResult();

                                    %>
                                    <div class="panel panel-default">
                                        <div class="panel panel-heading">Deliver Details</div>
                                        <div class="panel panel-body bgImage">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <i>Deliver To :</i>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group text-left">
                                                        <label ><%=deliver.getFirstName()%></label>
                                                    </div>
                                                    <div class="form-group text-left">
                                                        <label ><%=deliver.getAddressNo()%></label>
                                                    </div>
                                                    <div class="form-group text-left">
                                                        <label ><%=deliver.getAddressStreet()%></label>
                                                    </div>
                                                    <div class="form-group text-left">
                                                        <label ><%=deliver.getAddressStreet2()%></label>
                                                    </div>
                                                    <div class="form-group text-left">
                                                        <label ><%=deliver.getCity()%></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <p>* Products will be Deliverd within 3 - 10 days(Business days)</p>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-warning" onclick="printData()">Print Invoice</button>
                </div>
            </div>
        </div>
        <%
            }else{
                response.sendRedirect("Home.jsp");
            }
        %>
    </body>
</html>
