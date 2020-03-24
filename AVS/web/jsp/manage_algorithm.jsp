<%-- 
    Document   : viewalgorithm
    Created on : Mar 19, 2020, 8:08:46 PM
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
            ArrayList<Algorithm> allalgolist = (ArrayList<Algorithm>) request.getAttribute("algolist");
            Boolean showdeleted = (Boolean) request.getAttribute("showdeleted");
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
                    <input type="checkbox" id="showdeleted" value="showdeleted" onchange="reload()">
                    <label for="showdeleted"> Show Deleted</label>
                </div>
                <script>
                    
                    if(<%=showdeleted%>) {
                        document.getElementById("showdeleted").checked = true;
                    }
                    
                    function reload() {
                        var currentpage = "admin?category=algorithm";
                        if (<%=showdeleted%>) {
                            window.location = currentpage + "&showdeleted=false";
                        } else {
                            window.location = currentpage + "&showdeleted=true";
                        }
                    }
                </script>
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
                            <th>Category</th>
                            <th>Visualized</th>
                            <th>Detail</th>
                        </tr>
                        <% for (int i = 0; i < allalgolist.size(); i++) {%> 
                        <tr>
                            <td><%=allalgolist.get(i).getAlgoID()%></td>
                            <td><%=allalgolist.get(i).getAlgoName()%></td>
                            <td><%=allalgolist.get(i).getCategoryNametoString()%></td>
                            <td><%=allalgolist.get(i).getVisualizedToString()%></td>
                            <td><a href="viewalgo?id=<%=allalgolist.get(i).getAlgoID()%>">View</a></td>
                        </tr>
                        <%}%>
                    </table>

                    <a href="addalgo"><button>Add</button></a>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>    
    </body>
</html>

