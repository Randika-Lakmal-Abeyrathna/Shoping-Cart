/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classess;


import POJOs.SubCategory;
import POJOs.TopCategory;
import java.util.HashMap;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Randika Lakmal
 */
public class getProductSubDetails {

  

    public HashMap getTopCategory() {
        Session session = new classess.sessionConnect().testConnection();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();

        try {
            Criteria getTopCriteria = session.createCriteria(POJOs.TopCategory.class);

            List<POJOs.TopCategory> topCategoryList = getTopCriteria.list();

            if (!topCategoryList.isEmpty()) {
                for (int i = 0; i < topCategoryList.size(); i++) {
                    TopCategory topCategory = topCategoryList.get(i);

                    hashMap.put(i + "", topCategory);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return hashMap;
        }
    }

    public HashMap getSubcategory() {
        Session session = new classess.sessionConnect().testConnection();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();

        try {
            Criteria getSubCategoryCriteria = session.createCriteria(POJOs.SubCategory.class);

            List<POJOs.SubCategory> subCategoryList = getSubCategoryCriteria.list();

            if (!subCategoryList.isEmpty()) {
                for (int i = 0; i < subCategoryList.size(); i++) {
                    SubCategory subCategory = subCategoryList.get(i);

                    hashMap.put(i + "", subCategory);

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return hashMap;

        }

    }

    public String getSellingPrice(String value) {

        Session session = new classess.sessionConnect().testConnection();
        Criteria criteria = session.createCriteria(POJOs.CommisionRate.class);
        POJOs.CommisionRate commisionRate = (POJOs.CommisionRate) criteria.uniqueResult();
        double rate = commisionRate.getCommision();

        double price = Double.valueOf(value);

        double sellingPrice = price + (price * (rate / 100));
        System.out.println(sellingPrice);
        return sellingPrice + "";
    }

    // Get product status
    public POJOs.ProductStatus getActiveProductStatus() {

        Session session = new classess.sessionConnect().testConnection();

        Criteria getActive = session.createCriteria(POJOs.ProductStatus.class);
        getActive.add(Restrictions.eq("productStatus", "active"));
        POJOs.ProductStatus activeProductStatus =(POJOs.ProductStatus) getActive.uniqueResult();
        
        return activeProductStatus;

    }
    
    
    public POJOs.ProductStatus getDeactiveProductStatus() {

        Session session = new classess.sessionConnect().testConnection();

        Criteria getDeactive = session.createCriteria(POJOs.ProductStatus.class);
        getDeactive.add(Restrictions.eq("productStatus", "deactive"));
        POJOs.ProductStatus deactiveProductStatus =(POJOs.ProductStatus) getDeactive.uniqueResult();
        
        return deactiveProductStatus;

    }
}
