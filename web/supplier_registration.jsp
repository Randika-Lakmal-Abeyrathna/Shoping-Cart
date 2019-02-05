<%-- 
    Document   : supplier_registration
    Created on : Jun 26, 2016, 8:34:17 PM
    Author     : randika
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Supplier Registration</title>

            <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>
        
        <script type="text/javascript">

            function checkEmailSupplier() {
                var email = document.getElementById("companyemail").value;
                $.ajax({
                    url: "checkEmail",
                    type: 'POST',
                    data: {
                        value: email
                    },
                    success: function(data, textStatus, jqXHR) {
                        if (data === "0") {
                         
                            document.getElementById("emailCheck").value="1";
                            document.getElementById("companyemailmsg").innerHTML = "";

                        } else {
                            document.getElementById("companyemailmsg").innerHTML = "Email Already Exist !";
                            document.getElementById("emailCheck").value="0";
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                      alert(jqXHR)
                    }

                });


            }

            function checkPasswordSupplier() {
               
                var value1 = document.getElementById("password").value;
                var value2 = document.getElementById("confirmpassword").value;
                var value3 =document.getElementById("emailCheck").value;
                
                if(value3 == 1){
                    if (value1 === value2) {
                    return true;
                } else {
                    document.getElementById("passwordmsg").innerHTML = "Password dosn't Match !";
                    return false;

                }
                    
                }else{
                    return false;
                    
                }
                
            }

            function hidePasswordMsgSupplier() {
                document.getElementById("passwordmsg").innerHTML = "";
            }

        </script>

        <style type="text/css" >
            #passwordmsg{
                color: red;
            }
            #companyemailmsg{
                color: red;
            }
            .panelSizeTop{
                height: 400px;

            }
            .panelSize{
                height: 500px;

            }
            #right-aside{

                float: right;
                margin-right: 20px;
                margin-bottom: 20px;

            }

        </style>
    </head>

    <body>

        <!--Navigation Bar Start-->
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar navbar-header"><a class="navbar-brand" href="#">Supplier Registration</a></div>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="index.jsp">Login</a></li>
                </ul>
            </div>
        </nav>

        <!--Navigation Bar End-->

        <!--Message Area Start-->
        <%
            if (request.getParameter("msg") != null) {
                String message = request.getParameter("msg");

                if (message.equals("Successfuly Saved ! Account will be Activeated within some time.")) {
        %>
        <div class="alert alert-success"><a class="close" data-dismiss="alert" >&times;</a><%=message%></div>
        <%
        } else {
        %>
        <div class="alert alert-danger"><a class="close" data-dismiss="alert" >&times;</a><%=message%></div>
        <%
                }
            }

        %>

        <!--Message Area End-->

        <!--Content Area Start-->
        <div class="container-fluid"> 
            <form action="supplier_registration" method="post" onsubmit="return checkPasswordSupplier()" >

                <div class="row">
                    <!--Owner Information Start-->
                    <div class="col-md-6">
                        <input type="hidden" id="emailCheck" value="0">
                        <div class="panel panel-default panelSizeTop">
                            <div class="panel panel-heading">Owner Information</div>
                            <div class="panel panel-body">
                                <div class="form-group form-horizontal">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <label>Owner Name :</label>
                                            <input class="form-control" type="text" name="ownername" placeholder="Owner Name" required/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Owner National ID Number :</label>
                                            <input class="form-control" type="text" name="nicNumber" placeholder="National ID Number" required/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Owner Contact Number:</label>
                                            <input class="form-control" type="tel" name="ownercontact" placeholder="Contact Number" required/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Owner Information End-->

                    <!--Company Information Start-->
                    <div class="col-md-6">
                        <div class="panel panel-default panelSizeTop">
                            <div class="panel panel-heading">Company Information</div>
                            <div class="panel panel-body">
                                <div class="form-group form-horizontal">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <label>Company Name</label>
                                            <input class="form-control" type="text" name="companyname" placeholder="Company Name" required/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Company Register Number :</label>
                                            <input class="form-control" type="text" name="companyregnumber" placeholder="Company Register Number" required/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--Company Information End-->
                    <div class="clearfix"></div>

                </div>
                <div class="row">
                    <!--Company Contact Details Start-->
                    <div class="col-md-6">
                        <div class="panel panel-default panelSize">
                            <div class="panel panel-heading">Company Contact Details</div>
                            <div class="panel panel-body">
                                <div class="form-group form-horizontal">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <label>Company Email :</label>
                                            <input class="form-control" type="email" id="companyemail" name="companyemail" placeholder="Company Email" required onchange="checkEmailSupplier()" />
                                            <label id="companyemailmsg"></label>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Company Contact Number 1 :</label>
                                            <input class="form-control" type="tel" name="companycontact1" placeholder="Contact Number" required/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Company Contact Number 2 :</label>
                                            <input class="form-control" type="tel" name="companycontact2" placeholder="Contact Number"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Company Contact Details End-->

                    <!--Company Address Details Start-->
                    <div class="col-md-6">
                        <div class="panel panel-default panelSize">
                            <div class="panel panel-heading">Company Address Details</div>
                            <div class="panel panel-body">
                                <div class="form-group form-horizontal">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <label>Address Number</label>
                                            <input class="form-control" type="text" name="addressno" placeholder="Address Number"/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Street 1</label>
                                            <input class="form-control " type="text" name="street1" placeholder="Street 1"/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>Street 2</label>
                                            <input class="form-control" type="text" name="street2" placeholder="Street 2"/>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <label>City</label>
                                            <input class="form-control" type="text" name="city" placeholder="City"/>
                                        </div>    
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Company Address Details End-->

                </div>
                <div class="row">
                    <div class="container-fluid">
                        <!--Password-->
                        <div class="panel panel-default">
                            <div class="panel panel-heading danger"></div>
                            <div class="panel panel-body">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Password</label>
                                                <input id="password" class="form-control col-md-5" type="password" name="password" placeholder="Password" required/>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Confirm Password</label>
                                                <input id="confirmpassword" class="form-control col-md-5" type="password" name="confirmpassword" placeholder="Confirm Password" required onclick="hidePasswordMsgSupplier()" />
                                                <label id="passwordmsg"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <aside id="right-aside">
                        <input class="btn btn-success" type="submit" value="Save Details" />
                        <button class="btn btn-warning" type="button" value="Cancal"  >Cancel</button>
                    </aside>

                </div>
            </form>
        </div>
        <!--Content Area End-->
    </body>
</html>
