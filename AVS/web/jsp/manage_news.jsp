<%-- 
    Document   : manage_news
    Created on : Mar 20, 2020, 8:41:53 PM
    Author     : Ukah
--%>

<%@page import="Entity.News"%>
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
            ArrayList<News> allnews = (ArrayList<News>) request.getAttribute("newslist");
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
                        <option value="Title">Name</option>
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
                            <th>Title</th>
                            <th>Create Date</th>
                            <th>Editor</th>
                            <th>Detail</th>
                        </tr>
                        <% for (int i = 0; i < allnews.size(); i++) {%> 
                        <tr>
                            <td><%=allnews.get(i).getNewsID()%></td>
                            <td><%=allnews.get(i).getNewstittles()%></td>
                            <td><%=allnews.get(i).getNewsdaterealease()%></td>
                            <td><%=allnews.get(i).getUser().getUsername()%></td>
                            <td><a href="viewnews?id=<%=allnews.get(i).getNewsID()%>">View</a></td>
                        </tr>
                        <%}%>
                    </table>
                    
                    <a href="addnews"><button>Add</button></a>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>    
    </body>
</html>
