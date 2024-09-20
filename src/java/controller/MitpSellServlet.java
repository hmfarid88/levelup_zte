/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DB.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class MitpSellServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
            String cid=request.getParameter("cid");
            String invo = "NOV2018";
            String invoice = invo + cid;
            String ime = request.getParameter("imei");
            Float limit=Float.parseFloat(request.getParameter("limit"));

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs0=null;
            ResultSet rs=null;
            ResultSet rs1=null;
            ResultSet rs2=null;
            try {
                con = Database.getConnection();
                String query0="select sum(PRICE-DISCOUNT) from mobilesell where CUSTOMER_ID='"+ cid +"'";
                ps = con.prepareStatement(query0);
                rs0 = ps.executeQuery();
                rs0.next();
                Float evalue=rs0.getFloat(1);
                String query1 = "select count(*) from stock where IMEI=? " ;
                ps = con.prepareStatement(query1);
                ps.setString(1, ime);
                rs = ps.executeQuery();
                rs.next();
                int p = rs.getInt(1);
                if (p < 1) {
                   out.println("<h3>Sorry! This Product is not in stock");
                } else {
                    String query = "select  MODEL, COLOR, IMEI, PURCHASE_PRICE, A_SELL_PRICE, B_SELL_PRICE, VENDOR, AREA, STORE, BOSS, DATE from stock where IMEI=?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, ime);
                    rs1 = ps.executeQuery();
                    rs1.next();
                        String model = rs1.getString("MODEL");
                        String color = rs1.getString("COLOR");
                        String imei = rs1.getString("IMEI");
                        Float costprice = rs1.getFloat("PURCHASE_PRICE");
                        Float astockrate = rs1.getFloat("A_SELL_PRICE");
                        Float bstockrate = rs1.getFloat("B_SELL_PRICE");
                        Float bprice = rs1.getFloat("B_SELL_PRICE");
                        String vendor = rs1.getString("VENDOR");
                        String area=rs1.getString("AREA");
                        String store=rs1.getString("STORE");
                        String boss=rs1.getString("BOSS");
                        String date = rs1.getString("DATE");
                        if(evalue+bprice>limit){
                         out.println("<h3>Sorry! you have crossed limit!</h3>"); 
                               }else{
                        String query2 = "insert into mobilesell (PRODUCT_ID, CUSTOMER_ID, INVOICE_NO, "
                                + "MODEL, COLOR, COST_PRICE, A_STOCK_RATE, B_STOCK_RATE, PRICE, VENDOR, STOCK_DATE, AREA, STORE, BOSS, SELL_DATE) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?, CURDATE())";
                        ps = con.prepareStatement(query2);
                        ps.setString(1, imei);
                        ps.setString(2, cid);
                        ps.setString(3, invoice);
                        ps.setString(4, model);
                        ps.setString(5, color);
                        ps.setFloat(6, costprice);
                        ps.setFloat(7, astockrate);
                        ps.setFloat(8, bstockrate);
                        ps.setFloat(9, bprice);
                        ps.setString(10, vendor);
                        ps.setString(11, date);
                        ps.setString(12, area);
                        ps.setString(13, store);
                        ps.setString(14, boss);
                        ps.executeUpdate();
                        String salereturn="select count(*) from sale_return where PRODUCT_ID=? " ;
                          ps = con.prepareStatement(salereturn);
                          ps.setString(1, ime);
                          rs2 = ps.executeQuery();
                          rs2.next();
                          int r=rs2.getInt(1);
                          if(r>0){
                              String returnupdate="update sale_return set NEW_PROFIT=? where PRODUCT_ID=?";
                    ps = con.prepareStatement(returnupdate);
                    ps.setFloat(1, bprice-costprice);
                    ps.setString(2, ime);
                    ps.executeUpdate();
                          }
                        String query3 = "delete from stock where IMEI=?";
                        ps = con.prepareStatement(query3);
                        ps.setString(1, imei);
                        int b = ps.executeUpdate();
                        if (b > 0) {
                            response.sendRedirect("symmobilesell_mitp.jsp");
                        } else {
                            out.println("<h3>Sale is not completed, Try again!</h3>");
                        }
                    }
          
                }       } catch (SQLException ex) {
              
            }finally {
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
