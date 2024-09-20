/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DB.Database;
import java.io.IOException;
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
public class SalePriceUpdateServlet extends HttpServlet {

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
        
        String soldime=request.getParameter("soldime");
        String type=request.getParameter("type");
        Float amount=Float.parseFloat(request.getParameter("amount"));
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;
         try {
                con = Database.getConnection();
                if(type.equals("Plus")){
                    String update="update mobilesell set PRICE=PRICE+? where PRODUCT_ID=?";
                    ps = con.prepareStatement(update);
                    ps.setFloat(1, amount);
                    ps.setString(2, soldime);
                    int a=ps.executeUpdate();
                    if(a>0){
                        String query11="select CUSTOMER_ID from mobilesell where PRODUCT_ID=?";
                    ps = con.prepareStatement(query11);
                    ps.setString(1, soldime);
                    rs=ps.executeQuery();
                    rs.next();
                    int cid=rs.getInt("CUSTOMER_ID");
                        String payup="update paymentinfo set TOTAL=TOTAL+?, GRAND_TOTAL=GRAND_TOTAL+? where CUSTOMER_ID=?";
                        ps = con.prepareStatement(payup);
                        ps.setFloat(1, amount);
                        ps.setFloat(2, amount);
                        ps.setInt(3, cid);
                        ps.executeUpdate();
                        String returnupdate="update sale_return set NEW_PROFIT=NEW_PROFIT+? where PRODUCT_ID=?";
                    ps = con.prepareStatement(returnupdate);
                    ps.setFloat(1, amount);
                    ps.setString(2, soldime);
                    ps.executeUpdate();
                        response.sendRedirect("symsellview.jsp");
                    }
                }else{
                    String update="update mobilesell set PRICE=PRICE-? where PRODUCT_ID=?";
                    ps = con.prepareStatement(update);
                    ps.setFloat(1, amount);
                    ps.setString(2, soldime);
                    int a=ps.executeUpdate();
                    if(a>0){
                        String query11="select CUSTOMER_ID from mobilesell where PRODUCT_ID=?";
                    ps = con.prepareStatement(query11);
                    ps.setString(1, soldime);
                    rs=ps.executeQuery();
                    rs.next();
                    int cid=rs.getInt("CUSTOMER_ID");
                        String payup="update paymentinfo set TOTAL=TOTAL-?, GRAND_TOTAL=GRAND_TOTAL-? where CUSTOMER_ID=?";
                        ps = con.prepareStatement(payup);
                        ps.setFloat(1, amount);
                        ps.setFloat(2, amount);
                        ps.setInt(3, cid);
                        ps.executeUpdate();
                        String returnupdate="update sale_return set NEW_PROFIT=NEW_PROFIT-? where PRODUCT_ID=?";
                    ps = con.prepareStatement(returnupdate);
                    ps.setFloat(1, amount);
                    ps.setString(2, soldime);
                    ps.executeUpdate();
                        response.sendRedirect("symsellview.jsp");
                    }
                }
                }catch (SQLException ex) {
            }finally {
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
