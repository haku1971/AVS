<%-- 
    Document   : Admin
    Created on : Mar 18, 2020, 9:07:52 PM
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
        <!--<script type="text/javascript" src="js/Sort.js"></script>-->
        <link rel="stylesheet" type="text/css" href="css/Visual.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        
        <%
            ArrayList<User> alluserlist = (ArrayList<User>) request.getAttribute("userlist");
            String sortoption = (String) request.getAttribute("sortoption");
            String sortdirection = (String) request.getAttribute("sortdirection");
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
                    <div class="sortby">
                        Sort by: 
                        <select id="select_column" onchange="this.options[this.selectedIndex].value && (window.location = this.options[this.selectedIndex].value);">
                            <option id="option_id"  value="sortoption=id" <%if(sortoption.equals("id")){%>selected="selected" <%}%>>ID</option>
                            <option id="option_name" value="sortoption=name" <%if(sortoption.equals("name")){%>selected="selected" <%}%>>Name</option>
                            <option id="option_role" value="sortoption=role" <%if(sortoption.equals("role")){%>selected="selected" <%}%>>Role</option>
                            <option id="option_banstatus" value="sortoption=banstatus" <%if(sortoption.equals("banstatus")){%>selected="selected" <%}%>>Ban Status</option>
                        </select>
                        <select id="select_sortdirection" onchange="this.options[this.selectedIndex].value && (window.location = this.options[this.selectedIndex].value);">
                            <option id="option_ascending" value="sortdirection=ascending" <%if(sortdirection.equals("ascending")){%>selected="selected" <%}%>>Ascending</option>
                            <option id="option_descending" value="sortdirection=descending" <%if(sortdirection.equals("descending")){%>selected="selected" <%}%>>Descending</option>
                        </select>
                        <script>
                            var select_column = document.getElementById("select_column");
                            var select_sortdirection = document.getElementById("select_sortdirection");
                            var selectedsortoption = select_column.options[select_column.selectedIndex].value;
                            var selectedsortdirection = select_sortdirection.options[select_sortdirection.selectedIndex].value;
                            var currentpage = "admin?category=account";
                            document.getElementById("option_id").value = currentpage + "&sortoption=id&" + selectedsortdirection;
                            document.getElementById("option_name").value = currentpage + "&sortoption=name&" + selectedsortdirection;
                            document.getElementById("option_role").value = currentpage + "&sortoption=role&" + selectedsortdirection;
                            document.getElementById("option_banstatus").value = currentpage + "&sortoption=banstatus&" + selectedsortdirection;
                            
                            document.getElementById("option_ascending").value = currentpage + "&" + selectedsortoption + "&sortdirection=ascending";
                            document.getElementById("option_descending").value = currentpage + "&" + selectedsortoption + "&sortdirection=descending";
                        </script>
                    </div>
                    <div class="searchbox">
                        <form  method="POST" action="">
                            <input type="text" id=txtsearch" name="txtsearch"/>
                            <input type="submit" id="submitsearch" name="submitsearch" value="Search" />       
                        </form>
                    </div>
                    <div class="tableadmin">
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Role</th>
                                <th>Ban Status</th>
                                <th>View</th>
                            </tr>
                        <% for (int i = 0; i < alluserlist.size(); i++) {%> 
                        <tr>
                            <td><%=alluserlist.get(i).getId()%></td>
                            <td><%=alluserlist.get(i).getUsername()%></td>
                            <td><%=alluserlist.get(i).getRolenumString()%></td>
                            <td><%=alluserlist.get(i).getBanstatusString()%></td>
                            <td><a href="viewaccount?id=<%=alluserlist.get(i).getId()%>">View</a></td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>
            <%@include file="footer.jsp" %>    
            
    </body>
</html>
