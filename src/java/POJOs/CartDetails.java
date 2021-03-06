package POJOs;
// Generated Oct 3, 2017 6:37:39 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * CartDetails generated by hbm2java
 */
public class CartDetails  implements java.io.Serializable {


     private Integer idcartDetails;
     private SystemDate systemDate;
     private Customer customer;
     private Set productHasCartDetailses = new HashSet(0);

    public CartDetails() {
    }

	
    public CartDetails(SystemDate systemDate, Customer customer) {
        this.systemDate = systemDate;
        this.customer = customer;
    }
    public CartDetails(SystemDate systemDate, Customer customer, Set productHasCartDetailses) {
       this.systemDate = systemDate;
       this.customer = customer;
       this.productHasCartDetailses = productHasCartDetailses;
    }
   
    public Integer getIdcartDetails() {
        return this.idcartDetails;
    }
    
    public void setIdcartDetails(Integer idcartDetails) {
        this.idcartDetails = idcartDetails;
    }
    public SystemDate getSystemDate() {
        return this.systemDate;
    }
    
    public void setSystemDate(SystemDate systemDate) {
        this.systemDate = systemDate;
    }
    public Customer getCustomer() {
        return this.customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    public Set getProductHasCartDetailses() {
        return this.productHasCartDetailses;
    }
    
    public void setProductHasCartDetailses(Set productHasCartDetailses) {
        this.productHasCartDetailses = productHasCartDetailses;
    }




}


