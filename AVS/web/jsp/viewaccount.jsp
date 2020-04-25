<%-- 
    Document   : account
    Created on : Mar 18, 2020, 11:14:18 PM
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
        <link rel="stylesheet" type="text/css" href="css/admin.css" />

        <%
            User thisuser = (User) request.getAttribute("user");
            String action = thisuser.getBanstatus() == 0 ? "ban" : "unban";

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
                <div class="admininfo_box">
                    <table class="admininfortable">
                        <tr> 
                            <td><h1><%=thisuser.getRolename()%></h1></td> 
                            <td>
                                <span class="adminspan_info">User-Name :</span>
                                <input class="su_infor" type="text" name="username" value="<%=thisuser.getUsername()%>"readonly/>
                            </td>
                            <td>
                                <span class="adminspan_info">Full-Name :</span>
                                <input class="su_infor" type="text" name="fullname" value="<%=thisuser.getFullname()%>"readonly/>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="4">
                                <img src="images\user.png" />
                            </td>
                            <td>
                                <span class="adminspan_info">E-mail :</span>
                                <input class="su_infor" type="text" name="email" value="<%=thisuser.getMail()%>" readonly/>
                            </td>
                            <td>
                                <span class="adminspan_info">Date of Birth :</span>
                                <input class="su_infor" type="date" name="birthday" value="<%=thisuser.getDob()%>" readonly/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="adminspan_info">Gender :</span>
                                <input class="su_infor" type="text" name="gender" value="<%=thisuser.getGender()%>"readonly/>
                            </td>
                            <td>
                                <span class="adminspan_info">Work-Place</span>
                                <input class="su_infor" type="text" name="workplace" value="<%=thisuser.getWorkplace()%>"readonly/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="adminspan_info">Phone :</span>
                                <input class="su_infor" type="text" name="phone" value="<%=thisuser.getPhone()%>"readonly/>
                            </td>
                            <td>
                                <span class="adminspan_info">Jobs :</span>
                                <input class="su_infor" type="text" name="job" value="<%=thisuser.getRolenum()%>"readonly/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%if (thisuser.getBanstatus() == 0) {%>
                                <h3>Status: <div class="notban">Active</div></h3>
                                <%} else {%>
                                <h3>Status: <div class="banned">Banned</div></h3>
                                <%}%>
                            </td>
                            <td>
                                <form method="POST" action="manage" onsubmit="return confirm('Are you sure you want to <%=action%> this account?');">
                                    <input type="hidden" name="managetype" value="manageaccount">
                                    <input type="hidden" name="userid" value="<%=thisuser.getId()%>">
                                    <input type="hidden" name="ban" <%if (thisuser.getBanstatus() == 1) {%>value="unban"<%} else {%>value="ban"<%}%>>
                                    <input id="but1" type="submit" <%if (thisuser.getBanstatus() == 1) {%>value="Unban"<%} else {%>value="Ban"<%}%>>
                                </form>
                                <a href="admin?category=account"><button id="but2">Back</button></a>

                            </td>
                            <td>

                            </td>
                        </tr>
                    </table>
                </div>


            </div>
            <%@include file="footer.jsp" %>
        </div>


    </body>
</html>
