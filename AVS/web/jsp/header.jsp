<%-- 
    Document   : header
    Created on : Feb 25, 2020, 12:33:11 PM
    Author     : Jisoo
--%>

<%@page import="Entity.User"%>
<%@page import="Model.UserModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<% UserModel useracountmanagement = new UserModel();
    Cookie cookie[] = request.getCookies();
    int age = cookie[0].getMaxAge();
    String user = "";
    String userid = "";
//    if (ck != null) {
//        while (co < ck.length) {
//            if (ck[co].getName().equals("username")) {
//                user = ck[co].getValue();
//            }
//
//            co++;
//        }
//        if (age == 0) {
//            user = "";
//        }
//    }

    for (Cookie ck : cookie) {
        if (ck.getName().equals("username")) {
            user = ck.getValue();
        }
        if (ck.getName().equals("roleid")) {
            userid = ck.getValue();
        }
        if (age == 0) {
            user = "";
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <title>Header</title>
        <!-- BEGIN Pre-requisites -->

        <!-- END Pre-requisites -->
    </head>
    <body>
        <div class="header">
            <img src="images\avs_logo.png" />
            <ul id="redirectButton">
                <li onclick="document.location = '/AVS/HomeController'">Home</li>
                <li>News</li>
            </ul>
            <ul id="loginButton">
                <li>
                    <form id="search">
                        <input type="text" placeholder="  Search.." name="search">
                        <button type="submit">Submit</button>
                    </form>
                </li>
                <li>
                    <form id="account">

                        <% String usern = "";
                            if (!user.equals("")) {
//                                User users = useracountmanagement.getUserByUsername(user);
//                                usern = users.getUsername();
%>
                        <a>Hello,<span><%=user%></span> <img  src="images\user.png" /></a>

                        <button id="logout" onclick="document.location = '/AVS/LogoutController';return false">Log out</button>
                        <!--                        <div class="dropdown">
                                                    <p>Hello,<span><%=usern%></span></p>
                                                    <a href="JavaScript:myFunction()"> <img class="dropbtn"  src="images\user.png" /></a>
                                                    <div id="myDropdown" class="dropdown-content">
                                                        <a href="#">Link 1</a>
                                                        <a href="#">Link 2</a>
                                                        <a href="#">Link 3</a>
                                                    </div>
                                                </div>-->
                        <%} else {%>
                        <button onclick="document.location = '/AVS/LoginController';return false">Sign in</button>
                        <button onclick="document.location = '/AVS/SignupController';return false">Sign Up</button><%}%>
                    </form>
                </li>
            </ul>
        </div>
    </body>
</html>
