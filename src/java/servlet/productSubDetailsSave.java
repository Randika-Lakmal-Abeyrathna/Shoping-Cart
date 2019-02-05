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

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "productSubDetailsSave", urlPatterns = {"/productSubDetailsSave"})
public class productSubDetailsSave extends HttpServlet {

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
            String value = request.getParameter("value");
            if (msg.equals("subcategory")) {
                String result = "";
                new mvc.saveSubProductDetails().saveSubCategory(value);

                HashMap<String, Object> subCategoryMap = new classess.getProductSubDetails().getSubcategory();

                for (int i = 0; i < subCategoryMap.size(); i++) {
                    POJOs.SubCategory subCategory = (POJOs.SubCategory) subCategoryMap.get(i + "");

                    result += "<option>"+subCategory.getSubCategory()+"</option>";
                }
                out.write(result);
                out.flush();
            }

            if (msg.equals("category")) {
                String result = "";
                new mvc.saveSubProductDetails().saveCategory(value);

                HashMap<String,Object> categoryMap =new classess.getProductSubDetails().getTopCategory();
                
                for (int i = 0; i < categoryMap.size(); i++) {
                    POJOs.TopCategory category = (POJOs.TopCategory)categoryMap.get(i+"");
                    
                    result +="<option>"+category.getTopCategory()+"</option>";
                    
                }
                out.write(result);
                out.flush();
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
