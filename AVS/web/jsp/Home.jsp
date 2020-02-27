<%-- 
    Document   : Home
    Created on : Feb 24, 2020, 7:42:27 PM
    Author     : Jisoo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Entity.Algorithm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <title>AVS</title>
       <%
            ArrayList<Algorithm> AllAlgorithm = (ArrayList<Algorithm>) request.getAttribute("AllAlgorithm");
        %>
               <%
            ArrayList<Algorithm> AllAlgorithm2 = (ArrayList<Algorithm>) request.getAttribute("AllAlgorithm2");
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
                <button type="button" class="collapsible">Sort Algorithm</button>
                <div class="content">
                    <ul class="list_items">
                        <% for (Algorithm algo : AllAlgorithm) {%>
                        <li><%=algo.getAlgoName()%></li>
                            <%}%>
                    </ul>
                </div>
                <hr/>
                <button type="button" class="collapsible">Search Algorithm</button>
                <div class="content">
                    <ul class="list_items">
                        <% for (Algorithm algo2 : AllAlgorithm2) {%>
                        <li><%=algo2.getAlgoName()%></li>
                            <%}%>
                    </ul>
                </div>
                <hr/>
                <button type="button" class="collapsible">Others Algorithm</button>
                <div class="content">
                    <ul class="list_items">
                        <li>Comming Soon</li>
                    </ul>
                </div>
            </div>
            <div class="right">
                <h1>Algorithm Visualize System</h1>
                <h5 id="h5_1">Algorithm Visualize System is a interactive online platform that visualize algorithm from code</h5>
                <h5 id="h5_2">Learning algorithm much easier with animation and explain,Still confuse? Check out for more information</h5>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp" %>
</div>
<script type="text/javascript" src="js/code.js"></script>
</body>
</html>
