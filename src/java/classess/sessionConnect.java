/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package classess;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author randika
 */
public class sessionConnect {
    
    SessionFactory sf;
    Session s;

    public Session testConnection() {
        if (s == null) {
            s=POJOs.session_pool_manager.getSessionFactory().openSession();
            return s;
        } else {
            return s;
        }
    }
    
}
