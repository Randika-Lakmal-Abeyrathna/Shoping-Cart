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
@WebServlet(name = "checkRecoverCode", urlPatterns = {"/checkRecoverCode"})
public class checkRecoverCode extends HttpServlet {

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
            String email = request.getParameter("email");
            String code = request.getParameter("code");

            if (new classess.tools().checkUserExist(email)) {

                POJOs.Customer customer = new classess.tools().getCustomer(email);

                Criteria getRecover = session.createCriteria(POJOs.CustomerRecover.class);
                getRecover.add(Restrictions.eq("cutomer", customer));

                POJOs.CustomerRecover cr = (POJOs.CustomerRecover) getRecover.uniqueResult();

                String genCode = cr.getCode();

                if (code.equals(genCode)) {

                    cr.setCode("999999");

                    session.update(cr);
                    transaction.commit();
                    response.sendRedirect("UpdatePassword.jsp?type=c&id=" + email);

                } else {
                    response.sendRedirect("EmailCode.jsp?msg=Invalid  Code !");
                }

            } else if (new classess.tools().checkSupplierExist(email)) {
                POJOs.Supplier supplier = new classess.tools().getSupplier(email);

                Criteria getRecover = session.createCriteria(POJOs.SupplierRecover.class);
                getRecover.add(Restrictions.eq("supplier", supplier));

                POJOs.SupplierRecover cr = (POJOs.SupplierRecover) getRecover.uniqueResult();

                String genCode = cr.getCode();

                if (code.equals(genCode)) {

                    cr.setCode("999999");

                    session.update(cr);
                    transaction.commit();
                    response.sendRedirect("UpdatePassword.jsp?type=s&id=" +email);

                } else {
                    response.sendRedirect("EmailCode.jsp?msg=Invalid  Code !");
                }

            } else {
                response.sendRedirect("EmailCode.jsp?msg=Invalid  Email !");
            }

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
