/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

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
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "checkEmail", urlPatterns = {"/checkEmail"})
public class checkEmail extends HttpServlet {

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
        Session session = new classess.sessionConnect().testConnection();
        try {

            String msg = "1";
            String email = request.getParameter("value");

            Criteria checkEmailCustomerCriteria = session.createCriteria(POJOs.Customer.class);
            checkEmailCustomerCriteria.add(Restrictions.eq("email", email));

            List<POJOs.Customer> customerList = checkEmailCustomerCriteria.list();

            if (!customerList.isEmpty()) {

                msg = "1";
                out.write(msg);
            } else {
                Criteria checkEmailSupplierCriteria = session.createCriteria(POJOs.Supplier.class);
                checkEmailSupplierCriteria.add(Restrictions.eq("email", email));

                List<POJOs.Supplier> supplierList = checkEmailSupplierCriteria.list();

                if (!supplierList.isEmpty()) {

                    msg = "1";
                    out.write(msg);
                } else {

                    msg = "0";
                    out.write(msg);
                }

            }
            out.flush();

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
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
