<%-- 
    Document   : adminleft
    Created on : Mar 20, 2020, 9:35:13 PM
    Author     : Ukah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/admin.css" />
        <%
            String category = (String) request.getAttribute("category");
            if (category == null) {
                category = "";
            }
        %>
    </head>

    <body>
        <div class="adminleft">
            <a style="text-decoration: none"  href="admin?category=account"><div <c:if test="${category eq 'account'}">class="category_active"</c:if> id="category">Account</div></a>
            <a style="text-decoration: none"  href="admin?category=algorithm"><div <c:if test="${category eq 'algorithm'}">class="category_active"</c:if>id="category" >Algorithm</div></a>
            <a style="text-decoration: none"  href="admin?category=news"><div <c:if test="${category eq 'news'}">class="category_active"</c:if>id="category" >News</div></a>
            <a style="text-decoration: none"  href="admin?category=tracking"><div <c:if test="${category eq 'tracking'}">class="category_active"</c:if>id="category" >Tracking</div></a>
            <button type="button" class="collapsible" id="historybutton">History</button>
            <div class="content show">
                <ul class="list_items"> 
                    <a style=" text-decoration: none;" id="user_history" href="admin?category=user_history""><li>User history</li></a>
                    <a style=" text-decoration: none;" id="algo_history" href="admin?category=algo_history""><li>Algorithm history</li></a>
                    <a style=" text-decoration: none;" id="news_history" href="admin?category=news_history""><li>News history</li></a>

                </ul>
            </div>
        </div>
        <script type="text/javascript" src="js/code.js"></script>
    </body>
    <% if (category.equals("history")) {%>
    <script>
        document.getElementById("historybutton").click();
    </script>
    <%}%>
</html>
