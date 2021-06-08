<%-- 
    Document   : signup
    Created on : Apr 12, 2020, 9:21:54 PM
    Author     : Zee
--%>

<%@ page import="java.util.Date" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up Page</title>
    </head>
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

        h2{
            position: absolute;
            left: 25%;
            right: 25%;
            top:22%;
        }

        #container{
            width: 400px;
            position: relative;
            left: 50%;
            top: 35%;
            height: 40%;
            margin-top: 5%;
            margin-left: -200px;
            margin-bottom: 5%;
            padding:10px 0px 30px 0px;
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
            appearance: none;
            outline: 0;
            background-color: cadetblue;
            border: 0;
            padding: 10px 15px;
            color: #8bfdcd;
            border-radius: 3px;
            width: 50%;
            cursor: pointer;
            font-size: 18px;
            transition-duration: 0.25s;
        }
        a.button{
            appearance: button;
            text-decoration: none;
            background-color: #ebfff7;
            outline-style: solid;
            outline-color:#79b59e;
            border: 0;
            /*padding: 8px 50px;*/
            padding:10px 0px 10px 0px;
            color: #53e3a6;
            border-radius: 3px;
            width: 50%;
            cursor: pointer;
            font-size: 18px;
            transition-duration: 0.25s;
        }
       
        
/*        label{
            display: block;  add this 
        }*/

        .dropdown{
            cursor: pointer;
            padding: 5px;
            width: 100px;
        }
        select-selected{
            /*background-color: rgb(245, 247, 249);*/
            background-color: cornsilk;
        }

    </style>
    <body>
        <header>
            <%out.println(getServletContext().getInitParameter("header"));%>        
        </header>

        <div id="container">
            <h3 style= "padding-top: 0;">Create an account</h3>
            <form method="POST" action="ServletOne"> 
                <label>Username: </label>
                <input type="text" name="reg_uname" required="true" autocomplete="off" >
                <label>Password: </label>
                <input type="password" name="reg_pword" required="true" autocomplete="off">
                <label>Confirm Password: </label>
                <input type="password" name="reg_cpword" required="true" autocomplete="off">
                <br>
                <label>Choose a role:</label>
                <select class="dropdown" name="userRole">
                    <option>Admin</option>
                    <option>Guest</option>
                </select>
                
                <br><br><br>
                <button type="submit" name="addUser" value="SIGN UP">SIGN UP</button>           
            </form>
            <a href="index.jsp" class="button">BACK</a> 
        </div>  
        <div class="footer">

            <h3>
                <% out.println(getServletContext().getInitParameter("footer")); %>
            </h3>
            Application started at 
            <%
                Date time = (Date) getServletContext().getAttribute("time");
                out.print(time);
            %>
        </div> 

    </body>
</html>
