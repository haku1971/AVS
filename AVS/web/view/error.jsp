<%-- 
    Document   : Home
    Created on : Feb 24, 2020, 7:42:27 PM
    Author     : Jisoo
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8;">
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
        <title>Error</title>     
    </head>
    <body>
            <%@include file="header.jsp" %>
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <h1>${errorstring}</h1>
        </div>
        <div class="right">
            <h1>Algorithm Visualize System</h1>
            
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
<script type="text/javascript" src="js/code.js"></script>
</body>
</html>
