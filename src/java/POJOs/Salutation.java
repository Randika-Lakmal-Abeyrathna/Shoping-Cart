package POJOs;
// Generated Oct 3, 2017 6:37:39 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * Salutation generated by hbm2java
 */
public class Salutation  implements java.io.Serializable {


     private Integer idsalutation;
     private String salutation;
     private Set customers = new HashSet(0);

    public Salutation() {
    }

    public Salutation(String salutation, Set customers) {
       this.salutation = salutation;
       this.customers = customers;
    }
   
    public Integer getIdsalutation() {
        return this.idsalutation;
    }
    
    public void setIdsalutation(Integer idsalutation) {
        this.idsalutation = idsalutation;
    }
    public String getSalutation() {
        return this.salutation;
    }
    
    public void setSalutation(String salutation) {
        this.salutation = salutation;
    }
    public Set getCustomers() {
        return this.customers;
    }
    
    public void setCustomers(Set customers) {
        this.customers = customers;
    }




}

