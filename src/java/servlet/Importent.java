/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "Importent", urlPatterns = {"/Importent"})
public class Importent extends HttpServlet {

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
        
        try {
            
            String msg = request.getParameter("msg");
            if (msg.equals("subcategory")) {
                String value = request.getParameter("value");
                
                HashMap subCategoryMap = new classess.getProductSubDetails().getSubcategory();
                out.print(subCategoryMap);
                out.flush();
            }
            
            if (msg.equals("sellingPrice")) {
                String value = request.getParameter("value");
                System.out.println(value);
                String sellingPrice = new classess.getProductSubDetails().getSellingPrice(value);
                System.out.println(sellingPrice);
                out.print(sellingPrice);
                out.flush();
            }
            
            
            
            // Save Category
            if (msg.equals("savecategory")) {
                String category = request.getParameter("category");
                
                new mvc.saveSubProductDetails().saveCategory(category);
                
            }
            
            // Save Sub Category
            if (msg.equals("savesubcategory")) {
                String subcategory = request.getParameter("subcategory");
                
                new mvc.saveSubProductDetails().saveSubCategory(subcategory);
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
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
