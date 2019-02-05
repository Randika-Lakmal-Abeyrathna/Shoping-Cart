/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package classess;

import POJOs.ShipingDetails;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
public class getShippingCost {
    
    public String getCost(String city){
    
        String cost ="0";
        Session session =POJOs.session_pool_manager.getSessionFactory().openSession();
        try {
            Criteria getCostCriteria = session.createCriteria(POJOs.ShipingDetails.class);
            getCostCriteria.add(Restrictions.eq("city", city));
            
            List<POJOs.ShipingDetails> shipingDetailseList = getCostCriteria.list();
            
            if(!shipingDetailseList.isEmpty()){
                for (int i = 0; i < shipingDetailseList.size(); i++) {
                    ShipingDetails shipingDetails = shipingDetailseList.get(i);
                    
                    cost =shipingDetails.getCost()+"";
                }
            }else{
                cost ="no";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
        session.close();
        return cost;
        }
        
    }
    
}
