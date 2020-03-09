<%-- 
    Document   : linearsearch
    Created on : Mar 9, 2020, 8:00:12 PM
    Author     : quang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script type="text/javascript" src="../js/linearsearch.js"></script>
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
                <input type="submit" onclick="interpolationsearch();" value="Nhập data" />
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

                        <tr id="line_1"> <td>  int n = arr.length;  </td> </tr>
                        <tr id="line_2">  <td>  for(int i = 0; i < n; i++) </td></tr>   
                        <tr id="line_3"> <td>  { </td></tr>
                        <tr id="line_4"><td>     if(arr[i] == x) { </td></tr>
                        <tr id="line_5"> <td>         return i; }</td></tr>
                        <tr id="line_6"><td>  } </td></tr>
                        <tr id="line_7"> <td> return -1; </td></tr> 

                    </table>
                </div>
               
            </div>
        </div>

    </body>      
</html>
