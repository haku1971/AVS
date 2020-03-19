<%@page import="Entity.User"%>
<%@page import="Model.UserModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<% 
    String user = "";
    String pass = "";
    if (request.getCookies() != null) {
        Cookie cookie[] = request.getCookies();
        int agecookie = cookie[0].getMaxAge();

        int cookienum = 0;
        while (cookienum < cookie.length) {
            if (cookie[cookienum].getName().equals("username")) {
                user = cookie[cookienum].getValue();
            }

            cookienum++;
        }
        if (agecookie == 0) {
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
        <title>Header</title>
        <!-- BEGIN Pre-requisites -->

        <!-- END Pre-requisites -->
    </head>
    <body>
        <div class="header">
            <img src="images\avs_logo.png" />
            <ul id="redirectButton">
                <li onclick="document.location = '/AVS/home'">Home</li>
                <li><a href="NewsController">News</a></li>
                <li><a href="admin">Admin</a></li>
            </ul>
            <ul id="loginButton">
                <li>
                    <form id="search"  action="NewsController">
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