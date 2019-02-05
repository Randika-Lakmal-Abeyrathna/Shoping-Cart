/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import POJOs.Supplier;
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

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "getSuppliers", urlPatterns = {"/getSuppliers"})
public class getSuppliers extends HttpServlet {

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
            
            String type = request.getParameter("value");
            
            if(type.equals("All")){
            Criteria allCriteria = session.createCriteria(POJOs.Supplier.class);
            
                List<POJOs.Supplier> suppliers = allCriteria.list();
                
                if(!suppliers.isEmpty()){
                
                    String result ="<tabel class=\"table table-condensed\" >\n" +
"                    <thead>\n" +
"                    <th>#</th>\n" +
"                    <th>Company Reg #</th>\n" +
"                    <th>Company Name</th>\n" +
"                    <th>Owner Name</th>\n" +
"                    <th>Owner Contact</th>\n" +
"                    <th>Email</th>\n" +
"                    <th>Status</th>\n" +
"                    <th></th>\n" +
"                    </thead><tbody>";
                    
                    for (int i = 0; i < suppliers.size(); i++) {
                        result +="<tr>";
                        Supplier supplier = suppliers.get(i);
                        
                       result +="<td>"+ (i+1)+"</td>"
                                + "<td>"+supplier.getCompanyRegNumber()+"</td>"
                                + "<td>"+supplier.getCompanyName()+"</td>"
                                + "<td>"+supplier.getSupplierName()+"</td>"
                                + "<td>"+supplier.getOwnerContactno() +"</td>"
                                + "<td>"+supplier.getEmail()+"</td>"
                                + "<td>"+supplier.getStatus().getStatus() +"</td>"; 
                       
                        if(supplier.getStatus().getStatus().equals("active")){
                            result +=" <button  href=\"cutomerActive?id="+supplier.getEmail()+"\" disabled class=\"btn btn-primary\">Active</button>>\n" +
"                    <button href=\"cutomerDeactive?id=\" class=\"btn btn-danger \">Deactive</button>";
                        }else{
                            result +=" <button  href=\"cutomerActive?id="+supplier.getEmail()+"\"  class=\"btn btn-primary\">Active</button>>\n" +
"                    <button href=\"cutomerDeactive?id=\" disabled class=\"btn btn-danger \">Deactive</button>";
                        }
                        
                        
                        result +="</tr>";
                    }
                    result +=" </tbody>\n" +
"                </tabel>";
                    
                    out.write(result);
                    out.flush();
                }
            }
                        
        } catch (Exception e) {
            throw new ServletException(e);
        }finally{
            
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
