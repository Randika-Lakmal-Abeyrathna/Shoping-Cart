/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package classess;

import POJOs.WatchList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
public class getSavedItems {
    
    public String getLaterCount(POJOs.Customer customer) {
    
        int count=0;
        
        Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
        
        try {
            Criteria criteria = session.createCriteria(POJOs.CartDetails.class);
            criteria.add(Restrictions.eq("customer", customer));
            
            POJOs.CartDetails cartDetails = (POJOs.CartDetails)criteria.uniqueResult();
            
            Criteria getCountCriteria= session.createCriteria(POJOs.ProductHasCartDetails.class);
            getCountCriteria.add(Restrictions.eq("cartDetails", cartDetails));
            getCountCriteria.add(Restrictions.eq("status", new classess.tools().getLaterStatus()));
            
            
            List<POJOs.WatchList> getList = getCountCriteria.list();
            
            if (!getList.isEmpty()) {
                for (int i = 0; i < getList.size(); i++) {
                    
                        count++;
                    
                    
                }
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            session.close();
            return count+"";
        }
    }
    
}
