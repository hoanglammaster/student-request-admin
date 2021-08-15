<%-- 
    Document   : nav
    Created on : Jul 11, 2021, 1:39:40 PM
    Author     : Hoang Lam
    Copyright Notice : © 2021 Hoang Lam
    Description: 
--%>

<%@page import="model.user.User"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <div class="form__nav--right">
            <ul>
                <% if (session.getAttribute("user") == null) { %>
                <li><div class="form__nav--button" onclick="window.location.href = 'login'"><span>Login</span></div></li>
                    <% } else { %>
                <li><div class="form__nav--button" onclick="window.location.href = 'logout'"><span>Welcome <%= ((User) session.getAttribute("user")).getUserName()%>,<br>Log out</span></div></li>
                            <% }%>
                <li><div class="form__nav--button"onclick="window.location.href = 'home'" ><span>Home</span></div></li>
                <li><div class="form__nav--button" onclick="window.location.href = 'view-request'"><span>View requests</span></div></li>
                <li><div class="form__nav--button" onclick="window.location.href = 'solve-request'"><span>Solve requests</span></div></li>
                <li><div class="form__nav--button"><span class="blue__mark weight__bold">To day is: Saturday <br><%= LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %></span></div></li>
            </ul>
        </div>
    </body>
</html>
