<%@page import="Entity.User"%>
<%@page import="Model.UserModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String user = "";
    String roleid = "";
    String email = "";
    String fullname = "";
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
            if (cookie[cookienum].getName().equals("email")) {
                email = cookie[cookienum].getValue();
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

        <!--deploy sever-->
        <!--        <meta name="google-signin-client_id" content="912620741556-58chb0o18k50h03oblr4gr5t8vrqi139.apps.googleusercontent.com">-->

        <!--local host-->
        <meta name="google-signin-client_id" content="912620741556-hcmv2c3g46fti4psnqsjduu2hqcjo0qj.apps.googleusercontent.com">
        <title>Header</title>
        <!-- BEGIN Pre-requisites -->
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <!-- END Pre-requisites -->

    </head>
    <body>
        <div class="header">
            <ul>
                <li><img src="images\avs_logo.png" /></li>
                <li id="hover"><a href="home">Home</a></li>
                <li id="hover"><a href="news">News</a></li>
                    <% if (roleid.equals("1")) {%>
                <li id="hover"><a href="admin">Admin</a></li>
                    <%}%>
                <li>
                    <form id="account">
                        <%if (user.equals("anon")) {%>
                        <div style = "display:none" align="middle" class="g-signin2" data-cookiepolicy='single_host_origin' data-onsuccess="onSignIn"></div>

                        <button onclick="signOut();document.location = '/AVS/LogoutController';return false">Log out</button>
                        <%} else if (!user.equals("")) {%>
                        <a id="userName">Hello, <%=user%></a><img  src="images\user.png" />

                        <div class="dropdown">
                            <button style="pointer-events: none"><span>&#9776</span></button>
                            <div class="dropdown-content">
                                <div style = "display:none" align="middle" class="g-signin2" data-cookiepolicy='single_host_origin' data-onsuccess="onSignIn"></div>
                                <button onclick="document.location = '/AVS/userinfo';return false">Information</button>
                                <button id="logout" onclick="signOut();document.location = '/AVS/LogoutController';return false">Log out</button>
                            </div>
                        </div>
                        <%} else {%>
                        <button onclick="document.location = '/AVS/login';return false">Sign in</button>
                        <button onclick="document.location = '/AVS/register';return false">Sign Up</button><%}%>
                    </form>
                </li>
                <c:set var = "searchvalue" scope = "session" value ="${SearchValue}"/>  

                <li id="loginButton">
                    <form id="search" method="Post" action="news">
                        <%if (!user.equals("anon")) {%>
                        <input id="textsearch" type="text" placeholder="  Search.." name="search" value="<c:out value= "${searchvalue}"/>" />
                        <button onclick="checkLengthOfSearch()" id="buttonsearch" type="submit">Submit</button>
                        <%}%>
                    </form>
                    <script>
                        function checkLengthOfSearch() {
                            var txt_search_content = $('#textsearch').val().trim().replace("\\s+", " ");
                            console.log(txt_search_content);
                            if (txt_search_content === "") {
                                $('#buttonsearch').attr("disabled", true);
                            } else {
                                $('#buttonsearch').attr("disabled", false);

                            }
                        }
                        $('#textsearch').keyup(function () {
                            var txt_search_content = $('#textsearch').val().trim().replace("\\s+", " ");
                            if (txt_search_content.length < 1) {
                                console.log(' <1');
                                $('#buttonsearch').attr("disabled", true);
                            } else {
                                console.log('>1');
                                $('#buttonsearch').attr("disabled", false);
                            }
                        });
                    </script>
                </li>
            </ul>

        </div>
        <script type="text/javascript" src="js/signout.js"></script>
    </body>
</html>