package POJOs;
// Generated Oct 3, 2017 6:37:39 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * Orders generated by hbm2java
 */
public class Orders  implements java.io.Serializable {


     private Integer idorders;
     private OrderStatus orderStatus;
     private Customer customer;
     private Supplier supplier;
     private Set orderImageses = new HashSet(0);

    public Orders() {
    }

	
    public Orders(OrderStatus orderStatus, Customer customer, Supplier supplier) {
        this.orderStatus = orderStatus;
        this.customer = customer;
        this.supplier = supplier;
    }
    public Orders(OrderStatus orderStatus, Customer customer, Supplier supplier, Set orderImageses) {
       this.orderStatus = orderStatus;
       this.customer = customer;
       this.supplier = supplier;
       this.orderImageses = orderImageses;
    }
   
    public Integer getIdorders() {
        return this.idorders;
    }
    
    public void setIdorders(Integer idorders) {
        this.idorders = idorders;
    }
    public OrderStatus getOrderStatus() {
        return this.orderStatus;
    }
    
    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }
    public Customer getCustomer() {
        return this.customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    public Supplier getSupplier() {
        return this.supplier;
    }
    
    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }
    public Set getOrderImageses() {
        return this.orderImageses;
    }
    
    public void setOrderImageses(Set orderImageses) {
        this.orderImageses = orderImageses;
    }




}


