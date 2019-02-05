/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classess;

import POJOs.City;
import POJOs.CommisionRate;
import POJOs.Customer;
import POJOs.DeliverStatus;
import POJOs.Gender;
import POJOs.Salutation;
import POJOs.Supplier;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author randika
 */
public class tools {

    private Session session;
    private Transaction transaction;

    // Constructor
    public tools() {

        session = POJOs.session_pool_manager.getSessionFactory().openSession();
        transaction = session.beginTransaction();
    }

    public POJOs.City saveCity(String cityValue) {
        City city = null;

        Criteria cityDetailsCriteria = session.createCriteria(POJOs.City.class);
        cityDetailsCriteria.add(Restrictions.eq("city", cityValue));

        List<POJOs.City> cityDataList = cityDetailsCriteria.list();

        if (!cityDataList.isEmpty()) {
            for (int i = 0; i < cityDataList.size(); i++) {
                city = cityDataList.get(i);
                return city;
            }
            return city;
        } else {

            city = new City();
            city.setCity(cityValue);

            session.save(city);
            transaction.commit();

            return city;

        }
    }

   
    public POJOs.Status getActiveStatus() {

        POJOs.Status status = null;

        Criteria activeStatusCriteria = session.createCriteria(POJOs.Status.class);
        activeStatusCriteria.add(Restrictions.eq("status", "active"));

        List<POJOs.Status> statusList = activeStatusCriteria.list();

        if (!statusList.isEmpty()) {

            for (int i = 0; i < statusList.size(); i++) {
                status = statusList.get(i);

            }
            return status;
        } else {

            status = new POJOs.Status();

            status.setStatus("active");

            session.save(status);
            transaction.commit();

            return status;
        }

    }
    
    public POJOs.Status getPendingStatus(){
        POJOs.Status status = null;

        Criteria pendingStatusCriteria = session.createCriteria(POJOs.Status.class);
        pendingStatusCriteria.add(Restrictions.eq("status", "pending"));

        List<POJOs.Status> statusList = pendingStatusCriteria.list();

        if (!statusList.isEmpty()) {

            for (int i = 0; i < statusList.size(); i++) {
                status = statusList.get(i);

            }
            return status;
        } else {

            status = new POJOs.Status();

            status.setStatus("pending");

            session.save(status);
            transaction.commit();

            return status;
        }
    }
    
    public POJOs.Status getDeactiveStatus() {
        POJOs.Status status = null;

        Criteria activeStatusCriteria = session.createCriteria(POJOs.Status.class);
        activeStatusCriteria.add(Restrictions.eq("status", "deactive"));

        List<POJOs.Status> statusList = activeStatusCriteria.list();

        if (!statusList.isEmpty()) {

            for (int i = 0; i < statusList.size(); i++) {
                status = statusList.get(i);

            }
            return status;
        } else {

            status = new POJOs.Status();

            status.setStatus("deactive");

            session.save(status);
            transaction.commit();

            return status;
        }

    }
    
    public POJOs.Status getLaterStatus() {
        POJOs.Status status = null;

        Criteria activeStatusCriteria = session.createCriteria(POJOs.Status.class);
        activeStatusCriteria.add(Restrictions.eq("status", "later"));

        List<POJOs.Status> statusList = activeStatusCriteria.list();

        if (!statusList.isEmpty()) {

            for (int i = 0; i < statusList.size(); i++) {
                status = statusList.get(i);

            }
            return status;
        } else {

            status = new POJOs.Status();

            status.setStatus("later");

            session.save(status);
            transaction.commit();

            return status;
        }

    }

    public POJOs.ProductStatus getProductActiveStatus(){
        
        Session session = new classess.sessionConnect().testConnection();
        POJOs.ProductStatus productStatus =null;
        try {
            Criteria getActiveStatus =session.createCriteria(POJOs.ProductStatus.class);
            getActiveStatus.add(Restrictions.eq("productStatus", "active"));
            
            productStatus = (POJOs.ProductStatus)getActiveStatus.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
        return productStatus;
        }
        
    }
    
