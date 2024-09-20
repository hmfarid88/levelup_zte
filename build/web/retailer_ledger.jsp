
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.Database"%>
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.Accountant"%>
<%@page import="Model.StockModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AccountPojo"%>
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
        <link rel="icon" type="image/png" href="img/favicon.ico">
    </head>
    <body id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
    <div class="container-fluid">
        <header>
            <nav style="margin: 0 auto" class="navbar navbar-inverse">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li><a href="accountant.jsp"><span class="fa fa-home"> Home</span></a></li>
                        <li><a href="#" data-toggle="modal" data-target="#payinfo" >Payment Update</a></li>
                        
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                      <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>  
                      <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                    </ul> 
                </div>
            </nav>
        </header>
        <div class="row">
            <div class="col-sm-12">
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#all">ALL</a></li>
                    <li><a data-toggle="tab" href="#grt">GRT</a></li>
                    <li><a data-toggle="tab" href="#mipp">MIPP</a></li>
                    <li><a data-toggle="tab" href="#own">OWN</a></li>
                </ul>
                <div class="tab-content"><br>
                   
                     <div id="all" class="tab-pane fade in active">
                         <div class="row">
                        <div class="col-sm-3">
                            <a  href="#" name="b_print"  onClick="printdiv('div_print1')"><span class="glyphicon glyphicon-print"></span> Print</a>
                        </div>
                        <div class="col-sm-6"></div>
                        <div class="col-sm-3">

                        </div>
                        </div>
                        <div id="div_print1" style="font-family: fontawesome">
            <center>
                <h3>All Retailer</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>
 <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                            <table id="all"  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">DMSID</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Total Price</th>
                        <th style="text-align: center">As One Today</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AccountPojo ap=new AccountPojo();
                        List<StockModel> list = ap.RetailerLedger();
                        for (StockModel sml : list) {
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= sml.getRetiler()%></td>
                        <td style="text-align: center"><%= sml.getDms()%></td>
                        <th style="text-align: center"><%= sml.getDelivery()%></th>
                        <th style="text-align: center"><%= sml.getTotalprice()%></th>
                        <th style="text-align: center"><%= sml.getCurpay()%></th>
                        <th style="text-align: center"><%= sml.getTotalpay()%></th>
                        <th style="text-align: center"><%= sml.getRetailerbalance()%></th>
                        
                        <td style="text-align: center">
                            <form method="POST" action="dtails_retLedger.jsp">
                                <input type="hidden" name="retailer" value="<%= sml.getRetiler()%>">
                                <input type="submit" value="Details">
                            </form>
                        </td>
                    </tr>
                    
                    <% } %>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                     </tr> 
                </tfoot>
            </table>
 </div>
        </div>
    </div> 
                    
                     <div id="grt" class="tab-pane fade in">
                         <div class="row">
                        <div class="col-sm-3">
                            <a  href="#" name="b_print"  onClick="printdiv('div_print2')"><span class="glyphicon glyphicon-print"></span> Print</a>
                        </div>
                        <div class="col-sm-6"></div>
                        <div class="col-sm-3">

                        </div>
                    </div>
                        <div id="div_print2" style="font-family: fontawesome">
            <center>
                <h3>GRT Retailer</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>
                             <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                            <table id="grt"  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">DMSID</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Total Price</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null;       
        try {
            con = Database.getConnection();
            String queryretiler="select distinct R_NAME, DMSID from retailer_info where GRADE='GRT' order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
            String retailer=rs.getString(1);
            
            String query = "select count(PRODUCT_ID) as qty, sum(PRICE) as totalprice, sum(DISCOUNT) as dis from mobilesell where  RETAILER=? and YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            rs1 = ps.executeQuery(); 
            while(rs1.next()){
            String payment="select sum(AMOUNT) as totalpay from customer_pay where RETAILER=?";
            ps = con.prepareStatement(payment);
            ps.setString(1, retailer);
            rs2 = ps.executeQuery(); 
            while(rs2.next()){
            String monthpay="select sum(AMOUNT) from customer_pay where RETAILER=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(monthpay);
            ps.setString(1, retailer);
            rs3 = ps.executeQuery(); 
            while(rs3.next()){
                 String totalpricevalu = "select sum(PRICE), sum(DISCOUNT) from mobilesell where RETAILER=?";
                 ps = con.prepareStatement(totalpricevalu);
                 ps.setString(1, retailer);
                 rs4 = ps.executeQuery();
            while(rs4.next()){
            
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= rs.getString(1) %></td>
                        <td style="text-align: center"><%= rs.getString(2) %></td>
                        <th style="text-align: center"><%= rs1.getLong("qty") %></th>
                        <th style="text-align: center"><%= rs1.getLong("totalprice")-rs1.getLong("dis") %></th>
                        <th style="text-align: center"><%= rs3.getLong(1) %></th>
                        <th style="text-align: center"><%= rs4.getLong(1)-(rs2.getLong("totalpay")+rs4.getLong(2)) %></th>
                        
                        <td style="text-align: center">
                            <form method="POST" action="dtails_retLedger.jsp">
                                <input type="hidden" name="retailer" value="<%= rs.getString(1) %>">
                                <input type="submit" value="Details">
                            </form>
                        </td>
                    </tr>
                    
                    <% 
} } } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                    %>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                     </tr> 
                </tfoot>
            </table>  
                             </div>
                    </div>
                     </div>
                    <div id="mipp" class="tab-pane fade in">
                        <div class="row">
                        <div class="col-sm-3">
                            <a  href="#" name="b_print"  onClick="printdiv('div_print3')"><span class="glyphicon glyphicon-print"></span> Print</a>
                        </div>
                        <div class="col-sm-6"></div>
                        <div class="col-sm-3">

                        </div>
                    </div>
                        <div id="div_print3" style="font-family: fontawesome">
            <center>
                <h3>MIPP Retailer</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>
                             <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                            <table id="mipp"  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">DMSID</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Total Price</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
        
        try {
            con = Database.getConnection();
            String queryretiler="select distinct R_NAME, DMSID from retailer_info where GRADE='MIPP' order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
            String retailer=rs.getString(1);
            
            String query = "select count(PRODUCT_ID) as qty, sum(PRICE) as totalprice, sum(DISCOUNT) as dis from mobilesell where  RETAILER=? and YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            rs1 = ps.executeQuery(); 
            while(rs1.next()){
            String payment="select sum(AMOUNT) as totalpay from customer_pay where RETAILER=?";
            ps = con.prepareStatement(payment);
            ps.setString(1, retailer);
            rs2 = ps.executeQuery(); 
            while(rs2.next()){
            String monthpay="select sum(AMOUNT) from customer_pay where RETAILER=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(monthpay);
            ps.setString(1, retailer);
            rs3 = ps.executeQuery(); 
            while(rs3.next()){
                 String totalpricevalu = "select sum(PRICE), sum(DISCOUNT) from mobilesell where RETAILER=?";
                 ps = con.prepareStatement(totalpricevalu);
                 ps.setString(1, retailer);
                 rs4 = ps.executeQuery();
            while(rs4.next()){
            
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= rs.getString(1) %></td>
                        <td style="text-align: center"><%= rs.getString(2) %></td>
                        <th style="text-align: center"><%= rs1.getLong("qty") %></th>
                        <th style="text-align: center"><%= rs1.getLong("totalprice")-rs1.getLong("dis") %></th>
                        <th style="text-align: center"><%= rs3.getLong(1) %></th>
                        <th style="text-align: center"><%= rs4.getLong(1)-(rs2.getLong("totalpay")+rs4.getLong(2)) %></th>
                        
                        <td style="text-align: center">
                            <form method="POST" action="dtails_retLedger.jsp">
                                <input type="hidden" name="retailer" value="<%= rs.getString(1) %>">
                                <input type="submit" value="Details">
                            </form>
                        </td>
                    </tr>
                    
                    <% 
} } } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                    %>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                     </tr> 
                </tfoot>
            </table>   
                             </div>
                    </div>
                     </div>
                    <div id="own" class="tab-pane fade in">
                        <div class="row">
                        <div class="col-sm-3">
                            <a  href="#" name="b_print"  onClick="printdiv('div_print4')"><span class="glyphicon glyphicon-print"></span> Print</a>
                        </div>
                        <div class="col-sm-6"></div>
                        <div class="col-sm-3">

                        </div>
                    </div>
                        <div id="div_print4" style="font-family: fontawesome">
            <center>
                <h3>Own Retailer</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>
                             <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                            <table id="own"  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">DMSID</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Total Price</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
        
        try {
            con = Database.getConnection();
            String queryretiler="select distinct R_NAME, DMSID from retailer_info where GRADE='Own House' order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
            String retailer=rs.getString(1);
            
            String query = "select count(PRODUCT_ID) as qty, sum(PRICE) as totalprice, sum(DISCOUNT) as dis from mobilesell where  RETAILER=? and YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            rs1 = ps.executeQuery(); 
            while(rs1.next()){
            String payment="select sum(AMOUNT) as totalpay from customer_pay where RETAILER=?";
            ps = con.prepareStatement(payment);
            ps.setString(1, retailer);
            rs2 = ps.executeQuery(); 
            while(rs2.next()){
            String monthpay="select sum(AMOUNT) from customer_pay where RETAILER=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(monthpay);
            ps.setString(1, retailer);
            rs3 = ps.executeQuery(); 
            while(rs3.next()){
                 String totalpricevalu = "select sum(PRICE), sum(DISCOUNT) from mobilesell where RETAILER=?";
                 ps = con.prepareStatement(totalpricevalu);
                 ps.setString(1, retailer);
                 rs4 = ps.executeQuery();
            while(rs4.next()){
            
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= rs.getString(1) %></td>
                        <td style="text-align: center"><%= rs.getString(2) %></td>
                        <th style="text-align: center"><%= rs1.getLong("qty") %></th>
                        <th style="text-align: center"><%= rs1.getLong("totalprice")-rs1.getLong("dis") %></th>
                        <th style="text-align: center"><%= rs3.getLong(1) %></th>
                        <th style="text-align: center"><%= rs4.getLong(1)-(rs2.getLong("totalpay")+rs4.getLong(2)) %></th>
                        
                        <td style="text-align: center">
                            <form method="POST" action="dtails_retLedger.jsp">
                                <input type="hidden" name="retailer" value="<%= rs.getString(1) %>">
                                <input type="submit" value="Details">
                            </form>
                        </td>
                    </tr>
                    
                    <% 
} } } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                    %>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                     </tr> 
                </tfoot>
            </table>  
                             </div>
                    </div>
                     </div>
                     </div>
                 </div>
            </div>
        </div>
        
    <div id="payinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Payment Info Update</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="RtpayUpdateServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Payment Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" name="rtpsi" required="">
                                            <option value="">Select Payment</option>
                                            <%
                                                DeletePojo dp = new DeletePojo();
                                                List<DeleteModel> list2 = dp.RetlerPayUp();
                                                for (DeleteModel dm : list2) {
                                            %>
                                            <option value="<%= dm.getRtpaysi()%>"><%= dm.getRetailer()%>, <%= dm.getRtpayname()%>(<%= dm.getRtpayamount()%>)</option>
                                            <% } %>
                                        </select>
                                    </div>
                                    
                                    <div class="col-sm-6">
                                        <label>Set Amount</label>
                                        <input type="number" style=" width: 90%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="GO">
                            </form>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <br><br>
    <%@include file = "footerpage.jsp" %>

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
    <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('#all tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
    </script>
    <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('#grt tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
    </script>
    <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('#mipp tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
    </script>
    <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('#own tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
    </script>
    <script>
        $(document).ready(function() {
            $('#all thead th').each(function(i) {
                calculateColumn(i);
            });
        

        function calculateColumn(index) {
            var total = 0;
            $('#all tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#all tfoot td').eq(index).text(total);
        }
        });
    </script>
    <script>
        $(document).ready(function() {
            $('#grt thead th').each(function(i) {
                calculateColumn(i);
            });
        

        function calculateColumn(index) {
            var total = 0;
            $('#grt tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#grt tfoot td').eq(index).text(total);
        }});
    </script>
    <script>
        $(document).ready(function() {
            $('#mipp thead th').each(function(i) {
                calculateColumn(i);
            });
        

        function calculateColumn(index) {
            var total = 0;
            $('#mipp tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mipp tfoot td').eq(index).text(total);
        }});
    </script>
    <script>
        $(document).ready(function() {
            $('#own thead th').each(function(i) {
                calculateColumn(i);
            });
        

        function calculateColumn(index) {
            var total = 0;
            $('#own tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#own tfoot td').eq(index).text(total);
        }});
    </script>
    <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#all tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
});
        </script>
         <script language="javascript">
    	$('#pdf').click(function () {
    var HTML_Width = $("#div_print1").width();
 var HTML_Height = $("#div_print1").height();
 var top_left_margin = 15;
 var PDF_Width = HTML_Width+(top_left_margin*2);
 var PDF_Height = (PDF_Width*1.5)+(top_left_margin*2);
 var canvas_image_width = HTML_Width;
 var canvas_image_height = HTML_Height;
 
 var totalPDFPages = Math.ceil(HTML_Height/PDF_Height)-1;
 
 
 html2canvas($("#div_print1")[0],{allowTaint:true}).then(function(canvas) {
 canvas.getContext('2d');
 
 console.log(canvas.height+"  "+canvas.width);
 
 
 var imgData = canvas.toDataURL("image/jpeg", 1.0);
 var pdf = new jsPDF('p', 'pt',  [PDF_Width, PDF_Height]);
     pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin,canvas_image_width,canvas_image_height);
 
 
 for (var i = 1; i <= totalPDFPages; i++) { 
 pdf.addPage(PDF_Width, PDF_Height);
 pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height*i)+(top_left_margin*4),canvas_image_width,canvas_image_height);
 }
 
     pdf.save("RetailerLedger.pdf");
        });
});
</script>
    
    <script language="javascript">
        function printdiv(printpage)
        {
            var headstr = "<html><head><title></title></head><body>";
            var footstr = "</body>";
            var newstr = document.all.item(printpage).innerHTML;
            var oldstr = document.body.innerHTML;
            document.body.innerHTML = headstr + newstr + footstr;
            window.print();
            document.body.innerHTML = oldstr;
            return false;
        }
    </script>
    <% }%>
</body>
</html>
