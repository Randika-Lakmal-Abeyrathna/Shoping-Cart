/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classess;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
public class getNewOrder {

    public String getNewOrderCount(POJOs.Supplier supplier) {
        String value = "";
        try {
            int count = 0;
            Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();

            Criteria getDiliver = session1.createCriteria(POJOs.Deliver.class);
            getDiliver.add(Restrictions.eq("deliverStatus", new classess.tools().getPendingDeliverStatus()));

            List<POJOs.Deliver> deliverList = getDiliver.list();

            if (!deliverList.isEmpty()) {
                for (int i = 0; i < deliverList.size(); i++) {

                    POJOs.Deliver deliver = deliverList.get(i);

                    Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
                    getInvoice.add(Restrictions.eq("idinvoice", deliver.getInvoice().getIdinvoice()));
                    getInvoice.addOrder(Order.desc("systemDate"));

                    List<POJOs.Invoice> invoiceList = getInvoice.list();

                    if (!invoiceList.isEmpty()) {

                        for (int x = 0; x < invoiceList.size(); x++) {

                            POJOs.Invoice invoice = invoiceList.get(x);

                            Criteria getInvoiceItems = session1.createCriteria(POJOs.InvoiceItems.class);
                            getInvoiceItems.add(Restrictions.eq("invoice", invoice));

                            List<POJOs.InvoiceItems> invoiceItemseList = getInvoiceItems.list();

                            if (!invoiceItemseList.isEmpty()) {

                                for (int j = 0; j < invoiceItemseList.size(); j++) {

                                    POJOs.InvoiceItems invoiceItems = invoiceItemseList.get(j);

                                    String email1 = supplier.getEmail();
                                    String email2 = invoiceItems.getProduct().getSupplier().getEmail();

                                    if (email1.equals(email2)) {
                                        count++;
                                    } else {

                                    }

                                }

                                

                            }

                        }

                    }

                }

            }
            value = count + "";
        } catch (Exception e) {
            e.printStackTrace();
        }

        return value;
    }

}
