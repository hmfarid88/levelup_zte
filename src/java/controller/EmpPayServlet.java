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
public class EmpPayServlet extends HttpServlet {

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
        String empname=request.getParameter("empname");
        String costname=request.getParameter("costname");
        Float amount=Float.parseFloat(request.getParameter("amount")) ;
    
       Connection con = null;
       PreparedStatement ps=null;
        ResultSet rs=null;     
        try{
            con = Database.getConnection();
            String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
            ps = con.prepareStatement(nbalance);
            rs=ps.executeQuery();
            rs.next();
            Long lbalance=rs.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Balance !</h2></center>");  
            }else{
            String query="insert into emp_cost(EMP_NAME, COST_NAME, AMOUNT, DATE) values(?,?,?, CURDATE())";
            ps = con.prepareStatement(query);
            ps.setString(1, empname);
            ps.setString(2, costname);
            ps.setFloat(3, amount);
             
             int a = ps.executeUpdate();
             if (a > 0) {

                response.sendRedirect("accountant.jsp");
            } else {
                out.println("Sorry! Entry is not Success");
            }
        } }
        catch(Exception ex){
            
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
