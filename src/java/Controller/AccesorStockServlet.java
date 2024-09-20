/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DB.Ssymphonyy;
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
 * @author Polash
 */
public class AccesorStockServlet extends HttpServlet {

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
        
        
            String product = request.getParameter("product");
            String vname = request.getParameter("vname");
            String model = request.getParameter("model");
            Float cost = Float.parseFloat(request.getParameter("cost"));
            Float sellprice = Float.parseFloat(request.getParameter("sellprice"));
            String pid = request.getParameter("proid");

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rs1=null;
            try {
                con = Ssymphonyy.getConnection();
                String query = "select count(*) as acid from accessoriesstock where  PRODUCT_ID=?";
                ps = con.prepareStatement(query);
                ps.setString(1, pid);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt("acid");
                
                if (a > 0) {
                
                    out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Mobile Store</title>");    
            out.println("<link rel=\"icon\" type=\"image/png\" href=\"img/favicon.ico\">");  
            out.println("</head>");
            out.println("<body>");
            out.println("<a href='symaccesor_entry.jsp'>Back</a>");
            out.println("<h2><center><br><br>Sorry, This product is already in stock!</center></h2>");
            out.println("</body>");
            out.println("</html>"); 
                } else {
                    String query2 = "insert into vendor_stock (PRODUCT, TYPE, PRODUCT_ID, PURCHASE_PRICE, VENDOR, DATE)"
                                + "values (?,?,?,?,?, CURDATE())";
                        ps = con.prepareStatement(query2);
                        ps.setString(1, product);
                        ps.setString(2, "Acce");
                        ps.setString(3, pid);
                        ps.setFloat(4, cost);
                        ps.setString(5, vname);
                      int c= ps.executeUpdate();
                    
                    if (c > 0) {
                        String query3 = "insert into accessoriesstock (PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, DATE)"
                            + "values (?,?,?,?,?,?, CURDATE())";
                    ps = con.prepareStatement(query3);
                    ps.setString(1, product);
                    ps.setString(2, model);
                    ps.setString(3, pid);
                    ps.setFloat(4, cost);
                    ps.setFloat(5, sellprice);
                    ps.setString(6, vname);
                    int d = ps.executeUpdate();
                    if(d>0){
                      response.sendRedirect("symaccesor_entry.jsp");  
                    }else{
                       out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Mobile Store</title>");    
            out.println("<link rel=\"icon\" type=\"image/png\" href=\"img/favicon.ico\">");  
            out.println("</head>");
            out.println("<body>");
            out.println("<a href='symaccesor_entry.jsp'>Back</a>");
            out.println("<h2><center><br><br>Sorry, This product is not entryed successfully!</center></h2>");
            out.println("</body>");
            out.println("</html>"); 
                  
                    }
                    } else {
                       out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Mobile Store</title>");    
            out.println("<link rel=\"icon\" type=\"image/png\" href=\"img/favicon.ico\">");  
            out.println("</head>");
            out.println("<body>");
            out.println("<a href='symaccesor_entry.jsp'>Back</a>");
            out.println("<h2><center><br><br>Sorry, This product is not entryed successfully!</center></h2>");
            out.println("</body>");
            out.println("</html>"); 
                    }
                    
                }

            } catch (SQLException ex) {
                ex.printStackTrace();
          out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Mobile Store</title>");    
            out.println("<link rel=\"icon\" type=\"image/png\" href=\"img/favicon.ico\">");  
            out.println("</head>");
            out.println("<body>");
            out.println("<a href='symaccesor_entry.jsp'>Back</a>");
            out.println("<h2><center><br><br>Sorry, This product is not entryed successfully!</center></h2>");
            out.println("</body>");
            out.println("</html>"); 
}finally {
   try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
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
