<%@page import="Entity.User"%>
<%@page import="Model.UserModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
    String user = "";
    String roleid ="";
    if (request.getCookies() != null) {
        Cookie cookie[] = request.getCookies();
        int agecookie = cookie[0].getMaxAge();

        int cookienum = 0;
        while (cookienum < cookie.length) {
            if (cookie[cookienum].getName().equals("username")) {
                user = cookie[cookienum].getValue();
            }
             if (cookie[cookienum].getName().equals("roleid")) {
                roleid = cookie[cookienum].getValue();
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
        <!--<script type="text/javascript" src="js/PreventF12.js"></script>-->
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="912620741556-58chb0o18k50h03oblr4gr5t8vrqi139.apps.googleusercontent.com">
        <title>Header</title>
        <!-- BEGIN Pre-requisites -->

        <!-- END Pre-requisites -->
    </head>
    <body>
        <div class="header">
            <ul>
                <li><img src="images\avs_logo.png" /></li>
                <li id="hover"><a href="home">Home</a></li>
                <li id="hover"><a href="NewsController">News</a></li>
                <% if(roleid.equals("1")){%>
                <li id="hover"><a href="admin">Admin</a></li>
                <%}%>
                <li>
                    <form id="account">
                        <%if (!user.equals("")) {%>
                        <a id="userName">Hello,<%=user%></a><img  src="images\user.png" />
                        
                        <div class="dropdown">
                            <button style="pointer-events: none"><span>+</span></button>
                            <div class="dropdown-content">
                                <div style = "display:none" align="middle" class="g-signin2" data-cookiepolicy='single_host_origin' data-onsuccess="onSignIn"></div>
                                <button onclick="document.location = '/AVS/UserinforController';return false">Information</button>
                                <button id="logout" onclick="signOut()">Log out</button>
                            </div>
                        </div>
                        <%} else {%>
                        <button onclick="document.location = '/AVS/LoginController';return false">Sign in</button>
                        <button onclick="document.location = '/AVS/SignupController';return false">Sign Up</button><%}%>
                    </form>
                </li>
                <li id="loginButton">
                    <form id="search"  action="NewsController">
                        <input type="text" value="${SearchValue}" placeholder="  Search.." name="search">
                        <button type="submit">Submit</button>
                    </form>
                </li>
            </ul>
        </div>
        <script type="text/javascript" src="js/signout.js"></script>
    </body>
</html>