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
public class AdminTotalIncome {

    public double getTotal() {

        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
        double Total = 0;
        try {
            Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
            getInvoice.addOrder(Order.desc("systemDate"));

            List<POJOs.Invoice> invoiceList = getInvoice.list();
            double TotalShipping = 0;
            double TotalProfit = 0;
            if (!invoiceList.isEmpty()) {
                for (int i = 0; i < invoiceList.size(); i++) {
                    POJOs.Invoice invoice = invoiceList.get(i);
                    TotalShipping += invoice.getShippingCost();
                    Criteria getItems = session1.createCriteria(POJOs.InvoiceItems.class);
                    getItems.add(Restrictions.eq("invoice", invoice));

                    List<POJOs.InvoiceItems> invoiceItemseList = getItems.list();

                    if (!invoiceItemseList.isEmpty()) {
                        for (int j = 0; j < invoiceItemseList.size(); j++) {

                            POJOs.InvoiceItems invoiceItems = invoiceItemseList.get(j);
                            TotalProfit += invoiceItems.getProfit();

                        }

                    }

                }

            }
            Total = TotalProfit + TotalShipping;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session1.close();
            return Total;
        }

    }

    public double getShiping() {

        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
        double TotalShipping = 0;
        try {
            Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
            getInvoice.addOrder(Order.desc("systemDate"));

            List<POJOs.Invoice> invoiceList = getInvoice.list();

            double TotalProfit = 0;
            if (!invoiceList.isEmpty()) {
                for (int i = 0; i < invoiceList.size(); i++) {
                    POJOs.Invoice invoice = invoiceList.get(i);
                    TotalShipping += invoice.getShippingCost();
                    Criteria getItems = session1.createCriteria(POJOs.InvoiceItems.class);
                    getItems.add(Restrictions.eq("invoice", invoice));

                    List<POJOs.InvoiceItems> invoiceItemseList = getItems.list();

                    if (!invoiceItemseList.isEmpty()) {
                        for (int j = 0; j < invoiceItemseList.size(); j++) {

                            POJOs.InvoiceItems invoiceItems = invoiceItemseList.get(j);
                            TotalProfit += invoiceItems.getProfit();

                        }

                    }

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session1.close();
            return TotalShipping;
        }

    }

    public double getProfit() {

        Session session1 = POJOs.session_pool_manager.getSessionFactory().openSession();
        double TotalShipping = 0;
        double TotalProfit = 0;
        try {
            Criteria getInvoice = session1.createCriteria(POJOs.Invoice.class);
            getInvoice.addOrder(Order.desc("systemDate"));

            List<POJOs.Invoice> invoiceList = getInvoice.list();

            if (!invoiceList.isEmpty()) {
                for (int i = 0; i < invoiceList.size(); i++) {
                    POJOs.Invoice invoice = invoiceList.get(i);
                    TotalShipping += invoice.getShippingCost();
                    Criteria getItems = session1.createCriteria(POJOs.InvoiceItems.class);
                    getItems.add(Restrictions.eq("invoice", invoice));

                    List<POJOs.InvoiceItems> invoiceItemseList = getItems.list();

                    if (!invoiceItemseList.isEmpty()) {
                        for (int j = 0; j < invoiceItemseList.size(); j++) {

                            POJOs.InvoiceItems invoiceItems = invoiceItemseList.get(j);
                            TotalProfit += invoiceItems.getProfit();

                        }

                    }

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session1.close();
            return TotalProfit;
        }

    }

}
