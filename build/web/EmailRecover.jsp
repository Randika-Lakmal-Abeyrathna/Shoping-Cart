<%-- 
    Document   : EmailRecover
    Created on : Oct 17, 2016, 4:43:30 PM
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
        <title>Password Recover</title>
    </head>
    <body>
        <!--Navigation bar Start-->
        <div>
            <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar navbar-header"><a class="navbar-brand" href="#"><img src="img/logo_7_cakeshop.png" width="170px"></a></div>
                    <ul class="nav navbar-nav navbar-right " >
                        <li><a href="Home.jsp">Home</a></li>
                        
                    </ul>
                </div>
            </nav>    
        </div>

        <!--Navigation bar Finish-->
        <div class="container-fluid">
            <div class="col-md-3"></div>
             <%
                if (request.getParameter("msg") != null) {
                    String message = request.getParameter("msg");

                    if (message.equals("Email Doesn't Exists !") | message.equals("There were an error")) {
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
            <div class="col-md-6" style="margin-top: 20px;">
                <div class="panel panel-default">
                    <div class="panel panel-heading">Password Recover</div>
                    <div class="panel panel-body">
                        <form action="sendRecoverCode" method="post">
                            <div class="form-group">
                                <label class="control-label">User Email</label>
                                <input type="email" class="form-control" name="email" >
                            </div>
                            <div class="form-group">
                                <input type="submit" class="btn btn-primary pull-right" value="Get Recover Code"  >
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

    </body>
</html>
