/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import POJOs.CategoryDetails;
import POJOs.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "pagination", urlPatterns = {"/pagination"})
public class pagination extends HttpServlet {

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

            if (request.getParameter("msg") == null) {

                Criteria getProductsCriteria = session.createCriteria(POJOs.Product.class);
                getProductsCriteria.addOrder(Order.desc("systemDate"));
                getProductsCriteria.add(Restrictions.eq("productStatus", new classess.getProductSubDetails().getActiveProductStatus()));

                List<POJOs.Product> productList = getProductsCriteria.list();

                Vector v = new Vector();
                if (!productList.isEmpty()) {
                    for (int i = 0; i < productList.size(); i++) {
                        Product product = productList.get(i);

                        HashMap<String, Object> hm = new HashMap<String, Object>();

                        hm.put("product", product);

                        v.add(hm);
                    }

                }

                request.getSession().setAttribute("items", v);
                session.close();
                response.sendRedirect("Home.jsp?p=1");

            } else if (request.getParameter("msg").equals("search")) {

                String top = request.getParameter("top");
                String sub = request.getParameter("sub");
                String min = request.getParameter("min");
                String max = request.getParameter("max");

                double minPrice = Double.parseDouble(min);
                double maxPrice = Double.parseDouble(max);

                if (minPrice == 0 & maxPrice == 0) {
                    Criteria getProductsCriteria = session.createCriteria(POJOs.Product.class);
                    getProductsCriteria.add(Restrictions.eq("productStatus", new classess.getProductSubDetails().getActiveProductStatus()));
                    List<POJOs.Product> productList = getProductsCriteria.list();

                    Vector v = new Vector();
                    if (!productList.isEmpty()) {
                        for (int i = 0; i < productList.size(); i++) {
                            Product product = productList.get(i);

                            HashMap<String, Object> hm = new HashMap<String, Object>();

                            hm.put("product", product);

                            v.add(hm);
                        }

                    }

                    request.getSession().setAttribute("items", v);
                    session.close();
                    response.sendRedirect("Home.jsp?p=1");

                } else if (minPrice == 0 & maxPrice > 0) {

                    Criteria getProductsCriteria = session.createCriteria(POJOs.Product.class);
                    getProductsCriteria.add(Restrictions.between("sellingPrice", minPrice, maxPrice));
                    getProductsCriteria.add(Restrictions.eq("productStatus", new classess.getProductSubDetails().getActiveProductStatus()));
                    List<POJOs.Product> productList = getProductsCriteria.list();

                    Vector v = new Vector();
                    if (!productList.isEmpty()) {
                        for (int i = 0; i < productList.size(); i++) {
                            Product product = productList.get(i);

                            HashMap<String, Object> hm = new HashMap<String, Object>();

                            hm.put("product", product);

                            v.add(hm);
                        }

                    }

                    request.getSession().setAttribute("items", v);
                    session.close();
                    response.sendRedirect("Home.jsp?p=1");

                } else if (minPrice > 0 & maxPrice == 0) {
                    Criteria getProductsCriteria = session.createCriteria(POJOs.Product.class);
                    getProductsCriteria.add(Restrictions.between("sellingPrice", maxPrice, minPrice));
                    getProductsCriteria.add(Restrictions.eq("productStatus", new classess.getProductSubDetails().getActiveProductStatus()));
                    List<POJOs.Product> productList = getProductsCriteria.list();

                    Vector v = new Vector();
                    if (!productList.isEmpty()) {
                        for (int i = 0; i < productList.size(); i++) {
                            Product product = productList.get(i);

                            HashMap<String, Object> hm = new HashMap<String, Object>();

                            hm.put("product", product);

                            v.add(hm);
                        }

                    }

                    request.getSession().setAttribute("items", v);
                    session.close();
                    response.sendRedirect("Home.jsp?p=1");
                } else if (minPrice > maxPrice) {
                   Criteria getProductsCriteria = session.createCriteria(POJOs.Product.class);
                    getProductsCriteria.add(Restrictions.between("sellingPrice", maxPrice, minPrice));
                    getProductsCriteria.add(Restrictions.eq("productStatus", new classess.getProductSubDetails().getActiveProductStatus()));
                    List<POJOs.Product> productList = getProductsCriteria.list();

                    Vector v = new Vector();
                    if (!productList.isEmpty()) {
                        for (int i = 0; i < productList.size(); i++) {
                            Product product = productList.get(i);

                            HashMap<String, Object> hm = new HashMap<String, Object>();

                            hm.put("product", product);

                            v.add(hm);
                        }

                    }

                    request.getSession().setAttribute("items", v);
                    session.close();
                    response.sendRedirect("Home.jsp?p=1");

                } else if (minPrice <= maxPrice) {
                    Criteria getProductsCriteria = session.createCriteria(POJOs.Product.class);
                    getProductsCriteria.add(Restrictions.between("sellingPrice", minPrice, maxPrice));
                    getProductsCriteria.add(Restrictions.eq("productStatus", new classess.getProductSubDetails().getActiveProductStatus()));
                    List<POJOs.Product> productList = getProductsCriteria.list();

                    Vector v = new Vector();
                    if (!productList.isEmpty()) {
                        for (int i = 0; i < productList.size(); i++) {
                            Product product = productList.get(i);

                            HashMap<String, Object> hm = new HashMap<String, Object>();

                            hm.put("product", product);

                            v.add(hm);
                        }

                    }

                    request.getSession().setAttribute("items", v);
                    session.close();
                    response.sendRedirect("Home.jsp?p=1");

                } else {
                    response.sendRedirect("Home.jsp");
                }

            }else if(request.getParameter("msg").equals("top")){
            
                String value=request.getParameter("id");
                
                Criteria getTop = session.createCriteria(POJOs.CategoryDetails.class);
                getTop.add(Restrictions.eq("topCategory", session.createCriteria(POJOs.TopCategory.class).add(Restrictions.eq("topCategory", value)).uniqueResult()));
                
                List<POJOs.CategoryDetails> categoryDetailses = getTop.list();
                Vector v = new Vector();
                if(!categoryDetailses.isEmpty()){
                
                        for (int i = 0; i < categoryDetailses.size(); i++) {
                        CategoryDetails categoryDetails = categoryDetailses.get(i);
                        
                        POJOs.Product product =categoryDetails.getProduct();
                        
                        String status = product.getProductStatus().getProductStatus();
                        
                        if(status.equals("active")){
                            HashMap<String, Object> hm = new HashMap<String, Object>();

                        hm.put("product", product);

                        v.add(hm);
                        
                        }
                        
                    }
                }
                request.getSession().setAttribute("items", v);
                session.close();
                response.sendRedirect("Home.jsp?p=1");
                
            }else if(request.getParameter("msg").equals("sub")){
            
                String value=request.getParameter("id");
                
                Criteria getTop = session.createCriteria(POJOs.CategoryDetails.class);
                getTop.add(Restrictions.eq("subCategory", session.createCriteria(POJOs.SubCategory.class).add(Restrictions.eq("subCategory", value)).uniqueResult()));
                
                List<POJOs.CategoryDetails> categoryDetailses = getTop.list();
                Vector v = new Vector();
                if(!categoryDetailses.isEmpty()){
                
                        for (int i = 0; i < categoryDetailses.size(); i++) {
                        CategoryDetails categoryDetails = categoryDetailses.get(i);
                        
                        POJOs.Product product =categoryDetails.getProduct();
                        
                        String status = product.getProductStatus().getProductStatus();
                        
                        if(status.equals("active")){
                            HashMap<String, Object> hm = new HashMap<String, Object>();

                        hm.put("product", product);

                        v.add(hm);
                        
                        }
                        
                    }
                }
                request.getSession().setAttribute("items", v);
                session.close();
                response.sendRedirect("Home.jsp?p=1");
                
            }

        } catch (Exception e) {
            e.printStackTrace();
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
