/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.SQLException; 

public class MyDatabase {
    private  Connection con;  
      public Connection getCon() {  
            return con;  
      }  
      public MyDatabase(String dbClass, String url,String user_name,String password) {  
            try {  
                  Class.forName(dbClass);  
                  this.con = DriverManager.getConnection(url,user_name,password);  
            } catch (ClassNotFoundException e) {  
                  // TODO Auto-generated catch block  
                  e.printStackTrace();  
            } catch (SQLException e) {  
                  // TODO Auto-generated catch block  
                  e.printStackTrace();  
            }  
      }  
}
