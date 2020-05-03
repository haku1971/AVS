<%-- 
    Document   : userinfor
    Created on : Mar 18, 2020, 9:09:30 PM
    Author     : DuongPH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <form class="info_box" action="userinfo" method="post">
                <table class="infortable">
                    <tr> 
                        <td><h1>My Profile</h1></td> 
                        <td>
                            <span class="span_info">User-Name :</span>
                            <input class="su_infor3" type="text" name="username" value="<c:out value='${requestScope["username"]}' />"readonly/>
                        </td>
                        <td>
                            <span class="span_info">Full-Name :</span>
                            <input class="su_infor3" type="text" name="fullname" value="<c:out value='${requestScope["fullname"]}' />"readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="4">
                            <img src="images\user.png" />
                        </td>
                        <td>
                            <span class="span_info">E-mail :</span>
                            <input class="su_infor3" type="text" name="email" value="<c:out value='${requestScope["mail"]}' />" readonly/>
                        </td>
                        <td>
                            <span class="span_info">Age :</span>
                            <input class="su_infor3" type="date" name="birthday" value="<c:out value='${requestScope["birthday"]}' />" readonly/>
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
                            <span class="span_info">Gender :</span>
                            <input class="su_infor3" type="text" name="gender" value="<c:out value='${requestScope["gender"]}' />"readonly/>
                        </td>
                        <td>
                            <span class="span_info">Work-Place</span>
                            <input class="su_infor3" type="text" name="workplace" value="<c:out value='${requestScope["workplace"]}' />"readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="span_info">Phone :</span>
                            <input class="su_infor3" type="text" name="phone" value="<c:out value='${requestScope["phone"]}' />"readonly/>
                        </td>
                        <td>
                            <span class="span_info">Jobs :</span>
                            <input class="su_infor3" type="text" name="job" value="<c:out value='${requestScope["jobname"]}' />"readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%if (request.getAttribute("status") == "Ban") {%>
                            <h3>Status:<span style="color:red;"> Ban </span></h3>
                            <%} else {%>
                            <h3>Status:<span style="color:green;"> Active </span></h3> 
                            <%}%>

                            <span style="font-size:11px;"><span style="font-size:15px;color:red;">(*)</span>Ban User could not comment on news</span>
                        </td>
                        <td>

                            <button id="but1" onclick="document.location = '/AVS/changeinfo';return false" value="changeinfor"><span>Change Information</span></button>
                        </td>
                        <td>
                            <%if (session.getAttribute("googleacc") == null) {%>
                            <button id="but2" onclick="document.location = '/AVS/changepass';return false" value="changepass"><span>Change Password</span></button>
                            <%}%>
                        </td>
                    </tr>
                </table>  
            </form>

        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
