<%-- 
    Document   : Home
    Created on : Feb 24, 2020, 7:42:27 PM
    Author     : Jisoo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Model.Algorithm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8;">
        <title>AVS</title>
        <%
            ArrayList<Algorithm> AllAlgorithm = (ArrayList<Algorithm>) request.getAttribute("AllAlgorithm");
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

                <% String currentCategory = "";
                    boolean startUL = false;
                    boolean changeCategory = false;
                    for (Algorithm a : AllAlgorithm) {
                        if (!currentCategory.equals(a.getCategoryName())) {
                            changeCategory = true;
                            currentCategory = a.getCategoryName();
                        }
                        if (changeCategory) {
                            changeCategory = false;
                            if (startUL) {%>
                </ul>
            </div>
            <%}%>
            <button type="button" class="collapsible"><%=a.getCategoryName()%></button>
            <div class="content">
                <ul class="list_items"> 
                    <% startUL = true; %>
                    <%}
                        if (user.equals("anon")) {%>
                    <a style=" text-decoration: none;" id="AlgoNameList" onclick="document.location = '/AVS/inputusername';return false"><li><%=a.getAlgoName()%></li></a>
                            <%} else {%>
                    <a style=" text-decoration: none;" id="AlgoNameList" href="Detail?AlgoID=<%=a.getAlgoID()%>"><li><%=a.getAlgoName()%></li></a>
                            <%}
                            }%>
                </ul>
            </div>
        </div>
        <div class="right">
            <h1>Algorithm Visualize System</h1>
            <h5 id="h5_1">Algorithm Visualize System is a interactive online platform that visualize algorithm</h5>
            <h5 id="h5_2">Learning algorithm much easier with animation and explain,Still confuse? Check out for more information</h5>
        </div>

    </div>
    <%@include file="footer.jsp" %>
</div>

<script type="text/javascript" src="js/code.js"></script>
</body>
</html>
