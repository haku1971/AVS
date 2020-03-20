<%-- 
    Document   : viewalgo
    Created on : Mar 19, 2020, 9:15:51 PM
    Author     : Ukah
--%>

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
            Algorithm algo = (Algorithm) request.getAttribute("algo");
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

                    <div class="algoinfomation">
                    <%if (addnew) {%>
                    <!--trang addnew-->
                    <form>
                        <div>Name: </div> <div><input type="text" value=""></div>
                        <div>Code:  </div> <div><textarea name="txtcode" rows="10" cols="30" ></textarea></div>
                        <div>Description: </div> <div><textarea name="txtdescription" rows="10" cols="30" ></textarea></div>
                        <div>Category: </div> <div>
                            <select id="select_column">
                                <option value="Sort">Sort</option>
                                <option value="Search">Search</option>
                                <option value="Other">Other</option>
                            </select></div>
                        <input type="submit" value="Save">
                    </form>
                    <a href="admin?category=algorithm"><button>Cancel</button></a>
                    <%} else {%>
                    <!--trang view-->
                    <div class="algoid">Algorithm ID: <%=algo.getAlgoID()%></div>
                    <form>
                        <div>Name: </div> <div><input type="text" value="<%=algo.getAlgoName()%>"></div>
                        <div>Code:  </div> <div><textarea name="txtcode" rows="10" cols="30" ><%=algo.getAlgoCodeJS()%></textarea></div>
                        <div>Description: </div> <div><textarea name="txtdescription" rows="10" cols="30" ><%=algo.getAlgoDescription()%></textarea></div>
                        <div>Category: </div> <div>
                            <select id="select_column">
                                <option value="Sort">Sort</option>
                                <option value="Search">Search</option>
                                <option value="Other">Other</option>
                            </select></div>
                        <input type="submit" value="Save">
                    </form>
                    <a href="admin?category=algorithm"><button>Back</button></a>
                    <form>
                        <input type="submit" value="Delete">
                    </form>
                    <script>
                        document.getElementById("select_column").selectedIndex = <%=algo.getCategoryID()%> - 1;
                    </script>
                    <%}%>
                </div>
            </div>
            <%@include file="footer.jsp" %>    

    </body>

</html>
