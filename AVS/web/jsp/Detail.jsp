<%-- 
    Document   : Detail
    Created on : Mar 4, 2020, 1:26:57 AM
    Author     : Asus
--%>
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
            JSONArray jsonArrayalgorithms_byid= new JSONArray(algorithms);
            
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
            
           <div><%= list_algorithms_getbyid.get(0).getAlgoName()%></div> 

            <div class="Visual">
                <div class="leftAlgo">
                    <div><input id="txtElement" onkeydown="isNumberKey(event);" type="text" name="name" value="" /></div>
                    <div> Progress: <progress id="progressStep" value="1"  max="100" > 0 </progress></div>
                    <div>
                        <a id="txtStepcount" style="float: contour"></a> <input id="slideStep" type="range" oninput="chooseStep();" max="0" min="0" value="1">
                    </div>
                    <div><canvas id="canvasAnimation"  style="border:none solid #000000; "></canvas></div>
                    <canvas id="canvasGraph"  style="border:1px solid #000000;"></canvas>
                </div>

                <div class="rightAlgo">
                    <input type="submit" onclick="inputByUser();" value="Nhập data" />
                    <input id="btnShuffle" type="submit" onclick="shuffle();" value="Shuffle" />
                    <div><a>Speed</a> <input id="rangebar" type="range" oninput="changeSpeed();" max="10" min="1" value="1"> </div>
                    <div>
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
                   <div><jsp:include page="noteGraph.jsp" /></div> 
                </div>
            </div>
        </div>
    </div>
</div>
<%--<%@include file="footer.jsp" %>--%>
<script type="text/javascript" src="../js/code.js"></script>
</body>
          
</html>
