<%-- 
    Document   : Admin
    Created on : Mar 18, 2020, 9:07:52 PM
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
            ArrayList<User> alluserlist = (ArrayList<User>) request.getAttribute("userlist");
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
                    <div class="sortby">
                        Sort by: 
                        <select id="select_column">
                            <option value="ID">ID</option>
                            <option value="Name">Name</option>
                        </select>
                        <select id="select_sorttype">
                            <option value="Ascending">Ascending</option>
                            <option value="Descending">Descending</option>
                        </select>
                    </div>
                    <div class="searchbox">
                        <form  method="POST" action="">
                            <input type="text" id=txtsearch" name="txtsearch"/>
                            <input type="submit" id="submitsearch" name="submitsearch" value="Search" />       
                        </form>
                    </div>
                    <div class="tableadmin">
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Role</th>
                                <th>View</th>
                            </tr>
                        <% for (int i = 0; i < alluserlist.size(); i++) {%> 
                        <tr>
                            <td><%=alluserlist.get(i).getId()%></td>
                            <td><%=alluserlist.get(i).getUsername()%></td>
                            <td><%=alluserlist.get(i).getRolenum()%></td>
                            <td><a href="viewaccount?id=<%=alluserlist.get(i).getId()%>">View</a></td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>
            <%@include file="footer.jsp" %>    
            
    </body>
</html>
