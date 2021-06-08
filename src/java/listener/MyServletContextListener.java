/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import java.util.Date;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class MyServletContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        ServletContext sc = event.getServletContext();
        String dbClass = sc.getInitParameter("jdbcClassName");
        StringBuffer url = new StringBuffer(sc.getInitParameter("jdbcDriverURL"))
                    .append("://")
                    .append(sc.getInitParameter("dbHostName"))
                    .append(":")
                    .append(sc.getInitParameter("dbPort"))
                    .append("/")
                    .append(sc.getInitParameter("databaseName"));
    	String user_name = sc.getInitParameter("dbUserName");
    	String password = sc.getInitParameter("dbPassword");
    	MyDatabase db = new MyDatabase(dbClass, url.toString(), user_name, password);
    	sc.setAttribute("db", db);
        
        Date date = new Date();        
        sc.setAttribute("time", date);
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {

    }

}
