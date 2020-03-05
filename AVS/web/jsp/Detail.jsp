<%-- 
    Document   : Detail
    Created on : Mar 4, 2020, 1:26:57 AM
    Author     : Asus
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
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script type="text/javascript" src="../js/BubbleSort.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/Visual.css" />
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
        <%

            String AllAlgorithm = request.getParameter("AllAlgorithm");
            Gson converter = new Gson();

            JSONArray jsonArrayAllAlgorithm = new JSONArray(AllAlgorithm);
            ArrayList<Object> list_object_of_all_algo = new ArrayList<Object>();
            ArrayList<Algorithm> list_algo_of_all_algo = new ArrayList<Algorithm>();
            Algorithm algo = null;
            for (int i = 0; i < jsonArrayAllAlgorithm.length(); i++) {
                list_object_of_all_algo.add(jsonArrayAllAlgorithm.get(i));
                algo = converter.fromJson(list_object_of_all_algo.get(i).toString(), Algorithm.class);
                list_algo_of_all_algo.add(algo);

            }

            String algorithms = request.getParameter("algorithms");
            JSONArray jsonArrayalgorithms_byid = new JSONArray(algorithms);

            ArrayList<Object> algo_object_list = new ArrayList<Object>();
            ArrayList<Algorithm> list_algorithms_getbyid = new ArrayList<Algorithm>();
            Algorithm algorithm = null;
            for (int i = 0; i < jsonArrayalgorithms_byid.length(); i++) {
                //bo bao mang object
                algo_object_list.add(jsonArrayalgorithms_byid.get(i));

                //lay tung phan tu cua mang object => Algorithm
                algorithm = converter.fromJson(algo_object_list.get(i).toString(), Algorithm.class);
                list_algorithms_getbyid.add(algorithm);
            }
        %>

    </head>

    <body onload ="init();">
        <%-- <%@include file="header.jsp" %> --%>
        <div class="header">
            <img src="../images\avs_logo.png" />
            <ul id="redirectButton">
                <li onclick="document.location = '/AVS/HomeController'">Home</li>
                <li>News</li>
            </ul>
            <ul id="loginButton">
                <li>
                    <form id="search">
                        <input type="text" placeholder="  Search.." name="search">
                        <button type="submit">Submit</button>
                    </form>
                </li>
                <li>
                    <form id="account">

                        <% String usern = "";
                            if (session.getAttribute("username") != null) {
                                usern = (String) session.getAttribute("username");
                                UserModel useracountmanagement = new UserModel();
                                User users = useracountmanagement.getUserByUsername(usern);
                                usern = users.getUsername();
                        %>
                        <a>Hello,<span><%=usern%></span> <img  src="../images\user.png" /></a>

                        <button id="logout" onclick="document.location = '/AVS/LogoutController';return false">Log out</button>
                        <!--                        <div class="dropdown">
                                                    <p>Hello,<span><%=usern%></span></p>
                                                    <a href="JavaScript:myFunction()"> <img class="dropbtn"  src="images\user.png" /></a>
                                                    <div id="myDropdown" class="dropdown-content">
                                                        <a href="#">Link 1</a>
                                                        <a href="#">Link 2</a>
                                                        <a href="#">Link 3</a>
                                                    </div>
                                                </div>-->
                        <%} else {%>
                        <button onclick="document.location = '/AVS/LoginController';return false">Sign in</button>
                        <button>Sign Up</button><%}%>
                    </form>
                </li>
            </ul>
        </div>
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <div class="left">

                <% String currentCategory = "";
                    boolean startUL = false;
                    boolean changeCategory = false;
                    for (Algorithm a : list_algo_of_all_algo) {
                        if (!currentCategory.equals(a.getCategoryName())) {
                            changeCategory = true;
                            currentCategory = a.getCategoryName();
                        }
                        if (changeCategory) {
                            changeCategory = false;
                            if (startUL) {%>
                </ul>
            </div>
            <%}%>
            <button type="button" class="collapsible"><%=a.getCategoryName()%></button>
            <div class="content">
                <ul class="list_items"> 
                    <% startUL = true; %>
                    <%}%>
                    <li><a style=" text-decoration: none;" id="AlgoNameList" href="../Detail?AlgoID=<%=a.getAlgoID()%>"><%=a.getAlgoName()%></a></li>
                        <%}%>
                </ul>
            </div>
            <button type="button" class="collapsible">Others Algorithm</button>
            <div class="content">
                <ul class="list_items">
                    <li>Comming Soon</li>
                </ul>
            </div>
        </div>
        <div class="right">

            <div class="tab">
                <button class="tablinks" onclick="openTab(event, 'Tutorial')" id="defaultOpen">Tutorial</button>
                <button class="tablinks" onclick="openTab(event, 'Visualizer')">Visualizer</button>
            </div>

            <div id="Tutorial" class="tabcontent">
                <div><%= list_algorithms_getbyid.get(0).getAlgoName()%></div> 
            </div>

            <div id="Visualizer" class="tabcontent">
                <div class="Visual">
                    <div class="leftAlgo">
                        <div><input id="txtElement" onkeydown="isNumberKey(event);" type="text" name="name" value="" /></div>
                        <div id="progress"> 
                            <div id="progresstext">
                                Progress:<br> <br>
                                <a id="txtStepcount" style="float: contour"></a></div>
                            <div id="progressbar">
                                <progress id="progressStep" value="1"  max="100" > 0 </progress> <br><br>
                                <input id="slideStep" type="range" oninput="chooseStep();" max="0" min="0" value="1">
                            </div>
                        </div>
                        <div><canvas id="canvasAnimation"  style="border:none solid #000000; "></canvas></div>
                        <canvas id="canvasGraph"  style="border:1px solid #000000;"></canvas>

                        <%
                            double frequency = 0.3;
                            String[] graphnamearr = {"bubblesort", "selectionsort", "insertionsort"};
                            for (int i = 0; i < graphnamearr.length; i++) {
                        %>
                        <div>
                            <div class="rectangle" style="background-color:hsl(<%=360 / graphnamearr.length * (i + 1)%>, 100%,50%)">
                                <a id="note" href="<%=graphnamearr[i]%>"><%=graphnamearr[i]%></a>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <div class="rightAlgo">
                        <div id="txtButton">
                            <input type="submit" onclick="inputByUser();" value="Nhập data" />
                            <input id="btnShuffle" type="submit" onclick="shuffle();" value="Shuffle" />
                        </div>
                        <div id="progress"><a>Speed</a> <input id="rangebar" type="range" oninput="changeSpeed();" max="10" min="1" value="1"> </div>
                        <div id="stepButton">
                            <input id="btnPrev" type="submit" onclick="back();" value="<" />
                            <input type="submit" onclick=" init();" value="Restart" />
                            <input id="PauseOrCon" type="submit" onclick="resume();" value="Pause" />
                            <input id="btnNext" type="submit" onclick="next();" value=">" />
                        </div>
                        <div>            
                            <table>        
                                <tr id="line_1"> <td> for (var i = 0; i < array.length - 1; i++)  { </td> </tr>
                                <tr id="line_2"> <td>for (var j = 0; j < array.length - i - 1; j++) {  </td>  </tr>    
                                <tr id="line_3"> <td>  if (array[j] > array[j + 1]) { </td></tr>
                                <tr id="line_4"><td> &nbsp;  swap(array[i],array[j]); </td></tr>
                                <tr id="line_5"> <td>   }</td></tr>
                                <tr id="line_6"><td>   }</td></tr>
                                <tr id="line_7"> <td>  } </td></tr>          
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                function openTab(evt, cityName) {
                    var i, tabcontent, tablinks;
                    tabcontent = document.getElementsByClassName("tabcontent");
                    for (i = 0; i < tabcontent.length; i++) {
                        tabcontent[i].style.display = "none";
                    }
                    tablinks = document.getElementsByClassName("tablinks");
                    for (i = 0; i < tablinks.length; i++) {
                        tablinks[i].className = tablinks[i].className.replace(" activetab", "");
                    }
                    document.getElementById(cityName).style.display = "block";
                    evt.currentTarget.className += " activetab";
                }

                document.getElementById("defaultOpen").click();
            </script>



        </div>
    </div>
</div>
<%--<%@include file="footer.jsp" %>--%>
<div id="footer">
    <img id="avs" src="../images/avs_logo.png" />
    <img id="fb" src="../images/facebook.PNG" />
    <div class="footerSoild"></div>
    <div><p>Copyright 2020.</p></div>
</div>
<script type="text/javascript" src="../js/code.js"></script>
</body>

</html>
