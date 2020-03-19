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
        <style>
            #category {
                background-color: #edf0f4;
                color: black;
                cursor: pointer;
                padding: 18px;
                width: inherit;
                border: none;
                text-align: left;
                outline: none;
                font-size: 15px;
            }

            #category>a {
                color: black;
                cursor: pointer;
                width: 100%;
                border: none;
                outline: none;
                font-size: 15px;
            }

            #category:hover {
                background-color: gray;
                color: aqua;
            }

            .category_active{
                background-color: gray !important;
                color: aqua !important;
            }

            .tableadmin>table {
                border-collapse: collapse;
            }

            table,th,td{
                border: #29323d solid 1px;
            }

            .show{
                max-height: 97px !important;
            }
        </style>
        <%
            String category = (String) request.getAttribute("category");
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
            <div class="left">
                <a style="text-decoration: none"  href="admin?category=account"><div <c:if test="${category eq 'account'}">class="category_active"</c:if> id="category">Account</div></a>
                <a style="text-decoration: none"  href="admin?category=algorithm"><div <c:if test="${category eq 'algorithm'}">class="category_active"</c:if>id="category" >Algorithm</div></a>
                <a style="text-decoration: none"  href="admin?category=news"><div <c:if test="${category eq 'news'}">class="category_active"</c:if>id="category" >News</div></a>
                <a style="text-decoration: none"  ><div <c:if test="${category eq 'history'}">class="category_active"</c:if>id="category">History</div></a>
                    <div class="content show">
                        <ul class="list_items"> 
                            <li><a style=" text-decoration: none;" id="AlgoNameList" href="">User history</a></li>
                            <li><a style=" text-decoration: none;" id="AlgoNameList" href="">Algorithm history</a></li>
                            <li><a style=" text-decoration: none;" id="AlgoNameList" href="">News history</a></li>
                        </ul>
                    </div>
                </div>
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
