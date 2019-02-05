<%-- 
    Document   : RegistrationForm
    Created on : 24-Dec-2015, 20:04:03
    Author     : USER
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>Registration Form</title>

          <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>

        <style type="text/css">

            #buttonsSide{
                float: right;
                margin-right: 20px;
                margin-bottom: 10px;

            }
            #passwordmsg{
                color: red;
            }
            #emailMsg{
                color: red;
                
            }
        </style>

        <script type="text/javascript">

            function checkEmailSupplier() {
                var email = document.getElementById("email").value;
                $.ajax({
                    url: "checkEmail",
                    type: 'POST',
                    data: {
                        value: email
                    },
                    success: function(data, textStatus, jqXHR) {
                        if (data === "0") {
                         
                            document.getElementById("emailCheck").value="1";
                            document.getElementById("emailMsg").innerHTML = "";

                        } else {
                            document.getElementById("emailMsg").innerHTML = "Email Already Exist !";
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
                var value2 = document.getElementById("conformpassword").value;
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

            function hideEmailMsg() {
                document.getElementById("emailMsg").innerHTML = "";

            }

            function hidePasswordMsg() {
                document.getElementById("passwordmsg").innerHTML = "";
            }

        </script>
    </head>
    <body>

        <!--navigation Bar-->
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="naFvbar navbar-header"><a class="navbar-brand" href="#">User Registration</a></div>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="index.jsp">Login</a></li>
                </ul>
            </div>
        </nav>
        <div class="container-fluid">

            <%
                if (request.getParameter("msg") != null) {
                    String message = request.getParameter("msg");

                    if (message.equals("Successfuly Saved !")) {
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

            <div class="row">
                <div class="col-lg-2" id="col2" >

                </div>
                <div class="col-lg-8">
                    <!---- Registration Form ------>
                    <form action="user_registration" method="post" onsubmit="return checkPasswordSupplier()">
                        <div class="row">
                             <input type="hidden" id="emailCheck" value="0">
                            <div class="panel panel-default">
                                <div class="panel-heading"> Basic Information </div>
                                <div class="panel-body">


                                    <!-----basic information Panel ----->
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label>Salutation</label>
                                                <select class="form-control" name="salutaion">
                                                    <%                                                        Criteria c = new classess.sessionConnect().testConnection().createCriteria(POJOs.Salutation.class);
                                                        List<POJOs.Salutation> salutationList = c.list();

                                                        if (!salutationList.isEmpty()) {

                                                            for (int i = 0; i < salutationList.size(); i++) {
                                                                POJOs.Salutation salutation = salutationList.get(i);
                                                                String salutation1 = salutation.getSalutation();


                                                    %>
                                                    <option><%=salutation1%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>
                                                <hr>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label>First Name</label>
                                                <input type="text" class="form-control" id="fname"  name="fname" placeholder="First Name">

                                                <hr>
                                                <label>Date Of Birth</label>
                                                <input type="date" class="form-control" id="dateofbirth" name="dateofbirth" >
                                                <hr>
                                            </div>

                                        </div>

                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label>Last Name</label>
                                                <input type="text" class="form-control" id="lname" name="lname" placeholder="Last Name">
                                                <hr>
                                                <label>Gender</label>
                                                <select class="form-control" id="gender" name="gender">
                                                    <option>Male</option>
                                                    <option>Female</option>
                                                </select>
                                                <hr>
                                            </div>

                                        </div>
                                        <p> <br/></p>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <label>NIC Number</label>
                                            <input type="text" class="form-control" id="nic" name="nic" placeholder="NIC Number">
                                            <hr>
                                        </div>
                                    </div>                
                                    <!----- End of basic information Panel ----->


                                    <!--- Address panel--->

                                    <div class="panel panel-default">
                                        <div class="panel-heading"> Address </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label> Address No</label>
                                                        <input type="text" class="form-control" id="addressno"  name="addressno">
                                                        <hr>
                                                        <label> Street 2</label>
                                                        <input type="text" class="form-control" id="street2" name="street2" >
                                                        <hr>
                                                    </div>


                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label> Street 1</label>
                                                        <input type="text" class="form-control" id="street1" name="street1" >
                                                        <hr>
                                                        <label> City</label>
                                                        <input type="text" class="form-control" id="City1" name="city" >
                                                        <hr>
                                                    </div>

                                                </div>
                                            </div>


                                        </div>
                                    </div>

                                    <!----- End of Address Panel---->

                                    <!---- contact details Panel---->
                                    <div class="panel panel-default">
                                        <div class="panel-heading"> Contact Details </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="form-group">

                                                        <label> Mobile Number</label>
                                                        <input type="tel" class="form-control" id="mobileno" name="mobileno" >
                                                        <hr>
                                                        <label> Email Address</label>
                                                        <input type="email" class="form-control" id="email" name="email" onchange="checkEmailSupplier()" onclick="hideEmailMsg()">
                                                        <label id="emailMsg"></label>
                                                        <hr>
                                                    </div>

                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label> Home or Office Number</label>
                                                        <input type="tel" class="form-control" id="homeno" name="homeno" >
                                                        <hr>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <!---- End of contact details Panel---->

                                    <!--- Password and userName panel --->
                                    <div class="panel panel-danger">
                                        <div class="panel-heading"> Password  </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label> Password</label>
                                                        <input type="password" class="form-control" id="password" name="password">
                                                        <hr>
                                                    </div>

                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label>  Conform Password</label>
                                                        <input type="password" class="form-control" id="conformpassword" name="conformpassword" onclick="hidePasswordMsg()">
                                                        <label id="passwordmsg"></label>
                                                        <hr>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <!--- End  of Password and userName panel --->


                                </div>
                                <!----Submit Button ---->
                                <div class="row">
                                    <aside id="buttonsSide">
                                        <input type="submit" class="btn btn-primary" value="Submit Data">
                                        <input type="button" class="btn btn-warning" value="Cancel"  >
                                    </aside>
                                </div>
                                <!---- End of Submit Button ---->

                            </div>

                        </div>

                    </form>

                </div>

                <div class="col-lg-2" id="col2">
                </div>
            </div>
        </div>

    </body>
</html>
