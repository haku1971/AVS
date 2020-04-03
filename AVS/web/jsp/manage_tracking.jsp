<%-- 
    Document   : manage_Tracking
    Created on : Apr 2, 2020, 2:23:07 AM
    Author     : Asus
--%>

<%@page import="Entity.Tracking"%>
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
        <link rel="stylesheet" type="text/css" href="css/Visual.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />

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

            <div class="right">

                Days Tracking: 
                <select id="select_daystracking" onchange="changeDaysTracking(this.value)">
                    <option value="1">1</option>
                    <option value="7">7</option>
                    <option value="30">30</option>
                </select>
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
                <table>
                    <tr>
                        <th>AlgoID</th>
                        <th>Total Time</th>
                        <th>Total People</th>

                    </tr>
                    <% for (int i = 0; i < alltrackinglist.size(); i++) {%> 
                    <tr>
                        <td><%=alltrackinglist.get(i).getAlgoID()%></td>
                        <td><%=alltrackinglist.get(i).getTotalTime()%></td>
                        <td><%=alltrackinglist.get(i).getTotalPeople()%></td>
                    </tr>
                    <%}%>
                </table>
                <%
                    String currentpageurl = "admin?category=tracking";
                    String daystrackingurl = "&daystracking=" + daystracking;
                    String currenturl = currentpageurl + daystrackingurl;
                %>
                <% for (int i = 1; i <= totalpage; i++) {%>
                <a href="<%=currenturl + "&page=" + i%>"><%=i%></a>
                <%}%>
            </div>
        </div>
        <%@include file="footer.jsp" %>    
    </body>
    <script>

    </script>
</html>
