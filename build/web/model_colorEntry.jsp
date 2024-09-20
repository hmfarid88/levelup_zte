
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Level-Up</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <script src="js/jquery-3.1.1.min.js"></script>
        <link rel="icon" type="image/png" href="img/favicon.ico">
         <style>
            fieldset.scheduler-border {
    border: 1px groove green ;
    padding: 0 1.4em 1.4em 1.4em ;
    margin: 0 0 1.5em 0;
    -webkit-box-shadow:  0px 0px 0px 0px #000;
    box-shadow:  0px 0px 0px 0px #000;
}

legend.scheduler-border {
    width:inherit; 
    padding:0 10px; /* To give a bit of padding on the left and right */
    border-bottom:none;
}
        </style>
    </head>
    <body>
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>

    <div class="container">
        <div class="panel panel-primary">
            <nav style="margin: 0 auto" class="navbar navbar-inverse">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>

                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul style="margin: 15px 20px" class="nav navbar-nav">
                      <li><a data-toggle="collapse" data-target="#demo" href="#"><span class="fa fa-trash"></span> Model-Delete</a> </li>
                        <li>
                            <div style="margin: 10px 0" id="demo" class="collapse" >
                                <form method="POST" action="ModelDeleteServlet" class="form-inline"> 
                                    <input type="text" size="10px" name="model" class="form-control"  placeholder="Model Name " value="" required="" >
                                    <input type="submit" id="ok" class="btn btn-primary btn-sm" value="OK">
                                </form>  
                            </div>
                        </li>  
                        <li><a data-toggle="collapse" data-target="#demo2" href="#"><span class="fa fa-trash"></span> Color-Delete</a> </li>
                        <li>
                            <div style="margin: 10px 0" id="demo2" class="collapse" >
                                <form method="POST" action="ColorDeleteServlet" class="form-inline"> 
                                    <input type="text" size="10px" name="color" class="form-control"  placeholder="Color Name " value="" required="" >
                                    <input type="submit" id="ok" class="btn btn-primary btn-sm" value="OK">
                                </form>  
                            </div>
                        </li>
                        <li><a data-toggle="modal" data-target="#modelrename" href="#"><span class="fa fa-edit"></span> Model Rename</a> </li>
                      
                    </ul>
                    <ul style="margin: 15px 20px" class="nav navbar-nav navbar-right">
                        <li> <a href="stockentry.jsp"><span class="fa fa-backward"> Back</span></a></li>
                    </ul>
                </div>
            </nav>
            <div class="panel-body"> 
                <div class="row">
                    <div class="col-sm-1"></div>
                    <div class="col-sm-5">
                        <fieldset class="scheduler-border">
                            <legend class="scheduler-border">Add Model Name</legend>

                            <form method="POST" action="Model_entryProcess.jsp">
                                <center>
                                    <label>Model Name :</label>
                                    <input style=" width: 60%" type="text" class="form-control" value="" name="model" id="model" required="" ><br>
                                    <label>Purchase's Price :</label>
                                    <input style=" width: 60%" type="text" autocomplete="off" class="form-control" value="" name="costprice" id="costprice" required="" ><br>
                                    <label>Grade A Sale Price(GRT) :</label>
                                    <input style=" width: 60%" autocomplete="off" type="text" class="form-control"  value="" name="asaleprice" id="saleprice" required=""><br>
                                    <label>Grade B Sale Price(MIPP) :</label>
                                    <input style=" width: 60%" autocomplete="off" type="text" class="form-control"  value="" name="bsaleprice" id="saleprice" required=""><br><br>
                                    <input type="submit" id="modeladd" class="btn btn-success btn-sm" value="Add">
                                </center>
                            </form>
                        </fieldset>
                    </div>
                    <div class="col-sm-5">
                        <fieldset class="scheduler-border">
                            <legend class="scheduler-border">Update Price</legend>
                            <form method="POST" action="Model_rate_update.jsp">
                                <center>
                                    <label>Select Model :</label>
                                    <select style="width: 60%" class="form-control"   name="mdl" id="mdl"  required="" >
                                        <option value=""></option>

                                        <%
                                           Connection con = null;
                                            PreparedStatement ps = null;
                                            ResultSet rs=null;
                                            try {
                                                con = Database.getConnection();
                                                String query = "select MODEL from model_price ";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <option value="<%= rs.getString("MODEL") %>"> <%= rs.getString("MODEL") %></option>
                                        <%
                                                   }
                                               } catch (Exception ex) {
                                               }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
                                    </select><br>
                                    <label>Purchase's Price :</label>
                                    <input style=" width: 60%" type="text" autocomplete="off" class="form-control" value="" name="costprice" id="upcost" required=""><br>
                                    <label>Grade A Sale Price(GRT) :</label>
                                    <input style=" width: 60%" type="text" autocomplete="off" class="form-control"  value="" name="asaleprice" id="upsale" required=""><br>
                                    <label>Grade B Sale Price(MIPP) :</label>
                                    <input style=" width: 60%" type="text" autocomplete="off" class="form-control"  value="" name="bsaleprice" id="saleprice" required=""><br><br>
                                    <input type="submit" id="rateup" class="btn btn-success btn-sm" value="Update">
                                </center>
                            </form>

                        </fieldset> 
                    </div>
                    <div class="col-sm-1"></div>
                </div><br>
                <div class="row">
                    
                    <div class="col-sm-12">
                        <fieldset class="scheduler-border">
                            <legend class="scheduler-border">Add Items Name</legend>
                            <div class="col-sm-2">
                                <form method="POST" action="color_entryProcess.jsp">
                                    <label>Color Name :</label>
                                    <input type="text" value="" class="form-control" name="color" id="color" required=""><br><br>
                                    <input type="submit" id="coloradd" class="btn btn-success btn-sm" value="Add">
                                </form>
                            </div> 
                            <div class="col-sm-2">
                                <form method="POST" action="area_entryProcess.jsp">
                                    <label>Area Name :</label>
                                    <input type="text" value="" class="form-control" name="area" id="color" required=""><br><br>
                                    <input type="submit" id="coloradd" class="btn btn-success btn-sm" value="Add">
                                </form>
                            </div> 
                            <div class="col-sm-2">
                                <form method="POST" action="store_entryProcess.jsp">
                                    <label>Store Name :</label>
                                    <input type="text" value="" class="form-control" name="store" id="color" required=""><br><br>
                                    <input type="submit" id="coloradd" class="btn btn-success btn-sm" value="Add">
                                </form>
                            </div> 
                            <div class="col-sm-2">
                                <form method="POST" action="boss_entryProcess.jsp">
                                    <label>Boss Name :</label>
                                    <input type="text" value="" class="form-control" name="boss" id="color" required=""><br><br>
                                    <input type="submit" id="coloradd" class="btn btn-success btn-sm" value="Add">
                                </form>
                            </div> 
                            <div class="col-sm-2">
                                <form method="POST" action="vendor_entryProcess.jsp">
                                    <label>Vendor Name :</label><br>
                                    <input type="text" value="" class="form-control" name="vendor" id="vendor" required=""><br><br>
                                    <input type="submit" id="vendoradd" class="btn btn-success btn-sm" value="Add">
                                </form>
                            </div>
                        </fieldset>
                    </div>

                    
                </div>
            </div>
        </div>
        <%@include file = "footerpage.jsp" %> 
    </div>
    <div id="modelrename" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Model Rename</legend>
                        <div class="container-fluid">
                            <form method="POST" action="ModelRenameServlet" class="form-inline"> 
                                <div class="row">
                                <div class="col-sm-5">
                                   <select style="width: 90%" class="form-control"   name="model" id="mdl"  required="" >
                                        <option value="">Select Model</option>

                                        <%
                                            
                                            try {
                                                con = Database.getConnection();
                                                String query = "select MODEL from model_price ";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <option value="<%= rs.getString("MODEL") %>"> <%= rs.getString("MODEL") %></option>
                                        <%
                                                   }
                                               } catch (Exception ex) {
                                               }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
                                    </select>
                                    </div>
                                    <div class="col-sm-5">
                                          <input type="text" style="width: 90%" name="newmodel" class="form-control" placeholder="New Model Name"  value="" required="">
                                    </div>
                                    <div class="col-sm-2">
                                         <input type="submit" id="ok" class="btn btn-primary btn-sm" value="OK">
                                    </div>
                                </div>
                                   
                                </form>  
                        </div>
                        
                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <script src="js/bootstrap.min.js"></script>
   
    <script>
        history.pushState(null, document.title, location.href);
        window.addEventListener('popstate', function (event)
        {
            history.pushState(null, document.title, location.href);
        });
    </script>
    
    <% }%>
</body>
</html>
