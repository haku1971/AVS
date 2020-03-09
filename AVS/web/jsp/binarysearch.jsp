<%-- 
    Document   : binarysearch
    Created on : Mar 9, 2020, 9:13:30 PM
    Author     : quang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script type="text/javascript" src="../js/binarysearch.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/Visual.css" />
    </head>
    <body onload ="init();">
        <div class="Visual">
            <div class="leftAlgo">
                <div><input id="txtElement" onkeydown="isNumberKey(event);" type="text" name="name" value="" /></div>
                <div> Progress: <progress id="progressStep" value="1"  max="100" > 0 </progress></div>
                <div>
                    <a id="txtStepcount" style="float: contour"></a> <input id="slideStep" type="range" oninput="chooseStep();" max="0" min="0" value="1">
                </div>
                <div><canvas id="canvasAnimation"></canvas></div>
                <canvas id="canvasGraph"></canvas>
            </div>

            <div class="rightAlgo">
                <input type="submit" onclick="inputByUser();" value="Nhập data" />
                <input id="btnShuffle" type="submit" onclick="shuffle();" value="Shuffle" />
                <div><a>Speed</a> <input id="rangebar" type="range" oninput="changeSpeed();" max="10" min="1" value="1"> </div>
                <div>
                    <input id="btnPrev" type="submit" onclick="back();" value="<" />
                    <input type="submit" onclick=" init('bubblesort');" value="Restart" />
                    <input id="PauseOrCon" type="submit" onclick="resume();" value="Pause" />
                    <input id="btnNext" type="submit" onclick="next();" value=">" />
                </div>
                <div>            
                    <table>     
                        <tr id="line_1"> <td>          if (right >= left) { </td></tr>   
                        <tr id="line_2"> <td>     var mid = left + (right - left) / 2; </td></tr>   
                        <tr id="line_3"> <td>      if (array[mid] === searchvalue) { </td></tr>   
                        <tr id="line_4"><td>          return mid; </td></tr>   
                        <tr id="line_5"> <td>       }   </td></tr>   
                        <tr id="line_6"> <td>       if (array[mid] > searchvalue) { </td></tr>   
                        <tr id="line_7"> <td>           return binarySearch(array, left, mid - 1, searchvalue); </td></tr>   
                        <tr id="line_8"> <td>       }  </td></tr>   
                        <tr id="line_9"> <td>       return binarySearch(array, mid + 1,right, searchvalue); </td></tr>   
                        <tr id="line_10"> <td>    } </td></tr>   
                        <tr id="line_11"> <td>    return -1; </td></tr>       
                    </table>
                </div>
                <%--<jsp:include page="./noteGraph.jsp" />--%>
            </div>
        </div>

    </body>      
</html>
