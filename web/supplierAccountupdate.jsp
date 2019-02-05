<%-- 
    Document   : supplierAccountupdate
    Created on : Oct 13, 2016, 7:32:14 PM
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
        <title>Accpunt Update</title>
    </head>
    <body>
        <!----- Heading part Start----->
        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Update Details </a>
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

                            } else {
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
                            <li><a href="SupplierNewOrders.jsp">New Orders  <span class="badge" ><%=new classess.getNewOrder().getNewOrderCount(supplier)%></span></a></li>
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

        </div>  
        <div class="container-fluid">
            <form action="updateSupplierDetails" method="post">
                <div class="row">
                    <%
                    if(request.getSession().getAttribute("username") != null ){
                        
                        try{
                        POJOs.Supplier supplier1 = (POJOs.Supplier) request.getSession().getAttribute("username");

                        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                        
                        POJOs.Supplier supplier= (POJOs.Supplier)session1.load(POJOs.Supplier.class, supplier1.getEmail());
                        
                        
                        
                    %>

                    <!--Owner Information-->
                    <div class="col-md-4">
                        <div class="panel panel-default panelSizeTop">
                            <div class="panel panel-heading">Owner Information</div>
                            <div class="panel panel-body">
                                <div class="form-group form-horizontal">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <label>Owner Name :</label>
                                            <input class="form-control" type="text" name="ownername" placeholder="Owner Name" value="<%=supplier.getSupplierName() %>" required/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Owner National ID Number :</label>
                                            <input class="form-control" type="text" name="nicNumber" placeholder="National ID Number" value="<%=supplier.getSupplierNic() %>" required/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Owner Contact Number:</label>
                                            <input class="form-control" type="tel" name="ownercontact" placeholder="Contact Number" value="<%=supplier.getOwnerContactno() %>" required/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Comapany main Information-->
                    <div class="col-md-4">
                        <div class="panel panel-default panelSizeTop">
                            <div class="panel panel-heading">Company Information</div>
                            <div class="panel panel-body">
                                <div class="form-group form-horizontal">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <label>Company Name</label>
                                            <input class="form-control" type="text" name="companyname" placeholder="Company Name" value="<%=supplier.getCompanyName() %>" required/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Company Register Number :</label>
                                            <input class="form-control" type="text" name="companyregnumber" placeholder="Company Register Number" value="<%=supplier.getCompanyRegNumber() %>" required/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--Company Contact Information-->
                    <div class="col-md-4">
                        <div class="panel panel-default panelSize">
                            <div class="panel panel-heading">Company Contact Details</div>
                            <div class="panel panel-body">
                                <div class="form-group form-horizontal">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <label>Company Email :</label>
                                            <input disabled class="form-control" type="email" id="companyemail" placeholder="Company Email" value="<%=supplier.getEmail() %>"/>
                                            <input type="hidden" name="companyemail" value="<%=supplier.getEmail() %>" />
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Company Contact Number 1 :</label>
                                            <input class="form-control" type="tel" name="companycontact1" placeholder="Contact Number" value="<%=supplier.getContactNumber() %>" required/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Company Contact Number 2 :</label>
                                            <input class="form-control" type="tel" name="companycontact2" placeholder="Contact Number" value="<%=supplier.getContactNumber() %>" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default panelSize">
                            <div class="panel panel-heading">Company Address Details</div>
                            <div class="panel panel-body">
                                <div class="form-group form-horizontal">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Address Number</label>
                                                <input class="form-control" type="text" name="addressno" value="<%=supplier.getAddressNo() %>" placeholder="Address Number"/>
                                            </div>
                                            <div class="col-md-6">
                                                <label>Street 1</label>
                                                <input class="form-control " type="text" name="street1" value="<%=supplier.getAddressStreet() %>" placeholder="Street 1"/>
                                            </div>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Street 2</label>
                                                <input class="form-control" type="text" name="street2" value="<%=supplier.getAddressStreet2() %>" placeholder="Street 2"/>
                                            </div>
                                            <div class="col-md-6">
                                                <label>City</label>
                                                <input class="form-control" type="text" name="city" value="<%=supplier.getCity().getCity() %>" placeholder="City"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <aside style="float: right; margin-right: 20px; margin-top: 10px; "  >
                            <input type="submit" value="Update Details" class="btn btn-primary">
                            <a class="btn btn-warning" href="Change_Password.jsp?msg=s">Update Password</a>
                        </aside>

                    </div>
                    <%
                        
                        }catch(Exception e){
                            response.sendRedirect("index.jsp");
                        }
                    }else{
                        response.sendRedirect("index.jsp");
                    }
                    %>
                </div>
            </form>
        </div>
    </body>
</html>
