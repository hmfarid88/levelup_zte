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
public class M_sale_replace_Servlet extends HttpServlet {

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
        String soldime = request.getParameter("soldime");
        String newime = request.getParameter("newime");
        String type = request.getParameter("type");
            
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rs1=null;
            ResultSet rs2=null;
            ResultSet rs4=null;
            
            
            try {
                con = Database.getConnection();
                String query = "insert into stock (MODEL, COLOR, IMEI, PURCHASE_PRICE, A_SELL_PRICE, B_SELL_PRICE, VENDOR, AREA, STORE, BOSS, DATE) select  MODEL,"
                        + " COLOR, PRODUCT_ID, COST_PRICE, A_STOCK_RATE, B_STOCK_RATE, VENDOR, AREA, STORE, BOSS, CURDATE() from mobilesell where PRODUCT_ID=?";
                ps = con.prepareStatement(query);
                ps.setString(1, soldime);
                int a = ps.executeUpdate();
                if (a < 1) {
                    out.println("<h3>Sorry ! Invalid Product ID</h3>");
                } else {
                    String slback="insert into sale_return (PRODUCT_ID, MODEL, COLOR, PREV_PROFIT, NEW_PROFIT, RETAILER, SALE_DATE, BACK_DATE, REMARK ) select PRODUCT_ID, MODEL, COLOR, PRICE-COST_PRICE, '0', RETAILER, SELL_DATE, CURDATE(), 'Replaced' from mobilesell where  PRODUCT_ID=? and YEAR(SELL_DATE) <= YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE)< MONTH(CURRENT_DATE())";
                    ps = con.prepareStatement(slback);
                    ps.setString(1, soldime);
                    ps.executeUpdate();
                    String query01="select  MODEL, COLOR, IMEI, PURCHASE_PRICE, A_SELL_PRICE, B_SELL_PRICE, VENDOR, AREA, STORE, BOSS, DATE from stock where IMEI=?";
                    ps = con.prepareStatement(query01);
                    ps.setString(1, newime);
                    rs = ps.executeQuery();
                    rs.next();
                        String model = rs.getString("MODEL");
                        String color = rs.getString("COLOR");
                        String imei = rs.getString("IMEI");
                        Float costprice = rs.getFloat("PURCHASE_PRICE");
                        Float astockrate = rs.getFloat("A_SELL_PRICE");
                        Float bstockrate = rs.getFloat("B_SELL_PRICE");
                        String vendor = rs.getString("VENDOR");
                        String area=rs.getString("AREA");
                        String store=rs.getString("STORE");
                        String boss=rs.getString("BOSS");
                        String date = rs.getString("DATE");
                        if(type.equals("GRT")){
                    String query1 = "update  mobilesell set PRODUCT_ID=?, MODEL=?, COLOR=?, COST_PRICE=?, A_STOCK_RATE=?, B_STOCK_RATE=?, PRICE=?, VENDOR=?, STOCK_DATE=?, AREA=?, STORE=?, BOSS=?  where PRODUCT_ID=?";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, imei);
                    ps.setString(2, model);
                    ps.setString(3, color);
                    ps.setFloat(4, costprice);
                    ps.setFloat(5, astockrate);
                    ps.setFloat(6, bstockrate);
                    ps.setFloat(7, astockrate);
                    ps.setString(8, vendor);
                    ps.setString(9, date);
                    ps.setString(10, area);
                    ps.setString(11, store);
                    ps.setString(12, boss);
                    ps.setString(13, soldime);
                    ps.executeUpdate();
                        }else if(type.equals("MIPP")){
                            String query1 = "update  mobilesell set PRODUCT_ID=?, MODEL=?, COLOR=?, COST_PRICE=?, A_STOCK_RATE=?, B_STOCK_RATE=?, PRICE=?, VENDOR=?, STOCK_DATE=?, AREA=?, STORE=?, BOSS=?  where PRODUCT_ID=?";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, imei);
                    ps.setString(2, model);
                    ps.setString(3, color);
                    ps.setFloat(4, costprice);
                    ps.setFloat(5, astockrate);
                    ps.setFloat(6, bstockrate);
                    ps.setFloat(7, bstockrate);
                    ps.setString(8, vendor);
                    ps.setString(9, date);
                    ps.setString(10, area);
                    ps.setString(11, store);
                    ps.setString(12, boss);
                    ps.setString(13, soldime);
                    ps.executeUpdate();
                        }else{
                          String query1 = "update  mobilesell set PRODUCT_ID=?, MODEL=?, COLOR=?, COST_PRICE=?, A_STOCK_RATE=?, B_STOCK_RATE=?, PRICE=?, VENDOR=?, STOCK_DATE=?, AREA=?, STORE=?, BOSS=?  where PRODUCT_ID=?";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, imei);
                    ps.setString(2, model);
                    ps.setString(3, color);
                    ps.setFloat(4, costprice);
                    ps.setFloat(5, astockrate);
                    ps.setFloat(6, bstockrate);
                    ps.setFloat(7, costprice);
                    ps.setString(8, vendor);
                    ps.setString(9, date);
                    ps.setString(10, area);
                    ps.setString(11, store);
                    ps.setString(12, boss);
                    ps.setString(13, soldime);
                    ps.executeUpdate();  
                        }
                    String query11="select CUSTOMER_ID, PRICE-COST_PRICE, INVOICE_NO from mobilesell where PRODUCT_ID=?";
                    ps = con.prepareStatement(query11);
                    ps.setString(1, newime);
                    rs1=ps.executeQuery();
                    rs1.next();
                    int cid=rs1.getInt(1);
                    Float profit=rs1.getFloat(2);
                    String invono=rs1.getString(3);
                   
                    String salereturn="update sale_return set NEW_PROFIT=? where PRODUCT_ID=?";
                    ps = con.prepareStatement(salereturn);
                    ps.setFloat(1, profit);
                    ps.setString(2, soldime);
                    ps.executeUpdate();
                    String query111="select sum(PRICE) from mobilesell where CUSTOMER_ID=?";
                    ps = con.prepareStatement(query111);
                    ps.setInt(1, cid);
                    rs2=ps.executeQuery();
                    rs2.next();
                    Float tprice=rs2.getFloat(1);
                     
                
                    String queryvat="select VAT_RATE from vat";
                    ps = con.prepareStatement(queryvat);
                    rs4=ps.executeQuery();
                    rs4.next();
                    Float vatr=rs4.getFloat(1);
                    Float vat=(tprice*vatr)/100;
                    Float gprice=tprice+vat;
                    
                                      
                    String paymentupdate="update paymentinfo set TOTAL=?, VAT=?, GRAND_TOTAL=? where CUSTOMER_ID=?";
                    ps = con.prepareStatement(paymentupdate);
                    ps.setFloat(1, tprice);
                    ps.setFloat(2, vat);
                    ps.setFloat(3, gprice);
                    ps.setInt(4, cid);
                    ps.executeUpdate();
                    
                    String rtstate="update retailer_statement set VALUE=? where INVOICE=?";
                    ps = con.prepareStatement(rtstate);
                    ps.setFloat(1, gprice);
                    ps.setString(2, invono);
                    ps.executeUpdate();
                    
                    String query2 = "delete from stock where IMEI=?";
                    ps = con.prepareStatement(query2);
                    ps.setString(1, newime);
                    int b=ps.executeUpdate();
                    if(b>0){
                    response.sendRedirect("symsellview.jsp");
                    }else{
                     out.println("<h4>Sorry ! Replacement is not completed</h4>");   
                    }
                }
            } catch (SQLException ex) {
            }finally {
   
   try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
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
