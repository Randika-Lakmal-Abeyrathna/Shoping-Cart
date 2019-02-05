/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import POJOs.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "deactiveSupplier", urlPatterns = {"/deactiveSupplier"})
public class deactiveSupplier extends HttpServlet {

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
        Session session =POJOs.session_pool_manager.getSessionFactory().openSession();
        try {
            Transaction transaction = session.beginTransaction();
            
            String email = request.getParameter("id");
            
            POJOs.Supplier supplier = (POJOs.Supplier)session.load(POJOs.Supplier.class, email);
            
            supplier.setStatus(new classess.tools().getDeactiveStatus());
            
            Criteria criteria = session.createCriteria(POJOs.Product.class);
            criteria.add(Restrictions.eq("supplier", supplier));
            
            List<POJOs.Product> productList = criteria.list();
            
            if(!productList.isEmpty()){
                
                for (int i = 0; i < productList.size(); i++) {
                    Product product1 = productList.get(i);
                    Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                    Transaction transaction1 = session1.beginTransaction();
                    POJOs.Product product = (POJOs.Product)session1.get(POJOs.Product.class, product1.getIdproduct());
                    product.setProductStatus(new classess.getProductSubDetails().getDeactiveProductStatus());
                    
                    session1.update(product);
                    
                    transaction1.commit();
                    
                    session1.close();
                }
                
            }
            
            session.update(supplier);
            
            transaction.commit();
            
            response.sendRedirect("AdminSupplierDetails.jsp");
            
        } catch (Exception e) {
            throw new ServletException(e);
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
