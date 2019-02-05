<%-- 
    Document   : UpdatePassword
    Created on : Oct 17, 2016, 6:51:42 PM
    Author     : Randika Lakmal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>
        <title>Change Password</title>
        
        <style type="text/css">
            #passwordmsg{
                color: red;
            }
        </style>
        
        <script type="text/javascript">
            function checkPassword() {

                var p1 = document.getElementById("password").value;
                var p2 = document.getElementById("conformpassword").value;

                if (p1 === p2) {
                    return true;

                } else {
                    document.getElementById("passwordmsg").innerHTML = "Password dosn't Match !";
                    return false;
                }

            }
            
             function hidePasswordMsg() {
                document.getElementById("passwordmsg").innerHTML = "";
            }
        </script>
        
    </head>
    <body>
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
            <% if (request.getParameter("type") == null) {
                    response.sendRedirect("index.jsp");
                } else if (request.getParameter("type") == "c") {
            %>
            <div class="col-md-6" style="margin-top: 20px;">
                <div class="panel panel-default">
                    <div class="panel panel-heading">Change Password</div>
                    <div class="panel panel-body">
                        <form action="supplierPasswordRecover" method="post" onsubmit="return checkPassword()">
                            <input type="hidden" name="email" value="<%=request.getParameter("id") %>">
                            <div class="form-group">
                                <label class="control-label">New Password</label>
                                <input id="password" type="password" class="form-control" name="p" >
                            </div>
                            <div class="form-group">
                                <label class="control-label">Confirm Password</label>
                                <input id="conformpassword" type="password" class="form-control" name="cp" onclick="hidePasswordMsg()" >
                            </div>
                            <div class="form-group">
                                <label id="passwordmsg"></label>
                            </div>
                            <div class="form-group">
                                <input type="submit" class="btn btn-primary pull-right" value="Update"  >
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>

            <%
            } else if (request.getParameter("type") == "s") {

            %>
            <div class="col-md-6" style="margin-top: 20px;">
                <div class="panel panel-default">
                    <div class="panel panel-heading">Change Password</div>
                    <div class="panel panel-body">
                        <form action="customerPasswordRecover" method="post" onsubmit="return checkPassword()">
                            <input type="hidden" name="email" value="<%=request.getParameter("id") %>">
                            <div class="form-group">
                                <label class="control-label">New Password</label>
                                <input id="password" type="password" class="form-control" name="p" >
                            </div>
                            <div class="form-group">
                                <label class="control-label">Confirm Password</label>
                                <input id="conformpassword" type="password" class="form-control" name="cp" onclick="hidePasswordMsg()" >
                            </div>
                            <div class="form-group">
                                <label id="passwordmsg"></label>
                            </div>
                            <div class="form-group">
                                <input type="submit" class="btn btn-primary pull-right" value="Update"  >
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>

            <%                           }
            %>
        </div>

    </body>
</html>
