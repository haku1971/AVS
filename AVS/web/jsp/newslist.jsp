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
        <%
            Cookie cookie[] = request.getCookies();
            int age = cookie[0].getMaxAge();
            String username = "";
            String userid = "";

            for (Cookie ck : cookie) {
                if (ck.getName().equals("username")) {
                    username = ck.getValue();
                }
                if (ck.getName().equals("roleid")) {
                    userid = ck.getValue();
                }
                if (age == 0) {
                    username = "";
                }
            }
        %>
        <%= userid %>
         <%= username %>
        
        
        <% ArrayList<News> listallnews = (ArrayList<News>) request.getAttribute("listallnews");
        %>
        <h3> List of news</h3>
        <% if (listallnews != null) { %>
        <%for (int i = 0; i < listallnews.size(); i++) {%>
        <a href="CommentController?newsid=<%=listallnews.get(i).getNewID()%>"><%=listallnews.get(i).getNewtittles()%> </a>
        <br>
        <p>By: <%=listallnews.get(i).getUser().getFullname()%> <p>
        <p>Content: <%=listallnews.get(i).getNews_shortdescription() %> <p>  
        <p>At:<%=listallnews.get(i).getNewdaterealease()%> </p>
        <hr>
        <%}
        } else {%>
        <p>Do not have list of news now</p>
        <%}%>
    </body>
</html>
