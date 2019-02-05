/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc;

import POJOs.Supplier;
import POJOs.SupplierLogin;
import java.util.HashMap;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author randika
 */
public class supplier_registration {

    private Session session;
    private Transaction transaction;

    public supplier_registration() {
        session = new classess.sessionConnect().testConnection();
        transaction = session.beginTransaction();
    }

    /**
     * Save Supplier Data
     *
     * @param hm
     *
     * @return String
     */
    public String saveData(HashMap<String, Object> hm) {

        try {

            String ownerName, nicNumber, ownerContactNumber, companyName, companyRegNumber, companyEmail, contactNumber1, contactNumber2,
                    addressno, street1, street2, city, confirmPassword;

            ownerName = (String) hm.get("ownerName");
            nicNumber = (String) hm.get("nicNumber");
            ownerContactNumber = (String) hm.get("ownerContactNumber");
            companyName = (String) hm.get("companyName");
            companyRegNumber = (String) hm.get("companyRegNumber");
            companyEmail = (String) hm.get("companyEmail");
            contactNumber1 = (String) hm.get("contactNumber1");
            contactNumber2 = (String) hm.get("contactNumber2");
            addressno = (String) hm.get("addressno");
            street1 = (String) hm.get("street1");
            street2 = (String) hm.get("street2");
            city = (String) hm.get("city");
            confirmPassword = (String) hm.get("confirmPassword");
            
            if (contactNumber1.isEmpty()) {
                contactNumber1="0";
            }
            if (contactNumber2.isEmpty()) {
                contactNumber1="0";
            }
           

            POJOs.Supplier supplier = new Supplier();

            supplier.setSupplierName(ownerName);
            supplier.setSupplierNic(nicNumber);
            supplier.setOwnerContactno(Integer.parseInt(ownerContactNumber));

            // Address Details
            supplier.setAddressNo(addressno);
            supplier.setAddressStreet(street1);
            supplier.setAddressStreet2(street2);
            supplier.setCity(new classess.tools().saveCity(city));

            // Contact Details
            supplier.setContactNumber(Integer.parseInt(contactNumber1));
            if (!contactNumber2.equals("")) {
                supplier.setContactNumber2(Integer.parseInt(contactNumber2));
            }
            supplier.setCompanyName(companyName);
            supplier.setCompanyRegNumber(companyRegNumber);

            //Status Active
            supplier.setStatus(new classess.tools().getPendingStatus());

            // User Type
            supplier.setUserType(new classess.tools().getSupplierType());

            // System Date
            supplier.setSystemDate(new classess.tools().saveDate());

            supplier.setEmail(companyEmail);

            session.save(supplier);

            POJOs.SupplierLogin login = new SupplierLogin();

            login.setSupplier(supplier);
            login.setPassword(confirmPassword);

            session.save(login);
            transaction.commit();

            return "Successfuly Saved ! Account will be Activeated within some time.";

        } catch (Exception e) {
            e.printStackTrace();

            return "Somthing Went Wrong while Saving Data";
        } finally {
            session.close();
        }

    }

}
