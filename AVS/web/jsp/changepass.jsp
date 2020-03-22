<%-- 
    Document   : changepass
    Created on : Mar 19, 2020, 1:36:51 PM
    Author     : BinhNT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
        <title>AVS</title>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main2">
            <form class="changepass_box" action="ChangePassController" method="post">
                <h1><b>Change Password</b></h1>
                <div class="changepass_items">
                    <p class="caution" title="You must fill this !!"></p>
                    <span class="sp1">(*)</span>
                    <input class="su_changepass" type="password" name="oldpassword" placeholder="OldPassword" required /></br> 
                    <%if (request.getAttribute("errorOldPass") != null) {
                    %>
                    <span class="error_changepass1">
                        <%=request.getAttribute("errorOldPass")%>
                    </span>
                    <%
                        }
                    %>
                    <p class="caution" title="You must fill this !!"></p>
                    <span class="sp2">(*)</span>
                    <input class="su_changepass" type="password" name="newpassword" placeholder="NewPassword"required/></br>
                    <%if (request.getAttribute("errorNewPass") != null) {
                    %>
                    <span class="error_changepass2">
                        <%=request.getAttribute("errorNewPass")%>
                    </span>
                    <%
                        }
                    %>
                    <p class="caution" title="You must fill this !!"></p>
                    <span class="sp3">(*)</span>
                    <input class="su_changepass" type="password" name="repassword" placeholder="Re-Password"required/></br>
                    <%if (request.getAttribute("errorRePass") != null) {
                    %>
                    <span class="error_changepass2">
                        <%=request.getAttribute("errorRePass")%>
                    </span>
                    <%
                        }
                    %>
                    <br>
                    <br>
                    <button id="but5" type="submit"  value="save" onclick="checkyes()"><span>Save</span></button>
                    <button id="but6" onclick="document.location = '/AVS/UserinforController';return false" value="cancel"><span>Cancel</span></button>
                    <!--  <input type="submit" name="" value="Login">-->
                    <%if (request.getAttribute("success") != null) {
                    %>
                    <div class="success_changepass">
                        <p> <%=request.getAttribute("success")%></p>
                    </div>
                    <%  
                        }
                    %>
                </div>
            </form>
        </div>

        <%@include file="footer.jsp" %>
                <script type="text/javascript" src="js/confirm.js"></script>
    </body>
</html>
