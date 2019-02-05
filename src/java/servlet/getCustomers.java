/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import POJOs.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
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
@WebServlet(name = "getCustomers", urlPatterns = {"/getCustomers"})
public class getCustomers extends HttpServlet {

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
            String msg =request.getParameter("type");
            
            if (msg.equals("all")) {
                
                Criteria getallDetails = session.createCriteria(POJOs.Customer.class);
                List<POJOs.Customer> allCustomerList = getallDetails.list();

                String result ="<th>Email</th>"
                        + "<th>Name</th>"
                        + "<th>Status</th>";
                if (!allCustomerList.isEmpty()) {
                    for (int i = 0; i < allCustomerList.size(); i++) {
                        Customer allcustomer = allCustomerList.get(i);
                        
                        result +="<tr>"
                                + "<td>"+allcustomer.getEmail()+"</td>"
                                + "<td>"+allcustomer.getFirstName()+"</td>"
                                + "<td>"+allcustomer.getStatus().getStatus()+"</td>"
                                + "</tr>"; 
                    }
                }
                out.print(result);
                out.flush();
                
            }
            if (msg.equals("active")) {
                Criteria getactiveDetails = session.createCriteria(POJOs.Customer.class);
                getactiveDetails.add(Restrictions.eq("status", (POJOs.Status)session.createCriteria(POJOs.Status.class).add(Restrictions.eq("status", "active")).uniqueResult()));
                List<POJOs.Customer> activeCustomerList = getactiveDetails.list();
                
                String result ="<th>Email</th>"
                        + "<th>Name</th>"
                        + "<th>Status</th>";
                if (!activeCustomerList.isEmpty()) {
                    for (int i = 0; i < activeCustomerList.size(); i++) {
                        Customer activecustomer = activeCustomerList.get(i);
                        
                        result +="<tr>"
                                + "<td>"+activecustomer.getEmail()+"</td>"
                                + "<td>"+activecustomer.getFirstName()+"</td>"
                                + "<td>"+activecustomer.getStatus().getStatus()+"</td>"
                                + "</tr>"; 
                    }
                }
                out.print(result);
                out.flush();
            }
            if (msg.equals("inactive")) {
                Criteria getactiveDetails = session.createCriteria(POJOs.Customer.class);
                getactiveDetails.add(Restrictions.eq("status", (POJOs.Status)session.createCriteria(POJOs.Status.class).add(Restrictions.eq("status", "inactive")).uniqueResult()));
                List<POJOs.Customer> activeCustomerList = getactiveDetails.list();
                
                String result ="<th>Email</th>"
                        + "<th>Name</th>"
                        + "<th>Status</th>";
                if (!activeCustomerList.isEmpty()) {
                    for (int i = 0; i < activeCustomerList.size(); i++) {
                        Customer activecustomer = activeCustomerList.get(i);
                        
                        result +="<tr>"
                                + "<td>"+activecustomer.getEmail()+"</td>"
                                + "<td>"+activecustomer.getFirstName()+"</td>"
                                + "<td>"+activecustomer.getStatus().getStatus()+"</td>"
                                + "</tr>"; 
                    }
                }
                out.print(result);
                out.flush();
            }
            if (msg.equals("blacklist")) {
                
            }
            if (msg.equals("search")) {
                String value = request.getParameter("search");
                
                
            }
            
            
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
