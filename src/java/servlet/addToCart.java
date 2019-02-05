/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import POJOs.ProductHasCartDetails;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "addToCart", urlPatterns = {"/addToCart"})
public class addToCart extends HttpServlet {

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

            Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
            Transaction transaction = session.beginTransaction();

            String qty = request.getParameter("qty");
            String productID = request.getParameter("pid");

            POJOs.Product product = (POJOs.Product) session.load(POJOs.Product.class, Integer.parseInt(productID));

            Criteria getCartDetails = session.createCriteria(POJOs.CartDetails.class);
            getCartDetails.add(Restrictions.eq("customer", (POJOs.Customer) request.getSession().getAttribute("username")));

            POJOs.CartDetails cartDetail = (POJOs.CartDetails) getCartDetails.uniqueResult();

            if (cartDetail != null) {

                Criteria getItemsCriteria = session.createCriteria(POJOs.ProductHasCartDetails.class);
                getItemsCriteria.add(Restrictions.eq("cartDetails", cartDetail));
                getItemsCriteria.add(Restrictions.eq("product", product));
                getItemsCriteria.add(Restrictions.eq("status", new classess.tools().getActiveStatus()));

                POJOs.ProductHasCartDetails productHasCartDetails = (POJOs.ProductHasCartDetails) getItemsCriteria.uniqueResult();

                if (productHasCartDetails != null) {

                    int amount = productHasCartDetails.getQty() + Integer.parseInt(qty);

                    productHasCartDetails.setQty(amount);

                    productHasCartDetails.setSystemDate(new classess.tools().saveDate());

                    session.update(productHasCartDetails);

                    int availabelQTY = product.getQty() - Integer.parseInt(qty);

                    //product.setQty(availabelQTY);

                    if (availabelQTY == 0) {
                        product.setProductStatus(new classess.getProductSubDetails().getDeactiveProductStatus());
                    }

                    session.update(product);

                    transaction.commit();

                } else {
                    productHasCartDetails = new POJOs.ProductHasCartDetails();

                    productHasCartDetails.setCartDetails(cartDetail);
                    productHasCartDetails.setProduct(product);
                    productHasCartDetails.setStatus(new classess.tools().getActiveStatus());
                    productHasCartDetails.setQty(Integer.parseInt(qty));
                    productHasCartDetails.setSystemDate(new classess.tools().saveDate());

                    session.save(productHasCartDetails);

                    int availabelQTY = product.getQty() - Integer.parseInt(qty);

                    product.setQty(availabelQTY);

                    if (availabelQTY == 0) {
                        product.setProductStatus(new classess.getProductSubDetails().getDeactiveProductStatus());
                    }

                    session.update(product);

                    transaction.commit();

                }

            } else {
                cartDetail = new POJOs.CartDetails();
                cartDetail.setCustomer((POJOs.Customer) request.getSession().getAttribute("username"));
                cartDetail.setSystemDate(new classess.tools().saveDate());

                session.save(cartDetail);

                POJOs.ProductHasCartDetails details = new ProductHasCartDetails();

                details.setCartDetails(cartDetail);
                details.setProduct(product);
                details.setStatus(new classess.tools().getActiveStatus());
                details.setQty(Integer.parseInt(qty));
                details.setSystemDate(new classess.tools().saveDate());

                session.save(details);

                int availabelQTY = product.getQty() - Integer.parseInt(qty);

                product.setQty(availabelQTY);

                if (availabelQTY == 0) {
                    product.setProductStatus(new classess.getProductSubDetails().getDeactiveProductStatus());
                }

                session.update(product);

                transaction.commit();

            }
            
            out.write(new classess.getCartCount().getCartCount((POJOs.Customer) request.getSession().getAttribute("username")));
            
            session.close();
            
            out.flush();
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
