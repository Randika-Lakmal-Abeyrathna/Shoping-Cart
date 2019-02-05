/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mvc;


import POJOs.SubCategory;
import POJOs.TopCategory;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Randika Lakmal
 */
public class saveSubProductDetails {
    
    public void saveCategory(String value){
        
        Session session = new classess.sessionConnect().testConnection();
        Transaction transaction = session.beginTransaction();
        
        POJOs.TopCategory topCategory = new TopCategory();
        
        topCategory.setTopCategory(value);
        
        session.save(topCategory);
        transaction.commit();
        session.close();
        
    }
    
    public void saveSubCategory(String value){
        Session session = new classess.sessionConnect().testConnection();
        Transaction transaction = session.beginTransaction();
        
        POJOs.SubCategory subCategory = new SubCategory();
        
        subCategory.setSubCategory(value);
        
        session.save(subCategory);
        transaction.commit();
        session.close();

    }
    

    
}
