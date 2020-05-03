<%-- 
    Document   : Admin
    Created on : Mar 18, 2020, 9:07:52 PM
    Author     : Ukah
--%>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/Visual.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />

        <%
            ArrayList<User> alluserlist = (ArrayList<User>) request.getAttribute("userlist");
            int totalpage = (Integer) request.getAttribute("totalpage");
            String searchstring = (String) request.getAttribute("searchstring");
            String columnname = (String) request.getAttribute("columnname");
            String sortorder = (String) request.getAttribute("sortorder");
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
                    <input type="hidden" name="category" value="account">
                    <input type="hidden" id="inputcolumn" name="columnname">
                    <input type="hidden" id="inputsorttype" name="sortorder">
                    <div class="sortby">
                        Sort by: 
                        <select id="select_column" onchange="changeselected()">
                            <option value="n.user_id">ID</option>
                            <option value="user_name">Name</option>
                            <option value="user_rolenum">Role</option>
                            <option value="ban_status">Ban Status</option>
                        </select>
                        <select id="select_sorttype" onchange="changeselected()">
                            <option value="ASC">Ascending</option>
                            <option value="DESC">Descending</option>
                        </select>
                    </div>

                    <div class="searchbox">
                        <input type="text" id="txtsearch" name="searchtxt"/>
                        <input type="submit" value="Search" />       
                    </div>
                </form>
                <div class="table100">
                    <table>
                        <tr class="rowadmin head">
                            <th class="columnadmin">ID</th>
                            <th class="columnadmin">Name</th>
                            <th class="columnadmin">Role</th>
                            <th class="columnadmin">Ban Status</th>
                            <th class="columnadmin">View</th>
                        </tr>
                        <% for (int i = 0; i < alluserlist.size(); i++) {%> 
                        <tr class="rowadmin">
                            <td class="columnadmin"><%=alluserlist.get(i).getId()%></td>
                            <td class="columnadmin"><%=alluserlist.get(i).getUsername()%></td>
                            <td class="columnadmin "><%=alluserlist.get(i).getRolename()%></td>
                            <td class="columnadmin"><%=alluserlist.get(i).getBanstatusString()%></td>
                            <td class="columnadmin"><a href="viewaccount?id=<%=alluserlist.get(i).getId()%>">View</a></td>
                        </tr>
                        <%}%>
                    </table>
                    <div class="adminPaging">
                        <%
                            String currentpageurl = "admin?category=account";
                            String columnnameurl = "&columnname=" + columnname;
                            String sortorderurl = "&sortorder=" + sortorder;
                            String searchtxturl = "&searchtxt=" + searchstring;
                            String currenturl = currentpageurl + columnnameurl + sortorderurl + searchtxturl;
                        %>
                        <% for (int i = 1; i <= totalpage; i++) {%>
                        <a class="pagging" href="<%=currenturl + "&page=" + i%>"><%=i%></a>
                        <%}%>
                    </div>
                </div>

            </div>
            <%@include file="footer.jsp" %>
        </div>

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
                case 'user_id' :
                {
                    selectcolumn.selectedIndex = 0;
                    break;
                }
                case 'user_name' :
                {
                    selectcolumn.selectedIndex = 1;
                    break;
                }
                case 'user_rolenum' :
                {
                    selectcolumn.selectedIndex = 2;
                    break;
                }
                case 'ban_status' :
                {
                    selectcolumn.selectedIndex = 3;
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
