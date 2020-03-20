<%-- 
    Document   : viewnews
    Created on : Mar 20, 2020, 9:17:00 PM
    Author     : Ukah
--%>

<%@page import="Entity.News"%>
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
            News news = (News) request.getAttribute("news");
            Boolean addnew = (Boolean) request.getAttribute("addnew");
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

                    <div class="newsinfomation">
                    <%if (addnew) {%>
                    <!--trang addnew-->
                    <form>
                        <div>Title: </div> <div><input type="text" value=""></div>
                        <div>Content:  </div> <div><textarea name="txtcode" rows="10" cols="30" ></textarea></div>
                        <div>Source: </div> <div><input type="text" value=""></div>
                        
                        <input type="submit" value="Save">
                    </form>
                    <a href="admin?category=news"><button>Cancel</button></a>
                    <%} else {%>
                    <!--trang view-->
                    <div class="algoid">News ID: <%=news.getNewsID()%></div>
                    <form>
                        <div>Title: </div> <div><input type="text" value="<%=news.getNewstittles()%>"></div>
                        <div>Content:  </div> <div><textarea name="txtcode" rows="10" cols="30" ><%=news.getNewscontent()%></textarea></div>
                        <div>Source: </div> <div><input type="text" value="<%=news.getNewsresource()%>"></div>
                        
                        <input type="submit" value="Save">
                    </form>
                    <a href="admin?category=news"><button>Back</button></a>
                    <form>
                        <input type="submit" value="Delete">
                    </form>
                    <%}%>
                </div>
            </div>
            <%@include file="footer.jsp" %>    

    </body>

</html>
