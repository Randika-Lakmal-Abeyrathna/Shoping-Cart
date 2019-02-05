
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc;

import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author randika
 */
public class login {

    private Session session;
    private Transaction transaction;

    public login() {
        session = new classess.sessionConnect().testConnection();

    }

//    public String checkLogin(final String userName, final String Password) {
//
//        // Get Status
//        Criteria getStatus = session.createCriteria(POJOs.Status.class);
//        getStatus.add(Restrictions.eq("status", "active"));
//        
//        POJOs.Status  status = (POJOs.Status) getStatus.uniqueResult();
//        
//        // Get Status
//        
//        Criteria checkUserEmail = session.createCriteria(POJOs.Customer.class);
//        checkUserEmail.add(Restrictions.eq("email", userName));
//        checkUserEmail.add(Restrictions.eq("status", status));
//
//        List<POJOs.Customer> customerDetailsList = checkUserEmail.list();
//
//        // Check Customer Has This Email
//        if (!customerDetailsList.isEmpty()) {
//            for (int i = 0; i < customerDetailsList.size(); i++) {
//                Customer customer = customerDetailsList.get(i);
//                return checkUser("customer", customer, Password);
//
//            }
//        } else {
//            // Check Supplier Has This Email
//            Criteria checkUserEmailInSupplier = session.createCriteria(POJOs.Supplier.class);
//            checkUserEmailInSupplier.add(Restrictions.eq("email", userName));
//            checkUserEmail.add(Restrictions.eq("status", status));
//
//            List<POJOs.Supplier> supplierDetailsList = checkUserEmailInSupplier.list();
//
//            if (!supplierDetailsList.isEmpty()) {
//                for (int i = 0; i < supplierDetailsList.size(); i++) {
//                    Supplier supplier = supplierDetailsList.get(i);
//                    return checkUser("supplier", supplier, Password);
//                }
//            } else {
//                // No one Has the Email. Involid Email
//                return "Involid Email";
//            }
//        }
//        return null;
//
//    }

//    private String checkUser(final String type, Object object, String password) {
//
//        if (type.equals("customer")) {
//
//            Customer customer = (Customer) object;
//
//            Criteria checkUserCriteria = session.createCriteria(POJOs.UserLogin.class);
//            checkUserCriteria.add(Restrictions.eq("customer", customer));
//
//            POJOs.UserLogin userLogin = (POJOs.UserLogin) checkUserCriteria.uniqueResult();
//
//            if (userLogin.getPassword().equals(password)) {
//
//                return "succcess customer";
//
//            } else {
//                return "Involid password";
//            }
//
//        } else if (type.equals("supplier")) {
//
//            Supplier supplier = (Supplier) object;
//
//            Criteria checkUserCriteria = session.createCriteria(POJOs.UserLogin.class);
//            checkUserCriteria.add(Restrictions.eq("supplier", supplier));
//
//            POJOs.UserLogin userLogin = (POJOs.UserLogin) checkUserCriteria.uniqueResult();
//
//            if (userLogin.getPassword().equals(password)) {
//                return "succcess supplier";
//            } else {
//                return "Involid password";
//            }
//        }
//
//        return null;
//    }

}
