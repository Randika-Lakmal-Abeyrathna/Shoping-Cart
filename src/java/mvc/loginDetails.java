/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc;

import POJOs.SupplierLogin;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
public class loginDetails {

    // Check User Password
    public boolean checkUserPassword(String userEmail, String password) {

        boolean flag = false;

        Session session = new classess.sessionConnect().testConnection();
        System.out.println(userEmail);
        System.out.println(password);
        try {
            System.out.println(userEmail);
            System.out.println(password);
            Criteria checkPasswordCriteria = session.createCriteria(POJOs.CustomerLogin.class);
            checkPasswordCriteria.add(Restrictions.eq("customer", new classess.tools().getCustomer(userEmail)));
            checkPasswordCriteria.add(Restrictions.eq("password", password));

            List<POJOs.CustomerLogin> customerLoginList = checkPasswordCriteria.list();

            if (!customerLoginList.isEmpty()) {
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return flag;
        }

    }

    // Check Supplier Password
    public boolean checkSupplirPassword(String supplierEmail, String password) {
        boolean flag = false;
        Session session = new classess.sessionConnect().testConnection();
        try {

            Criteria checkPasswordCriteria = session.createCriteria(POJOs.SupplierLogin.class);
            checkPasswordCriteria.add(Restrictions.eq("supplier", new classess.tools().getSupplier(supplierEmail)));
            checkPasswordCriteria.add(Restrictions.eq("password", password));

            List<SupplierLogin> supplierLoginlList = checkPasswordCriteria.list();

            if (!supplierLoginlList.isEmpty()) {
                flag = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return flag;
        }

    }

}
