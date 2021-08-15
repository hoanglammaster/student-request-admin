<%-- 
    Document   : performViewRequest
    Created on : Jul 11, 2021, 9:15:42 AM
    Author     : Hoang Lam
    Copyright Notice : © 2021 Hoang Lam
    Description: 
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/global.css">
        <link rel="stylesheet" type="text/css" href="css/header.css">
        <link rel="stylesheet" type="text/css" href="css/nav.css">
        <link rel="stylesheet" type="text/css" href="css/view-request.css">
        <title>View Request</title>
    </head>
    <body>
        <%@include file="component/header.jsp" %>
        <%@include file="component/nav.jsp" %>
        <form action="view-request" method="POST" id="form">
            <div class="form__container">
                <div class="form__container--center">
                    <div class="form__title--big">
                        <h4>View requests</h4>
                    </div>
                    <div class="form__content">
                        <table class="table__container">
                            <th colspan="6" class="table__header">

                                <div class="table__header--title">
                                    <span>Select department</span>
                                    <select name="departmentSelect">
                                        <c:forEach var="depart" items="${listDepartment}">
                                            <c:choose>
                                                <c:when test="${depart.getId() == selectedDepartment}">
                                                    <option value="${depart.getId()}" selected>${depart.getName()}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${depart.getId()}">${depart.getName()}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="table__header--title">
                                    <span>or Enter request title</span>
                                    <input type="text" name="requestTitle" value=""/> <input type="submit" name="search" value="View"/>
                                </div>

                            </th>
                            <tr class="table__content table__content--header">
                                <td>Request title</td>
                                <td>Date created</td>
                                <td>Close created</td>
                                <td>Status</td>
                                <td>Report to</td>
                                <td>Detail</td>
                            </tr>
                            <c:if test="${listSelectedRequest != null}">
                                <% SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");%>
                                <c:forEach var="request" items="${listSelectedRequest}">
                                    <tr class="table__content table__content--rows">
                                        <td>${request.getTitle()}</td>
                                        <td>
                                            <c:set value="${request.getDateCreated()}" var="dateCreated"/>
                                            <%= dateFormat.format(Date.valueOf(pageContext.getAttribute("dateCreated").toString()))%>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${request.getDateClosed() != null}">
                                                    <c:set value="${request.getDateClosed()}" var="dateClosed"/>
                                                    <%= dateFormat.format(Date.valueOf(pageContext.getAttribute("dateClosed").toString()))%>
                                                </c:when>
                                                <c:otherwise>
                                                    N/A
                                                </c:otherwise>
                                            </c:choose>

                                        <td>${request.getStatus() != null ?request.getStatus()==true?"Approved": "Reject" : "In process" }</td>
                                        <td>${request.getReportTo().getName()}</td>
                                        <td><input type="button" name="solve" value="Solve" onclick="clickSolveButton(${request.getRequestId()})"/></td>
                                    </tr> 
                                </c:forEach>
                            </c:if>
                                    <input type="hidden" id="requsetIdSelected" name="requsetIdSelected" value=""/> 
                        </table>
                    </div>
                </div>
            </div>

        </form>
    </body>
    <script type="text/javascript"> 
        function clickSolveButton(id){
            document.getElementById('requsetIdSelected').value = id;
            document.getElementById('form').submit();
        }
    </script>
</html>
