/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "updateProduct", urlPatterns = {"/updateProduct"})
public class updateProduct extends HttpServlet {

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
        
        Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
        try {
            Transaction transaction = session.beginTransaction();
            int id= Integer.parseInt(request.getParameter("id"));
            
            String name,price,sellingPrice,qty,description,status,topCategory,subCategory;
            
            name =request.getParameter("name");
            price = request.getParameter("price");
            sellingPrice = new classess.getProductSubDetails().getSellingPrice(price);
            qty= request.getParameter("qty");
            description = request.getParameter("description");
            status =request.getParameter("status");
            topCategory =request.getParameter("topCategory");
            subCategory = request.getParameter("subCategory");
            
            POJOs.ProductStatus productStatus=null;
            if (status.equals("Active")) {
                productStatus = new classess.getProductSubDetails().getActiveProductStatus();
            }else{
                productStatus=new classess.getProductSubDetails().getDeactiveProductStatus();
            }
            
            POJOs.TopCategory topCategory1 = new classess.tools().getTopCategory(topCategory);
            POJOs.SubCategory subCategory1 = new classess.tools().getSubCategory(subCategory);
            
            POJOs.Product product = (POJOs.Product)session.load(POJOs.Product.class, id);
            
            product.setProductName(name);
            
            product.setPrice(Double.parseDouble(price));
            product.setSellingPrice(Double.parseDouble(sellingPrice));
            product.setQty(Integer.parseInt(qty));
            product.setDeiscription(description);
            product.setProductStatus(productStatus);
            
            session.update(product);
            
            Criteria getCategoryCriteria = session.createCriteria(POJOs.CategoryDetails.class);
            getCategoryCriteria.add(Restrictions.eq("product", product));
            
            POJOs.CategoryDetails categoryDetails  = (POJOs.CategoryDetails)getCategoryCriteria.uniqueResult();
            
            
            categoryDetails.setTopCategory(topCategory1);
            categoryDetails.setSubCategory(subCategory1);
            
            session.update(categoryDetails);
            
            transaction.commit();
            
            response.sendRedirect("Supplier_Main_Home.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            session.close();
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
