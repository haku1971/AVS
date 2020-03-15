<%-- 
    Document   : newslist
    Created on : Mar 15, 2020, 11:59:34 AM
    Author     : quang
--%>

<%@page import="Entity.News"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>new list Page</title>
    </head>
    <body>
        <% ArrayList<News> listallnews = (ArrayList<News>) request.getAttribute("listallnews");
        %>
        <h3> List of news</h3>
        <%for (int i = 0; i < listallnews.size(); i++) {%>
        <a href="CommentController?newsid=<%=listallnews.get(i).getNewID()%>"><%=listallnews.get(i).getNewtittles()%> </a>
        <br>
        <p>By: <%=listallnews.get(i).getUser().getId()%> <p>
        <p>At:<%=listallnews.get(i).getNewdaterealease() %> </p>
        <hr>
        <%}%>
    </body>
</html>
