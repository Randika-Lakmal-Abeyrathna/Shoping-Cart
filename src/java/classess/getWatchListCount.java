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
public class getWatchListCount {
    
    
    public String getCount(POJOs.Customer customer) {
    
        int count=0;
        
        Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
        
        try {
            Criteria getCountCriteria= session.createCriteria(POJOs.WatchList.class);
            getCountCriteria.add(Restrictions.eq("customer", customer));
            
            List<POJOs.WatchList> getList = getCountCriteria.list();
            
            if (!getList.isEmpty()) {
                for (int i = 0; i < getList.size(); i++) {
                   WatchList watchList = getList.get(i);
                    POJOs.Product product = watchList.getProduct();
                    
                    String status = product.getProductStatus().getProductStatus();
                    
                    if(status.equals("active")){
                        count++;
                    }
                    
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


