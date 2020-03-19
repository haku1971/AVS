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
        <style>
            #category {
                background-color: #edf0f4;
                color: black;
                cursor: pointer;
                padding: 18px;
                width: inherit;
                border: none;
                text-align: left;
                outline: none;
                font-size: 15px;
            }

            #category>a {
                color: black;
                cursor: pointer;
                width: 100%;
                border: none;
                outline: none;
                font-size: 15px;
            }

            #category:hover {
                background-color: gray;
                color: aqua;
            }

            .category_active{
                background-color: gray !important;
                color: aqua !important;
            }

            .tableadmin>table {
                border-collapse: collapse;
            }

            table,th,td{
                border: #29323d solid 1px;
            }
            
            .show{
                max-height: 97px !important;
            }
        </style>
        <%
            String category = (String) request.getAttribute("category");
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
            <div class="left">
                <a style="text-decoration: none"  href="admin?category=account"><div <c:if test="${category eq 'account'}">class="category_active"</c:if> id="category">Account</div></a>
                <a style="text-decoration: none"  href="admin?category=algorithm"><div <c:if test="${category eq 'algorithm'}">class="category_active"</c:if>id="category" >Algorithm</div></a>
                <a style="text-decoration: none"  href="admin?category=news"><div <c:if test="${category eq 'news'}">class="category_active"</c:if>id="category" >News</div></a>
                <a style="text-decoration: none"  ><div <c:if test="${category eq 'history'}">class="category_active"</c:if>id="category">History</div></a>
                <div class="content show">
                    <ul class="list_items"> 
                        <li><a style=" text-decoration: none;" id="AlgoNameList" href="">User history</a></li>
                        <li><a style=" text-decoration: none;" id="AlgoNameList" href="">Algorithm history</a></li>
                        <li><a style=" text-decoration: none;" id="AlgoNameList" href="">News history</a></li>
                    </ul>
                </div>
            </div>
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
