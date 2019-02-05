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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "adminLogin", urlPatterns = {"/adminLogin"})
public class adminLogin extends HttpServlet {

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

            String userName = request.getParameter("userName");
            String password = request.getParameter("password");
            String remember = request.getParameter("remember");

            Criteria getDetails = session.createCriteria(POJOs.AdminDetails.class);
            getDetails.add(Restrictions.eq("username", userName));
            getDetails.add(Restrictions.eq("password", password));

            POJOs.AdminDetails adminDetails = (POJOs.AdminDetails) getDetails.uniqueResult();
            List<POJOs.AdminDetails> adminList = getDetails.list();

            if (!adminList.isEmpty()) {
                if (remember != null) {
                    if (remember.equals("on")) {
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("admin", adminDetails);
                        System.out.println("in on");
                        // Add Cookie
                        Cookie cookie = new Cookie("admin", userName);
                        cookie.setMaxAge(60 * 60 * 24 * 30);
                        response.addCookie(cookie);
                        System.out.println("cookie");
                        response.sendRedirect("AdminHome.jsp");
                    } else {
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("admin", adminDetails);
                        System.out.println("on else");
                        response.sendRedirect("AdminHome.jsp");
                    }

                } else {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("admin", adminDetails);
                    System.out.println("else");
                    response.sendRedirect("AdminHome.jsp");
                }
            } else {
                response.sendRedirect("Admin_Login.jsp?msg=User Name or Password Incorrect");
            }

        } catch (Exception e) {
            e.printStackTrace();
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
