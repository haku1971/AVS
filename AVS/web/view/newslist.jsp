<%-- 
    Document   : newslist
    Created on : Mar 15, 2020, 11:59:34 AM
    Author     : quang
--%>

<%@page import="Model.News"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>News</title>
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

        <style>
            .pagination a, .notactive {
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

            .pagination .notactive.active{
                 background-color: dodgerblue;
                color: white;
                content: none;
            }
            .pagination .notactive:after{
                 content: none;
            }
             .pagination .notactive:hover:not(.active) {background-color: #ddd;}
             
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


        <% ArrayList<News> listallnews = (ArrayList<News>) request.getAttribute("listallnews");
            String search = (String) request.getAttribute("SearchValue");
            int numberOfPage = (Integer) request.getAttribute("numberOfPage");
            int currentPage = (Integer) request.getAttribute("currentPage");
        %>

        <div class="container">
            <div class="SearchResult"><c:out value="${numberofsearchresult}"/></div>         
            <div  class="col-lm-4">  
                <% if (listallnews != null && !listallnews.isEmpty()) { %>
                <div class="col-lm-4"><h3> List of news</h3></div>
                <%
                    for (int i = 0; i < listallnews.size(); i++) {%>

                <a href="newsdetail?id=<%=listallnews.get(i).getNewsID()%>"><%=listallnews.get(i).getNewstittles()%> </a>
                <br>     
                <p>By: <%=listallnews.get(i).getUser().getFullname()%> <p>
                <p>Content: <%=listallnews.get(i).getNews_shortdescription()%> <p>  
                <p>At:<%=listallnews.get(i).getNewsdaterealease().substring(0, listallnews.get(i).getNewsdaterealease().length() - 5)%> </p>
                <hr>
                <%}

                } else {%>
                <p>${searchnoti}</p>
                <p>Do not have list of news now</p>
                <%}%>
            </div>        
            <div class="col-lm-4" >
                <div class="pagination">
                    <% for (int i = 1; i <= numberOfPage; i++) {
                            if (currentPage == i) {%>
                    <a class="active"> <%=i%></a>
                    <%} else if (search != null) {%>              
                    <div><form method="Post" action="news">
                            <input type="hidden" name="search" value="<%=search%>" />   
                            <input type="hidden" name="page" value="<%=i%>" />  
                            <button class="notactive"><%=i%></button>
                        </form>
                    </div>
                    <%} else {%>
                    <a href="news?page=<%=i%>"><%=i%></a>
                    <%}
                        }%>
                </div>
            </div>
        </div>

    </body>
</html>
