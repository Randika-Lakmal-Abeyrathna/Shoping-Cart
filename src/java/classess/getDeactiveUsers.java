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
public class getDeactiveUsers {
    public int getActive(){
    
        int count=0;
        
        Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
        
        Criteria criteria = session.createCriteria(POJOs.Customer.class);
        criteria.add(Restrictions.eq("status", new classess.tools().getDeactiveStatus()));
        
        List<POJOs.Customer> customers =criteria.list();
        
        if(!customers.isEmpty()){
            for (int i = 0; i < customers.size(); i++) {
                count++;
            }
        }
        
    return count;
    }
}
