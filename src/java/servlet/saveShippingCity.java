/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import POJOs.ShipingDetails;
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
@WebServlet(name = "saveShippingCity", urlPatterns = {"/saveShippingCity"})
public class saveShippingCity extends HttpServlet {

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
            
            String city = request.getParameter("city");
            String price = request.getParameter("cost");
            
            Criteria criteria = session.createCriteria(POJOs.ShipingDetails.class);
            criteria.add(Restrictions.eq("city", city));
            
            List<POJOs.ShipingDetails> detailses = criteria.list();
            
            if(detailses.isEmpty()){
            
                POJOs.ShipingDetails details = new ShipingDetails();
                
                details.setCity(city);
                details.setCost(Double.parseDouble(price));
                
                session.save(details);
                
                transaction.commit();
                
                
                
            }else{
                for (int i = 0; i < detailses.size(); i++) {
                    ShipingDetails shipingDetails = detailses.get(i);
                    
                    shipingDetails.setCost(Double.parseDouble(price));
                    
                    session.update(shipingDetails);
                }
                transaction.commit();
            }
                 
            response.sendRedirect("AdminShippingDetails.jsp");
            
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
