package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.SecurePass;
import listener.*;


public class ServletOne extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    String queryStr;
    String insertStr;
    String exceptStr;
    String genUser;
    String genRole;
    int counter = 0;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
            queryStr = config.getInitParameter("queryStr");
            insertStr = config.getInitParameter("insertStr");
            exceptStr = getServletContext().getInitParameter("exceptStr");     
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        MyDatabase mydata = (MyDatabase) getServletContext().getAttribute("db");
        Connection conn = mydata.getCon();
        
        try{
            if (request.getParameter("login") != null) {
                if (conn != null) {
                    String u = null;
                    String p = null;
                    String r = null;
                    
                    String username = request.getParameter("uname");
                    String password = request.getParameter("pword");
                    HttpSession session =  request.getSession();
                    
                    PreparedStatement ps = conn.prepareStatement(queryStr);
                    ps.setString(1, username);
                    ResultSet records = ps.executeQuery();

                    while (records.next()) {
                        u = records.getString("USERNAME");
                        p = records.getString("PASSWORD");
                        r = records.getString("ROLES");
                    }
                    
                    String decryptedPass = SecurePass.decrypt(p);

                    if (u != null) {
                        if (decryptedPass.equals(password)) {
                            genUser = u;
                            genRole = r;
                            session.setAttribute("userSession", u);
                            session.setAttribute("roleSession", r);
                            request.setAttribute("user", u);
                            request.setAttribute("role", r);
                            request.getRequestDispatcher("success.jsp").forward(request, response);
                        } else if (password.equals("")) {
                            request.getRequestDispatcher("error.jsp").include(request, response);
                            out.print("<center><h3>Password cannot be blank!</h3></center><br>");
                        } else {
                            request.getRequestDispatcher("error.jsp").include(request, response);
                            out.print("<center><h3>Incorrect password!</h3></center><br>");
                        }

                    } else if (username.equals("")) {
                        if (password.equals("")) {
                            request.getRequestDispatcher("error.jsp").include(request, response);
                            out.print("<center><h3>You did not enter any fields!</h3></center>");
                        } else {
                            request.getRequestDispatcher("error.jsp").include(request, response);
                            out.print("<center><h3>Username cannot be blank!</h3></center>");
                        }
                    } else if (u != username) {
                        if (password.equals("")) {
                            request.getRequestDispatcher("error.jsp").include(request, response);
                            out.print("<center><h3>Password cannot be blank!</h3></center><br>");
                        }
                        else {
                        request.getRequestDispatcher("error.jsp").include(request, response);
                        out.print("<center><h3>No such username exists!</h3></center>");
                        }
                        
                    } else {
                        response.sendRedirect("error.jsp");
                    }
                } else {
                    response.sendRedirect("error.jsp");
                }
            }

            if (request.getParameter("addUser") != null) {
                if (conn != null) {
                    String u = null;
                                       
                    String username = request.getParameter("reg_uname");
                    String password = request.getParameter("reg_pword");
                    String cpassword = request.getParameter("reg_cpword");
                    String role = request.getParameter("userRole");

                    PreparedStatement ps = conn.prepareStatement(queryStr);
                    ps.setString(1, username);
                    ResultSet records = ps.executeQuery();
                    
                    while (records.next()) {
                        u = records.getString("USERNAME");
                        records.getString("PASSWORD");
                        records.getString("ROLES");
                    }
                    
                    if(u == null){
                        if (password.equals(cpassword)) {
                        String encryptedPass = SecurePass.encrypt(password);

                        PreparedStatement insert = conn.prepareStatement(insertStr);
                        insert.setString(1, username);
                        insert.setString(2, encryptedPass);
                        insert.setString(3, role);

                        int users = insert.executeUpdate();
                        counter = users + counter++;
                        RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                        rd.include(request, response);
                        out.print("<center><h2> You have successfully created your account, <b>" + username + "</b>!</h2></center>");                     
                        }
                        else{
                            request.getRequestDispatcher("error.jsp").include(request, response);
                            out.print("<center><h3>Password does not match! <br> Kindly recheck your password</h3></center>");
                        }         
                    }
                    else{
                        request.getRequestDispatcher("error.jsp").include(request, response);
                        out.print("<center><h3>Username already exists! <br> Please choose a different username.</h3></center>");
                    }
                }
            }
            
            if (request.getParameter("viewRecs") != null){
                if (conn != null){
                    PreparedStatement ps = conn.prepareStatement(exceptStr);
                    ps.setString(1, genUser);
                    ResultSet records = ps.executeQuery();
                    request.setAttribute("user", genUser);
                    request.setAttribute("results", records);
                    request.getRequestDispatcher("view.jsp").forward(request,response);
                }
            }

            if (request.getParameter("signup") != null) {
                response.sendRedirect("signup.jsp");
            }

            if (request.getParameter("logOut") != null) {
                HttpSession session = request.getSession(false);
                session.invalidate();
                response.sendRedirect("index.jsp");
            }
            if (request.getParameter("back") != null) {
                request.setAttribute("user", genUser);
                request.setAttribute("role", genRole);
                request.getRequestDispatcher("success.jsp").forward(request, response);
            }
            if (request.getParameter("signupPage") != null) {
                response.sendRedirect("signup.jsp");
            }
            if (request.getParameter("loginPage") != null) {
                response.sendRedirect("index.jsp");
            }
  
        } catch (SQLException sqle) {
            response.sendRedirect("error.jsp");
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
