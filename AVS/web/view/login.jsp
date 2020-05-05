<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
//   if (session.getAttribute("username")!=null) {
//          String  usern=(String) session.getAttribute("username");
//       }
%>
<!DOCTYPE html>
<html> <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-scope" content="profile email">
        <title>Login</title>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <form class="box" action="login" method="post">
                <h1><b>Login</b></h1>
                <input id="infor" type="text" name="username" placeholder="Username" maxlength="15" required /></br>

                <input id="infor" type="password" name="password" placeholder="Password" maxlength="15" required /></br> 

                <%if (request.getAttribute("errorMessage") != null) {
                %>
                <div class="errormesslogin">

                    <p> <%=request.getAttribute("errorMessage")%></p>
                </div>
                <%
                    }
                %>
                <input id="log" type="submit" name="login" value="login" />
                <hr>
                <h4>Or</h4>
                <div id="gg" class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
                <hr>
                <h4>Don't have an account</h4>

                <button id="sign" onclick="document.location = '/AVS/register';return false">Register</button>
            </form>
        </div>

        <%@include file="footer.jsp" %>
        <script type="text/javascript" src="js/signin.js"></script>
    </body>
</html>
