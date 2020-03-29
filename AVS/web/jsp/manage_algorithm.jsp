<%-- 
    Document   : viewalgorithm
    Created on : Mar 19, 2020, 8:08:46 PM
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
            ArrayList<Algorithm> allalgolist = (ArrayList<Algorithm>) request.getAttribute("algolist");
            int totalpage = (Integer) request.getAttribute("totalpage");
            String showdeleted = (String) request.getAttribute("showdeleted");
            if (showdeleted == null) {
                showdeleted = "notshow";
            }
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

            <div class="right">
                <form action="admin">
                    <input type="hidden" name="category" value="algorithm">
                    <input type="hidden" id="inputcolumn" name="columnname">
                    <input type="hidden" id="inputsorttype" name="sortorder">
                    <div class="sortby">
                        Sort by: 
                        <select id="select_column" onchange="changeselected()">
                            <option value="algo_id">ID</option>
                            <option value="algo_name">Name</option>
                            <option value="category_id">Category</option>
                            <option value="algo_comparestatus">Visualized</option>
                        </select>
                        <select id="select_sorttype" onchange="changeselected()">
                            <option value="ASC">Ascending</option>
                            <option value="DESC">Descending</option>
                        </select>
                        <input type="checkbox" id="checkshowdeleted" name="showdeleted">
                        <label for="showdeleted"> Show Deleted</label>
                    </div>

                    <div class="searchbox">
                        <input type="text" id="txtsearch" name="searchtxt"/>
                        <input type="submit" value="Search" />       
                    </div>
                </form>
                <div class="tableadmin">
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Visualized</th>
                            <th>Detail</th>
                        </tr>
                        <% for (int i = 0; i < allalgolist.size(); i++) {%> 
                        <tr>
                            <td><%=allalgolist.get(i).getAlgoID()%></td>
                            <td><%=allalgolist.get(i).getAlgoName()%></td>
                            <td><%=allalgolist.get(i).getCategoryNametoString()%></td>
                            <td><%=allalgolist.get(i).getVisualizedToString()%></td>
                            <td><a href="viewalgo?id=<%=allalgolist.get(i).getAlgoID()%>">View</a></td>
                        </tr>
                        <%}%>
                    </table>
                    <div>
                        <%
                            String currentpageurl = "admin?category=algorithm";
                            String columnnameurl = "&columnname=" + columnname;
                            String sortorderurl = "&sortorder=" + sortorder;
                            String showdeletedurl = "";
                            if (showdeleted == "showdeleted") {
                                showdeletedurl = "&showdeleted=on";
                            }
                            String searchtxturl = "&searchtxt="+searchstring;
                            String currenturl = currentpageurl+columnnameurl+sortorderurl+showdeletedurl+searchtxturl;
                        %>
                        <% for (int i = 1; i <= totalpage; i++) {%>
                        <a href="<%=currenturl+"&page="+i%>"><%=i%></a>
                        <%}%>
                    </div>
                    <a href="addalgo"><button>Add</button></a>
                </div>
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
                case 'algo_id' :
                {
                    selectcolumn.selectedIndex = 0;
                    break;
                }
                case 'algo_name' :
                {
                    selectcolumn.selectedIndex = 1;
                    break;
                }
                case 'category_id' :
                {
                    selectcolumn.selectedIndex = 2;
                    break;
                }
                case 'algo_comparestatus' :
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

