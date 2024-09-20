
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
            <%
                String date1 = request.getParameter("date1");
                String date2 = request.getParameter("date2");
                request.setAttribute("date1", date1);
                request.setAttribute("date2", date2);
                String bank = request.getParameter("bank");
                request.setAttribute("bank", bank);
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                ResultSet rs1 = null;
                ResultSet rs2 = null;
                ResultSet rs3 = null;
                
                try {
                    con = Database.getConnection();
                    String query = "select AMOUNT, BRANCH, PAYER, BALANCE, DATE from bank_transition where TYPE='Deposit' and BANK=? and DATE between '" + date1 + "' and '" + date2 + "' order by DATE";
                    ps = con.prepareStatement(query);
                    ps.setString(1, bank);
                   
                    rs = ps.executeQuery();
                    String query1 = "select AMOUNT, BRANCH, PAYER, BALANCE, DATE from bank_transition where TYPE='Withdraw' and BANK=? and DATE between '" + date1 + "' and '" + date2 + "' order by DATE";
                       
                    ps = con.prepareStatement(query1);
                    ps.setString(1, bank);
                    
                    rs1 = ps.executeQuery();
                    String query2 = "select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK=? and DATE between '" + date1 + "' and '" + date2 + "'";
                    ps = con.prepareStatement(query2);
                    ps.setString(1, bank);
                    rs2 = ps.executeQuery();
                    rs2.next();
                    request.setAttribute("totaldeposit", rs2.getLong(1));
                    String query3 = "select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK=? and DATE between '" + date1 + "' and '" + date2 + "'";
                    ps = con.prepareStatement(query3);
                    ps.setString(1, bank);
                    rs3 = ps.executeQuery();
                    rs3.next();
                    request.setAttribute("totalwithdraw", rs3.getLong(1));
                    
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

                <div id="div_print" style="font-family: fontawesome">
                    <center>
                        <h3>Bank Ledger</h3>
                        <h3>Bank Name : ${bank}</h3>
                        <h5><b>Date : ${date1} TO ${date2} </b></h5>
                    </center>

                    <table  border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Date</th>
                                <th style="text-align: center">Branch</th>
                                <th style="text-align: center">Payer/Withdrawer</th>
                                <th style="text-align: center">Deposit</th>
                                <th style="text-align: center">Withdraw</th>
                                <th style="text-align: center">Balance</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%       
                               while (rs.next()) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString(5)%></td>
                                <td style="text-align: center"><%= rs.getString(2)%></td>
                                <td style="text-align: center"><%= rs.getString(3)%></td>
                                <td style="text-align: center"><%= rs.getFloat(1)%></td>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getDouble(4)%></td>
                            </tr>
                            <% }
                                while (rs1.next()) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs1.getString(5)%></td>
                                <td style="text-align: center"><%= rs1.getString(2)%></td>
                                <td style="text-align: center"><%= rs1.getString(3)%></td>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs1.getFloat(1)%></td>
                                <td style="text-align: center"><%= rs1.getDouble(4)%></td>
                            </tr>
                           
                            <%  }
                                } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {

try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }  
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }          
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }        
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                         }
                                %>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center">${totaldeposit}</th>
                                <th style="text-align: center">${totalwithdraw}</th>
                                <th style="text-align: center"></th>
                            </tr>
                           
                        </tbody>
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
                    $('table tr').each(function (index) {
                        $(this).find('td:nth-child(1)').html(index - 1 + 1);
                    });
                };

                addSerialNumber();
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
