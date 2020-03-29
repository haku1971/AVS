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
        <script type="text/javascript" src="../js/visualize.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/Visual.css" />
    </head>
    <body onload ="init('interpolationsearch');"> 
        <div class="Visual">
            <div class="leftAlgo">
                <div><input id="txtElement" type="text" name="name" value="" /></div>
                <div><input id="txtSearchnumber" type="text" value="" /></div>
                <div> Progress: <progress id="progressStep" value="1"  max="100" > 0 </progress></div>
                <div>
                    <a id="txtStepcount" style="float: contour"></a> <input id="slideStep" type="range" oninput="chooseStep();" max="0" min="0" value="1">
                </div>
                <div><canvas id="canvasAnimation"></canvas></div>
                <canvas id="canvasGraph"></canvas>
            </div>

            <div class="rightAlgo">
                <input type="submit" onclick="inputByUser();" value="Nhập data" />
                <input id="btnShuffle" type="submit" onclick="random();" value="Random" />
                <div><a>Speed</a> <input id="rangebar" type="range" oninput="changeSpeed();" max="10" min="1" value="1"> </div>
                <div>
                    <input id="btnPrev" type="submit" onclick="back();" value="<" />
                    <!--fix here-->
                    <input type="submit" onclick=" init('interpolationsearch');" value="Restart" />
                    <input id="PauseOrCon" type="submit" onclick="resume();" value="Pause" />
                    <input id="btnNext" type="submit" onclick="next();" value=">" />
                </div>
                <div>
                    <table>
                        <tr id="line_1"> <td>int interpolationSearch(int arr[], int x){ </td></tr>
                        <tr id="line_2"> <td>&emsp;&emsp;int lo = 0, hi = (arr.length - 1); </td></tr>
                        <tr id="line_3"> <td>&emsp;&emsp;while (lo <= hi && x >= arr[lo] && x <= arr[hi]){ </td></tr>
                        <tr id="line_4"> <td>&emsp;&emsp;&emsp;&emsp;if (lo == hi){ </td></tr>
                        <tr id="line_5"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;if (arr[lo] == x) {</td></tr>
                        <tr id="line_6"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;return lo; </td></tr>
                        <tr id="line_7"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;{</td></tr>
                        <tr id="line_8"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;return -1; </td></tr>
                        <tr id="line_9"> <td>&emsp;&emsp;&emsp;&emsp;} </td></tr>
                        <tr id="line_10"> <td>&emsp;&emsp;&emsp;&emsp;int pos = lo + (((hi - lo) / </td></tr>
                        <tr id="line_11"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;(arr[hi] - arr[lo])) * (x - arr[lo])); </td></tr>
                        <tr id="line_12"> <td>&emsp;&emsp;&emsp;&emsp;if (arr[pos] == x){ </td></tr>
                        <tr id="line_13"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;return pos; </td></tr>
                        <tr id="line_14"> <td>&emsp;&emsp;&emsp;&emsp;}</td></tr>
                        <tr id="line_15"> <td>&emsp;&emsp;&emsp;&emsp;if (arr[pos] < x){</td></tr>
                        <tr id="line_16"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;lo = pos + 1; </td></tr>
                        <tr id="line_17"> <td>&emsp;&emsp;&emsp;&emsp;} else{</td></tr>
                        <tr id="line_18"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;hi = pos - 1; </td></tr>
                        <tr id="line_19"> <td>&emsp;&emsp;&emsp;&emsp;}</td></tr>
                        <tr id="line_20"> <td>&emsp;&emsp;} </td></tr>
                        <tr id="line_21"> <td>&emsp;&emsp;return -1; </td></tr>
                        <tr id="line_22"> <td>}</td></tr>
                    </table>

                </div>
                <br>
                <div id="txtlog">Log:</div>

            </div>
        </div>
        <script>
            setInputFilter(document.getElementById("txtElement"), function (value) {
                return /^[0-9,-,]*$/i.test(value);
            }
            );
            setInputFilter(document.getElementById("txtSearchnumber"), function (value) {
                return /^\d*$/.test(value);
            }
            );
        </script>
    </body>      
</html>
