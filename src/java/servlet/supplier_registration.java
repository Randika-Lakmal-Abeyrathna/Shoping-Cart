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
 * @author randika
 */
@WebServlet(name = "supplier_registration", urlPatterns = {"/supplier_registration"})
public class supplier_registration extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.s
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

            String ownerName, nicNumber, ownerContactNumber, companyName, companyRegNumber, companyEmail, contactNumber1, contactNumber2,
                    addressno, street1, street2, city, confirmPassword;

            ownerName = request.getParameter("ownername");
            nicNumber = request.getParameter("nicNumber");
            ownerContactNumber = request.getParameter("ownercontact");
            companyName = request.getParameter("companyname");
            companyRegNumber = request.getParameter("companyregnumber");
            companyEmail = request.getParameter("companyemail");
            contactNumber1 = request.getParameter("companycontact1");
            contactNumber2 = request.getParameter("companycontact2");

            addressno = request.getParameter("addressno");
            street1 = request.getParameter("street1");
            street2 = request.getParameter("street2");
            city = request.getParameter("city");

            confirmPassword = request.getParameter("confirmpassword");

            HashMap<String, Object> hm = new HashMap<String, Object>();
            hm.put("ownerName", ownerName);
            hm.put("nicNumber", nicNumber);
            hm.put("ownerContactNumber", ownerContactNumber);
            hm.put("companyName", companyName);
            hm.put("companyRegNumber", companyRegNumber);
            hm.put("companyEmail", companyEmail);
            hm.put("contactNumber1", contactNumber1);
            hm.put("contactNumber2", contactNumber2);

            hm.put("addressno", addressno);
            hm.put("street1", street1);
            hm.put("street2", street2);
            hm.put("city", city);

            hm.put("confirmPassword", confirmPassword);

            String status = new mvc.supplier_registration().saveData(hm);

//            Sess
            
            response.sendRedirect("supplier_registration.jsp?msg=" + status);
        } catch (Exception e) {
            throw new ServletException(e);
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
