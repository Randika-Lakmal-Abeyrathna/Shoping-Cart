package POJOs;
// Generated Oct 3, 2017 6:37:39 PM by Hibernate Tools 3.6.0



/**
 * SupplierLogin generated by hbm2java
 */
public class SupplierLogin  implements java.io.Serializable {


     private Integer idsupplierLogin;
     private Supplier supplier;
     private String password;

    public SupplierLogin() {
    }

	
    public SupplierLogin(Supplier supplier) {
        this.supplier = supplier;
    }
    public SupplierLogin(Supplier supplier, String password) {
       this.supplier = supplier;
       this.password = password;
    }
   
    public Integer getIdsupplierLogin() {
        return this.idsupplierLogin;
    }
    
    public void setIdsupplierLogin(Integer idsupplierLogin) {
        this.idsupplierLogin = idsupplierLogin;
    }
    public Supplier getSupplier() {
        return this.supplier;
    }
    
    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }




}

