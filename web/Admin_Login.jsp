<%-- 
    Document   : Admin_Login
    Created on : 04-Oct-2016, 09:53:07
    Author     : Randika Lakmal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>


        <style type="text/css">

            #loginDiv{
                margin-top: 20px;
                box-shadow: 0 0 6px 1px #245269;
                margin-left: calc;

            }

            #loginButton{
                float: right;
                margin-right: 20px;

            }
            #forgottenPassword{
                border: none;
                background: none;
                color: #269abc

            }

        </style>

        <title>Admin Login</title>
    </head>
    <body>
        <%
            Cookie[] cookies = request.getCookies();

            for (Cookie co : cookies) {
                if (co.getName().equals("admin")) {
                    out.write(co.getValue());
                    HttpSession session1 = request.getSession();
                    session1.setAttribute("admin", (POJOs.AdminDetails) new classess.tools().getAdmin(co.getValue()));

                    response.sendRedirect("AdminHome.jsp");

                }

            }


        %>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">

                    <%                        if (request.getParameter("msg") != null) {
                            if (request.getParameter("msg").equals("User Name or Password Incorrect")) {
                                String message = request.getParameter("msg").toString();
                    %>
                    <div class="alert alert-danger"><a class="close" data-dismiss="alert" >&times;</a><%=message%></div>
                    <%
                            }

                        }

                    %>
                    <div id="loginDiv" class="panel panel-success">
                        <div  class="panel panel-heading"><h4>Admin Login</h4></div>
                        <div class="panel panel-body">
                            <form class="form-horizontal" action="adminLogin" method="post">
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
                            
                        </div>
                    </div>
                </div>
                <div class="col-md-3"></div>

            </div>
            <center>
                <div class="row">
                    <div  class="col-md-5 center-block">

                    </div>
                </div>
            </center>
        </div>
    </body>
</html>
