<%-- 
    Document   : changeinfor
    Created on : Mar 19, 2020, 1:36:28 PM
    Author     : BinhNT
--%>

<%@page import="Entity.Jobs"%>
<%@page import="Model.JobsModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
    JobsModel jobdao = new JobsModel();
    ArrayList<Jobs> jobs = jobdao.getJobs();
%>
<!DOCTYPE html>
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
        <div class="main2">
            <form id="changeinfor" class="changeinfo_box" action="ChangeInforController" method="post">
                <h1>Edit Profile</h1>
                <img src="images\user.png" />
                <div class="changeinfo_item1">
                    <span id="span1">Full-Name: </span>
                    <input class="su_changeinfor" type="text" name="fullname" value="<%=request.getAttribute("fullname")%>"/></br>
                    <span id="span2">Age: </span>
                    <input class="su_changeinfor" type="text" name="age" value="<%=request.getAttribute("age")%>" /></br>

                    <%if (session.getAttribute("errorAge") != null) {
                    %>
                    <div class="errormesschangeinfo1">
                        <p> <%=session.getAttribute("errorAge")%></p>
                    </div>
                    <%
                       session.removeAttribute("errorAge");  }
                    %>
                </div>
                <span id="span3">(***)</span>
                <div id="gender">
                    <span>Gender :</span>
                    <%if (request.getAttribute("sex").equals("Male")) {%>
                    <input type="radio" id="male" name="gender" value="1" checked="true">Male</input>
                    <input type="radio" id="female" name="gender" value="0">Female</input>
                    <%} else {%>
                    <input type="radio" id="male" name="gender" value="1" >Male</input>
                    <input type="radio" id="female" name="gender" value="0"checked="true">Female</input><%}%>
                </div>
                <div class="changeinfo_item2">
                    <span id="span4">Phone: </span>
                    <input class="su_changeinfor" type="text" name="phone" value="<%=request.getAttribute("phone")%>"/></br>
                    <%if (session.getAttribute("errorPhone") != null) {
                    %>
                    <div class="errormesschangeinfo2">
                        <p> <%=session.getAttribute("errorPhone")%></p>
                    </div>
                    <%
                      session.removeAttribute("errorPhone");  }
                    %>
                    <span id="span5">WorkPlace: </span>
                    <input class="su_changeinfor" type="text" name="workplace" value="<%=request.getAttribute("workplace")%>"/></br>
                </div>
                <span id="span6">Jobs: </span>
                <select name="job">
                    <%for (int i = 0; i < jobs.size(); i++) {
                                if (jobs.get(i).getJobid() == 5) {%>
                        <option value=<%=Integer.toString(jobs.get(i).getJobid())%> <%=request.getAttribute(Integer.toString(jobs.get(i).getJobid()))%>>About your jobs</option>
                        <%} else {%>
                        <option value=<%=Integer.toString(jobs.get(i).getJobid())%> <%=request.getAttribute(Integer.toString(jobs.get(i).getJobid()))%>>You are <%=jobs.get(i).getJobname()%></option>
                        <%}
                            }%>
                </select>

                <br>
                <button id="but3" type="submit"  value="save" onclick="checkyes()"/><span>Save</span></button>
                <button id="but4" onclick="document.location = '/AVS/UserinforController';return false" value="cancel"><span>Cancel</span></button>
            </form>

        </div>
                <script type="text/javascript" src="js/confirm.js"></script>
        <%@include file="footer.jsp" %>
    </body>
</html>
