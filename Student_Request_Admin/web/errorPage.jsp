<%-- 
    Document   : errorPage
    Created on : Jul 11, 2021, 10:30:56 AM
    Author     : Hoang Lam
    Copyright Notice : © 2021 Hoang Lam
    Description: 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/global.css">
        <link rel="stylesheet" type="text/css" href="css/header.css">
        <link rel="stylesheet" type="text/css" href="css/nav.css">
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <title>Login</title>
    </head>
    <body>
        <%@include file="component/header.jsp" %>
        <%@include file="component/nav.jsp" %>

        <form action="login" method="POST">
            <div class="form__container">
                <ul>
                    <li>
                        <h1>${errorMsg} <span style="color:red">${errorCode}</span></h1>
                    </li>
                    <li>
                        <span>${exception}</span> <span>${requestURI}</span>
                    </li>
                </ul>
                <div>
                    <span>Return to Home Page:</span><br/>
                    <a href="${homePageURL}">Home Page</a>
                </div>
                <div>
                    <span>Report this error:</span><br/>
                    <a href="mailto:hoanglammaster@gmail.com">Send email</a>
                </div>

            </div>
        </form>
    </body>
</html>
