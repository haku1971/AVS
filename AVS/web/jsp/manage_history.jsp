<%-- 
    Document   : viewhistory
    Created on : Mar 21, 2020, 9:56:53 PM
    Author     : Ukah
--%>

<%@page import="Entity.History"%>
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
            ArrayList<History> allhistorylist = (ArrayList<History>) request.getAttribute("historylist");
            String historytype = (String) request.getAttribute("historytype");
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
                
                <div class="tableadmin">
                    <%if(historytype== "user_history" ) {%>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Admin</th>
                            <th>Time</th>
                            <th>Action</th>
                        </tr>
                        <% for (int i = 0; i < allhistorylist.size(); i++) {%> 
                        <tr>
                            <td><%=allhistorylist.get(i).getModID()%></td>
                            <td><%=allhistorylist.get(i).getUser().getUsername()%></td>
                            <td><%=allhistorylist.get(i).getAdmin().getUsername()%></td>
                            <td><%=allhistorylist.get(i).getModTime()%></td>
                            <td><%=allhistorylist.get(i).getBanStatustoString()%></td>
                        </tr>
                        <%}%>
                    </table>
                    <%}%>
                    
                    <%if(historytype== "algo_history" ) {%>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Algo</th>
                            <th>Time</th>
                            <th>Action</th>
                        </tr>
                        <% for (int i = 0; i < allhistorylist.size(); i++) {%> 
                        <tr>
                            <td><%=allhistorylist.get(i).getModID()%></td>
                            <td><%=allhistorylist.get(i).getUser().getUsername()%></td>
                            <td><%=allhistorylist.get(i).getAlgo().getAlgoName()%></td>
                            <td><%=allhistorylist.get(i).getModTime()%></td>
                            <td><%=allhistorylist.get(i).getAction()%></td>
                        </tr>
                        <%}%>
                    </table>
                    <%}%>
                    
                    <%if(historytype== "news_history" ) {%>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>User </th>
                            <th>News title</th>
                            <th>Time</th>
                            <th>Action</th>
                        </tr>
                        <% for (int i = 0; i < allhistorylist.size(); i++) {%> 
                        <tr>
                            <td><%=allhistorylist.get(i).getModID()%></td>
                            <td><%=allhistorylist.get(i).getUser().getUsername()%></td>
                            <td><%=allhistorylist.get(i).getNews().getNewstittles()%></td>
                            <td><%=allhistorylist.get(i).getModTime()%></td>
                            <td><%=allhistorylist.get(i).getAction()%></td>
                        </tr>
                        <%}%>
                    </table>
                    <%}%>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>    
    </body>
</html>