package POJOs;
// Generated Oct 3, 2017 6:37:39 PM by Hibernate Tools 3.6.0



/**
 * OrderImages generated by hbm2java
 */
public class OrderImages  implements java.io.Serializable {


     private Integer idorderImages;
     private Orders orders;
     private String orderImagesPath;

    public OrderImages() {
    }

	
    public OrderImages(Orders orders) {
        this.orders = orders;
    }
    public OrderImages(Orders orders, String orderImagesPath) {
       this.orders = orders;
       this.orderImagesPath = orderImagesPath;
    }
   
    public Integer getIdorderImages() {
        return this.idorderImages;
    }
    
    public void setIdorderImages(Integer idorderImages) {
        this.idorderImages = idorderImages;
    }
    public Orders getOrders() {
        return this.orders;
    }
    
    public void setOrders(Orders orders) {
        this.orders = orders;
    }
    public String getOrderImagesPath() {
        return this.orderImagesPath;
    }
    
    public void setOrderImagesPath(String orderImagesPath) {
        this.orderImagesPath = orderImagesPath;
    }




}

