<%-- 
    Document   : performSendRequest
    Created on : Jul 14, 2021, 1:28:58 AM
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
        <link rel="stylesheet" type="text/css" href="css/solve-request.css">
        <title>Solve Request</title>
    </head>
    <body>
        <%@include file="component/header.jsp" %>
        <%@include file="component/nav.jsp" %>
        <div class="form__container">
            <div class="form__content--container">
                <div class="form__content--title">
                    <h4>Register User:</h4>
                </div>
                <form id="form" action="send-request" method="POST" enctype="multipart/form-data">
                    <div class="form__content">
                        <table id="defaultUser">
                            
                            <tr>
                                <td class="table__row--lable green__mark">Department</td>
                                <td class="table__row--input">
                                    <select name="department" style="width: 150px;">
                                        <option value="100">Academic Department</option>
                                        <option value="101">Service Department</option>
                                        <option value="102">Technical Department</option>
                                        <option value="103">Accounting Department</option>
                                        <option value="104">Foreign Language Department</option>
                                        <option value="105">Economics Department</option>
                                    </select>
                                </td>
                            </tr>
                             <tr>
                                <td class="table__row--lable lable__textarea">Title</td>
                                <td class="table__row--input"><textarea class="table__row--textarea" name="title"></textarea></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable lable__textarea">Content</td>
                                <td class="table__row--input"><textarea class="table__row--textarea" name="content"></textarea></td>
                            </tr>
                            <tr>
                                <td>File Attach</td>
                                <td class="table__row--input"><input type="file" name="file"/></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="table__row--input"><input type="submit" value="Send" /></td>
                            </tr>
                        </table>
                    </div>
                </form>
            </div>
        </div>

    </body>
    
</html>
