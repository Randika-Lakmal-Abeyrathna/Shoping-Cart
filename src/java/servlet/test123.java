/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "test123", urlPatterns = {"/test123"})
public class test123 extends HttpServlet {

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
             String email,fname,lname,addno,street1,street2,city,nic,dob,contact1,contact2;
            email =request.getParameter("email");
            fname =request.getParameter("firstname");
            lname =request.getParameter("lastname");
            addno =request.getParameter("addno");
            street1 =request.getParameter("street1");
            street2 =request.getParameter("street2");
            city =request.getParameter("city");
            nic =request.getParameter("nic");
            dob =request.getParameter("dob");
            contact1 =request.getParameter("contact1");
            contact2 =request.getParameter("contact2");
            
            
            POJOs.Customer customer = (POJOs.Customer)session.load(POJOs.Customer.class, email);
            
            customer.setFirstName(fname);
            customer.setLastName(lname);
            customer.setAddressNo(addno);
            customer.setAddressStreet(street1);
            customer.setAddressStreet2(street2);
            customer.setCity(new classess.tools().saveCity(city));
            customer.setNicNumber(nic);
            customer.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").parse(dob));
            customer.setContactNumber1(Integer.parseInt(contact1));
            customer.setContactNumber2(Integer.parseInt(contact2));
            
            session.update(customer);
            transaction.commit();
            
            response.sendRedirect("CustomerAccountUpdate.jsp");
            
        } catch(Exception e){
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