    public POJOs.ProductStatus getProductDeactiveStatus(){
        
        Session session = new classess.sessionConnect().testConnection();
        POJOs.ProductStatus productStatus =null;
        try {
            Criteria getActiveStatus =session.createCriteria(POJOs.ProductStatus.class);
            getActiveStatus.add(Restrictions.eq("productStatus", "deactive"));
            
            productStatus = (POJOs.ProductStatus)getActiveStatus.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
        return productStatus;
        }
        
    }
    
    
    public POJOs.UserType getCustomerType() {

        POJOs.UserType userType = null;

        Criteria userTypeCriteria = session.createCriteria(POJOs.UserType.class);
        userTypeCriteria.add(Restrictions.eq("userType", "customer"));

        List<POJOs.UserType> userTypeList = userTypeCriteria.list();

        if (!userTypeList.isEmpty()) {
            for (int i = 0; i < userTypeList.size(); i++) {
                userType = userTypeList.get(i);

            }
            return userType;
        } else {

            userType = new POJOs.UserType();

            userType.setUserType("customer");

            session.save(userType);
            transaction.commit();

            return userType;
        }

    }

   
    public POJOs.UserType getSupplierType() {
        POJOs.UserType userType = null;

        Criteria userTypeCriteria = session.createCriteria(POJOs.UserType.class);
        userTypeCriteria.add(Restrictions.eq("userType", "supplier"));

        List<POJOs.UserType> userTypeList = userTypeCriteria.list();

        if (!userTypeList.isEmpty()) {
            for (int i = 0; i < userTypeList.size(); i++) {
                userType = userTypeList.get(i);

            }
            return userType;
        } else {

            userType = new POJOs.UserType();

            userType.setUserType("supplier");

            session.save(userType);
            transaction.commit();

            return userType;
        }
    }

    
    public POJOs.UserType getAdminType() {
        POJOs.UserType userType = null;

        Criteria userTypeCriteria = session.createCriteria(POJOs.UserType.class);
        userTypeCriteria.add(Restrictions.eq("userType", "admin"));

        List<POJOs.UserType> userTypeList = userTypeCriteria.list();

        if (!userTypeList.isEmpty()) {
            for (int i = 0; i < userTypeList.size(); i++) {
                userType = userTypeList.get(i);

            }
            return userType;
        } else {

            userType = new POJOs.UserType();

            userType.setUserType("admin");

            session.save(userType);
            transaction.commit();

            return userType;
        }
    }

    
    public POJOs.SystemDate saveDate() {
        POJOs.SystemDate systemDate = null;
        try {
            Criteria getDateCriteria = session.createCriteria(POJOs.SystemDate.class);
            getDateCriteria.add(Restrictions.eq("sysDate", new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date()))));

            List<POJOs.SystemDate> systemDateList = getDateCriteria.list();

