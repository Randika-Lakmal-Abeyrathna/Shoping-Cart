/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import POJOs.CustomerRecover;
import POJOs.SupplierRecover;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "sendRecoverCode", urlPatterns = {"/sendRecoverCode"})
public class sendRecoverCode extends HttpServlet {

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
            Transaction transaction=session.beginTransaction();
            
            String email =request.getParameter("email");
            
            if(new classess.tools().checkUserExist(email)){
                
                double code =Math.floor(Math.random()*999)+1000;
                String gen=code+"";
                String gencode =gen.substring(0, 4);
                POJOs.Customer customer =new classess.tools().getCustomer(email);
                
                Criteria getRecoverCustomerCriteria = session.createCriteria(POJOs.CustomerRecover.class);
                getRecoverCustomerCriteria.add(Restrictions.eq("customer", customer));
                
                List<POJOs.CustomerRecover> customerRecoverList = getRecoverCustomerCriteria.list();
                if(!customerRecoverList.isEmpty()){
                    
                        CustomerRecover customerRecover = customerRecoverList.get(0);
                        
                        customerRecover.setCode(gencode);
                        customerRecover.setUpdateDate(new SimpleDateFormat("yyyy-Mm-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date())));
                        
                        session.update(customerRecover);
                        transaction.commit();
                    
                }else{
                    POJOs.CustomerRecover customerRecover = new POJOs.CustomerRecover();
                    customerRecover.setCode(gencode);
                    customerRecover.setCustomer(customer);
                    customerRecover.setUpdateDate(new SimpleDateFormat("yyyy-Mm-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date())));
                    
                    session.save(customerRecover);
                    
                    transaction.commit();
                }
                
                response.sendRedirect("EmailSendingServlet?recipient="+customer.getEmail()+"&content="+gencode);
                
            }else if(new classess.tools().checkSupplierExist(email)){
                double code =Math.floor(Math.random()*999)+1000;
                String gen=code+"";
                String gencode =gen.substring(0, 4);
                POJOs.Supplier Supplier =new classess.tools().getSupplier(email);
                
                Criteria getRecoverSupplierCriteria = session.createCriteria(POJOs.SupplierRecover.class);
                getRecoverSupplierCriteria.add(Restrictions.eq("supplier", Supplier));
                
                List<POJOs.SupplierRecover> supplierRecoverList = getRecoverSupplierCriteria.list();
                if(!supplierRecoverList.isEmpty()){
                    
                        SupplierRecover supplierRecover = supplierRecoverList.get(0);
                        
                        supplierRecover.setCode(gencode);
                        supplierRecover.setUpdateDate(new SimpleDateFormat("yyyy-Mm-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date())));
                        
                        session.update(supplierRecover);
                        transaction.commit();
                    
                }else{
                    POJOs.SupplierRecover supplierRecover = new POJOs.SupplierRecover();
                    supplierRecover.setCode(gencode);
                    supplierRecover.setSupplier(Supplier);
                    supplierRecover.setUpdateDate(new SimpleDateFormat("yyyy-Mm-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date())));
                    
                    session.save(supplierRecover);
                    
                    transaction.commit();
                }
                
                response.sendRedirect("EmailSendingServlet?recipient="+Supplier.getEmail()+"&content="+gencode);
            }else{
                response.sendRedirect("EmailRecover.jsp?msg=Email Doesn't Exists !");
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
