<%-- 
    Document   : home
    Created on : Jul 10, 2021, 8:45:48 PM
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
        <link rel="stylesheet" type="text/css" href="css/home.css">
        <title>Login</title>
    </head>
    <body>
        <%@include file="component/header.jsp" %>
        <%@include file="component/nav.jsp" %>
        <form action="home" method="POST">
            <div class="form__container">
                <div class="table__container--center">
                    <div><h4 class="table__title">Request received by today - <%= LocalDate.now().format(DateTimeFormatter.ofPattern("MM/dd/yyyy")) %></h4></div>
                    <table>
                        <tr class="table__header">
                            <th>Department name</th>
                            <th>Number of request</th>
                            <th>View detail</th>
                        </tr>
                        
                        <c:forEach var="request" items="${requestToDays}">
                            <tr class="table__container">
                                <td class="green__mark">${request.getDepartment()}</td>
                                <td>${request.getNumberOfRequest()}</td>
                                <td><input class="table__button--white" type="submit" name="${request.getDepartment()}" value="View"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div><h4 class="table__title">Request received by last ${lastDate}</h4></div>
                    <table>
                        <tr class="table__header">
                            <th>Department name</th>
                            <th>Number of request</th>
                            <th>View detail</th>
                        </tr>
                        <c:forEach var="request" items="${requestBefores}">
                            <tr class="table__container">
                                <td class="green__mark">${request.getKey()}</td>
                                <td>${request.getValue()}</td>
                                <td><input class="table__button--white" type="submit" name="${request.getKey()}" value="View"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>

        </form>
    </body>
</html>

