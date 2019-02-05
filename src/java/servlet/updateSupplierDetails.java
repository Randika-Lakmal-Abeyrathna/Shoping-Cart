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
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "updateSupplierDetails", urlPatterns = {"/updateSupplierDetails"})
public class updateSupplierDetails extends HttpServlet {

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
            Transaction transaction =session.beginTransaction();
            String ownername,nicNumber,ownercontact,companyname,companyregnumber,companyemail,companycontact1,companycontact2,
                    addressno,street1,street2,city;
            
            ownername = request.getParameter("ownername");
            nicNumber =request.getParameter("nicNumber");
            ownercontact =request.getParameter("ownercontact");
            companyname =request.getParameter("companyname");
            companyregnumber =request.getParameter("companyregnumber");
            companyemail =request.getParameter("companyemail");
            companycontact1 =request.getParameter("companycontact1");
            companycontact2 =request.getParameter("companycontact2");
            addressno =request.getParameter("addressno");
            street1 =request.getParameter("street1");
            street2 =request.getParameter("street2");
            city =request.getParameter("city");
            
            
            POJOs.Supplier supplier =(POJOs.Supplier)session.load(POJOs.Supplier.class, companyemail);
            
            supplier.setSupplierName(ownername);
            supplier.setSupplierNic(nicNumber);
            supplier.setOwnerContactno(Integer.parseInt(ownercontact));
            supplier.setCompanyRegNumber(companyregnumber);
            supplier.setContactNumber(Integer.parseInt(companycontact1));
            supplier.setContactNumber2(Integer.parseInt(companycontact2));
            supplier.setAddressNo(addressno);
            supplier.setAddressStreet(street1);
            supplier.setAddressStreet2(street2);
            supplier.setCity(new classess.tools().saveCity(city));
            
            session.update(supplier);
            
            transaction.commit();

            response.sendRedirect("supplierAccountupdate.jsp");
            
        }catch(Exception e){
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
