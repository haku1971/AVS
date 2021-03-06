<%-- 
    Document   : manage_Tracking
    Created on : Apr 2, 2020, 2:23:07 AM
    Author     : Asus
--%>

<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.math.BigInteger"%>
<%@page import="Model.Tracking"%>
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
            ArrayList<Tracking> alltrackinglist = (ArrayList<Tracking>) request.getAttribute("trackinglist");
            int totalpage = (Integer) request.getAttribute("totalpage");
            String daystracking = (String) request.getAttribute("daystracking");
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
                <div class="tool">
                    <div class="sortby">
                        Get data from 
                        <div class="inline">
                            <div class="select">
                                <select id="select_daystracking" onchange="changeDaysTracking(this.value)">
                                    <option value="1">1</option>
                                    <option value="7">7</option>
                                    <option value="30">30</option>
                                </select> 
                            </div>
                        </div>
                        days ago.
                    </div>
                </div>
                <script>
                    var select_daystracking = document.getElementById("select_daystracking");
                    var daystracking = "<%=daystracking%>";
                    switch (daystracking) {
                        case "7" :
                            select_daystracking.selectedIndex = 1;
                            break;
                        case "30" :
                            select_daystracking.selectedIndex = 2;
                            break;
                    }
                    function changeDaysTracking(value) {
                        window.location.assign("admin?category=tracking&daystracking=" + value);
                    }
                </script>
                <% if (alltrackinglist.isEmpty()) {%>
                <div class="emptyTable">No data recorded!</div>
                <%} else {%>
                <div class="table100">
                    <table>
                        <tr class="rowadmin head">
                            <th class="columnadmin">AlgoID</th>
                             <th class="columnadmin">Algorithm Name</th>
                            <th class="columnadmin">Total Time</th>
                            <th class="columnadmin">Total People</th>

                        </tr>
                        <% for (int i = 0; i < alltrackinglist.size(); i++) {%> 
                        <tr class="rowadmin">
                            <td class="columnadmin"><%=alltrackinglist.get(i).getAlgoID()%></td>
                            <td class="columnadmin"><%=alltrackinglist.get(i).getAlgoName() %></td>
                            <%
                                long millisecon = alltrackinglist.get(i).getTotalTime().longValue();
                                long day = TimeUnit.MILLISECONDS.toDays(millisecon);
                                long hour = TimeUnit.MILLISECONDS.toHours(millisecon) - TimeUnit.DAYS.toHours(TimeUnit.MILLISECONDS.toDays(millisecon));
                                long minute = TimeUnit.MILLISECONDS.toMinutes(millisecon) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(millisecon));
                                long second = TimeUnit.MILLISECONDS.toSeconds(millisecon) - TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millisecon));
                            %>
                            <td class="columnadmin">
                                <%if (day != 0) {%> <%=day%> Days <%}%>
                                <%if (hour != 0) {%> <%=hour%> Hours<%}%>
                                <%if (minute != 0) {%> <%=minute%> Minutes<%}%>
                                <%=second%> Second</td>
                            <td class="columnadmin"><%=alltrackinglist.get(i).getTotalPeople()%></td>
                        </tr>
                        <%}%>
                    </table>
                </div>
                <%
                    String currentpageurl = "admin?category=tracking";
                    String daystrackingurl = "&daystracking=" + daystracking;
                    String currenturl = currentpageurl + daystrackingurl;
                %>
                <div class="adminPaging">
                    <% for (int i = 1; i <= totalpage; i++) {%>
                    <a class="pagging" href="<%=currenturl + "&page=" + i%>"><%=i%></a>
                    <%}%>
                </div>
                <%}%>
            </div>

        </div>   
        <%@include file="footer.jsp" %>  
    </body>
    <script>

    </script>
</html>
