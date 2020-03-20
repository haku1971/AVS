<%-- 
    Document   : account
    Created on : Mar 18, 2020, 11:14:18 PM
    Author     : Ukah
--%>

<%@page import="Model.UserModel"%>
<%@page import="Entity.User"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Entity.Algorithm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <!--<script type="text/javascript" src="js/Sort.js"></script>-->
        <link rel="stylesheet" type="text/css" href="css/Visual.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        
        <%
            User thisuser = (User) request.getAttribute("user");
        %>
    </head>

    <body>
        <%@include file="header.jsp" %> 

        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <%@include file="adminleft.jsp" %> 
            <div class="right">

                <div class="userinfomation">
                    <div class="username"><%=thisuser.getUsername()%></div>
                    <div class="mail"><%=thisuser.getMail()%></div>
                    <div class="fullname">Fullname: <%=thisuser.getFullname()%></div>
                    <div class="gender">Gender: <%=thisuser.getGender()%></div>
                    <div class="age">Age: <%=thisuser.getAge()%></div>
                    <div class="workplace">Workplace: <%=thisuser.getWorkplace()%></div>
                    <div class="role">Role: <%=thisuser.getRolenum()%></div>
                    <div class="phone">Phone: <%=thisuser.getPhone()%></div>
                </div>
                <form>
                    <input type="submit" value="Ban">
                </form>
                <a href="admin?category=account"><button>Back</button></a>


            </div>
            <%@include file="footer.jsp" %>    
            <!--<script type="text/javascript" src="js/code.js"></script>-->
    </body>
    

</html>
