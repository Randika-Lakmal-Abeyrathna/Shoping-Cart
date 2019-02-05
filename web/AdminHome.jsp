<%-- 
    Document   : AdminHome
    Created on : 04-Oct-2016, 21:35:39
    Author     : Randika Lakmal
--%>

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

        <script src="bootstrap/js/bootstrap.js"></script>

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="JS/Chart.js"></script>

        <title>Admin Main Page</title>
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
                    <li><a href="AdminSupplierDetails.jsp">Supplier Details <span class="badge" ><i>New  </i>  <%=new classess.GetPendingSupplier().getPendingSupplierCount()%> </span></a></li>
                    <li><a href="AdminAccountDetails.jsp">Account Details</a></li>
                    <li><a href="AdminShippingDetails.jsp">Shipping Details</a></li>
                </ul>
            </nav>    
        </div>
        <!--Navigation bar Finish-->

        <!--Content Area Start--> 
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="glyphicon glyphicon-user fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">

                                    <div class="huge"><%=new classess.totalUsers().getUserCount()%></div>
                                    <div>All Customers</div>
                                </div>
                            </div>
                        </div>
                        <a href="allCustomers.jsp">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="glyphicon glyphicon-circle-arrow-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="panel panel-green">
                        <div class="panel panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="glyphicon glyphicon-shopping-cart fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">

                                    <div class="huge"><%=new classess.totalSuppliers().getSupplierCount()%></div>
                                    <div>All Suppliers</div>
                                </div>
                            </div>
                        </div>
                        <a href="AdminSupplierDetails.jsp">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="glyphicon glyphicon-circle-arrow-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="panel panel-yellow">
                        <div class="panel panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="glyphicon glyphicon-credit-card fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">

                                    <div class="huge"><%=new classess.AdminTotalIncome().getTotal()%></div>
                                    <div>Total Income</div>
                                </div>
                            </div>
                        </div>
                        <a href="AdminAccountDetails.jsp">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="glyphicon glyphicon-circle-arrow-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel panel-heading">Summery</div>
                    <div class="panel panel-body">
                        
                        <div class="row">
                            <!--Customer-->
                            <div class="col-md-4">
                                <div class="panel panel-primary">
                                    <div class="panel panel-heading">Customer Summery</div>
                                    <div class="panel panel-body">
                                        <%
                                            int Active =new classess.getActiveUsers().getActive();
                                            int Deactive =new classess.getDeactiveUsers().getActive();
                                        %>
                                        <canvas id="customer" ></canvas>
                                        <script>
                                    var ctx = document.getElementById("customer");
                                    var myChart = new Chart(ctx, {
                                        type: 'doughnut',
                                        data: {
                                            labels: ["Active Users", "Deactive Users"],
                                            datasets: [{
                                                    label: '# of Users',
                                                    data: [<%=Active%>, <%=Deactive%>],
                                                    backgroundColor: [
                                                        'rgba(255, 99, 132, 0.2)',
                                                        'rgba(54, 162, 235, 0.2)'
                                                    ],
                                                    borderColor: [
                                                        'rgba(255,99,132,1)',
                                                        'rgba(54, 162, 235, 1)'
                                                    ],
                                                    borderWidth: 1
                                                }]
                                        }

                                    });
                                </script>
                                    </div>
                                </div>
                            </div>
                            <!--Supplier-->
                            <div class="col-md-4">
                                <div class="panel panel-success">
                                    <div class="panel panel-heading">Supplier Summery</div>
                                    <div class="panel panel-body">
                                        <%
                                            int sActive =new classess.getSupplier().getActive();
                                            int sDeactive =new classess.getSupplier().getDeactive();
                                            int spending =new classess.getSupplier().getPending();
                                        %>
                                        <canvas id="supplier" ></canvas>
                                        <script>
                                    var ctx = document.getElementById("supplier");
                                    var myChart = new Chart(ctx, {
                                        type: 'doughnut',
                                        data: {
                                            labels: ["Active Users", "Deactive Users","Pending Users"],
                                            datasets: [{
                                                    label: '# of Users',
                                                    data: [<%=sActive%>, <%=sDeactive%>,<%=spending %>],
                                                    backgroundColor: [
                                                        'rgba(255, 99, 132, 0.2)',
                                                        'rgba(54, 162, 235, 0.2)',
                                                        'rgba(53, 53, 198, 0.2)'
                                                    ],
                                                    borderColor: [
                                                        'rgba(255,99,132,1)',
                                                        'rgba(54, 162, 235, 1)',
                                                        'rgba(53, 53, 198, 1)'
                                                    ],
                                                    borderWidth: 1
                                                }]
                                        }

                                    });
                                </script>
                                    </div>
                                </div>
                            </div>
                            <!--Income-->
                            <div class="col-md-4">
                                
                                <div class="panel panel-warning">
                                    <div class="panel panel-heading">Account Summery</div>
                                    <div class="panel panel-body">
                                        <%
                                            double shipping =new classess.AdminTotalIncome().getShiping();
                                            double profit =new classess.AdminTotalIncome().getProfit();
                                        %>
                                        <canvas id="account" ></canvas>
                                        <script>
                                    var ctx = document.getElementById("account");
                                    var myChart = new Chart(ctx, {
                                        type: 'doughnut',
                                        data: {
                                            labels: ["Shipping", "Profit"],
                                            datasets: [{
                                                    label: 'In LKR',
                                                    data: [<%=shipping%>, <%=profit%>],
                                                    backgroundColor: [
                                                        'rgba(255, 99, 132, 0.2)',
                                                        'rgba(53, 53, 198, 0.2)'
                                                    ],
                                                    borderColor: [
                                                        'rgba(255,99,132,1)',
                                                        'rgba(53, 53, 198, 1)'
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
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Content Area Finish --> 

</body>
</html>
