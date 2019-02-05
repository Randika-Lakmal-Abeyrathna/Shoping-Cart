/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc;

import POJOs.Customer;
import POJOs.CustomerLogin;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author randika
 */
public class user_registration {

    public user_registration() {
       
    }

    public String saveData(final HashMap<String, Object> Hm) {
           
        Session session = new classess.sessionConnect().testConnection();
        String msg ="";
        
        try {
            Transaction transaction= session.beginTransaction();
            String firstName, lastName, addressNo, street1, street2, city, dateOfBirth, email, gender, salutation, contact1, contact2, nic, password;
            
            firstName=(String)Hm.get("firstName");
            lastName=(String)Hm.get("lastName");
            addressNo=(String)Hm.get("addressNo");
            street1=(String)Hm.get("street1");
            street2=(String)Hm.get("street2");
            city=(String)Hm.get("city");
            dateOfBirth=(String)Hm.get("dateOfBirth");
            email=(String)Hm.get("email");
            gender=(String)Hm.get("gender");
            salutation=(String)Hm.get("salutation");
            contact1=(String)Hm.get("contact1");
            contact2=(String)Hm.get("contact2");
            nic=(String)Hm.get("nic");
            password=(String)Hm.get("password");
            
            
            POJOs.Customer customer =new Customer();
            
            customer.setEmail(email);
            customer.setFirstName(firstName);
            customer.setLastName(lastName);
            customer.setAddressNo(addressNo);
            customer.setAddressStreet(street1);
            customer.setAddressStreet2(street2);
            customer.setCity(new classess.tools().saveCity(city));
            customer.setNicNumber(nic);
            customer.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").parse(dateOfBirth));
            customer.setContactNumber1(Integer.parseInt(contact1));
            customer.setContactNumber2(Integer.parseInt(contact2));
            customer.setGender(new classess.tools().saveGender(gender));
            customer.setSalutation(new classess.tools().saveSalutation(salutation));
            customer.setStatus(new classess.tools().getActiveStatus());
            customer.setUserType(new classess.tools().getCustomerType());
            customer.setSystemDate(new classess.tools().saveDate());
            
            session.save(customer);
            
            POJOs.CustomerLogin login = new CustomerLogin();
            
            login.setCustomer(customer);
            login.setPassword(password);
            
            session.save(login);
            
            transaction.commit();
            
            msg="Successfuly Saved !";
        } catch (Exception e) {
            msg="Somthing Whent Wrong !";
            e.printStackTrace();
            
        }finally{
            return msg;
        }

    }

}
