<%-- 
    Document   : userinfor
    Created on : Mar 18, 2020, 9:09:30 PM
    Author     : BinhNT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>

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
            <form class="info_box" action="UserinforController" method="post">
                <table class="infortable">
                    <tr> 
                        <td><h1>My Profile</h1></td> 
                        <td>
                            <span class="span_info">User-Name :</span>
                            <input class="su_infor3" type="text" name="username" value="<%=request.getAttribute("username")%>"readonly/>
                        </td>
                        <td>
                            <span class="span_info">Full-Name :</span>
                            <input class="su_infor3" type="text" name="fullname" value="<%=request.getAttribute("fullname")%>"readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="4">
                            <img src="images\user.png" />
                        </td>
                        <td>
                            <span class="span_info">E-mail :</span>
                            <input class="su_infor3" type="text" name="email" value="<%=request.getAttribute("mail")%>" readonly/>
                        </td>
                        <td>
                            <span class="span_info">Age :</span>
                            <input class="su_infor3" type="date" name="birthday" value="<%=request.getAttribute("birthday")%>" readonly/>
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
                            <input class="su_infor3" type="text" name="gender" value="<%=request.getAttribute("gender")%>"readonly/>
                        </td>
                        <td>
                            <span class="span_info">Work-Place</span>
                            <input class="su_infor3" type="text" name="workplace" value="<%=request.getAttribute("workplace")%>"readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="span_info">Phone :</span>
                            <input class="su_infor3" type="text" name="phone" value="<%=request.getAttribute("phone")%>"readonly/>
                        </td>
                        <td>
                            <span class="span_info">Jobs :</span>
                            <input class="su_infor3" type="text" name="job" value="<%=request.getAttribute("jobname")%>"readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3>Status:<span> <%=request.getAttribute("status")%></span></h3>
                        </td>
                        <td>

                            <button id="but1" onclick="document.location = '/AVS/ChangeInforController';return false" value="changeinfor"><span>Change Information</span></button>
                        </td>
                        <td>
                            <%if (!request.getAttribute("username").equals(request.getAttribute("mail"))) {%>
                            <button id="but2" onclick="document.location = '/AVS/ChangePassController';return false" value="changepass"><span>Change Password</span></button>
                            <%}%>
                        </td>
                    </tr>
                </table>  
            </form>

        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
