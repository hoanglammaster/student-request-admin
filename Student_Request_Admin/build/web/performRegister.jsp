<%-- 
    Document   : performRegister
    Created on : Jul 13, 2021, 3:11:41 PM
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
                <form id="form" action="register" method="POST" enctype="multipart/form-data">
                    <div class="form__content">
                        <table id="defaultUser">
                            <tr>
                                <td class="table__row--lable green__mark">User Name</td>
                                <td class="table__row--input"><input type="text" name="userName"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Password</td>
                                <td class="table__row--input"><input type="text" name="password"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Role</td>
                                <td class="table__row--input">
                                    <select name="role" style="width: 150px;">
                                        <option value="1">Admin</option>
                                        <option value="2">Teacher</option>
                                        <option value="3">Staff</option>
                                        <option value="4">Student</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">First Name</td>
                                <td class="table__row--input"><input type="text" name="firstName"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Midle Name</td>
                                <td class="table__row--input"><input type="text" name="midleName"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Last Name</td>
                                <td class="table__row--input"><input type="text" name="lastName"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Gender</td>
                                <td class="table__row--input"><input type="radio" name="gender" value="female"/>Female<input type="radio" name="gender" value="male"/>Male</td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">DOB</td>
                                <td class="table__row--input"><input type="date" name="dob"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Avatar</td>
                                <td class="table__row--input"><input type="file" name="avatar"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Phone</td>
                                <td class="table__row--input"><input type="tel" name="phone"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Email</td>
                                <td class="table__row--input"><input type="email" name="email"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Adress</td>
                                <td class="table__row--input"><input type="text" name="address"/></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="table__row--input"><input type="button" value="Next" onclick="nextStep()"/></td>
                            </tr>
                        </table>
                        <table id="teacher">
                            <tr>
                                <td class="table__row--lable green__mark">Department</td>
                                <td class="table__row--input">
                                    <select name="teacher_department" style="width: 150px;">
                                        <option value="1">Admin</option>
                                        <option value="2">Teacher</option>
                                        <option value="3">Staff</option>
                                        <option value="4">Student</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="table__row--input"> <input type="submit" value="Register"/></td>
                            </tr>
                        </table>

                        <table id="staff">
                            <tr>
                                <td class="table__row--lable green__mark">Department</td>
                                <td class="table__row--input">
                                    <select name="staff_department" style="width: 150px;">
                                        <option value="1">Admin</option>
                                        <option value="2">Teacher</option>
                                        <option value="3">Staff</option>
                                        <option value="4">Student</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="table__row--input"><input type="submit" value="Register"/></td>
                            </tr>
                        </table>

                        <table id="student">
                            <tr>
                                <td class="table__row--lable green__mark">Majors</td>
                                <td class="table__row--input">
                                    <select name="major" style="width: 150px;">
                                        <option value="1">Admin</option>
                                        <option value="2">Teacher</option>
                                        <option value="3">Staff</option>
                                        <option value="4">Student</option>
                                    </select>
                                </td>

                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Father Name</td>
                                <td class="table__row--input"><input type="text" name="fatherName"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Phone</td>
                                <td class="table__row--input"><input type="tel" name="fatherPhone"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Email</td>
                                <td class="table__row--input"><input type="email" name="fatherEmail"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Adress</td>
                                <td class="table__row--input"><input type="text" name="fatherAddress"/></td>
                            </tr><tr>
                                <td class="table__row--lable green__mark">Mother Name</td>
                                <td class="table__row--input"><input type="text" name="motherName"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Phone</td>
                                <td class="table__row--input"><input type="tel" name="motherPhone"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Email</td>
                                <td class="table__row--input"><input type="email" name="motherEmail"/></td>
                            </tr>
                            <tr>
                                <td class="table__row--lable green__mark">Adress</td>
                                <td class="table__row--input"><input type="text" name="motherAddress"/></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="table__row--input"><input type="submit" value="Register"/></td>
                            </tr>
                        </table>

                    </div>
                </form>
            </div>
        </div>

    </body>
    <script type="text/javascript">
        setup();
        function setup(){
            document.getElementById("teacher").style = "display : none";
            document.getElementById("staff").style = "display : none";
            document.getElementById("student").style = "display : none";
        }
        function nextStep() {
            var role = document.getElementsByName("role")[0].value;
            if(role!== undefined){
                document.getElementById("defaultUser").style = "display : none";
            }
            alert(role);
        switch (role) {
                case "1" :
                    break;
                case "2" : document.getElementById("teacher").style = "display : unset";
                    break;
                case "3" : document.getElementById("staff").style = "display : unset";
                    break;
                case "4" : document.getElementById("student").style = "display : unset";
                    break;
                default:
                    return;
            }
        }
    </script>
</html>
