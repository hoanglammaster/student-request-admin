<%-- 
    Document   : performSolveRequest
    Created on : Jul 11, 2021, 9:16:02 AM
    Author     : Hoang Lam
    Copyright Notice : © 2021 Hoang Lam
    Description: 
--%>

<%@page import="java.util.Random"%>
<%@page import="model.request.RequestFully"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.user.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
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
        <%
            Random random = new Random();
            ArrayList listStyleId = new ArrayList();
            listStyleId.add("title__id--sup");
            listStyleId.add("title__id--sub");
            listStyleId.add("title__id--small");
            listStyleId.add("title__id--normal");
        %>
    </head>
    <body>

        <%@include file="component/header.jsp" %>
        <%@include file="component/nav.jsp" %>
        <form action="solve-request2" method="POST">
            <div class="form__container">
                <div class="form__content--container">
                    <div class="form__content--title">
                        <h4>Request ID:
                            <input type="hidden" name="requestId" value="${selectedRequest.getRequestId()}"/>
                            <%  RequestFully selectedRequest = (RequestFully) pageContext.getAttribute("selectedRequest", 2);
                                int requestId = selectedRequest.getRequestId();

                                ArrayList listSplitId = new ArrayList();
                                while (requestId > 0) {
                                    listSplitId.add(requestId % 10);
                                    requestId = requestId / 10;
                                }

                                for (int i = listSplitId.size()- 1; i >= 0; i--) {
                            %>
                            <div class="title__id--containter">
                                <div class="title__id--default <%= listStyleId.get(random.nextInt(4))%>">
                                    <span><%= listSplitId.get(i) %></span>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </h4>
                    </div>
                    <div class="form__content">
                        <table>
                            <tr>
                                <td class="table__row--lable">Request to Department</td>
                                <td class="table__row--input"><input type="text" name="department" value="${selectedRequest.getReportTo().getName()}" readonly="true"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable">Student Id</td>
                                <td class="table__row--input"><input type="text" name="studentId" value="${selectedRequest.getStudent().getCode()}" readonly="true"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable">Student name</td>
                                <td class="table__row--input"><input type="text" name="studentName" value="${selectedRequest.getStudent().getFullName()}" readonly="true"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable">Date created</td>
                                <td class="table__row--input"><input type="text" name="dateCreated" value="${selectedRequest.getDateCreated()}" readonly="true"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable">Request title</td>
                                <td class="table__row--input"><input type="text" name="requestTitle" value="${selectedRequest.getTitle()}" readonly="true"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable lable__textarea">Request content</td>
                                <td class="table__row--input"><textarea class="table__row--textarea" name="requestContent" readonly="true">${selectedRequest.getContent()}</textarea></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable">Request state</td>
                                <td class="table__row--input">
                                    <input type="radio" name="requestState" value="approved" checked="true"/>
                                    <span class="blue__mark">Approved</span>
                                    <input type="radio" name="requestState" value="rejected"/>
                                    <span class="red__mark">Rejected</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="table__row--lable">Close date</td>
                                <td class="table__row--input"><input type="text" name="dateClose" value="<%= LocalDate.now()%>" readonly="true"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable">Solve by</td>
                                <c:choose>
                                    <c:when test="${selectedRequest.getSolved()== null}">
                                   
                                        <% User user = (User) session.getAttribute("user");%>
                                        <td class="table__row--input"><input type="text" name="solve" value="<%= user.getUserName()%>" readonly="true"/></td>
                                        </c:when>
                                        <c:otherwise>
                                        <input type="hidden" name="solvedId" value="${selectedRequest.getSolved().getId()}">
                                        <td class="table__row--input"><input type="text" name="solve" value="${selectedRequest.getSolved().getFullName()}" readonly="true"/></td>
                                        </c:otherwise>
                                    </c:choose>

                            </tr>
                            <tr>
                                <td class="table__row--lable">Attached ( if any )</td>
                                <td class="table__row--input">
                                    <input type="button" value="Download" <c:if test="${selectedRequest.getFile() != null}">onclick="window.location.href = 'download'"</c:if>>                                
                                    </td>
                                </tr>
                                <tr>
                                    <td class="table__row--lable lable__textarea">School's solution</td>
                                    <td><textarea class="table__row--textarea" name="solution" >${selectedRequest.getSolution()}</textarea></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" name="save" value="Save"></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </form>
    </body>
</html>
