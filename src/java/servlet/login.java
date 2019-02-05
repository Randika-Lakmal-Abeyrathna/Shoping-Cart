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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

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

            String remember = request.getParameter("remember");
            String userName = request.getParameter("userName");
            String password = request.getParameter("password");

            // Check If it's a Customer
            if (new classess.tools().checkUserExist(userName)) {
                // This is a Customer

                if (new mvc.loginDetails().checkUserPassword(userName, password)) {
                    POJOs.Customer customer = new classess.tools().getCustomer(userName);
                    if (remember != null) {
                        if (remember.equals("on")) {
                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("username", customer);

                            // Add Cookie
                            Cookie cookie = new Cookie("username", userName);
                            cookie.setMaxAge(60 * 60 * 24 * 30);
                            response.addCookie(cookie);

                            response.sendRedirect("Home.jsp");
                        } else {
                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("username", customer);
                            response.sendRedirect("Home.jsp");

                        }
                    } else {
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("username", customer);
                        response.sendRedirect("Home.jsp");
                    }

                } else {
                    response.sendRedirect("index.jsp?msg=Error in User Name Or Password");
                    // Incorrect Password
                }

            } else if (new classess.tools().checkSupplierExist(userName)) {
                // This is a Supplier
                if (new mvc.loginDetails().checkSupplirPassword(userName, password)) {

                    POJOs.Supplier supplier = new classess.tools().getSupplier(userName);
                    if (remember != null) {
                        if (remember.equals("on")) {
                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("username", supplier);

                            // Add Cookie
                            Cookie cookie = new Cookie("username", userName);
                            cookie.setMaxAge(60 * 60 * 24 * 30);
                            response.addCookie(cookie);

                            response.sendRedirect("Supplier_Main_Home.jsp");
                        } else {
                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("username", supplier);

                            response.sendRedirect("Supplier_Main_Home.jsp");

                        }
                    } else {
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("username", supplier);
                        response.sendRedirect("Supplier_Main_Home.jsp");
                    }

                } else {
                    response.sendRedirect("index.jsp?msg=Error in User Name Or Password");
                    //Incorrect Password
                }

            } else {
                response.sendRedirect("index.jsp?msg=Error in User Name Or Password");
                // User not Exsits. Send error message
            }

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
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
