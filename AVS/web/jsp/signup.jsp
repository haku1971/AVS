<%-- 
    Document   : signup
    Created on : Mar 10, 2020, 4:23:33 PM
    Author     : BinhNT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-client_id" content="912620741556-58chb0o18k50h03oblr4gr5t8vrqi139.apps.googleusercontent.com">
        <title>AVS</title>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <form class="box2" action="SignupController" method="post">
                <h1><b>Sign Up</b></h1>
                <img src="images\user.png" />

                <div class ="signup_item1">
                    <input class="su_info1" type="text" name="username" placeholder="Username"required/></br>
                    <%if (request.getAttribute("errorUsername") != null) {
                    %>
                    <div class="errormess_username">
                        <p> <%=request.getAttribute("errorUsername")%></p>
                    </div>
                    <%
                        }
                    %>

                    <input class="su_info1" type="text" name="email" placeholder="Email"required/></br>
                    <%if (request.getAttribute("errorMail") != null) {
                    %>
                    <div class="errormess_mail">
                        <p> <%=request.getAttribute("errorMail")%></p>
                    </div>
                    <%
                        }
                    %>


                </div>
                <div class ="signup_item2">
                    <input class="su_info2" type="password" name="password" placeholder="Password"required/></br>
                    <%if (request.getAttribute("errorPass") != null) {
                    %>
                    <div class="errormess_pass">
                        <p> <%=request.getAttribute("errorPass")%></p>
                    </div>
                    <%
                        }
                    %>

                    <input class="su_info2" type="password" name="repassword" placeholder="Re-Password"required/></br>
                    <%if (request.getAttribute("errorRepass") != null) {
                    %>
                    <div class="errormess_repass">
                        <p> <%=request.getAttribute("errorRepass")%></p>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div class ="signup_item3">
                    <input class="su_info3" type="text" name="fullname" placeholder="Enter your Name"/></br>
                    <input class="su_info3" type="text" name="age" placeholder="Enter your Age"/></br>
                    <%if (request.getAttribute("errorAge") != null) {
                    %>
                    <div class="errormess_age">
                        <p> <%=request.getAttribute("errorAge")%></p>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div class="signup_item5">
                    <span>Gender :</span>
                    <input type="radio" id="male" name="gender" value="1" checked="true">Male</input>
                    <input type="radio" id="female" name="gender" value="0">Female</input>
                </div>
                <br>
                <br>
                <div class ="signup_item4">
                    <input class="su_info3" type="text" name="phone" placeholder="Enter your Phone Number"/></br>
                    <%if (request.getAttribute("errorPhone") != null) {
                    %>
                    <div class="errormess_phone">
                        <p> <%=request.getAttribute("errorPhone")%></p>
                    </div>
                    <%
                        }
                    %>             
                    <input class="su_info3" type="text" name="workplace" placeholder="Enter your Work Place"/></br>
                </div>
                <div class="signup_item6">
                    <select name="job">
                        <option value="1">You are Teacher</option>
                        <option value="2" selected>You are Student</option>
                        <option value="3">You are Employee</option>
                        <option value="4">You are Manager</option>
                    </select>
                </div>
                
                <button id="bottun" type="submit"><span>Sign Up</span></button>               
            </form>

        </div>
        <%@include file="footer.jsp" %>
        <script type="text/javascript" src="js/code.js"></script>
    </body>
</html>
