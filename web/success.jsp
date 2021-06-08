<%-- 
    Document   : success
    Created on : Mar 12, 2020, 10:31:27 AM
    Author     : Zee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Account</title>
    </head>
    <style>
        header{
            position: relative;
            padding: 2%;
            font-family: "Montserrat ExtraBold";
            font-size: 80px;
            color: white;
            border: 1px solid #ddd;
            background: rgb(2,0,36);
            background: linear-gradient(to right, #50a9a2, #52daa5);
        }
        #welcome{
            padding: 2%;
            font-family: "Montserrat ExtraBold";
            font-size: 30px;
            color: white;
            border: 1px solid #ddd;
            background: rgb(2,0,36);
            background: linear-gradient(to right, #8150a9, #52daa5);
        }

        h1{
            margin: 0px 0px 0px 0px; 
            padding: 0px 0px 0px 0px;
        }
        h2{
            margin: 0px 0px 0px 0px; 
            padding: 0px 0px 0px 0px;
        }

        #container{
            position: relative;
            align-content: center;
            background-color: white;
            /*z-index: -2;*/
            box-shadow: 1px 4px 11px 2px rgba(0,0,0,0.42);
            /*margin: 0 150px;*/
            margin: 0 auto;
            height: 100%;
            width: 800px;
        }
        body{
            margin: 0;
            padding: 0;
            text-align: center;
            background-color: #F3F2F2;
            font-family: karla;
        }
        .footer {
            /*position: fixed;*/
            position: relative;
            width: 100%;
            margin-top: 5%;
            margin-bottom: 0%;
            text-align: center;
            padding-bottom: 1%;
            padding-top: 1%;
            background-color: #333333;
            color: #e3e3e3;
        }

        form{
            padding: 3px;
            position: relative;
            z-index: 2;
        }

        button{
            appearance: none;
            outline: 0;
            background-color: cadetblue;
            border: 0;
            padding: 10px 15px;
            margin:0.5%;
            color: #bfffe6;
            border-radius: 3px;
            width: 200px;
            cursor: pointer;
            font-size: 18px;
            transition-duration: 0.25s;
        }


        label{
            display: block; /* add this */

        }
    </style>
    <body>
        <%
            response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            
            if(session.getAttribute("userSession") == null){
                response.sendRedirect("index.jsp");
            }
        %>
        <header>
            <%out.println(getServletContext().getInitParameter("header"));%>        
        </header>
        <br><br>
 
   
        <div id="container">
            <p>
                
            <div id="welcome">Welcome <%=request.getAttribute("user")%>!</div>
            <br> <h2>Your role:</h2><br>
            <p style="font-size: 50px; margin: 10px"><%=request.getAttribute("role")%></p>
            <br>
        
            <form method="post" action="generatePDF">
                <button type="submit" name="genPDF">Generate PDF report</button>
            </form>
            <form method="post" action="ServletOne">
                <button type="submit" name="viewRecs">View all Records</button><br>
                <button type="submit" name="logOut">Log Out</button>
            </form>
        <br>
        </div>
                
        <div class="footer">

            <h3>
                <% out.println(getServletContext().getInitParameter("footer")); %>
            </h3>
            Application started at 
            <%
                Date time = (Date)getServletContext().getAttribute("time");
                out.print(time);
            %>
        </div>

    </body>
</html>
