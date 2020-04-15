<%-- 
    Document   : signup
    Created on : Mar 10, 2020, 4:23:33 PM
    Author     : BinhNT
--%>

<%@page import="Entity.Jobs"%>
<%@page import="Model.JobsModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<%
    JobsModel jobdao = new JobsModel();
    ArrayList<Jobs> jobs = jobdao.getJobs();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <!--<meta name="google-signin-client_id" content="912620741556-58chb0o18k50h03oblr4gr5t8vrqi139.apps.googleusercontent.com">-->
        <title>AVS</title>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <form class="box2" action="SignupController" method="post">
                <h1><b>Sign Up</b></h1>
                <table class="infortable">
                    <tr> 
                        <td rowspan="10"><img src="images\user.png" /></td> 
                        <td>
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
                        <td>
                            
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
                    </tr>
                    <tr>
                        <td>
                            <span class="span_info1">UserName:</span>
                            <input class="su_info1" type="text" name="username" placeholder="6 to 15 characters, contain:a-z,0-9,(-),(_)"required/>
                        </td>
                        <td>
                            <span class="span_info1">Password:</span>
                            <input class="su_info2" type="password" name="password" placeholder="At least 6 character"required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            
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
                        <td>
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
                            <span class="span_info1">Email:</span>
                            <input class="su_info1" type="text" name="email" placeholder="xyz@qwe.abc.com"required/>
                        </td>
                        <td>
                            <span class="span_info1">RePass:</span>
                            <input class="su_info2" type="password" name="repassword" placeholder="At least 6 character"required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                           
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
                            <span class="span_info1">FullName:</span>
                            <input class="su_info3" type="text" name="fullname" placeholder="Enter your Name"/>
                        </td>
                        <td>
                            <span class="span_info1">Phone:</span>
                            <input class="su_info3" type="text" name="phone" placeholder="Phone must be numbers"/>
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
                            <span class="span_info1">DayOfBirth:</span>
                            <input class="su_info3" type="date" name="birthday" value="1900-01-01"/>
                        </td>
                        <td>
                            <span class="span_info1">Workplace:</span>
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
</html>
