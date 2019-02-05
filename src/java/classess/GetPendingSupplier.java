/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classess;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
public class GetPendingSupplier {

    public int getPendingSupplierCount() {
        int count = 0;
        Session session2 = POJOs.session_pool_manager.getSessionFactory().openSession();

        Criteria pendingSuppliersCriteria = session2.createCriteria(POJOs.Supplier.class);
        pendingSuppliersCriteria.add(Restrictions.eq("status", new classess.tools().getPendingStatus()));

        List<POJOs.Supplier> suppliers = pendingSuppliersCriteria.list();

        if (!suppliers.isEmpty()) {

            for (int j = 0; j < suppliers.size(); j++) {
                count++;

            }

        }
        
        return count;

    }

}
