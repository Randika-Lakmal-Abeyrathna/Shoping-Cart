<%-- 
    Document   : index
    Created on : 23-Dec-2015, 22:14:46
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">

        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>


        <style type="text/css">

            #loginDiv{
                box-shadow: 0 0 6px 1px #245269;
            }

            #loginButton{
                float: right;
                margin-right: 20px;
            }

        </style>

        <script>
            function preventBack() {
                window.history.forward();
            }
            setTimeout("preventBack()", 0);
            window.onunload = function() {
                null
            };
            
            $(document).ready(function() {
                $('.carousel').carousel({
                    interval: 3200
                })
            });
            function check() {

                $.ajax({
                    url: "",
                    type: 'POST',
                    data: {
                        text: "Randika",
                    },
                    success: function(data, textStatus, jqXHR) {
                        alert(data);
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
            Cookie[] cookies = request.getCookies();

            for (Cookie co : cookies) {
                if (co.getName().equals("username")) {

                    if (co.getValue() != null) {
                        if (new classess.tools().checkUserExist(co.getValue())) {
                            POJOs.Customer customer = new classess.tools().getCustomer(co.getValue());
                            HttpSession session1 = request.getSession();
                            session1.setAttribute("username", customer);

                            response.sendRedirect("Home.jsp");
                        } else if (new classess.tools().checkSupplierExist(co.getValue())) {
                            POJOs.Supplier supplier = new classess.tools().getSupplier(co.getValue());
                            HttpSession session1 = request.getSession();
                            session1.setAttribute("username", supplier);

                            response.sendRedirect("Supplier_Main_Home.jsp");

                        }
                    }

                }

            }
        %>

        <!--Navigation bar Start-->
        <div>
            <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar navbar-header"><a class="navbar-brand" href="#"><img src="img/logo_7_cakeshop.png" width="170px"></a></div>
                    <ul class="nav navbar-nav navbar-right " >
                        <li><a href="Home.jsp">Home</a></li>
                        <li><a href="RegistrationForm.jsp">User Registration</a></li>
                        <li><a href="supplier_registration.jsp">Shop Registration</a></li>
                    </ul>
                </div>
            </nav>    
        </div>

        <!--Navigation bar Finish-->

        <!--Content Area Start-->

        <div class="container-fluid">

            <%
                if (request.getParameter("msg") != null) {
                    String message = request.getParameter("msg");

                    if (message.equals("Error in User Name Or Password")) {
            %>
            <div class="alert alert-danger"><a class="close" data-dismiss="alert" >&times;</a><%=message%></div>
            <%
            } else {
            %>
            <div class="alert alert-danger"><a class="close" data-dismiss="alert" >&times;</a><%=message%></div>
            <%
                    }
                }

            %>



            <div class="row">
                <div class="col-md-7">
                    <!--Images Here-->
                    <div class="container-fluid">
                        <div class="row">
                            <!-- Carousel Start -->
                            <div class="carousel slide" id="carosel1" >
                                <!-- Carousel indicators -->
                                <ol class="carousel-indicators">
                                    <li data-target="#carosel1" data-slide-to="0" class="active"></li>
                                    <li data-target="#carosel1" data-slide-to="1" ></li>
                                    <li data-target="#carosel1" data-slide-to="2" ></li>
                                    <li data-target="#carosel1" data-slide-to="3" ></li>
                                </ol>

                                <div class="carousel-inner">
                                    <div class="item active">
                                        <img src="img/iamge 4.jpg" alt="First slide">
                                    </div>
                                    <div class="item">
                                        <img src="img/image 5.jpg" alt="Second slide">
                                    </div>
                                    <div class="item">
                                        <img src="img/image 6.jpg" alt="Third slide">
                                    </div>
                                    <div class="item">
                                        <img src="img/edit.jpg" alt="4th slide">
                                    </div>
                                </div>
                                <a class="carousel-control left" href="#carosel1"
                                   data-slide="prev">&lsaquo;</a>
                                <a class="carousel-control right" href="#carosel1"
                                   data-slide="next">&rsaquo;</a>
                            </div>
                            <!-- Carousel End -->
                        </div>
                    </div>
                </div>
                <div  class="col-md-5">
                    <div id="loginDiv" class="panel panel-success">
                        <div class="panel panel-heading"><h4>Login</h4></div>
                        <div class="panel-body">
                            <form class="form-horizontal" action="login" method="post">
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="email">Email:</label>
                                    <div class="col-sm-10">
                                        <input type="email" class="form-control" id="email" name="userName" placeholder="Enter email" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="pwd">Password:</label>
                                    <div class="col-sm-10"> 
                                        <input type="password" class="form-control" id="pwd" name="password" placeholder="Enter password" required >
                                    </div>
                                </div>
                                <div class="form-group"> 
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <div class="checkbox">
                                            <label><input type="checkbox" name="remember"> Remember me</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group"> 
                                    <aside id="loginButton">
                                        <button type="submit" class="btn btn-primary">Login</button>
                                    </aside>
                                </div>
                            </form>
                            <div class="form-group">
                                <div class="col-sm-offset-2">
                                    <a href="EmailRecover.jsp">forgotten Password ?</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Content Area Finish-->
        
<!--        <footer class="panel panel-footer text-center" style="margin-bottom: 0px; padding-bottom: 0px;">
            <a href="Admin_Login.jsp">Admin Login</a>
        </footer>-->
    </body>
    <%@ include file="Footer.jsp" %>
</html>
