<%-- 
    Document   : performLogin
    Created on : Jul 5, 2021, 10:18:45 AM
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
                    <li class="form__title--big"><h3>Member Login</h3></li>
                    <li class="form__title--small">Using your usename and password.</li>
                    <li>Username <input type="text" name="username" value=""> <span class="red__mark">(*)</span></li>
                    <li>Password <input type="password" name="password" value=""> <span class="red__mark">(*)</span></li>
                    <li><input class="form__button--login" type="submit" value="Log In" onclick="changeCursor()"></li>
                    <li>The field <span class="red__mark">(*)</span> is required</li>
                </ul>
            </div>

        </form>
    </body>
    <script type="text/javascript">
        function changeCursor() {
            document.body.style.cursor = 'wait';
        }
    </script>

</html>
