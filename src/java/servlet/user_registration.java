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
@WebServlet(name = "user_registration", urlPatterns = {"/user_registration"})
public class user_registration extends HttpServlet {

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
            String firstName,lastName,addressNo,street1,street2,city,dateOfBirth,email,gender,salutation,contact1,contact2,nic,password;
            
            firstName=request.getParameter("fname");
            lastName=request.getParameter("lname");
            nic =request.getParameter("nic");
            addressNo=request.getParameter("addressno");
            street1=request.getParameter("street1");
            street2=request.getParameter("street2");
            city=request.getParameter("city");
            dateOfBirth=request.getParameter("dateofbirth");
            email=request.getParameter("email");
            gender=request.getParameter("gender");
            salutation=request.getParameter("salutaion");
            contact1=request.getParameter("mobileno");
            contact2=request.getParameter("homeno");
            password=request.getParameter("conformpassword");
            
            if (contact1.isEmpty()) {
                contact1="0";
            }
            if (contact2.isEmpty()) {
                contact2="0";
            }
            if (dateOfBirth.isEmpty()) {
                dateOfBirth = "9999-09-31";
            }
            
            HashMap<String,Object> hm=new HashMap<String, Object>();
            
            hm.put("firstName", firstName);
            hm.put("lastName", lastName);
            hm.put("nic", nic);
            hm.put("addressNo", addressNo);
            hm.put("street1", street1);
            hm.put("street2", street2);
            hm.put("city", city);
            hm.put("dateOfBirth", dateOfBirth);
            hm.put("email", email);
            hm.put("gender", gender);
            hm.put("salutation", salutation);
            hm.put("contact1", contact1);
            hm.put("contact2", contact2);
            hm.put("password", password);
            
            String status=new mvc.user_registration().saveData(hm);
            
            response.sendRedirect("RegistrationForm.jsp?msg="+status);
            
            
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
