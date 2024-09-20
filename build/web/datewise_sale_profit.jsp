
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
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
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>
<%
                                 int year = Integer.parseInt(request.getParameter("year"));
                                 int month = Integer.parseInt(request.getParameter("month"));
                                 request.setAttribute("yer", year);
                                 Connection con = null;
                                 PreparedStatement ps = null;

                                ResultSet rs1 = null;
                                ResultSet rs2 = null;
                                ResultSet rs3 = null;
                                ResultSet rs4 = null;
                                ResultSet rs = null;
                                ResultSet rs5 = null;
                                ResultSet rs55 = null;
                                ResultSet rs6 = null;
                                ResultSet rs7 = null;
                                ResultSet rs8 = null;
                            try {
                                con = Database.getConnection();
                                    String totalsale = "select sum(COST_PRICE), sum(PRICE) from mobilesell where YEAR(SELL_DATE) = '"+ year +"' AND MONTH(SELL_DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(totalsale);
                                    rs1 = ps.executeQuery();
                                    rs1.next();
                                    request.setAttribute("totalbuy", rs1.getLong(1));
                                    request.setAttribute("totalsale", rs1.getLong(2));
                                     String commi1 = "select sum(AMOUNT) from fac_commission where TYPE='BackMargin' and YEAR = '"+ year +"' AND MONTH = '"+ month +"'";
                                    ps = con.prepareStatement(commi1);
                                    rs2 = ps.executeQuery();
                                    rs2.next();
                                    request.setAttribute("totalcommi1", rs2.getLong(1));
                                    String commi2 = "select sum(AMOUNT) from fac_commission where TYPE='PromoOffer' and YEAR = '"+ year +"' AND MONTH = '"+ month +"'";
                                    ps = con.prepareStatement(commi2);
                                    rs3 = ps.executeQuery();
                                    rs3.next();
                                    request.setAttribute("totalcommi2", rs3.getLong(1));
                                    
                                    String totalcost = "select sum(AMOUNT) from cost where  YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(totalcost);
                                    rs4 = ps.executeQuery();
                                    rs4.next();
                                    request.setAttribute("totalcost", rs4.getLong(1));
                                    String totalemp = "select sum(AMOUNT) from emp_cost where  YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(totalemp);
                                    rs5 = ps.executeQuery();
                                    rs5.next();
                                    request.setAttribute("totalemp", rs5.getLong(1));
                                    String discount = "select sum(DISCOUNT) from mobilesell where  YEAR(SELL_DATE) = '"+ year +"' AND MONTH(SELL_DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(discount);
                                    rs55 = ps.executeQuery();
                                    rs55.next();
                                    request.setAttribute("totaldis", rs55.getLong(1));
                                    
                                    String mont = "select MONTHNAME(DATE) from vendor_stock where YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(mont);
                                    rs6=ps.executeQuery();
                                    rs6.next();
                                    request.setAttribute("mnth", rs6.getString(1));
                                    String totalwithdraw="select sum(AMOUNT) from profit_withdraw where MONTH=? and YEAR=?";
                                    ps = con.prepareStatement(totalwithdraw);
                                    ps.setInt(1, month);
                                    ps.setInt(2, year);
                                    rs7 = ps.executeQuery();
                                    rs7.next();
                                    request.setAttribute("totalwith", rs7.getLong(1));
                                    String saleback = "select sum(PREV_PROFIT-NEW_PROFIT) from sale_return where YEAR(BACK_DATE) = '"+ year +"' AND MONTH(BACK_DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(saleback);
                                    rs8 = ps.executeQuery();
                                    rs8.next();
                                    request.setAttribute("totalsaleback", rs8.getLong(1));       
                                                       
                                
%>
                <div id="div_print" style="font-family: fontawesome">
                    <center>
                        <h3>Sales & Profit Report</h3>
                        <center><h4> ${mnth} ${yer}  </h4></center>
                    </center>

                    <table id="profittable" border="2" width="100%" class="table-striped table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Stock Date</th>
                            <th style="text-align: center">Product</th>
                            <th style="text-align: center">Qty</th>
                            <th style="text-align: center">Purchase Rate</th>
                            <th style="text-align: center">Sale Rate</th>
                            <th style="text-align: center">Unit Profit</th>
                            <th style="text-align: center">Total Profit</th>
                        </tr>
                        </thead>
                        <tbody id="myTable">
                          <%
                                    String query = "select MODEL, COST_PRICE, PRICE, SELL_DATE, count(PRODUCT_ID) as qty from mobilesell where YEAR(SELL_DATE) = '"+ year +"' AND MONTH(SELL_DATE) = '"+ month +"' group by MODEL, PRICE, SELL_DATE";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();   
                                    while (rs.next()) {
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString("SELL_DATE")%></td>
                            <td style="text-align: center"><%= rs.getString("MODEL")%></td>
                            <th style="text-align: center"><%= rs.getInt("qty")%></th>
                            <td style="text-align: center"><%= rs.getFloat("COST_PRICE")%></td>
                            <td style="text-align: center"><%= rs.getFloat("PRICE")%></td>
                            <td style="text-align: center"><%= rs.getFloat("PRICE")-rs.getFloat("COST_PRICE") %></td>
                            <th style="text-align: center"><%= (rs.getFloat("PRICE")-rs.getFloat("COST_PRICE")) * rs.getInt("qty") %></th>
                        </tr>
                        <% 
 
                                                     }
                                                } catch (Exception ex) {
                                                }finally {
try { if (rs8 != null) rs8.close(); rs8=null; } catch (SQLException ex2) { }
try { if (rs7 != null) rs7.close(); rs7=null; } catch (SQLException ex2) { }
try { if (rs6 != null) rs6.close(); rs6=null; } catch (SQLException ex2) { } 
try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
try { if (rs55 != null) rs55.close(); rs55=null; } catch (SQLException ex2) { } 
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }   
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }   
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }   
try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }   
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %> 
                
                        </tbody>
                        <tfoot>
                        <tr style="background-color: #CCCCCC">
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center">TOTAL</th> 
                            <td style="text-align: center"></td> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <td style="text-align: center"></td> 
                        </tr>
                    </tfoot>
                    </table> 
                        <h4 class="text-center text-primary"><b>PROFIT DETAILS</b></h4>
                     <table border="2" width="100%" style="background-color: #030303; color: #ffffff" class="table table-condensed table-responsive">
                            <tr>
                                <th style="text-align: center">PRODUCT'S PROFIT</th> 
                                <td style="text-align: center">${totalsale-totalbuy}</td> 
                                <td style="text-align: center">${((totalsale-totalbuy)*100)/totalbuy} %</td>
                            </tr>
                            <tr>
                                <th style="text-align: center">(+) BACK MARGIN</th> 
                                <td style="text-align: center">${totalcommi1}</td> 
                                <td style="text-align: center"><a href="#">Details(View from Report)</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(+) PROMOTION OFFER</th> 
                                <td style="text-align: center">${totalcommi2}</td> 
                                <td style="text-align: center"><a href="#">Details(View from Report)</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(-) RETURNED SALE</th> 
                                <td style="text-align: center">${totalsaleback}</td> 
                                <td style="text-align: center"><a href="returned_sale.jsp">Details</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(-) OFFICE COST</th> 
                                <td style="text-align: center">${totalcost}</td> 
                                <td style="text-align: center"><a href="expense_ledger.jsp">Details</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(-) EMPLOYEE COST</th> 
                                <td style="text-align: center">${totalemp}</td> 
                                <td style="text-align: center"><a href="expenseinfo.jsp">Details</a></td> 
                            </tr>
                             <tr>
                                <th style="text-align: center">(-) DISCOUNT</th> 
                                <td style="text-align: center">${totaldis}</td> 
                                <td style="text-align: center"><a href="symmonthly_mobile_sell.jsp">Details</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">NIT PROFIT</th> 
                                <td style="text-align: center">${((totalsale-totalbuy)+totalcommi1+totalcommi2)-(totalcost+totalemp+totaldis)}</td> 
                                <td style="text-align: center"></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">PROFIT WITHDRAW</th> 
                                <td style="text-align: center">${totalwith}</td> 
                                <td style="text-align: center"><a href="profit_withdraw.jsp">Details</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">PROFIT BALANCE</th> 
                                <td style="text-align: center">${((totalsale-totalbuy)+totalcommi1+totalcommi2)-(totalcost+totalemp+totalwith+totalsaleback+totaldis)}</td> 
                                <td style="text-align: center"></td> 
                            </tr>
                        </table>
                </div>

            </div>
            <br><br>
            <%@include file = "footerpage.jsp" %>

            <script src="js/jquery-3.1.1.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
                        
            <script language="javascript">
                var addSerialNumber = function () {
                    var i = 0;
                    $('#profittable tr').each(function (index) {
                        $(this).find('td:nth-child(1)').html(index - 1 + 1);
                    });
                };

                addSerialNumber();
            </script>
             <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('#profittable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#profittable tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#profittable tfoot td').eq(index).text(total);
        } 
  });
});
</script>
     <script>
        $(document).ready(function() {
            $('#profittable thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('#profittable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#profittable tfoot td').eq(index).text(total);
        }
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
<% } %>
        </body>
    </html>
