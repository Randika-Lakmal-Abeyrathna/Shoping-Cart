/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import POJOs.Deliver;
import POJOs.InvoiceItems;
import POJOs.ProductHasCartDetails;
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
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
@WebServlet(name = "chekout", urlPatterns = {"/chekout"})
public class chekout extends HttpServlet {

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
            if (request.getParameter("byuitnow") == null) {
                Transaction transaction = session.beginTransaction();
                String paymentType, addressno, street1, street2, city, customerName;

                paymentType = "Credit Card ";
                POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");
                addressno = request.getParameter("addno");
                street1 = request.getParameter("st1");
                street2 = request.getParameter("st2");
                city = request.getParameter("city");
                customerName = request.getParameter("name");

                Criteria getCustomerCartCriteria = session.createCriteria(POJOs.CartDetails.class);
                getCustomerCartCriteria.add(Restrictions.eq("customer", customer));

                POJOs.CartDetails cartDetail = (POJOs.CartDetails) getCustomerCartCriteria.uniqueResult();

                Session s = POJOs.session_pool_manager.getSessionFactory().openSession();

                Criteria getItemCriteria = s.createCriteria(POJOs.ProductHasCartDetails.class);
                getItemCriteria.add(Restrictions.eq("cartDetails", cartDetail));
                getItemCriteria.add(Restrictions.eq("status", new classess.tools().getActiveStatus()));

                List<POJOs.ProductHasCartDetails> productHasCartDetailseList = getItemCriteria.list();

                ////// Save Invoice /////////////
                String invoiceId = "INV" + System.currentTimeMillis();

                POJOs.Invoice invoice = new POJOs.Invoice();

                invoice.setCustomer(customer);
                invoice.setInvoiceNo(invoiceId);
                invoice.setSystemDate(new classess.tools().saveDate());
                invoice.setShipingDetails(new classess.tools().getShippingDetails(city));

                session.save(invoice);

                transaction.commit();

                int numberOfItems = 0;
                double GrandTotal = 0;
                if (!productHasCartDetailseList.isEmpty()) {
                    for (int i = 0; i < productHasCartDetailseList.size(); i++) {
                        Session session2 = POJOs.session_pool_manager.getSessionFactory().openSession();
                        Transaction transaction2 = session2.beginTransaction();

                        Transaction t = s.beginTransaction();
                        ProductHasCartDetails productHasCartDetails = productHasCartDetailseList.get(i);
                        POJOs.Product product1 = productHasCartDetails.getProduct();
                        int id = product1.getIdproduct();

                        POJOs.Product product = (POJOs.Product) session2.load(POJOs.Product.class, id);

                        product.setSold(product.getSold() + productHasCartDetails.getQty());
                        product.setQty(product.getQty() - productHasCartDetails.getQty());

                        session2.update(product);

                        POJOs.InvoiceItems invoiceItems = new InvoiceItems();
                        invoiceItems.setProduct(product);
                        invoiceItems.setInvoice(invoice);
                        invoiceItems.setQty(productHasCartDetails.getQty());

                        double sellierPrice = productHasCartDetails.getProduct().getPrice() * productHasCartDetails.getQty();
                        double profit = (productHasCartDetails.getProduct().getSellingPrice() * productHasCartDetails.getQty()) - sellierPrice;

                        double Total = sellierPrice + profit;

                        numberOfItems += productHasCartDetails.getQty();
                        GrandTotal += Total;

                        invoiceItems.setSellierProfit(sellierPrice);
                        invoiceItems.setProfit(profit);
                        invoiceItems.setAmount(Total);
                        invoiceItems.setPrice(Total);

                        session2.save(invoiceItems);

                        productHasCartDetails.setStatus(new classess.tools().getCheckOutStatus());
                        s.update(productHasCartDetails);
                        t.commit();

                        transaction2.commit();

                        session2.close();
                    }
                }

                Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                Transaction transaction1 = session1.beginTransaction();

                Criteria getShippingCost = session1.createCriteria(POJOs.ShipingDetails.class);
                getShippingCost.add(Restrictions.eq("city", city));

                POJOs.ShipingDetails shipingDetail = (POJOs.ShipingDetails) getShippingCost.uniqueResult();

                double shiping = shipingDetail.getCost();

                double shippingCost = shiping * numberOfItems;

                Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
                getInvoice.add(Restrictions.eq("invoiceNo", invoiceId));

                POJOs.Invoice invoice1 = (POJOs.Invoice) getInvoice.uniqueResult();

                invoice1.setBillCount(1);
                invoice1.setTotal(GrandTotal);
                invoice1.setTotalAmount(GrandTotal + shippingCost);
                invoice1.setShippingCost(shippingCost);
                invoice1.setPaymentType(paymentType);

                session1.update(invoice1);

                POJOs.Deliver deliver = new Deliver();

                deliver.setDeliverStatus(new classess.tools().getPendingDeliverStatus());
                deliver.setFirstName(customerName);
                deliver.setAddressNo(addressno);
                deliver.setAddressStreet(street1);
                deliver.setAddressStreet2(street2);
                deliver.setCity(city);
                deliver.setInvoice(invoice);

                session1.save(deliver);

                transaction1.commit();

                response.sendRedirect("invoice.jsp?id=" + invoiceId);
            } else {
                ///////////////////////////////////////////Buy It Now ////////////////////////
                Transaction transaction = session.beginTransaction();
                String paymentType, addressno, street1, street2, city, customerName, id, qty;

                paymentType = "Credit Card ";
                POJOs.Customer customer = (POJOs.Customer) request.getSession().getAttribute("username");
                addressno = request.getParameter("addno");
                street1 = request.getParameter("st1");
                street2 = request.getParameter("st2");
                city = request.getParameter("city");
                customerName = request.getParameter("name");
                id = request.getParameter("id");
                qty = request.getParameter("qty");

                Criteria getCustomerCartCriteria = session.createCriteria(POJOs.CartDetails.class);
                getCustomerCartCriteria.add(Restrictions.eq("customer", customer));

                POJOs.CartDetails cartDetail = (POJOs.CartDetails) getCustomerCartCriteria.uniqueResult();

                Session s = POJOs.session_pool_manager.getSessionFactory().openSession();

                ////// Save Invoice /////////////
                String invoiceId = "INV" + System.currentTimeMillis();

                POJOs.Invoice invoice = new POJOs.Invoice();

                invoice.setCustomer(customer);
                invoice.setInvoiceNo(invoiceId);
                invoice.setSystemDate(new classess.tools().saveDate());
                invoice.setShipingDetails(new classess.tools().getShippingDetails(city));

                session.save(invoice);

                transaction.commit();

                int numberOfItems = 0;
                double GrandTotal = 0;
                Session session2 = POJOs.session_pool_manager.getSessionFactory().openSession();
                Transaction transaction2 = session2.beginTransaction();

                Transaction t = s.beginTransaction();
                int quantiy = Integer.parseInt(qty);

                POJOs.Product product = (POJOs.Product) session2.load(POJOs.Product.class, Integer.parseInt(id));

                product.setSold(product.getSold() + quantiy);
                product.setQty(product.getQty() - quantiy);

                session2.update(product);

                POJOs.InvoiceItems invoiceItems = new InvoiceItems();
                invoiceItems.setProduct(product);
                invoiceItems.setInvoice(invoice);
                invoiceItems.setQty(quantiy);

                double sellierPrice = product.getPrice() * quantiy;
                double profit = (product.getPrice() * quantiy) - sellierPrice;

                double Total = sellierPrice + profit;

                numberOfItems += quantiy;
                GrandTotal += Total;

                invoiceItems.setSellierProfit(sellierPrice);
                invoiceItems.setProfit(profit);
                invoiceItems.setAmount(Total);
                invoiceItems.setPrice(Total);

                session2.save(invoiceItems);

                transaction2.commit();

                session2.close();

                Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
                Transaction transaction1 = session1.beginTransaction();

                Criteria getShippingCost = session1.createCriteria(POJOs.ShipingDetails.class);
                getShippingCost.add(Restrictions.eq("city", city));

                POJOs.ShipingDetails shipingDetail = (POJOs.ShipingDetails) getShippingCost.uniqueResult();

                double shiping = shipingDetail.getCost();

                double shippingCost = shiping * numberOfItems;

                Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
                getInvoice.add(Restrictions.eq("invoiceNo", invoiceId));

                POJOs.Invoice invoice1 = (POJOs.Invoice) getInvoice.uniqueResult();

                invoice1.setBillCount(1);
                invoice1.setTotal(GrandTotal);
                invoice1.setTotalAmount(GrandTotal + shippingCost);
                invoice1.setShippingCost(shippingCost);
                invoice1.setPaymentType(paymentType);

                session1.update(invoice1);

                POJOs.Deliver deliver = new Deliver();

                deliver.setDeliverStatus(new classess.tools().getPendingDeliverStatus());
                deliver.setFirstName(customerName);
                deliver.setAddressNo(addressno);
                deliver.setAddressStreet(street1);
                deliver.setAddressStreet2(street2);
                deliver.setCity(city);
                deliver.setInvoice(invoice);

                session1.save(deliver);

                transaction1.commit();

                response.sendRedirect("invoice.jsp?id=" + invoiceId);

            }
        } catch (Exception e) {
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
