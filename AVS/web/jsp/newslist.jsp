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
        <style>
            body {
                background-color: lightblue;
            }

            .newstitletop3 {
                font-family: "Times New Roman", Times, serif;
                color: white;
                font-size: 25px;
                text-decoration: none;
            }
            .top3wrapper {
                background-color: pink;
                padding: 0 10px;
                margin-left: auto;
                margin-right: auto;
                max-width: 1100px;
            }
            .gachngangsautendanhsach{      
                box-sizing: border-box;
            }
            .zn-header__text, .zn-header_preview__text {
                color: #f2f2f2;
                overflow: hidden;
                padding: 0 0 15px;
                position: relative;
                width: 100%;
                font-family: CNN,Helvetica Neue,Helvetica,Arial,Utkal,sans-serif;
                font-weight: 300;
                -webkit-font-smoothing: antialiased;
                font-size: 20px;
                font-size: 1.33333rem;
                line-height: 1.3;
            }
            .cottrai{
                width: 320px;
                padding-left: 10px;
                padding-right: 0;
                clear: left;
                left: 100%;
                margin-left: -320px;
            }
            .cotphai {
                margin-right: -320px;
                clear: left;
                left: 100%;
                margin-left: -320px;
                padding-left: 10px;
                padding-right: 0;
                width: 320px;
            }


        </style>
    </head>
    <body>

        <%@include file="header.jsp" %> 
        <%
            Cookie cookie[] = request.getCookies();
            int age = cookie[0].getMaxAge();
            String username = "";
            String userid = "";
            String roleid = "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("username")) {
                    username = ck.getValue();
                }
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
                if (ck.getName().equals("userid")) {
                    userid = ck.getValue();
                }
                if (age == 0) {
                    username = "";
                }
            }
        %>
 

        ${numberofsearchresult}

        <% ArrayList<News> listallnews = (ArrayList<News>) request.getAttribute("listallnews");
            int numberOfPage = (Integer) request.getAttribute("numberOfPage");
            int currentPage = (Integer) request.getAttribute("currentPage");
        %>
        <h3> List of news</h3>
        <div class="top3wrapper">
            <% if (listallnews != null) {
             for (int i = 0; i < listallnews.size(); i++) {%>
            <a class="newstitletop3" href="CommentController?newsid=<%=listallnews.get(i).getNewsID()%>"><%=listallnews.get(i).getNewstittles()%> </a>
            <br>     
            <p>By: <%=listallnews.get(i).getUser().getFullname()%> <p>
            <p>Content: <%=listallnews.get(i).getNews_shortdescription()%> <p>  
            <p>At:<%=listallnews.get(i).getNewsdaterealease()%> </p>
            <hr>
            <%}
             
            } else {%>
            <p>Do not have list of news now</p>
            <%}%>
        </div>
        <% for (int i = 1; i <= numberOfPage; i++) {
                if (currentPage == i) {%>
        <a id="paging-active"><%=i%></a>
        <%} else {%>
        <a href="NewsController?page=<%=i%>"><%=i%></a>
        <%}%>
        <%}%>


    </body>
</html>