            if (!systemDateList.isEmpty()) {
                for (int i = 0; i < systemDateList.size(); i++) {
                    systemDate = systemDateList.get(i);

                }
                return systemDate;
            } else {
                systemDate = new POJOs.SystemDate();

                systemDate.setSysDate(new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date())));

                session.save(systemDate);
                transaction.commit();

                return systemDate;
            }
        } catch (ParseException ex) {
            ex.printStackTrace();
            return systemDate;
        }
    }

    /**
     * System Date Details Finish*
     */
    /**
     * Save Gender
     *
     * @param value
     * @return gender
     */
    public POJOs.Gender saveGender(String value) {

        POJOs.Gender gender = null;

        try {

            Criteria gendercCriteria = session.createCriteria(POJOs.Gender.class);
            gendercCriteria.add(Restrictions.eq("gender", value));

            List<POJOs.Gender> genderList = gendercCriteria.list();

            if (!genderList.isEmpty()) {

                for (int i = 0; i < genderList.size(); i++) {
                    gender = genderList.get(i);

                }
                return gender;
            } else {
                gender = new POJOs.Gender();

                gender.setGender(value);

                session.save(gender);
                transaction.commit();

                return gender;

            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Save Salutation
     *
     * @param value
     * @return salutation
     */
    public POJOs.Salutation saveSalutation(String value) {

        POJOs.Salutation salutation = null;

        try {

            Criteria salutationCriteria = session.createCriteria(POJOs.Salutation.class);
            salutationCriteria.add(Restrictions.eq("salutation", value));

            List<POJOs.Salutation> salutationList = salutationCriteria.list();
            if (!salutationList.isEmpty()) {
                for (int i = 0; i < salutationList.size(); i++) {
                    salutation = salutationList.get(i);
                }
                return salutation;
            } else {
                salutation = new POJOs.Salutation();
                salutation.setSalutation(value);

                session.save(salutation);
                transaction.commit();
                return salutation;

            }
        } catch (Exception e) {
            e.printStackTrace();
            return salutation;
        }
    }

    public double setSellingPrice(String value) {
        Session session = new classess.sessionConnect().testConnection();
        double sellingPrice = 0;
        double rate = 1;
        double price = Double.parseDouble(value);
        double commition = 0;

        try {

            Criteria comitionRateDetailsCriteria = session.createCriteria(POJOs.CommisionRate.class);

            List<POJOs.CommisionRate> commisionRateList = comitionRateDetailsCriteria.list();

            for (int i = 0; i < commisionRateList.size(); i++) {
                CommisionRate commisionRate = commisionRateList.get(0);
                rate = commisionRate.getCommision();
            }

            commition = Math.round(((price * rate) / 100) * 100) / 100;

            sellingPrice = price + commition;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return sellingPrice;
        }

    }

    // Get Supplier
    public POJOs.Supplier getSupplier(String supplierEmail) {
        Session session = new classess.sessionConnect().testConnection();
        POJOs.Supplier supplier = null;
        try {
            Criteria supplierDetailscCriteria = session.createCriteria(POJOs.Supplier.class);
            supplierDetailscCriteria.add(Restrictions.eq("email", supplierEmail));
            supplierDetailscCriteria.add(Restrictions.eq("status", new classess.tools().getActiveStatus()));

            supplier = (Supplier) supplierDetailscCriteria.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return supplier;
        }

    }

    // Get Customer
    public POJOs.Customer getCustomer(String customerEmail) {
        POJOs.Customer customer = null;
        Session session = new classess.sessionConnect().testConnection();
        try {
            Criteria getCustomerCriteria = session.createCriteria(POJOs.Customer.class);
            getCustomerCriteria.add(Restrictions.eq("email", customerEmail));
            getCustomerCriteria.add(Restrictions.eq("status", new classess.tools().getActiveStatus()));

            customer = (POJOs.Customer) getCustomerCriteria.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return customer;
        }

    }

    // Check User Exist
    public boolean checkUserExist(String userEmail) {
        boolean flag = false;
        Session session = new classess.sessionConnect().testConnection();
        System.out.println(userEmail);
        try {

            Criteria userCheckDetails = session.createCriteria(POJOs.Customer.class);
            userCheckDetails.add(Restrictions.eq("email", userEmail));
            userCheckDetails.add(Restrictions.eq("status", (POJOs.Status) session.createCriteria(POJOs.Status.class).add(Restrictions.eq("status", "active")).uniqueResult()));

            List<Customer> customersList = userCheckDetails.list();

            if (!customersList.isEmpty()) {
                flag = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return flag;
        }

    }

    // Check Supplier Exist
    public boolean checkSupplierExist(String supplierEmail) {
        boolean flag = false;
        Session session = new classess.sessionConnect().testConnection();

        try {

            Criteria supplierCheckDetails = session.createCriteria(POJOs.Supplier.class);
            supplierCheckDetails.add(Restrictions.eq("email", supplierEmail));
            supplierCheckDetails.add(Restrictions.eq("status", (POJOs.Status) session.createCriteria(POJOs.Status.class).add(Restrictions.eq("status", "active")).uniqueResult()));
            List<Supplier> suppliersList = supplierCheckDetails.list();

            if (!suppliersList.isEmpty()) {
                flag = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return flag;
        }

    }

    // Get subCategory
    public POJOs.SubCategory getSubCategory(String subCategory) {

        Session session = new classess.sessionConnect().testConnection();
        POJOs.SubCategory subCategory1 = null;
        try {
            Criteria getSubCategory = session.createCriteria(POJOs.SubCategory.class);
            getSubCategory.add(Restrictions.eq("subCategory", subCategory));

            subCategory1 = (POJOs.SubCategory) getSubCategory.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return subCategory1;
        }

    }

    // Get TopCategory
    public POJOs.TopCategory getTopCategory(String topCategory) {

        Session session = new classess.sessionConnect().testConnection();
        POJOs.TopCategory topCategory1 = null;
        try {
            Criteria getTopCategory = session.createCriteria(POJOs.TopCategory.class);
            getTopCategory.add(Restrictions.eq("topCategory", topCategory));

            topCategory1 = (POJOs.TopCategory) getTopCategory.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return topCategory1;
        }

    }

    // Get  Admin Details
    public POJOs.AdminDetails getAdmin(String value) {
        Session session = new classess.sessionConnect().testConnection();
        POJOs.AdminDetails adminDetail = null;
        try {
            Criteria getAdminDetails = session.createCriteria(POJOs.AdminDetails.class);
            getAdminDetails.add(Restrictions.eq("username", value));

            adminDetail = (POJOs.AdminDetails) getAdminDetails.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            return adminDetail;
        }

    }
    
    // Get Shipping Details
    public POJOs.ShipingDetails getShippingDetails(String value){
        Session session =POJOs.session_pool_manager.getSessionFactory().openSession();
        POJOs.ShipingDetails shipingDetails=null;
        try {
            Criteria criteria =session.createCriteria(POJOs.ShipingDetails.class);
            criteria.add(Restrictions.eq("city", value));
            shipingDetails = (POJOs.ShipingDetails)criteria.uniqueResult();
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            session.close();
        return shipingDetails;
        }
    
    }
    
    // Deliver Pending
    public POJOs.DeliverStatus getPendingDeliverStatus(){
    
        Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
        POJOs.DeliverStatus deliverStatus =null;
        try {
            Transaction transaction = session.beginTransaction();
            
            Criteria criteria = session.createCriteria(POJOs.DeliverStatus.class);
            criteria.add(Restrictions.eq("deliverStatus", "pending"));
            
            List<POJOs.DeliverStatus> statuses = criteria.list();
            
            if (!statuses.isEmpty()) {
                deliverStatus = statuses.get(0);
            }else{
                deliverStatus =new DeliverStatus();
                
                deliverStatus.setDeliverStatus("pending");
                
                session.save(deliverStatus);
                
                transaction.commit();
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            session.close();
        return deliverStatus;
        }
        
    }
    
     // Deliver shipped
    public POJOs.DeliverStatus getShippedDeliverStatus(){
    
        Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
        POJOs.DeliverStatus deliverStatus =null;
        try {
            Transaction transaction = session.beginTransaction();
            
            Criteria criteria = session.createCriteria(POJOs.DeliverStatus.class);
            criteria.add(Restrictions.eq("deliverStatus", "shipped"));
            
            List<POJOs.DeliverStatus> statuses = criteria.list();
            
            if (!statuses.isEmpty()) {
                deliverStatus = statuses.get(0);
            }else{
                deliverStatus =new DeliverStatus();
                
                deliverStatus.setDeliverStatus("shipped");
                
                session.save(deliverStatus);
                
                transaction.commit();
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            session.close();
        return deliverStatus;
        }
        
    }

         // Deliver delivered
    public POJOs.DeliverStatus getDeliveredDeliverStatus(){
    
        Session session = POJOs.session_pool_manager.getSessionFactory().openSession();
        POJOs.DeliverStatus deliverStatus =null;
        try {
            Transaction transaction = session.beginTransaction();
            
            Criteria criteria = session.createCriteria(POJOs.DeliverStatus.class);
            criteria.add(Restrictions.eq("deliverStatus", "delivered"));
            
            List<POJOs.DeliverStatus> statuses = criteria.list();
            
            if (!statuses.isEmpty()) {
                deliverStatus = statuses.get(0);
            }else{
                deliverStatus =new DeliverStatus();
                
                deliverStatus.setDeliverStatus("delivered");
                
                session.save(deliverStatus);
                
                transaction.commit();
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            session.close();
        return deliverStatus;
        }
        
    }
    // Get checkout Status
    public POJOs.Status getCheckOutStatus (){
    
        POJOs.Status status = null;

        Criteria activeStatusCriteria = session.createCriteria(POJOs.Status.class);
        activeStatusCriteria.add(Restrictions.eq("status", "checkout"));

        List<POJOs.Status> statusList = activeStatusCriteria.list();

        if (!statusList.isEmpty()) {

            for (int i = 0; i < statusList.size(); i++) {
                status = statusList.get(i);

            }
            return status;
        } else {

            status = new POJOs.Status();

            status.setStatus("checkout");

            session.save(status);
            transaction.commit();

            return status;
        }
        
    
    
    }
    
}
