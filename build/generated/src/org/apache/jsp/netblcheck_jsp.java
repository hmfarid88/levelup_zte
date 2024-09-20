package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.SQLException;
import DB.Database;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;

public final class netblcheck_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(1);
    _jspx_dependants.add("/footerpage.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"utf-8\">\n");
      out.write("        <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n");
      out.write("        <title>Level-Up</title>\n");
      out.write("        <meta name=\"description\" content=\"\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/font-awesome.min.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/style.css\">\n");
      out.write("        <link rel=\"icon\" type=\"image/png\" href=\"img/favicon.ico\">\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            if ((session.getAttribute("admin") == null) || (session.getAttribute("admin") == "")) {
        
      out.write("\n");
      out.write("    <br> <center><h3> You are not logged in</h3><br/>\n");
      out.write("        <a href=\"index.jsp\"><button class=\"btn btn-success\">Please Login</button></a></center>\n");
      out.write("        ");
} else {
        
      out.write("\n");
      out.write("      ");

                                    Connection con = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs0=null;
                                    ResultSet rs=null;
                                    ResultSet rs1=null;
                                    ResultSet rs2=null;
                                    ResultSet rs3=null;
                                    ResultSet rs4=null;
                                    ResultSet rs5=null;
                                    ResultSet rs6=null;
                                    ResultSet rs7=null;
                                    ResultSet rs8=null;
                                    ResultSet rs9=null;
                                    try {
                                    con = Database.getConnection();
                                    String date="select distinct DATE from netbalance";
                                    ps=con.prepareStatement(date);
                                    rs0 = ps.executeQuery();
                                    while(rs0.next()){
                                     String date1=rs0.getString("DATE");
                                    
                                    String query = "select sum(AMOUNT) from cash_debit where DATE=? ";
                                    ps=con.prepareStatement(query);
                                    ps.setString(1, date1);
                                    rs = ps.executeQuery();
                                    while(rs.next()){
//                                    Long cashdebit=rs.getLong(1);
                                    
                                    String query1 = "select sum(AMOUNT) from customer_pay where DATE=?";
                                    ps=con.prepareStatement(query1);
                                    ps.setString(1, date1);
                                    rs1 = ps.executeQuery();
                                    while(rs1.next()){
//                                     Long retpay=rs1.getLong(1);
                                     
                                        String query2 = "select sum(RECEIVE) from proprietor_cost where DATE=?";
                                    ps=con.prepareStatement(query2);
                                    ps.setString(1, date1);
                                    rs2 = ps.executeQuery();
                                    while(rs2.next()){
//                                    Long prorecv=rs2.getLong(1); 
                                    
                                        String query3 = "select sum(AMOUNT) from cash_credit where DATE=?";
                                    ps=con.prepareStatement(query3);
                                    ps.setString(1, date1);
                                    rs3 = ps.executeQuery();
                                    while(rs3.next()){
//                                    Long cashcredit=rs3.getLong(1); 
                                    
                                        String query4 = "select sum(AMOUNT) from company_payment where DATE=?";
                                    ps=con.prepareStatement(query4);
                                    ps.setString(1, date1);
                                    rs4 = ps.executeQuery();
                                    while(rs4.next()){
//                                        Long compay=rs4.getLong(1);
                                        
                                        String query5 = "select sum(AMOUNT) from cost where DATE=?";
                                     ps = con.prepareStatement(query5);
                                     rs5 = ps.executeQuery();
                                     while(rs5.next()){
//                                     Long cost=rs5.getLong(1);
                                    
                                    String query6 = "select sum(AMOUNT) from emp_cost where DATE=? ";
                                    ps = con.prepareStatement(query6);
                                    rs6 = ps.executeQuery();
                                    while(rs6.next()){
//                                    Long empcost=rs6.getLong(1);

                                    String query7 = "select sum(PAYMENT) from proprietor_cost where DATE=? ";
                                    ps = con.prepareStatement(query7);
                                    rs7 = ps.executeQuery();
                                    while(rs7.next()){
//                                    Long propay=rs7.getLong(1);

                                    String query8 = "select sum(AMOUNT) from customer_pay where PAY_TYPE='Bank' and DATE=?";
                                    ps = con.prepareStatement(query8);
                                    rs8 = ps.executeQuery();
                                    while(rs8.next()){
//                                    Long retbankpay=rs8.getLong(1);
                                                                             
                                        String query9 = "select AMOUNT from netbalance where DATE<'" + date1 + "' order by SI_NO DESC LIMIT 1 ";
                                        ps=con.prepareStatement(query9);
                                        rs9 = ps.executeQuery();
                                        while(rs9.next()){
//                                        Long openbalance=rs9.getLong(1);    
            Long totaldebit=rs9.getLong(1)+rs.getLong(1)+rs1.getLong(1)+rs2.getLong(1);
            Long totalcredit=rs3.getLong(1)+rs4.getLong(1)+rs5.getLong(1)+rs6.getLong(1)+rs7.getLong(1)+rs8.getLong(1);
            Long netbalance=totaldebit-totalcredit; 
            
            String balanceup="update netbalance set CH_BL='1' where DATE='2023-07-05'";
                ps=con.prepareStatement(balanceup);
//                ps.setDouble(1, netbalance);
//                ps.setString(2, date1);
                ps.executeUpdate();
                                        }}}} }}}}}}} } catch (Exception ex) {
                                }finally {
   try { if (rs9 != null) rs9.close(); rs9=null; } catch (SQLException ex2) { }
   try { if (rs8 != null) rs8.close(); rs8=null; } catch (SQLException ex2) { }
   try { if (rs7 != null) rs7.close(); rs7=null; } catch (SQLException ex2) { }
   try { if (rs6 != null) rs6.close(); rs6=null; } catch (SQLException ex2) { }
   try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
   try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
   try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                        } 
      
      out.write("\n");
      out.write("    <div class=\" container-fluid\">\n");
      out.write("                    <nav style=\"margin: 0 auto\" class=\"navbar navbar-inverse\">\n");
      out.write("                        <div class=\"navbar-header\">\n");
      out.write("                            <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\"#myNavbar\"> \n");
      out.write("                                <span class=\"icon-bar\"></span>\n");
      out.write("                                <span class=\"icon-bar\"></span>\n");
      out.write("                                <span class=\"icon-bar\"></span>\n");
      out.write("                            </button>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"collapse navbar-collapse\" id=\"myNavbar\">\n");
      out.write("                            <ul class=\"nav navbar-nav\">\n");
      out.write("                             <li style=\"margin-left: 20px\"> <a href=\"admin_portal.jsp\"><span class=\"fa fa-home\"></span> Home</a></li>\n");
      out.write("                            </ul>\n");
      out.write("                            <ul class=\"nav navbar-nav navbar-right\">\n");
      out.write("                                <li> <a href=\"#\" name=\"b_print\"  onClick=\"printdiv('div_print')\" ><span class=\"glyphicon glyphicon-print\"></span> Print</a></li>\n");
      out.write("                            </ul>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                    </nav>\n");
      out.write("      \n");

try {
                                                        con = Database.getConnection();
                                                        String query = "select COMPANY_NAME from companyinfo";
                                                        ps=con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                             request.setAttribute("company", rs.getString("COMPANY_NAME"));
                                                    } catch (Exception ex) {
                                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                       

      out.write("\n");
      out.write("                        <div class=\"row\">\n");
      out.write("                            <div class=\"col-sm-12\">\n");
      out.write("                                <div id=\"div_print\">\n");
      out.write("                                    <center>\n");
      out.write("                                        <h3>Net Balance Compare Sheet</h3>\n");
      out.write("                                        <h4>Shop Name : ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${company}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write(" </h4>\n");
      out.write("                                        <h4> Reporting Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>\n");
      out.write("                                        <hr>\n");
      out.write("                                        <table border=\"2\" class=\" table-striped table-responsive\" width=\"70%\" id=\"mobiletable\" >\n");
      out.write("                                            <thead>\n");
      out.write("                                                <tr>\n");
      out.write("                                                    <th style=\"text-align: center\">SN</th>\n");
      out.write("                                                    <th style=\"text-align: center\">Date</th>\n");
      out.write("                                                    <th style=\"text-align: center\">Net Balance</th>\n");
      out.write("                                                    <th style=\"text-align: center\">Checked Balance</th>\n");
      out.write("                                                    <th style=\"text-align: center\">Difference</th>\n");
      out.write("                                                 </tr>\n");
      out.write("                                            </thead> \n");
      out.write("                                            <tbody>\n");
      out.write("                                                ");

                                                  
                                                    try {
                                                        con = Database.getConnection();
                                                        String query = "select AMOUNT, CH_BL, DATE from netbalance where AMOUNT<>CH_BL";
                                                        ps=con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                
      out.write("\n");
      out.write("                                                <tr>\n");
      out.write("                                                    <td style=\"text-align: center\"></td>\n");
      out.write("                                                    <td style=\"text-align: center\">");
      out.print( rs.getString("DATE"));
      out.write("</td>\n");
      out.write("                                                    <td style=\"text-align: center\">");
      out.print( rs.getFloat("AMOUNT"));
      out.write("</td>\n");
      out.write("                                                    <td style=\"text-align: center\">");
      out.print( rs.getFloat("CH_BL"));
      out.write("</td>\n");
      out.write("                                                    <th style=\"text-align: center\">");
      out.print( rs.getFloat("CH_BL")-rs.getFloat("AMOUNT"));
      out.write("</th>\n");
      out.write("                                                </tr>\n");
      out.write("\n");
      out.write("                                                ");

                                                        }
                                                    } catch (Exception ex) {
                                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                
      out.write("\n");
      out.write("                                            </tbody>\n");
      out.write("                                            <tfoot>\n");
      out.write("                                                <tr>\n");
      out.write("                                                    <th style=\"text-align: center\"></th>\n");
      out.write("                                                    <th style=\"text-align: center\"></th>\n");
      out.write("                                                    <th style=\"text-align: center\"></th>\n");
      out.write("                                                    <th style=\"text-align: center\">TOTAL</th>\n");
      out.write("                                                    <td style=\"text-align: center\"></td>\n");
      out.write("                                                </tr>\n");
      out.write("                                            </tfoot>\n");
      out.write("                                            \n");
      out.write("\n");
      out.write("                                        </table>\n");
      out.write("                                        \n");
      out.write("                                    </center>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("    </div>\n");
      out.write("    ");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("       <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n");
      out.write(" \n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <footer class=\"text-center\">\n");
      out.write("\n");
      out.write("            <p>All Right Reserved &copy;2020</p> \n");
      out.write("            <p>Powered by <a href=\"http//www.jcodeslab.com/\">JCodesLab</a> 01676-182277, 01924-485686</p>\n");
      out.write("            \n");
      out.write("        </footer>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write(" \n");
      out.write("             \n");
      out.write("<script src=\"js/bootstrap.min.js\"></script>\n");
      out.write("<script src=\"js/jquery-3.1.1.min.js\"></script>\n");
      out.write("<script language=\"javascript\">\n");
      out.write("            function printdiv(printpage)\n");
      out.write("            {\n");
      out.write("                var headstr = \"<html><head><title></title></head><body>\";\n");
      out.write("                var footstr = \"</body>\";\n");
      out.write("                var newstr = document.all.item(printpage).innerHTML;\n");
      out.write("                var oldstr = document.body.innerHTML;\n");
      out.write("                document.body.innerHTML = headstr + newstr + footstr;\n");
      out.write("                window.print();\n");
      out.write("                document.body.innerHTML = oldstr;\n");
      out.write("                return false;\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("        \n");
      out.write("        <script language=\"javascript\">\n");
      out.write("            var addSerialNumber = function () {\n");
      out.write("                var i = 0;\n");
      out.write("                $('table tr').each(function (index) {\n");
      out.write("                    $(this).find('td:nth-child(1)').html(index - 1 + 1);\n");
      out.write("                });\n");
      out.write("            };\n");
      out.write("\n");
      out.write("            addSerialNumber();\n");
      out.write("        </script>\n");
      out.write("        <script>\n");
      out.write("        $(document).ready(function() {\n");
      out.write("            $('table thead th').each(function(i) {\n");
      out.write("                calculateColumn(i);\n");
      out.write("            });\n");
      out.write("        });\n");
      out.write("\n");
      out.write("        function calculateColumn(index) {\n");
      out.write("            var total = 0;\n");
      out.write("            $('table tr').each(function() {\n");
      out.write("                var value = parseInt($('th', this).eq(index).text());\n");
      out.write("                if (!isNaN(value)) {\n");
      out.write("                    total += value;\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("            $('table tfoot td').eq(index).text(total);\n");
      out.write("        }\n");
      out.write("    </script>\n");
      out.write("    ");
 } 
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
