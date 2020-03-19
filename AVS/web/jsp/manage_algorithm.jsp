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
            ArrayList<Algorithm> allalgolist = (ArrayList<Algorithm>) request.getAttribute("algolist");
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
                    
                    <form action="addalgo">
                        <input type="submit" value="Add">
                    </form>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>    
    </body>
</html>

