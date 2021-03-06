<%-- 
    Document   : viewhistory
    Created on : Mar 21, 2020, 9:56:53 PM
    Author     : Ukah
--%>

<%@page import="Model.History"%>
<%@page import="DAO.UserDAO"%>
<%@page import="Model.User"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Model.Algorithm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>

        <%
            ArrayList<History> allhistorylist = (ArrayList<History>) request.getAttribute("historylist");
            String historytype = (String) request.getAttribute("historytype");
            int totalpage = (Integer) request.getAttribute("totalpage");
            int currentPage = (Integer) request.getAttribute("currentPage");
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

            <div class="adminright">
                <%if (!allhistorylist.isEmpty()) {%>
                <div class="table100">
                    <%if (historytype == "user_history") {%>
                    <div class="tableName">User History</div>
                    <table>
                        <tr class="rowadmin head">
                            <th class="columnadmin">ID</th>
                            <th class="columnadmin">User</th>
                            <th class="columnadmin">Admin</th>
                            <th class="columnadmin">Time</th>
                            <th class="columnadmin">Action</th>
                        </tr>
                        <% for (int i = 0; i < allhistorylist.size(); i++) {%> 
                        <tr class="rowadmin">
                            <td class="columnadmin"><%=allhistorylist.get(i).getModID()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getUser().getUsername()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getAdmin().getUsername()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getModTimeToMinute()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getBanStatustoString()%></td>
                        </tr>
                        <%}%>
                    </table>
                    <%}%>

                    <%if (historytype == "algo_history") {%>
                    <div class="tableName">Algorithm History</div>
                    <table>
                        <tr class="rowadmin head">
                            <th class="columnadmin">ID</th>
                            <th class="columnadmin">User</th>
                            <th class="columnadmin">Algo</th>
                            <th class="columnadmin">Time</th>
                            <th class="columnadmin">Action</th>
                        </tr>
                        <% for (int i = 0; i < allhistorylist.size(); i++) {%> 
                        <tr class="rowadmin">
                            <td class="columnadmin"><%=allhistorylist.get(i).getModID()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getUser().getUsername()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getAlgo().getAlgoName()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getModTimeToMinute()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getAction()%></td>
                        </tr>
                        <%}%>
                    </table>
                    <%}%>

                    <%if (historytype == "news_history") {%>
                    <div class="tableName">News History</div>
                    <table>
                        <tr class="rowadmin head">
                            <th class="columnadmin">ID</th>
                            <th class="columnadmin">User </th>
                            <th class="columnadmin">News title</th>
                            <th class="columnadmin">Time</th>
                            <th class="columnadmin">Action</th>
                        </tr>
                        <% for (int i = 0; i < allhistorylist.size(); i++) {%> 
                        <tr class="rowadmin">
                            <td class="columnadmin"><%=allhistorylist.get(i).getModID()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getUser().getUsername()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getNews().getNewstittles()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getModTimeToMinute()%></td>
                            <td class="columnadmin"><%=allhistorylist.get(i).getAction()%></td>
                        </tr>
                        <%}%>
                    </table>
                    <%}%>
                    <div class="adminPaging">
                        <%
                            String currentpageurl = "admin?category=" + historytype;
                        %>
                        <% for (int i = 1; i <= totalpage; i++) {
                                if (currentPage == i) {%>
                        <a class="pagging"> <%=i%></a>
                        <%} else {%>    
                        <a class="notactive" href="<%=currentpageurl + "&page=" + i%>"><%=i%></a>
                        <%}
                            }%>
                    </div>
                </div>
                <%} else {%>
                <div class="emptyTable">No data recorded!</div>
                <%}%>
            </div>

        </div>  
        <%@include file="footer.jsp" %> 

    </body>
    <script>

    </script>
</html>