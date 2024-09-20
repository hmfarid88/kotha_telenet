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
public class MstockServlet extends HttpServlet {

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
       
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String color = request.getParameter("color");
            String imei = request.getParameter("imei");
            String vendor = request.getParameter("vname");
            Float pprice = Float.parseFloat(request.getParameter("pprice"));
            Float sprice = Float.parseFloat(request.getParameter("sprice"));

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rss=null;
            try {
                con = Ssymphonyy.getConnection();
                String query = "select count(*) as imeei from stock where  IMEI=?";
                ps = con.prepareStatement(query);
                ps.setString(1, imei);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt("imeei");
               
                if (a > 0) {
                 out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Mobile Store</title>");    
            out.println("<link rel=\"icon\" type=\"image/png\" href=\"img/favicon.ico\">");  
            out.println("</head>");
            out.println("<body>");
            out.println("<a href='symstockentry.jsp'>Back</a>");
            out.println("<h2><center><br><br>Sorry, This product is already in stock!</center></h2>");
            out.println("</body>");
            out.println("</html>"); 
                
                } else {
                    String query1="insert into vendor_stock (PRODUCT, TYPE, PRODUCT_ID, PURCHASE_PRICE, VENDOR, DATE)"
                                + "values (?,?,?,?,?, CURDATE())";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, brand+","+model);
                    ps.setString(2, "Mobile");
                    ps.setString(3, imei);
                    ps.setFloat(4, pprice);
                    ps.setString(5, vendor);
                    int b=ps.executeUpdate();
                    if (b > 0) {
                       String query2 = "insert into stock (BRAND, MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, DATE)"
                            + "values (?,?,?,?,?,?,?, CURDATE())";
                    ps = con.prepareStatement(query2);
                    ps.setString(1, brand);
                    ps.setString(2, model);
                    ps.setString(3, color);
                    ps.setString(4, imei);
                    ps.setFloat(5, pprice);
                    ps.setFloat(6, sprice);
                    ps.setString(7, vendor);
                    int x = ps.executeUpdate(); 
                    if(x>0){
                    response.sendRedirect("symstockentry.jsp");
                    }else{
                      out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Mobile Store</title>");    
            out.println("<link rel=\"icon\" type=\"image/png\" href=\"img/favicon.ico\">");  
            out.println("</head>");
            out.println("<body>");
            out.println("<a href='symstockentry.jsp'>Back</a>");
            out.println("<h2><center><br><br>Sorry, This product is not entryed!</center></h2>");
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
            out.println("<a href='symstockentry.jsp'>Back</a>");
            out.println("<h2><center><br><br>Sorry, This product is not entryed!</center></h2>");
            out.println("</body>");
            out.println("</html>"); 
                    }
                  }

            } catch (Exception ex) {
              ex.printStackTrace();
           out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Mobile Store</title>");    
            out.println("<link rel=\"icon\" type=\"image/png\" href=\"img/favicon.ico\">");  
            out.println("</head>");
            out.println("<body>");
            out.println("<a href='symstockentry.jsp'>Back</a>");
            out.println("<h2><center><br><br>Sorry, This product is not entryed!</center></h2>");
            out.println("</body>");
            out.println("</html>"); 
            }
   try { if (rss != null) rss.close(); } catch (SQLException ex2) { }        
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
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
