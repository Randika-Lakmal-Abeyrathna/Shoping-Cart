<%-- 
    Document   : User_Profile
    Created on : 30-Dec-2015, 12:07:23
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">

        <!------- CSS---->
        <link href="CSS/Filebrowser.css" rel="stylesheet"/>
        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

        <script src="bootstrap/js/bootstrap.min.js"></script>

        <title>User Profile</title>

    </head>
    <body>
        <div class="container-fluid">
            <p><br/></p>

            <div class="row" id="nav">

                <div class="col-lg-8">
                    <div class="row">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-4">
                            <h4><center>User Profile</center> </h4>
                        </div>
                        <div class="col-lg-4"></div>
                    </div>

                </div>
                <div class="col-lg-4">
                    <ul class="nav nav-justified">
                        <li><a href="User_Profile.jsp"> User Details</a></li>
                        <li><a href="Change_Password.jsp"> Change Password</a></li>
                    </ul>
                </div>

            </div>
            <hr>
            <div id="contentArea">
                <form method="post" action="#">
                    <div class="row">

                        <div class="col-lg-7">
                            <div class="panel panel-default">
                                <div class="panel panel-heading"> Basic Information </div>
                                <div class="panel panel-body">


                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>First Name </label><br>
                                                <input type="text" class="form-control" name="fname" placeholder="First Name"/>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Last Name </label> <br>
                                                <input type="text"  class="form-control" name="lname" placeholder="Last Name"/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Date of Birth </label><br>
                                                <input type="date" class="form-control" name="dob" />
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Gender </label> <br>
                                                <select class="form-control" id="gender" name="gender">
                                                    <option>Male</option>
                                                    <option>Female</option>

                                                </select>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="panel panel-default">
                                <div class="panel panel-heading"> Upload Photo </div>
                                <div class="panel panel-body">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <label>
                                                    <center>
                                                        <img class="img img-rounded" src="img/user.png" width="50%" height="50%"/>
                                                    </center>
                                                </label>
                                            </div>
                                            <div class="col-lg-8">
                                                <div class="form-group">
                                                    <form enctype="multipart/form-data" method="post" action="fileupload" id="uploradform">
                                                        <div id="progressbox" class="form-inline">
                                                            <input disabled="disabled" class="form-control" id="fileName" placeholder="Choose File"/>

                                                            <div id="upFile" class="btn btn-primary">
                                                                <span>Select</span>
                                                                <input onchange="readURL(this)" class="upload" type="file" name="myfile" id="selectFile"/>
                                                            </div>
                                                            <br/>
                                                            <div class="progress">
                                                                <div class="progress-bar progress-bar-success progress-bar-striped active" id="pBar"></div>
                                                            </div>
                                                            <br/>
                                                            <div class="row">
                                                                <div class="col-lg-6" id="message"></div>
                                                                <div class="col-lg-2"></div>
                                                                <div class="col-lg-4">
                                                                    <input type="submit" class="btn btn-success" value="Upload"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="panel panel-default">
                                <div class="panel panel-heading"> Address Details</div>

                                <div class="panel panel-body">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>NO </label><br/>
                                                <input type="text" name="no" placeholder="Address No"  class="form-control"/>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Street 1 </label><br/>
                                                <input type="text" name="street1" placeholder="Street"  class="form-control"/>
                                            </div>
                                        </div><br/>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Street 2 </label><br/>
                                                <input type="text" name="street2" placeholder="Street"  class="form-control"/>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>City </label><br/>
                                                <input type="text" name="city" placeholder="City"  class="form-control"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="panel panel-default">
                                <div class="panel panel-heading"> Contact Details</div>

                                <div class="panel panel-body">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Email</label><br/>
                                                <input type="email" name="email" placeholder="Email"  class="form-control"/>
                                            </div>
                                            <div class="col-lg-6">

                                            </div>
                                        </div><br/>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Mobile Number </label><br/>
                                                <input type="tel" name="mobileno" placeholder="Mobile Number"  class="form-control"/>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Home Number </label><br/>
                                                <input type="tel" name="homeno" placeholder="Home Number"  class="form-control"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="buttonArea">
                        <div class="row">
                            <div class="col-lg-9"></div>
                            <div class="col-lg-2">
                                <div class="form-group form-inline">
                                    <a href="Main_Home.jsp" class="btn btn-default">Cancel</a>
                                    <input type="submit" class="btn btn-success" value="Update Details" />
                                </div>
                            </div>
                            <div class="col-lg-1"></div>
                        </div>
                    </div>
            </div>
        </form>
    </div>
    <div></div>
</div>

</div>
</body>
</html>
