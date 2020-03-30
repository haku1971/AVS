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
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

        <style>
            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                transition: background-color .3s;
            }

            .pagination a.active {
                background-color: dodgerblue;
                color: white;
                content: none;
            }
            .pagination a.active:after{
                content: none;
            }

            .pagination a:hover:not(.active) {background-color: #ddd;}

            .container {
                padding-right: 15px;
                padding-left: 15px;
                margin-right: auto;
                margin-left: auto;
            }
            @media (min-width: 768px) {
                .container {
                    width: 750px;
                }
            }
            @media (min-width: 992px) {
                .container {
                    width: 970px;
                }
            }
            @media (min-width: 1200px) {
                .container {
                    width: 1170px;
                }
            }
            .text-center {
                background-color: #eee;
                text-align: center !important;
                width: auto;
                height: 150px;
                background-color: #edf0f4;
            }

        </style>
        <%@include file="header.jsp" %> 
    </head>
    <body>


        <div class="banner">
            <h1 >News Page</h1>
            <h5>Welcome to news page</h5> 
        </div>
        ${numberofsearchresult}

        <% ArrayList<News> listallnews = (ArrayList<News>) request.getAttribute("listallnews");
            String search = (String) request.getAttribute("search");
            int numberOfPage = (Integer) request.getAttribute("numberOfPage");
            int currentPage = (Integer) request.getAttribute("currentPage");
        %>

        <div class="container">
            <div class="col-lm-4"><h3> List of news</h3></div>

            <div  class="col-lm-4">  
                <% if (listallnews != null) {
                        for (int i = 0; i < listallnews.size(); i++) {%>

                <a href="CommentController?newsid=<%=listallnews.get(i).getNewsID()%>"><%=listallnews.get(i).getNewstittles()%> </a>
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


            <div class="col-lm-4" >
                <div class="pagination">
                    <% for (int i = 1; i <= numberOfPage; i++) {
                            if (currentPage == i) {%>

                    <a class="active"> <%=i%></a>
                    <%} else if (search != null) {%>
                    <a href="NewsController?page=<%=i%>&search=<%=search%>"><%=i%></a>
                    <%} else {%>
                    <a href="NewsController?page=<%=i%>"><%=i%></a>
                    <%}
                        }%>
                </div>
            </div>
        </div>

    </body>
</html>
