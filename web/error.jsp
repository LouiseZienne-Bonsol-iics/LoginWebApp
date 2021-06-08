<%-- 
    Document   : error
    Created on : Mar 12, 2020, 10:31:10 AM
    Author     : Zee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
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
        #error{
            margin: 2%;
            font-family: "Montserrat ExtraBold";
            font-size: 30px;
            color: lightslategray;
        }

        h1{
            margin: 0px 0px 0px 0px; 
            padding: 0px 0px 0px 0px;
        }
        h2{
            margin: 0px 0px 0px 0px; 
            padding: 0px 0px 0px 0px;
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
            position: absolute;
            bottom: 0;
            width: 100%;
            text-align: center;
            padding-bottom: 2%;
            background-color: #333333;
            color: #e3e3e3;
        }

        button{
            /*position: static;*/
            position: relative;
            margin: 1%;
            /*bottom: 30%;*/
            /*top: 70%;*/
            outline: 0;
            background-color: cadetblue;
            border: 0;
            padding: 10px 15px;
            color: #bfffe6;
            border-radius: 3px;
            width: 250px;
            cursor: pointer;
            font-size: 18px;
        }

        form{
            padding: 3px;
            position: absolute;
            left: 25%;
            right: 25%;
            bottom: 20%;
        }

        label{
            display: block; /* add this */
        }
        #sad{
                width:150px;
                height:150px;
        }
    </style>
    <body>
        <header>
            <%out.println(getServletContext().getInitParameter("header"));%>        
        </header>
        <br><br>

        <div id="error">There seems to be a problem!</div>
        <img id="sad" src="img/sad.png" alt="Sad face">
        <br>

        
            <form method="get" action="ServletOne">
                <button type="submit" name="loginPage">Return to Login Page</button>
                <button type="submit" name="signupPage" style="background-color:#bdf2bd; color: #4ac28f;">Return to Sign Up Page</button>
            </form>
        
              
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
