/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import POJOs.CategoryDetails;
import POJOs.Product;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.DefaultFileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author randika
 */
@WebServlet(name = "product_registration", urlPatterns = {"/product_registration"})
public class product_registration extends HttpServlet {

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
        Session session = new classess.sessionConnect().testConnection();

        Transaction transaction = session.beginTransaction();

        try {

            String productName, Qty, price, description, category = "", subCategory = "", username, brand;
            double sellingPrice = 0;
            String path = "product_img/";

            DiskFileItemFactory dfif = new DefaultFileItemFactory();
            ServletFileUpload fileUpload = new ServletFileUpload(dfif);
            List<FileItem> list = fileUpload.parseRequest(request);

            POJOs.Product product = new Product();

            for (FileItem fileItem : list) {

                if (fileItem.isFormField()) {

                    if (fileItem.getFieldName().equals("productname")) {
                        productName = fileItem.getString();
                        product.setProductName(productName);

                    } else if (fileItem.getFieldName().equals("quantity")) {
                        Qty = fileItem.getString();
                        product.setQty(Integer.parseInt(Qty));

                    } else if (fileItem.getFieldName().equals("price")) {
                        price = fileItem.getString();
                        sellingPrice = new classess.tools().setSellingPrice(price);

                        product.setPrice(Double.parseDouble(price));
                        product.setSellingPrice(sellingPrice);

                    } else if (fileItem.getFieldName().equals("description")) {
                        description = fileItem.getString();
                        product.setDeiscription(description);
                    } else if (fileItem.getFieldName().equals("category")) {
                        category = fileItem.getString();

                    } else if (fileItem.getFieldName().equals("subcategory")) {
                        subCategory = fileItem.getString();

                    } else if (fileItem.getFieldName().equals("username")) {
                        username = fileItem.getString();
                        product.setSupplier(new classess.tools().getSupplier(username));
                    }

                } else {

                    if (session.isOpen()) {
                        product.setProductStatus(new classess.getProductSubDetails().getActiveProductStatus());
                        product.setSystemDate(new classess.tools().saveDate());
                        product.setSold(0);

                        session.save(product);

                        POJOs.CategoryDetails categoryDetails = new CategoryDetails();

                        categoryDetails.setProduct(product);
                        categoryDetails.setSubCategory(new classess.tools().getSubCategory(subCategory));
                        categoryDetails.setTopCategory(new classess.tools().getTopCategory(category));

                        session.save(categoryDetails);

                        transaction.commit();
                        session.close();
                    }

//                Image
                    Session imgsession = new classess.sessionConnect().testConnection();
                    Transaction imgTransaction = imgsession.beginTransaction();

                    path += System.currentTimeMillis() + fileItem.getName();
                    String setPath = "product_img/" + System.currentTimeMillis() + fileItem.getName();
                    File SaveFile = new File(request.getServletContext().getRealPath("") + "/" + setPath);
                    fileItem.write(SaveFile);

                    POJOs.ProductImage productImage = new POJOs.ProductImage();
                    productImage.setProduct(product);
                    productImage.setProductImagePath(setPath);

                    imgsession.save(productImage);
                    imgTransaction.commit();
                    imgsession.close();
                }
            }
            response.sendRedirect("Product_Registeration.jsp?msg=Successfully Saved !");
        } catch (Exception e) {

            e.printStackTrace();
            response.sendRedirect("Product_Registeration.jsp?msg=Error in Saving Details !");
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
