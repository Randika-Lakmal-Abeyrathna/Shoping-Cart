package POJOs;
// Generated Oct 3, 2017 6:37:39 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * OrderStatus generated by hbm2java
 */
public class OrderStatus  implements java.io.Serializable {


     private Integer idorderStatus;
     private String orderStatus;
     private Set orderses = new HashSet(0);

    public OrderStatus() {
    }

    public OrderStatus(String orderStatus, Set orderses) {
       this.orderStatus = orderStatus;
       this.orderses = orderses;
    }
   
    public Integer getIdorderStatus() {
        return this.idorderStatus;
    }
    
    public void setIdorderStatus(Integer idorderStatus) {
        this.idorderStatus = idorderStatus;
    }
    public String getOrderStatus() {
        return this.orderStatus;
    }
    
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    public Set getOrderses() {
        return this.orderses;
    }
    
    public void setOrderses(Set orderses) {
        this.orderses = orderses;
    }




}


