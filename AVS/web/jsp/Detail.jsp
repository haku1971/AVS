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
        <script type="text/javascript" src="js/visualize.js"></script>
        <link rel="stylesheet" type="text/css" href="css/Visual.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />

        <%
            ArrayList<Algorithm> AllAlgorithm = (ArrayList<Algorithm>) request.getAttribute("AllAlgorithm");
            Algorithm algo = (Algorithm) request.getAttribute("algorithm");
            ArrayList<Algorithm> algorithmbycategory = (ArrayList<Algorithm>) request.getAttribute("algorithmbycategory");
//            Boolean isvisualized = true;
//            if(algo.getAlgoFile().equals("null")) {
//                isvisualized = false;
//            }
        %>
    </head>

    <body onload ="init('<%=algo.getAlgoFile()%>',<%=algo.getCategoryID()%>);">
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v6.0"></script>
        <%@include file="header.jsp" %> 
        <div class="banner">
            <h1>Welcome to Algorithm Visualize System<%=algo.getCategoryID()%></h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>    
        <div class="main">
            <div class="left">

                <% String currentCategory = "";
                    boolean startUL = false;
                    boolean changeCategory = false;
                    for (Algorithm a : AllAlgorithm) {
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
            <button type="button" id="<%=a.getCategoryID()%>" class="collapsible"><%=a.getCategoryName()%></button>
            <div class="content">
                <ul class="list_items"> 
                    <% startUL = true; %>
                    <%}%>
                    <li><a style=" text-decoration: none;" id="AlgoNameList" class="<%=a.getAlgoID()%>" href="Detail?AlgoID=<%=a.getAlgoID()%>"><%=a.getAlgoName()%></a></li>
                        <%}%>
                </ul>
            </div>
        </div>
        <div class="right">
            <div>
                <div id="algoTitle"><h1><%= algo.getAlgoName()%></h1>
                    <h5 style="text-align: center;"><%= algo.getAlgoDescription()%></h5></div>
                <div style="float: right; margin-right: 10px;" class="fb-share-button" data-href="" data-layout="button_count" data-size="small"><a target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse" class="fb-xfbml-parse-ignore">Share this page</a></div>
                <div><input id="algoid" type="hidden" value="<%= algo.getAlgoID()%>" /></div>
                <script type="text/javascript" src="js/tracking.js"></script>
            </div>
            <br>
            <br>
            <div class="tab">
                <button class="tablinks" onclick="openTab(event, 'CodeCPlus')" id="defaultOpen">C++</button>
                <button class="tablinks" onclick="openTab(event, 'CodeJava')">Java</button>
                <button class="tablinks" onclick="openTab(event, 'CodeJavaScript')">JavaScript</button>
                <button class="tablinks" onclick="openTab(event, 'Visualizer')">Visualizer</button>

            </div>



            <div id="CodeCPlus" class="tabcontent">
                <% if (algo.getAlgoCodeCplus().equalsIgnoreCase("null")) {%>
                <div class="emptySampleCode">This code has not been added yet!</div>
                <%} else {%>       
                <pre>
                <div class="sampleCode"><%=algo.getAlgoCodeCplus()%></div>
                </pre>
                <%}%>
            </div>

            <div id="CodeJava" class="tabcontent">
                <% if (algo.getAlgoCodeJava().equalsIgnoreCase("null")) {%>
                <div class="emptySampleCode">This code has not been added yet!</div>
                <%} else {%>
                <pre>
                <div class="sampleCode"><%= algo.getAlgoCodeJava()%></div>
                </pre>
                <%}%>
            </div>

            <div id="CodeJavaScript" class="tabcontent">
                <% if (algo.getAlgoCodeJS().equalsIgnoreCase("null")) {%>
                <div class="emptySampleCode">This code has not been added yet!</div>
                <%} else {%>
                <pre>
                <div class="sampleCode"><%= algo.getAlgoCodeJS()%></div>
                </pre>
                <%}%>
            </div>

            <div id="Visualizer" class="tabcontent">
                <div class="Visual">
                    <div class="leftAlgo">
                        <div>Array:<br><input id="txtElement" type="text" name="name" maxlength="15" /></div>
                        <div><input placeholder="Search Value" id="txtSearchnumber" type="text" value="" /></div>
                        <div id="progress"> 
                            <div id="progresstext">
                                Progress:<br> <br>
                                <a id="txtStepcount" style="float: contour"></a></div>
                            <div id="progressbar">
                                <progress id="progressStep" value="1"  max="100" ></progress> <br><br>
                                <input id="slideStep" type="range" oninput="chooseStep();" max="0" min="0" value="1">
                            </div>
                        </div>
                        <div><canvas id="canvasAnimation"  style="border:none solid #000000; "></canvas></div>
                        <canvas id="canvasGraph"  style="border:1px solid #000000;"></canvas>
                            <%
                                for (int i = 0; i < algorithmbycategory.size(); i++) {
                            %>
                        <div>
                            <div class="rectangle" style="background-image: linear-gradient(to bottom,hsl(<%=360 / algorithmbycategory.size() * (i + 1)%>, 100%,50%),white);"></div>
                            <a id="note" href="Detail?AlgoID=<%=algorithmbycategory.get(i).getAlgoID()%>"><%=algorithmbycategory.get(i).getAlgoName()%></a>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <div class="rightAlgo">
                        <div id="txtButton">
                            <Button class="button button--nuka button--round-s button--text-thick" type="submit" onclick="inputByUser();">Input Data</button>
                            <!--cần sửa id thành btnRandom-->
                            <Button class="button button--nuka button--round-s button--text-thick" id="btnShuffle" type="submit" onclick="random();">Random</Button>
                        </div>
                        <div id="speed"><a>Speed: x0.25 </a> <input id="rangebar" type="range" oninput="changeSpeed();" max="10" min="1" value="1"> <a>x2</a></div>
                        <div id="stepButton">
                            <Button class="button button--nuka button--round-s button--text-thick" id="btnPrev" type="submit" onclick="back();"><</Button>
                            <Button class="button button--nuka button--round-s button--text-thick" type="submit" onclick="init('<%=algo.getAlgoFile()%>',<%=algo.getCategoryID()%>);">Restart</Button> 
                            <Button onclick="resume();" class="button button--nuka button--round-s button--text-thick Resumebtn"><input class="Resumeinput" id="PauseOrCon" type="submit" value="Pause"/></button>
                            <Button class="button button--nuka button--round-s button--text-thick" id="btnNext" type="submit" onclick="next();">></Button>
                        </div>
                        <div> 
                            <pre>
                                <%=algo.getAlgoCodeVisual()%>
                            </pre>
                        </div>
                        <div class="scrollLog" id="txtlog">Log:</div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>



        <script type="text/javascript" src="js/code.js"></script>
        <script>
                                setInputFilter(document.getElementById("txtElement"), function (value) {
                                    //                                    return /^[0-9,-,]*$/i.test(value);
                                    return /^\d*$/.test(value);
                                }
                                );
                                setInputFilter(document.getElementById("txtSearchnumber"), function (value) {
                                    return /^\d*$/.test(value);
                                }
                                );
        </script>
        <script type="text/javascript" src="js/tabFunction.js"></script>
        <script>document.getElementById(<%=algo.getCategoryID()%>).click();</script>
        <script>
            var activeItem = document.getElementsByClassName(<%=algo.getAlgoID()%>);
            activeItem[0].className = "activeAlgo";
            var isvisualized = "<%=algo.getAlgoFile()%>";
            if (isvisualized === "null") {

            }
        </script>

    </body>

</html>
