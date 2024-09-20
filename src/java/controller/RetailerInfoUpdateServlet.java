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
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class RetailerInfoUpdateServlet extends HttpServlet {

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
            String retailer = request.getParameter("retailer");
            String oldretailer=request.getParameter("oldretailer");
            String owner=request.getParameter("owner");
            String address=request.getParameter("address");
            String number=request.getParameter("number");
            String email=request.getParameter("email");
            String grade=request.getParameter("grade");
            String dmsid=request.getParameter("dmsid");
            Connection con = null;
            PreparedStatement ps = null;

            try {
                con = Database.getConnection();
                String query = "update retailer_info set R_NAME=?, OWNER=?, ADDRESS=?, M_NUMBER=?, EMAIL=?, GRADE=?, DMSID=?  where  R_NAME=? ";
                ps = con.prepareStatement(query);
                ps.setString(1, retailer);
                ps.setString(2, owner);
                ps.setString(3, address);
                ps.setString(4, number);
                ps.setString(5, email);
                ps.setString(6, grade);
                ps.setString(7, dmsid);
                ps.setString(8, oldretailer);
                int a = ps.executeUpdate();
                if (a > 0) {
                    String upq="update customerinfo set C_NAME=?, AREA_NAME=?, BOSS_NAME=?, GRADE=?, DMSID=?  where C_NAME=?";
                ps = con.prepareStatement(upq);
                ps.setString(1, retailer);
                ps.setString(2, address);
                ps.setString(3, owner);
                ps.setString(4, grade);
                ps.setString(5, dmsid);
                ps.setString(6 , oldretailer);
                ps.executeUpdate();
                String payup="update customer_pay set RETAILER=? where RETAILER=?";
                ps = con.prepareStatement(payup);
                ps.setString(1, retailer);
                ps.setString(2, oldretailer);
                ps.executeUpdate();
                String sellup="update mobilesell set RETAILER=? where RETAILER=?";
                ps = con.prepareStatement(sellup);
                ps.setString(1, retailer);
                ps.setString(2, oldretailer);
                ps.executeUpdate();
                    response.sendRedirect("retailer_edit.jsp");
                } else {
                    out.println("Info is not updated");
                }

            } catch (SQLException ex) {

            }finally {
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
