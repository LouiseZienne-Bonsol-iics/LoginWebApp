<%-- 
    Document   : index
    Created on : Mar 11, 2020, 7:43:21 PM
    Author     : Zee
--%>

<%@ page import="java.util.Date" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>

        <style>
            header{
                padding: 2%;
                position: relative;
                font-family: "Montserrat ExtraBold";
                font-size: 80px;
                color: white;
                border: 1px solid #ddd;
                background: rgb(2,0,36);
                background: linear-gradient(to right, #50a9a2, #52daa5);
            }


            #container{
                width: 400px;
                position: relative;
                left: 50%;
                top: 20%;
                /*height: 40%;*/
                margin-top: 5%;
                margin-left: -200px;
                margin-bottom: 5%;
                padding:0px 0px 20px 0px;
                background-color: white;
                /*border-radius:6px;
                border: lightgray 4px solid; */
                box-shadow: 1px 4px 11px 2px rgba(0,0,0,0.42);
            }
            body{
                margin: 0;
                padding: 0;
                text-align: center;
                background-color: #F3F2F2;
                font-family: karla;
            }
            .footer {
                position: relative;
                left: 0;
                bottom: 0;
                width: 100%;
                text-align: center;
                padding-bottom: 2%;
                padding-top: 1%;
                background-color: #333333;
                color: #e3e3e3;
            }

            form{
                padding: 20px 0;
                position: relative;
                z-index: 2;
            }

            input{
                display: block;
                appearance: none;
                outline: 0;
                border: 1px solid gray;
                background-color: #f5f5f5;
                width: 250px;
                border-radius: 3px;
                padding: 5px 10px;
                margin: 0 auto 0 auto;
                display: block;
                text-align: center;
                font-size: 18px;
                color: gray;
                transition-duration: 0.25s;
                font-weight: 300;
            }

            input:hover{
                background-color: #dddfdd;
            }

            input:focus{
                background-color: #ddfdee;
                width: 300px;
                color: #53e3a6;
            }

            button{
                outline: 0;
                background-color: cadetblue;
                border: 0;
                padding: 10px 15px;
                color: #8bfdcd;
                border-radius: 3px;
                width: 100px;
                cursor: pointer;
                font-size: 18px;
                transition-duration: 0.25s;
            }
            buttton:hover{
                background-color: rgb(245, 247, 249);
            }
            
            #b2{
                appearance: none;
                outline: 0;
                background-color:#bdf2bd;
                border: 0;
                padding: 10px 15px;
                color: #4ac28f;
                border-radius: 3px;
                width: 100px;
                cursor: pointer;
                font-size: 18px;
                transition-duration: 0.25s;
            }
            #user{
                width:150px;
                height:150px;
            }
            label{
                display: block; /* add this */

            }

        </style>
    </head>
    <body>

        <header>
            <%out.println(getServletContext().getInitParameter("header"));%>        
        </header>
        
                
        <div id="container">
            <h2 style= "padding-top: 5%;">HELLO, USER!</h2>
            <img id="user" src="img/user.png" alt="student user">
            <form class="form" method="POST" action="ServletOne">          
                <input type="text" name="uname" autocomplete="off" placeholder="Username"><br>
                <input type="password" name="pword" autocomplete="off" placeholder="Password"><br>
                <button id="button" type="submit" name="login">Login</button>
                <button id="b2" type="submit" name="signup">Sign Up</button>
            </form>
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
