<%@page import="Entity.User"%>
<%@page import="Model.UserModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<% 
    String user = "";
    String pass = "";
    if (request.getCookies() != null) {
        Cookie ck[] = request.getCookies();
        int age = ck[0].getMaxAge();

        int co = 0;
        while (co < ck.length) {
            if (ck[co].getName().equals("username")) {
                user = ck[co].getValue();
            }

            co++;
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
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="912620741556-58chb0o18k50h03oblr4gr5t8vrqi139.apps.googleusercontent.com">
        <script type="text/javascript" src="js/signout"></script>
        <title>Header</title>
        <!-- BEGIN Pre-requisites -->

        <!-- END Pre-requisites -->
    </head>
    <body>
        <div class="header">
            <img src="images\avs_logo.png" />
            <ul id="redirectButton">
                <li onclick="document.location = '/AVS/HomeController'">Home</li>
                <li><a href="NewsController">News</a></li>
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

                        <div style = "display:none" align="middle" class="g-signin2" data-cookiepolicy='single_host_origin' data-onsuccess="onSignIn"></div>
                        <button id="logout" onclick="signOut()">Log out</button>
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
                    <script type="text/javascript" src="js/signout.js"></script>
    </body>
</html>