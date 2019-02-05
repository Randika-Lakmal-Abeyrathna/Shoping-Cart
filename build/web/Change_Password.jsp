<%-- 
    Document   : Change_Password
    Created on : 30-Dec-2015, 20:00:29
    Author     : USER
--%>

<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">

        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>
        <title>Change Password</title>
        <style>
            
            #cpasswordmsg{
                color: red;
            }
            #spasswordmsg{
                color: red;
            }
            
        </style> 
        
        <script>
            function checkUserPassword() {

                var p1 = document.getElementById("cnewpassword").value;
                var p2 = document.getElementById("cconfirmpassword").value;

                if (p1 === p2) {
                    return true;

                } else {
                    document.getElementById("cpasswordmsg").innerHTML = "Password dosn't Match !";
                    return false;
                }

            }
            
            function checkSupplierPassword() {

                var s1 = document.getElementById("snewpassword").value;
                var s2 = document.getElementById("sconfirmpassword").value;

                if (s1 === s2) {
                    return true;

                } else {
                    document.getElementById("spasswordmsg").innerHTML = "Password dosn't Match !";
                    return false;
                }

            }
            
            function hideUserPasswordMsg() {
                
                document.getElementById("cpasswordmsg").innerHTML = "";
            }
            function hideSupplierPasswordMsg(){
                document.getElementById("spasswordmsg").innerHTML = "";
                
            }
        </script>
    </head>
    <body>


        <%
            if (request.getParameter("msg") != null) {
                if (request.getParameter("msg").equals("c")) {

        %>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Update Password </a>
                </div>
                <ul class="nav navbar-nav navbar-right " >
                    <%                        if (request.getSession().getAttribute("username") != null) {

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

                                }

                            } else {
                                response.sendRedirect("index.jsp");
                            }
                        %>
                </ul>
            </div>
        </nav>

        <div class="row">
            <div class="col-lg-3"></div>
            <div class="col-lg-6">
                
                <%
                if (request.getParameter("err") != null) {
                    String message = request.getParameter("err");

                    if (message.equals("Error in Password")) {
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
                
                <div class="panel panel-danger">
                    <div class="panel panel-heading"> Change Your Password </div>
                    <div class="panel panel-body">
                        <form action="updateUserPassword" method="post" onsubmit="return checkUserPassword()">
                            <div class="form-group">
                                <label> Current Password : </label>
                                <input type="password" name="ccurrentpassword" placeholder="Current Password" class="form-control" id="ccurrentpassword"/><br/>

                                <label> New Password :  </label>
                                <input type="password" name="cnewpassword" placeholder="New password" class="form-control" id="cnewpassword"/><br/>
                                
                                <label> Confirm Password :  </label>
                                <input type="password" name="cconfirmpassword" placeholder="Confirm Password" class="form-control" id="cconfirmpassword" onclick="hideUserPasswordMsg()"/><br/>
                                <label id="cpasswordmsg"></label>
                                <div class="row">
                                    <div class="col-lg-5"></div>
                                    <div class="col-lg-7">
                                        <div class="form-group form-inline">
                                            <a href="User_Profile.jsp" class="btn btn-default btn-group-justified form-control" > Cancel</a>
                                            <input type="submit" value="Change Password" id="cbuttonChange" class="btn btn-primary form-control"/>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-lg-3"></div>

        </div>
        <%                                } else if (request.getParameter("msg").equals("s")) {

        %>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Update Password </a>
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
                    <li><a href="Supplier_Main_Home.jsp">Home</a></li>
                    <li><a name = "username" id = "username" ><span class="glyphicon glyphicon-user ">  <%=customer.getEmail()%></span> </a> </li>
                    <li><a href="logout">Logout</a></li>
                        <%
                                } catch (Exception e) {
                                    response.sendRedirect("index.jsp");
                                }

                            }
                        %>
                </ul>
            </div>
        </nav>
        
        <div class="row">    
            <div class="col-lg-3"></div>
            <div class="col-lg-6">
                <%
                if (request.getParameter("err") != null) {
                    String message = request.getParameter("err");

                    if (message.equals("Error in Password")) {
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
                <div class="panel panel-danger">
                    <div class="panel panel-heading"> Change Your Password </div>
                    <div class="panel panel-body">
                        <form action="updateSupplierPassword" method="post" onsubmit="return checkSupplierPassword()">
                            <div class="form-group">
                                <label> Current Password : </label>
                                <input type="password" name="scurrentpassword" placeholder="Current Password" class="form-control" id="scurrentpassword"/><br/>

                                <label> New Password :  </label>
                                <input type="password" name="snewpassword" placeholder="New password" class="form-control" id="snewpassword"/><br/>

                                <label> Confirm Password :  </label>
                                <input type="password" name="sconfirmpassword" placeholder="Confirm Password" class="form-control" id="sconfirmpassword" onclick="hideSupplierPasswordMsg()"/><br/>
                                <label id="spasswordmsg"></label>
                                <div class="row">
                                    <div class="col-lg-5"></div>
                                    <div class="col-lg-7">
                                        <div class="form-group form-inline">
                                            <a href="User_Profile.jsp" class="btn btn-default btn-group-justified form-control" > Cancel</a>
                                            <input type="submit" value="Change Password" id="sbuttonChange" class="btn btn-primary form-control"/>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-lg-3"></div>
        </div>
        <%                    }
            } else {
                response.sendRedirect("index.jsp");
            }
        %>
    </body>
</html>
