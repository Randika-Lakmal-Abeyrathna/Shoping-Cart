/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package classess;

import POJOs.Customer;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;

/**
 *
 * @author Randika Lakmal
 */
public class totalUsers {
    
    public int getUserCount(){
        Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
        int count=0;
        try {
            Criteria criteria = session.createCriteria(POJOs.Customer.class);
            
            List<POJOs.Customer> customers=criteria.list();
            
            for (int i = 0; i < customers.size(); i++) {
                count++;
                
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            session.close();
            return count;
        }
    }
}
