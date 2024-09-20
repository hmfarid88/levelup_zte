
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <body>
        <%
            String imei = request.getParameter("rollback");
            Connection con = null;
            PreparedStatement ps = null;
            try {
                con = Database.getConnection();
                String query0="insert into stock_delete (MODEL, COLOR, IMEI, PURCHASE_PRICE, A_SELL_PRICE, B_SELL_PRICE, VENDOR, DATE) select MODEL, COLOR, IMEI, PURCHASE_PRICE, A_SELL_PRICE, B_SELL_PRICE, VENDOR, CURDATE() from stock where IMEI=?";
                ps = con.prepareStatement(query0);
                ps.setString(1, imei);
                int p = ps.executeUpdate();
                if(p>0){
                String query = "delete from stock where IMEI=?";
                ps = con.prepareStatement(query);
                ps.setString(1, imei);
                int a = ps.executeUpdate();
                if(a>0){
                String query1 = "delete  from vendor_stock where PRODUCT_ID=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, imei);
                ps.executeUpdate();
                response.sendRedirect("totalStock.jsp");
                }
                }else{
                    out.println("<h3>Invalid Product ID</h3>");
                }
            } catch (Exception ex) {
            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}


        %>
    </body>
</html>
