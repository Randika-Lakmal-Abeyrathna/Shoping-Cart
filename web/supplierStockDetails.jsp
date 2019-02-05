<%-- 
    Document   : supplierStockDetails
    Created on : Oct 13, 2016, 7:31:07 PM
    Author     : Randika Lakmal
--%>

<%@page import="POJOs.ProductStatus"%>
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
        <script src="JS/Chart.js"></script>
        <title>Stock Details</title>
    </head>
    <body>

        <!----- Heading part Start----->
        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Stock Details </a>
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
                    <div class="col-md-10">
                        
                        <%
                            Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                            POJOs.Supplier supplier1= (POJOs.Supplier)request.getSession().getAttribute("username");
                            POJOs.Supplier supplier = (POJOs.Supplier) session1.load(POJOs.Supplier.class, supplier1.getEmail());
                            
                            Criteria productDetailsCriteria = session1.createCriteria(POJOs.Product.class);
                            productDetailsCriteria.add(Restrictions.eq("supplier", supplier));
                            productDetailsCriteria.add(Restrictions.eq("productStatus", new classess.getProductSubDetails().getActiveProductStatus()));
                            
                            List<POJOs.Product> productList = productDetailsCriteria.list();
                            
                            if(!productList.isEmpty()){
                                
                                String prodcuts="[";
                                String quantity ="[ ";
                                
                                for(int i=0; i<productList.size();i++){
                                
                                    POJOs.Product product = productList.get(i);
                                    
                                    if((productList.size()-1) == i) {
                                        prodcuts += "\""+product.getProductName()+"\" "+"]";
                                        quantity += "\""+product.getQty()+"\" "+"]";
                                    }else{
                                         prodcuts += "\""+ product.getProductName()+"\" "+",";
                                         quantity += "\""+product.getQty()+"\" "+",";
                                    }
                                    
                                    
                                }
                                %>
                                 <canvas id="myChart" height="150px"></canvas>
                    <script>
                        var ctx = document.getElementById("myChart");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: <%=prodcuts %>,
                                datasets: [{
                                        label: '# of Units',
                                        data: <%=quantity %>,
                                        backgroundColor: [
                                            'rgba(255, 99, 132, 0.2)',
                                            'rgba(54, 162, 235, 0.2)',
                                            'rgba(255, 206, 86, 0.2)',
                                            'rgba(75, 192, 192, 0.2)',
                                            'rgba(153, 102, 255, 0.2)',
                                            'rgba(255, 159, 64, 0.2)'
                                        ],
                                        borderColor: [
                                            'rgba(255,99,132,1)',
                                            'rgba(54, 162, 235, 1)',
                                            'rgba(255, 206, 86, 1)',
                                            'rgba(75, 192, 192, 1)',
                                            'rgba(153, 102, 255, 1)',
                                            'rgba(255, 159, 64, 1)'
                                        ],
                                        borderWidth: 1
                                    }]
                            },
                            options: {
                                scales: {
                                    yAxes: [{
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }]
                                }
                            }
                        });
                    </script>
                                
                                
                                
                                <%
                                
                            }else{
                            
                                %>
                                <p class="text-center text-warning" style="font-size: xx-large">There is No Products </p>
                                <%
                            
                            }
                            
                            
                        %>
                        
                        
                   
                    </div>
                </div>
            </div>
    </body>
</html>
