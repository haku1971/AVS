<%-- 
    Document   : signup
    Created on : Mar 10, 2020, 4:23:33 PM
    Author     : BinhNT
--%>

<%@page import="Model.Jobs"%>
<%@page import="DAO.JobsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<%
    JobsDAO jobdao = new JobsDAO();
    ArrayList<Jobs> jobs = jobdao.getJobs();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <!--<meta name="google-signin-client_id" content="912620741556-58chb0o18k50h03oblr4gr5t8vrqi139.apps.googleusercontent.com">-->
        <title>Sign Up</title>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <form class="box2" action="register" method="post">
                <h1><b>Sign Up</b></h1>
                <h5><span style="color:red;">(*)</span> is required information</h5>
                <table class="infortable">
                    <tr> 
                        <td rowspan="10"><img src="images\user.png" /></td> 

                        <td class="error">
                            <span id="hidden">UserName:</span>
                            <%if (request.getAttribute("errorUsername") != null) {
                            %>
                            <div class="errormess">
                                <%=request.getAttribute("errorUsername")%>
                            </div>
                            <%
                            } else {
                            %>
                            &nbsp;
                            <%}%>
                        </td>
                        <td class="error">
                            <span id="hidden">E-mail:</span>
                            <%if (request.getAttribute("errorMail") != null) {
                            %>
                            <div class="errormess">
                                <%=request.getAttribute("errorMail")%>
                            </div>
                            <%
                            } else {
                            %>
                            &nbsp;
                            <%}%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="span_info1">Username:</span>
                            <input class="su_info1" type="text" name="username" placeholder="6 to 15 characters, contain:a-z,0-9,(-),(_)" maxlength="15" required/>
                            <span class="red_star">(*)</span>
                        </td>
                        <td>
                            <span class="span_info1">E-mail:</span>
                            <input class="su_info1" type="text" name="email" placeholder="xyz@qwe.abc.com"required/>
                            <span class="red_star">(*)</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="hidden">Password:</span>
                            <%if (request.getAttribute("errorPass") != null) {
                            %>
                            <div class="errormess">
                                <%=request.getAttribute("errorPass")%>
                            </div>
                            <%
                            } else {
                            %>
                            &nbsp;
                            <%}%>
                        </td>
                        <td>
                            <span id="hidden">Re-Password:</span>
                            &nbsp;
                            <%if (request.getAttribute("errorRepass") != null) {
                            %>
                            <div class="errormess">
                                <%=request.getAttribute("errorRepass")%>
                            </div>
                            <%
                            } else {
                            %>
                            &nbsp;
                            <%}%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="span_info1">Password:</span>
                            <input class="su_info2" type="password" name="password" placeholder="From 6 to 15 characters" maxlength="15"required/>
                            <span class="red_star">(*)</span>                         
                        </td>
                        <td>
                            <span class="span_info1">Re-Password:</span>
                            <input class="su_info2" type="password" name="repassword" placeholder="From 6 to 15 characters" maxlength="15"required/>
                            <span class="red_star">(*)</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <span id="hidden">Phone:</span>
                            <%if (request.getAttribute("errorPhone") != null) {
                            %>
                            <div class="errormess">
                                <%=request.getAttribute("errorPhone")%>
                            </div>
                            <%
                            } else {
                            %>
                            &nbsp;
                            <%}%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="span_info1">Full Name:</span>
                            <input class="su_info3" type="text" name="fullname" placeholder="Enter your Name"/>
                        </td>
                        <td>
                            <span class="span_info1">Phone:</span>
                            <input class="su_info3" id="su_info_phone" type="text" name="phone" placeholder="Phone must be 10 digits" maxlength="10"/>
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
                            <span class="span_info1">Date of Birth:</span>
                            <input class="su_info3" type="date" name="birthday" value="1900-01-01"/>
                        </td>
                        <td>
                            <span class="span_info1">Work Place:</span>
                            <input class="su_info3" type="text" name="workplace" placeholder="Enter your Work Place"/>
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
                            <div class="signup_item5">
                                <span>Gender :</span>
                                <input type="radio" id="male" name="gender" value="1" checked="true">Male</input>
                                <input type="radio" id="female" name="gender" value="0">Female</input>
                            </div>
                        </td>
                        <td>
                            <div class="signup_item6">
                                <span class="span_info1">Jobs:</span>
                                <select name="job">
                                    <%for (int i = 0; i < jobs.size(); i++) {
                                            if (jobs.get(i).getJobid() == 5) {%>
                                    <option value=<%=Integer.toString(jobs.get(i).getJobid())%> selected>About your jobs</option>
                                    <%} else {%>
                                    <option value=<%=Integer.toString(jobs.get(i).getJobid())%>>You are <%=jobs.get(i).getJobname()%></option>
                                    <%}
                                        }%>
                                </select>
                            </div>
                        </td>
                    </tr>
                </table>   
                <button id="bottun" type="submit"><span>Sign Up</span></button>
            </form>

        </div>
        <%@include file="footer.jsp" %>
    </body>
    <script>
        function setInputFilter(textbox, inputFilter) {
            ["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function (event) {
                if (textbox === null) {
                    console.log('Null pointer exception!');
                } else {
                    textbox.addEventListener(event, function () {
                        if (inputFilter(this.value)) {
                            this.oldValue = this.value;
                            this.oldSelectionStart = this.selectionStart;
                            this.oldSelectionEnd = this.selectionEnd;
                        } else if (this.hasOwnProperty("oldValue")) {
                            this.value = this.oldValue;
                            this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
                        } else {
                            this.value = "";
                        }
                    });
                }
            });
        }
        setInputFilter(document.getElementById("su_info_phone"), function (value) {
            return /^\d*$/.test(value);
        }
        );
    </script>
</html>
