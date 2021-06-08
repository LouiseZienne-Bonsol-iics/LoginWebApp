<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User List</title>
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
            /*left: 0;
            bottom: 0;*/
            margin-top: 5%;
            width: 100%;
            text-align: center;
            padding-top: 1%;
            padding-bottom: 2%;
            background-color: #333333;
            color: #e3e3e3;
        }

        form{
            padding: 2px;
            position: relative;
            z-index: 2;
        }

        button{
            appearance: none;
            outline: 0;
            background-color: cadetblue;
            border: 0;
            padding: 10px 15px;
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

        #usertable {
            /*font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;*/
            border-collapse: collapse;
            width: 70%;
        }

        #usertable td, #usertable th {
            border: 1px solid #ddd;
            padding: 2px;
        }

        #usertable tr:nth-child(even){background-color: #f2f2f2;}

        #usertable tr:hover {background-color: #ddd;}

        #usertable th {
            font-size: 18px;
            padding-top: 10px;
            padding-bottom: 10px;
            text-align: center;
            background-color: #6995A7;
            color: white;
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
            <br> <h2>Table of Other Registered Users</h2><br>

            <table id = "usertable" align = "center">
                <tr>
                    <th>Username</th>
                    <th>Role</th>
                </tr>

                <%
                        ResultSet results = (ResultSet) request.getAttribute("results");
                        while (results.next()) {%>
                <tr>
                    <td><%=results.getString("USERNAME")%></td>
                    <td><%=results.getString("ROLES")%></td>
                </tr>	
                <%	}
                %>

            </table>

            <br>

            <form method="post" action="generatePDF">
                <button type="submit" name="genPDF">Generate PDF report</button>
            </form>
            
            <form method="post" action="ServletOne">
                <button type="submit" name="back">Back</button>
            </form>
            <br>
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
