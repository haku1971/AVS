<%-- 
    Document   : manage_news
    Created on : Mar 20, 2020, 8:41:53 PM
    Author     : Ukah
--%>

<%@page import="Model.News"%>
<%@page import="DAO.UserDAO"%>
<%@page import="Model.User"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Model.Algorithm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>

        <%
            ArrayList<News> allnews = (ArrayList<News>) request.getAttribute("newslist");
            int totalpage = (Integer) request.getAttribute("totalpage");
            String showdeleted = (String) request.getAttribute("showdeleted");
            if (showdeleted == null) {
                showdeleted = "notshow";
            }
            String searchstring = (String) request.getAttribute("searchstring");
            String columnname = (String) request.getAttribute("columnname");
            String sortorder = (String) request.getAttribute("sortorder");
            int currentPage = (Integer) request.getAttribute("currentPage");
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

            <div class="adminright">
                <form action="admin">
                    <div class="tool">
                        <input type="hidden" name="category" value="news">
                        <input type="hidden" id="inputcolumn" name="columnname">
                        <input type="hidden" id="inputsorttype" name="sortorder">
                        <div class="sortby">
                            Sort by: 
                            <div class="inline">
                                <div class="select">
                                    <select id="select_column" onchange="changeselected()">
                                        <option value="news_id">ID</option>
                                        <option value="news_Tittles">Title</option>
                                        <option value="news_DateRealease">Create Date</option>
                                        <option value="user_Name">Editor</option>
                                        <option value="news_Imgs">Image</option>
                                    </select>
                                </div>
                            </div>
                            <div class="inline">
                                <div class="select">
                                    <select id="select_sorttype" onchange="changeselected()">
                                        <option value="ASC">Ascending</option>
                                        <option value="DESC">Descending</option>
                                    </select>
                                </div>
                            </div>
                            <input type="checkbox" id="checkshowdeleted" name="showdeleted">
                            <label for="showdeleted"> Show Deleted</label>
                            <input type="text" id="txtsearch" name="searchtxt"/>
                            <input class="adminSearch" type="submit" value="Search" />     
                        </div>
                    </div>
                </form>
                <% if (allnews.isEmpty()) {%>
                <div class="emptyTable">No data!</div>
                <%} else {%>
                <div class="table100">
                    <table>
                        <tr class="rowadmin head">
                            <th class="columnadmin">ID</th>
                            <th class="columnadmin">Title</th>
                            <th class="columnadmin">Create Date</th>
                            <th class="columnadmin">Editor</th>
                            <th class="columnadmin">Image</th>
                            <th class="columnadmin">Detail</th>
                                <% if (showdeleted == "showdeleted") {%>
                            <th>Deleted</th>
                                <%}%>
                        </tr>
                        <% for (int i = 0; i < allnews.size(); i++) {%> 
                        <tr class="rowadmin">
                            <td class="columnadmin"><%=allnews.get(i).getNewsID()%></td>
                            <td class="columnadmin"><%=allnews.get(i).getNewstittles()%></td>
                            <td class="columnadmin"><%=allnews.get(i).getNewsdaterealeaseToMinute()%></td>
                            <td class="columnadmin"><%=allnews.get(i).getUser().getUsername()%></td>
                            <td class="columnadmin"><%=allnews.get(i).getNews_Imgs()%></td>
                            <td class="columnadmin"><a href="viewnews?id=<%=allnews.get(i).getNewsID()%>"><button class="buttonheader type5">View</button></a></td>
                            <% if (showdeleted == "showdeleted") {%>
                            <td><%=allnews.get(i).getDeletedToString()%></td>
                            <%}%>
                        </tr>
                        <%}%>
                    </table>
                    <div class="adminPaging">
                        <%
                            String currentpageurl = "admin?category=news";
                            String columnnameurl = "&columnname=" + columnname;
                            String sortorderurl = "&sortorder=" + sortorder;
                            String showdeletedurl = "";
                            if (showdeleted == "showdeleted") {
                                showdeletedurl = "&showdeleted=on";
                            }
                            String searchtxturl = "&searchtxt=" + searchstring;
                            String currenturl = currentpageurl + columnnameurl + sortorderurl + showdeletedurl + searchtxturl;
                        %>
                        <% for (int i = 1; i <= totalpage; i++) {
                                if (currentPage == i) {%>
                        <a class="pagging" href="<%=currenturl + "&page=" + i%>"><%=i%></a>
                        <%} else {%>
                        <a class="notactive" href="<%=currenturl + "&page=" + i%>"><%=i%></a>
                        <%}
                            }%>
                        <div class="addBtn">
                            <a href="addnews"><button class="buttonheader type4">Add</button></a>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>

        </div>
        <%@include file="footer.jsp" %>  
    </body>
    <script>
        var selectcolumn = document.getElementById("select_column");
        var selectsortype = document.getElementById("select_sorttype");
        var checkshowdeleted = document.getElementById("checkshowdeleted");
        var txtsearch = document.getElementById("txtsearch");
        function init() {
            var columnname = '<%=columnname%>';
            var sortorder = '<%=sortorder%>'
            switch (columnname) {
                case 'news_id' :
                {
                    selectcolumn.selectedIndex = 0;
                    break;
                }
                case 'news_Tittles' :
                {
                    selectcolumn.selectedIndex = 1;
                    break;
                }
                case 'news_DateRealease' :
                {
                    selectcolumn.selectedIndex = 2;
                    break;
                }
                case 'user_Name' :
                {
                    selectcolumn.selectedIndex = 3;
                    break;
                }
                case 'news_Imgs' :
                {
                    selectcolumn.selectedIndex = 4;
                    break;
                }
            }
            switch (sortorder) {
                case 'ASC' :
                {
                    selectsortype.selectedIndex = 0;
                    break;
                }
                case 'DESC' :
                {
                    selectsortype.selectedIndex = 1;
                    break;
                }
            }
            var showdeleted = "<%=showdeleted%>";
            if (showdeleted === "showdeleted") {
                checkshowdeleted.checked = "checked";
            }
            txtsearch.value = "<%=searchstring%>";
        }
        function changeselected() {

            document.getElementById("inputcolumn").value = selectcolumn.options[selectcolumn.selectedIndex].value;

            document.getElementById("inputsorttype").value = selectsortype.options[selectsortype.selectedIndex].value;
        }

        init();
        changeselected();
    </script>
</html>
