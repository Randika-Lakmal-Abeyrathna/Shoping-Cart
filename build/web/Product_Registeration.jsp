<%-- 
    Document   : Product_Registeration
    Created on : 04-Jan-2016, 13:34:59
    Author     : USER
--%>

<%@page import="org.hibernate.Session"%>
<%@page import="POJOs.SubCategory"%>
<%@page import="POJOs.TopCategory"%>
<%@page import="classess.getProductSubDetails"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Product Registration </title>


        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">


        <script src="JS/jquery-1.11.3.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>

        <style type="text/css">
            aside{
                float: right;
                padding: 10px;
                margin: 10px;
            }

            #progressBox{

                width : 500px;
                height: auto;

            }


            #filename{

                width: 304px;

            }

            #upfile{

                position: relative;
                overflow: hidden;
                margin: 10px;

            }


            .upload{

                opacity: 0;
                cursor: pointer;
                top : 0;
                right: 0;
                margin: 0;
                padding: 0;
                position: absolute;

            }


            .myimg{

                margin-left: 10px;
                margin-top: 10px;
                cursor: pointer;

            }

            #rightside{
                float: right;

            }
            #sellingprice{
                color: blue;

            }

        </style>

        <script type="text/javascript">

            function getfilename() {


                var filename = document.getElementById("selectfile").value;
                var f = filename.split("\\");

                document.getElementById("filename").value = f[f.length - 1];

                var a = document.getElementById("selectfile").files;

                for (var i = 0; i < a.length; i++) {

                    // alert(a[i].name + " , " + ((a[i].size/1024)/1024)/1024);

                }

            }

            function deleteimage(x) {

                $("#" + x).remove();

            }

            function getImage(input) {
                var c = 0;
                for (var i = 0; i < input.files.length; i++) {

                    if (input.files[i] !== null) {

                        var reader = new FileReader();

                        reader.onload = function(e) {

                            var elem = document.createElement("img");
                            elem.setAttribute("id", c);
                            elem.setAttribute("class", "myimge");
                            elem.setAttribute("src", e.target.result);
                            elem.setAttribute("width", "150");
                            elem.setAttribute("height", "150");
                            elem.setAttribute("onclick", 'deleteimage(' + c + ')');
                            elem.setAttribute("style", "margin-left: 2%; margin-top:2%");

                            document.getElementById("images").appendChild(elem);

                            c++;

                        };
                        reader.readAsDataURL(input.files[i]);
                    }
                }
            }

            function setSellingPrice(value) {
                $.ajax({
                    url: "Importent",
                    type: 'POST',
                    data: {
                        value: value, msg: "sellingPrice",
                    },
                    success: function(data, textStatus, jqXHR) {
                        document.getElementById("sellingprice").innerHTML = " " + data;
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(jqXHR);
                    }

                });
            }

            function saveCategory() {

                var value = document.getElementById("savecategory").value;

                $.ajax({
                    url: "productSubDetailsSave",
                    type: 'POST',
                    data: {
                        value: value, msg: "category"

                    },
                    success: function(data, textStatus, jqXHR) {
                        document.getElementById("category").innerHTML = data;
                        document.getElementById("savecategory").value = "";
                    },
                    error: function(jqXHR, textStatus, errorThrown) {

                    }

                });

            }

            function saveSubCategory() {

                var value = document.getElementById("savesubcategory").value;

                $.ajax({
                    url: "productSubDetailsSave",
                    type: 'POST',
                    data: {
                        value: value, msg: "subcategory"

                    },
                    success: function(data, textStatus, jqXHR) {
                        document.getElementById("subcategory").innerHTML = data;
                        document.getElementById("savesubcategory").value = "";
                    },
                    error: function(jqXHR, textStatus, errorThrown) {

                    }

                });

            }

        </script>
    </head>

    <body  >
 <!----- Heading part Start----->
        <nav class="navbar navbar-inverse" style="margin-bottom: 0px;">
            <div class="container-fluid">
                <div class="navbar navbar-header">
                    <a class="navbar-brand" href="#">Product Registration </a>
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
             <%
                if (request.getParameter("msg") != null) {
                    String message = request.getParameter("msg");

                    if (message.equals("Error in Saving Details !")) {
            %>
            <div class="alert alert-danger"><a class="close" data-dismiss="alert" >&times;</a><%=message%></div>
            <%
            } else {
            %>
            <div class="alert alert-success"><a class="close" data-dismiss="alert" >&times;</a><%=message%></div>
            <%
                    }
                }

            %>
            <form  method="post" action="product_registration" enctype="multipart/form-data" id="uploradform" >
                <%
                       POJOs.Supplier supplier = (POJOs.Supplier)request.getSession().getAttribute("username");
                %>
                <input type="hidden" name="username" value="<%=supplier.getEmail() %>">
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading"> Basic Information </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label>Product Name </label>
                                    <input class="form-control" type="text" name="productname" placeholder="Product Name">
                                </div>
                                <div class="form-group">
                                    <label>Quantity </label>
                                    <input class="form-control" type="number" name="quantity" placeholder="Quantity">
                                </div>
                                <div class="form-group">
                                    <label>Price </label>
                                    <input class="form-control" id="price" type="number" name="price" placeholder="Price" min="0" value="00.00" onchange="setSellingPrice(this.value)">
                                    <label >Selling price will be : Rs : </label><label id="sellingprice"></label>
                                </div>
                                <div class="form-group">
                                    <label>Description </label>
                                    <textarea class="form-control" rows="10" name="description" placeholder="Add Description About Product"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <!--Category select-->

                        <div class="panel panel-default">
                            <div class="panel panel-heading">Category Details</div>                        
                            <div class="panel-body">

                                <div class="form-group">
                                    <div class="row">
                                        <div class="form-horizontal">
                                            <label class="control-label col-md-3">Category</label>
                                            <div class="col-md-6">
                                                <select class="form-control" id="category" name="category" onselect="" >
                                                    <%
                                                        HashMap<String, Object> map = new classess.getProductSubDetails().getTopCategory();

                                                        if (!map.isEmpty()) {
                                                            for (int i = 0; i < map.size(); i++) {
                                                                TopCategory topCategory = (TopCategory) map.get(i + "");

                                                    %>
                                                    <option><%=topCategory.getTopCategory()%></option>
                                                    <%

                                                            }
                                                        }
                                                    %>
                                                </select> 
                                            </div>
                                            <!--                                            <div class="col-md-3">
                                                                                            <button class="btn btn-default" type="button" data-toggle="modal" data-target="#categorymodal">New Category</button>
                                                                                        </div>-->
                                        </div>

                                    </div>
                                </div>
                                <hr>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="form-horizontal">
                                            <label class="control-label col-md-3">Sub-Category</label>
                                            <div class="col-md-6">
                                                <select class="form-control" id="subcategory" name="subcategory" >
                                                    <%
                                                        HashMap<String, Object> subCategoryMap = new classess.getProductSubDetails().getSubcategory();

                                                        if (!subCategoryMap.isEmpty()) {
                                                            for (int i = 0; i < subCategoryMap.size(); i++) {
                                                                SubCategory subCategory = (SubCategory) subCategoryMap.get(i + "");

                                                    %>
                                                    <option><%=subCategory.getSubCategory()%></option>
                                                    <%

                                                            }
                                                        }
                                                    %>
                                                </select> 
                                            </div>
                                            <div class="col-md-3">
                                                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#subcategorymodal">New Sub-Category</button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--Image Upload-->
                        <div class="panel panel-default">
                            <div class="panel panel-heading"> Upload Photo </div>
                            <div class="panel panel-body">
                                <div class="row">
                                    <div class="col-lg-8">
                                        <div class="form-group">
                                            <label>Upload Image</label>
                                            <input type="file" multiple="true" name="files" onchange="getImage(this)" class=" btn btn-default">
                                            <div id="images"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  

                    </div>

                    <aside>
                        <input class="btn btn-warning" type="button" name="cancel" value="Cancel">
                        <input class="btn btn-success" type="submit" name="save" value="Save Details">
                    </aside>
                </div>

            </form>


            <!--Model Set Start-->

            <div class="modal fade" id="brandmodal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header"><h4>Register New Brand </h4></div>
                        <div class="modal-body">
                            <form action="Importent?msg=savebrand" method="post">
                                <div class="form-group">
                                    <label class="control-label">Brand Name</label>
                                    <input class="form-control" type="text" name="brand" placeholder="Brand Name"/>
                                    <div class="row">
                                        <aside id="rightside"><input type="submit" class="btn btn-success" value="Save Brand"></aside>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="categorymodal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header"><h4>Register Category </h4></div>
                        <div class="modal-body">
                            <form action="Importent?msg=savecategory" method="post" >
                                <div classs="form-group">
                                    <label class="control-label">Category Name</label>
                                    <input class="form-control" id="savecategory" type="text" name="category" placeholder="Category Name"/>

                                    <div class="row">
                                        <aside id="rightside"><input type="button" class="btn btn-success" value="Save category" onclick="saveCategory()"></aside>

                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="subcategorymodal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header"><h4>Register New Sub-Category </h4></div>
                        <div class="modal-body">
                            <form action="Importent?msg=savesubcategory" method="post">
                                <div class="form-group">
                                    <label class="control-label">Sub-Category Name</label>
                                    <input class="form-control" type="text" id="savesubcategory" name="subcategory" placeholder="Sub Category"/>
                                    <div class="row">
                                        <aside id="rightside">
                                            <input type="button" class="btn btn-success" value="Save Sub-Category" onclick="saveSubCategory()">
                                        </aside>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!--Model Set End--> 
        </div>
    </body>
</html>
