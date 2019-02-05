/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import POJOs.WatchList;
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
@WebServlet(name = "addToWatchList", urlPatterns = {"/addToWatchList"})
public class addToWatchList extends HttpServlet {

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
            Session  session = POJOs.session_pool_manager.getSessionFactory().openSession();
            
            Transaction transaction =session.beginTransaction();
            
            POJOs.Product product = (POJOs.Product)session.load(POJOs.Product.class, Integer.parseInt(request.getParameter("pid")));
            
            POJOs.Customer customer = (POJOs.Customer)request.getSession().getAttribute("username");
            
            if (customer == null) {
                
            }else{
            Criteria getWatchListCriteria = session.createCriteria(POJOs.WatchList.class);
            getWatchListCriteria.add(Restrictions.eq("customer", customer));
            getWatchListCriteria.add(Restrictions.eq("product", product));
            
            List<POJOs.WatchList> watchLists =getWatchListCriteria.list();
            if (!watchLists.isEmpty()) {
                
            }else{
                POJOs.WatchList watchList = new WatchList();
            
                watchList.setCustomer(customer);
                watchList.setProduct(product);
                watchList.setSystemDate(new classess.tools().saveDate());
                
                session.save(watchList);
                
                transaction.commit();
            }
            
            out.write(new classess.getWatchListCount().getCount(customer));
            }
            session.close();
            out.flush();
            
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
