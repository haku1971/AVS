var initarray = [9, 8, 7, 6, 9, 4, 3, 2, 1, 1];
var hasharray = [10, 20, 30, 40, 1, 2, 3, 4, 8];
var searchnumber = 8;
var N = 10; // Array Size
var XYs = 5; // Element Visual Size
var Xp = 1; // Start Pos X
var Yp = 1; // Start Pos Y
var canvas;
var currentstep = 0;
var totalstep;
var run;
var boolRun = true;
var arr_by_user = [];
var speed = 1000;
var eachStepArr = [];
var highlightcheck = [];
var highlightcode = [];
var highlightsorted = [];
var color = [];
var logarray = [];
var algorithmtype;
var category;
var isinit = true;
var arrayheight = 50;
var arraywidth = 50;
var gapbetweennumber = 9.5;
var gapbetweenbox = 1;
var fontsize = 15;
/*
 * Hash implement
 */
//var hash = require('string-hash');
var hasharraysize = 10;
function getindex(key, arraysize) {
//    var hash = hashfunc(key);
    var hash = key;
    return  hash % arraysize;
}

function hashfunc(key) {
    var hash = key;
    for (var i = 0; i < key.length; i++) {
        let chr = key.charCodeAt(i);
        hash = ((hash << 5) - hash) + chr;
        hash |= 0; // Convert to 32bit integer
    }
    return hash;
}

class OpenAddressHashTable {
    constructor() {
        this.list = [];
    }

    get(key) {
        return this.list[getindex(key, hasharraysize)];
    }

    add(key) {
        let index = getindex(key, hasharraysize);
        if (this.list[index] === undefined || this.list[index] === key) {
            this.list[index] = key;
        } else {
            index++;
            if (index > hasharraysize - 1) {
                index = 0;
            }
            this.addto(index, key);
        }
    }

    addto(index, key) {
        if (index > hasharraysize - 1) {
            index = 0;
        }
        if (this.list[index] === undefined || this.list[index] === key) {
            this.list[index] = key;
        } else {
            this.addto(index + 1, key);
        }
    }
}

var hashtable;
function addArraytoHashTable(array) {
    for (var i = 0; i < array.length; i++) {
        let key = array[i];
        hashtable.add(key);
    }
}



/*
 *  Other main function start here
 */
function init(algorithmtype, category) {
    switch (category) {
        case 6 :
        {
            document.getElementById("txtElement").hidden = true;
            document.getElementById("txtElementHashing").value = hasharray.join(',');
            document.getElementById("txtSearchnumber").value = searchnumber;
            document.getElementById("txtArraySize").value = hasharraysize;

            break;
        }
        default :
        {
            document.getElementById("txtElementHashing").hidden = true;
            document.getElementById("divArraySize").hidden = true;
            document.getElementById("txtElement").value = initarray.join('');
            document.getElementById("txtSearchnumber").value = searchnumber;
            break;
        }
    }
    this.algorithmtype = algorithmtype;
    this.category = category;
    let isvisualized = algorithmtype === "null" ? false : true;
    startVisualizing(isvisualized, category);
    if (isvisualized) {
        removeHighlightedCode();
        currentstep = 0;
        canvas = document.getElementById('canvasAnimation');
        draw(currentstep);
        boolRun = true;
        resume();
    } else {
        document.getElementById("progress").hidden = true;
        document.getElementById("canvasAnimation").hidden = true;
        document.getElementById("speed").hidden = true;
        document.getElementById("stepButton").hidden = true;
        document.getElementById("txtlog").hidden = true;
    }

    
}

function startVisualizing(isvisualized, category) {
    if (isvisualized) {
        switch (algorithmtype) {
//Internal Sorting
            case 'bubblesort' :
            {
                bubbleSort(initarray);
                break;
            }
            case 'insertionsort' :
            {
                insertionSort(initarray);
                break;
            }
            case 'selectionsort' :
            {
                selectionSort(initarray);
                break;
            }

//Searching by Comparision of Keys
            case 'linearsearch' :
            {
                linearSearch(initarray);
                break;
            }
            case 'binarysearch' :
            {
                binarySearch(initarray);
                break;
            }
            case 'interpolationsearch' :
            {
                interpolationSearch(initarray);
                break;
            }
//Hashing
            case 'separatechaining_hash' :
                separatechainingHash(hasharray);
                break;
            case 'openaddressing_hash':
                openaddressingHash(hasharray);
                break;
        }
    }

    switch (category) {
        case 1 : //Internal Sorting
            getAjaxSortData();
            break;
        case 5 : //Searching by Comparision of Keys
            getAjaxSearchData();
            break;
        case 6:
            getAjaxHashingSearchData();
            numberofbox = hasharraysize;
            break;
    }
}
function getAjaxHashingSearchData() {
    var mydata = JSON.stringify(hasharray);
    $.ajax({
        type: "POST",
        url: "HashingSearchController", //
        data: {initarray: mydata, searchvalue: searchnumber, hasharraysize: hasharraysize}
        ,
        dataType: "json",
        success: function (data) {
            drawGraph(data);
        }
    }
    );
}
function getAjaxSortData() {
    var mydata = JSON.stringify(initarray);
    $.ajax({
        type: "POST",
        url: "SortStepServlet",
        data: {name: mydata}
        ,
        dataType: "json",
        success: function (data) {
            drawGraph(data);
        }
    }
    );
    document.getElementById("divSearchnumber").hidden = true;
}

function getAjaxSearchData() {
    var mydata = JSON.stringify(initarray);
    //  var searchvalue = JSON.stringify(searchnumber);
    $.ajax({
        type: "POST",
        url: "SearchStepServlet",
        data: {initarray: mydata, searchvalue: searchnumber}
        ,
        dataType: "json",
        success: function (data) {
            drawGraph(data);
        }
    }
    );
}


function random() {
    switch (category) {
        case 6: //hashing
        {
            searchnumber = getRndInteger(1, 99)
            var arraylenght = hasharray.length;
            hasharray = [];
            for (var i = 0; i < arraylenght; i++) {
                hasharray.push(getRndInteger(1, 99));
            }
            document.getElementById("txtElementHashing").value = hasharray.join(',');
            removeHighlightedCode();
            init(algorithmtype, category);
            break;
        }
        default: //sort and search
        {
            searchnumber = getRndInteger(1, 9); // returns a random integer from 0 to 9
            var arraylenght = initarray.length;
            initarray = [];
            for (var i = 0; i < arraylenght; i++) {
                initarray.push(getRndInteger(1, 9));
            }
            document.getElementById("txtElement").value = initarray.join('');
            removeHighlightedCode();
            init(algorithmtype, category);
        }
    }
}

function randomFrom1to9() {
    var random = 0;
    while (random === 0) {
        random = Math.floor(Math.random() * 10);
    }
    return random;
}

function getRndInteger(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function inputByUser() {

    var isvalid = true;
    //Array
    switch (category) {
        case 6: //hashing 
        {
            let maxlength;
            if (document.getElementById("txtArraySize").value !== '') {
                maxlength = document.getElementById("txtArraySize").value;
                if (maxlength < 1) {
                    window.alert("Failed! Size of hashtable > 0!");
                    isvalid = false;
                    break;
                }
                if (maxlength > 10) {
                    window.alert("Failed! Max size available is 10!");
                    isvalid = false;
                    break;
                }
            } else {
                maxlength = hasharraysize;
            }
            arr_by_user = document.getElementById("txtElementHashing").value !== "" 
                ? document.getElementById("txtElementHashing").value.split(',') : [];
            for (var i = 0; i < arr_by_user.length; i++) {
                if (arr_by_user[i] > 99) {
                    window.alert("Failed! Element(s) too big, element <= 99!");
                    isvalid = false;
                    break;
                }
            }
            if (arr_by_user.length > 0) {
                if (arr_by_user.length > maxlength) {
                    window.alert("Failed! Array lenght > size of hashtable, try with array lenght <= " + maxlength + "!");
                    isvalid = false;
                }
                if (arr_by_user.length <= maxlength) {
                    hasharray = arr_by_user;
                }
            } else {
                window.alert("Failed! Array is empty!");
                isvalid = false;
            }
            break;
        }
        default :
        {
            let maxlength = 15;
            arr_by_user = document.getElementById("txtElement").value;
            arr_by_user = arr_by_user.split("");
            if (arr_by_user.length > 0) {
                if (arr_by_user.length > maxlength) {
                    window.alert("Failed! Array lenght too long, try array lenght <= 15!");
                    isvalid = false;
                }
                if (arr_by_user.length <= maxlength) {
                    initarray = arr_by_user;
                }
            } else {
                window.alert("Failed! Array is empty!");
                isvalid = false;
            }
            break;
        }
    }

    if (isvalid) {
        //Searchnumber
        if (document.getElementById("txtSearchnumber").value !== '') {
            searchnumber = document.getElementById("txtSearchnumber").value;
        }

        if (document.getElementById("txtArraySize").value !== '') {
            hasharraysize = document.getElementById("txtArraySize").value;
        }
        init(algorithmtype, category);
    }
}

function next() {
    clearInterval(run);
    if (currentstep < eachStepArr.length - 1) {
        currentstep++;
        draw(currentstep);
    }
    boolRun = false;
    document.getElementById("PauseOrCon").value = 'Play';
}



function chooseStep() {
    currentstep = parseInt(document.getElementById("slideStep").value);
    draw(currentstep);
}

function back() {
//mang da chay dc it nhat 2 phan tu
    if (currentstep >= 1) {
        clearInterval(run);
        currentstep--;
        draw(currentstep);
    }
    boolRun = false;
    document.getElementById("PauseOrCon").value = 'Play';
}

function resume() {
    if (currentstep === totalstep) {
        currentstep = 0;
        clearInterval(run);
        document.getElementById("PauseOrCon").value = 'Pause';
        boolRun = true;
        run = setTimeout(loadingAnimation, speed);
    } else {
        if (boolRun) {
//đang trong trạng thái chạy
            clearInterval(run);
            document.getElementById("PauseOrCon").value = 'Play';
            boolRun = false;
        } else {
//đang trong trạng thái pause
            clearInterval(run);
            document.getElementById("PauseOrCon").value = 'Pause';
            boolRun = true;
            run = setTimeout(loadingAnimation, speed);
        }
    }
}

function newarray(array) {
    var tempwarray = [];
    for (var i = 0; i < array.length; i++) {
        tempwarray.push(array[i]);
    }

    return tempwarray;
}

function newsortedarray(sorted) {
    var tempwarray = [];
    for (var i = sorted; i > 0; i--) {
        tempwarray.push(initarray.length - i);
    }
    return newarray(tempwarray);
}

function newSortedInsertionArray(sorted) {
    var tempwarray = [];
    for (var i = sorted; i > 0; i--) {
        tempwarray.push(i - 1);
    }
    return newarray(tempwarray);
}

function changeSpeed() {
    speed = 1000 / (parseInt(document.getElementById("rangebar").value));
}

function loadingAnimation() {
//check de cho phep load tiep hay ko
    if (currentstep < eachStepArr.length - 1) {
        currentstep++;
        draw(currentstep);
    }
    run = setTimeout(loadingAnimation, speed);
}

//chưa sửa được lỗi
function getdata(data) {
    return
}

function drawGraph(data) {
    var canvas = document.getElementById("canvasGraph");
    var canvas_height = 300; //chieu cao canvas

    var canvas_width = 500; // chieu rong canvas
    document.getElementById("canvasGraph").height = canvas_height;
    document.getElementById("canvasGraph").width = canvas_width;
    context = canvas.getContext("2d");
    //set background_color for graph
    context.fillStyle = "lightgrey";
    context.fillRect(0, 0, canvas_width, canvas_height);
    var vertical_gap_top = 20;
    var vertical_gap_bot = 20;
    var biggest_value_of_array = Math.max.apply(Math, data.map(function (o) {
        return o.number_of_step;
    }));
    var numberdigits;
    numberdigits = Math.floor(Math.log10(Math.abs(biggest_value_of_array))) + 1;
    if (numberdigits < 0 || numberdigits === 0) {
        numberdigits = 1;
    }

    var constant = Math.pow(10, numberdigits - 1); // cai z cua Mạnh
    var vertical_axis_top_value = (parseInt(biggest_value_of_array / constant) + 1) * constant;
    if (vertical_axis_top_value < 10) {
        vertical_axis_top_value = 10;
    }
    function pixcelLengthOfValue(value) {
        return context.measureText(value).width;
    }

//chỗ này t chưa tìm được tên phù hợp cho biến
    var left = 10;
    var center = left + pixcelLengthOfValue(vertical_axis_top_value); // vi tri viet gia tri tren Oy
    var right = 5;
    var root_cordinate_pos = center - context.measureText("0").width;
    var horizon_gap_left = left + center + right;
    var horizon_gap_right = 20;
    var vertical_axis_name = 'Time';
    var margin_left = 20;
    var margin_right = 20;
    var margin_top_collumn = 10;
    var horizon_axis = canvas_width - (horizon_gap_left + horizon_gap_right); // truc ox
    var vertical_axis = canvas_height - (vertical_gap_bot + vertical_gap_top); // truc oy

    var next_col_cordinate_pos = 0;
    var length_arrow = 5;
    var colum_width = 30;
    var realLength = horizon_axis - (margin_left + margin_right); // chieu dai tu bat dau cot nay toi ket thuc cot cuoi 
    var gap_between_col = (realLength - (colum_width * data.length)) / (data.length - 1);
    //draw colum
    var start_col_pos = horizon_gap_left + margin_left;
    function endPos(stepValue) {
        return vertical_gap_top + vertical_axis - colHeight(stepValue);
    }
    var distance_arrow_to_underline = 20;
    //draw each collum
    for (i = 0; i < data.length; i++) {
//set color for each collum       
        var color = "hsl(" + 360 / data.length * (i + 1) + ",100%, 50%)";
//      x0	The x-coordinate of the start point of the gradient
//      y0	The y-coordinate of the start point of the gradient
//      x1	The x-coordinate of the end point of the gradient
//      y1	The y-coordinate of the end point of the gradient
        var grd = context.createLinearGradient(0, 700, 0, 0);
        grd.addColorStop(0, color);
        grd.addColorStop(1, "white");
        context.fillStyle = grd;
        if (i === 0) {
            context.fillRect(start_col_pos, endPos((data[i].number_of_step)), colum_width, colHeight(data[i].number_of_step));
            fillColHeader(data[i].number_of_step, start_col_pos, endPos((data[i].number_of_step)) - margin_top_collumn);
        }

        if (i > 0 && i < data.length - 1) {
            context.fillRect(start_col_pos + next_col_cordinate_pos, endPos((data[i].number_of_step)), colum_width, colHeight(data[i].number_of_step));
            fillColHeader(data[i].number_of_step, start_col_pos + next_col_cordinate_pos, endPos((data[i].number_of_step)) - margin_top_collumn);
        }
//vong cuoi
        if (i === data.length - 1) {
            context.fillRect(start_col_pos + next_col_cordinate_pos, endPos((data[i].number_of_step)), colum_width, colHeight(data[i].number_of_step));
            fillColHeader(data[i].number_of_step, start_col_pos + next_col_cordinate_pos, endPos((data[i].number_of_step)) - margin_top_collumn);
            break;
        }
        next_col_cordinate_pos += colum_width + gap_between_col;
    }

//draw Oxy axys 
    context.beginPath();
    // context.fillStyle = "black";
    //  context.font = "19 pt Arial;";

    //Viết tên của trục Oy
    context.fillText(vertical_axis_name, margin_left, vertical_gap_top - margin_top_collumn);
    //draw Oy and arrow        
    context.moveTo(horizon_gap_left, vertical_axis + vertical_gap_top);
    context.lineTo(horizon_gap_left, vertical_gap_top);
    context.lineTo(horizon_gap_left + length_arrow, vertical_gap_top + length_arrow);
    context.moveTo(horizon_gap_left, vertical_gap_top);
    context.lineTo(horizon_gap_left - length_arrow, vertical_gap_top + length_arrow);
    //draw Ox
    context.moveTo(horizon_gap_left, vertical_axis + vertical_gap_top);
    context.lineTo(horizon_axis + horizon_gap_left, vertical_axis + vertical_gap_top);
    context.stroke();
    //write Oy value
    function writeVerticalAxisValue(headerValue, horCor, verCor) {
        context.fillStyle = "black";
        context.font = "19 pt Arial;";
        context.fillText(parseInt(headerValue), horCor, verCor);
    }
    //return height of each column
    function colHeight(step) {
        return parseInt(((vertical_axis - distance_arrow_to_underline) * step) / vertical_axis_top_value);
    }
    // write the number step in the top of each column
    function fillColHeader(headerValue, horCor, verCor) {
        context.fillStyle = "black";
        context.font = "19 pt Arial;";
        var lengthtemp = context.measureText(headerValue).width;
        context.fillText(headerValue, horCor + (colum_width / 2) - (lengthtemp / 2), verCor);
    }

    //var underline_length = 5;
    var number_of_underline = 5;
    var next_underline_pos = 0;
    var underline_value = vertical_axis_top_value;
    //bat dau lien quan toi horizon left

    //ve gia tri tung cua Oy        
    context.beginPath();
    for (var i = 0; i <= number_of_underline; i++) {
        //vẽ giá trị cao nhất của trục Oy
        if (i === 0) {
            context.moveTo(horizon_gap_left - right, vertical_gap_top + distance_arrow_to_underline);
            context.lineTo(horizon_gap_left + right, vertical_gap_top + distance_arrow_to_underline);
            writeVerticalAxisValue(underline_value, center - pixcelLengthOfValue(underline_value), vertical_gap_top + distance_arrow_to_underline);
        } else if (i > 0 && i <= number_of_underline - 2) {
            context.moveTo(horizon_gap_left - right, vertical_gap_top + distance_arrow_to_underline + next_underline_pos);
            context.lineTo(horizon_gap_left + right, vertical_gap_top + distance_arrow_to_underline + next_underline_pos);
            writeVerticalAxisValue(underline_value, center - pixcelLengthOfValue(underline_value), vertical_gap_top + distance_arrow_to_underline + next_underline_pos);
        } //viết ra số ở ngay trên số 0 gốc toạ độ
        else if (i === number_of_underline - 1) {
            context.moveTo(horizon_gap_left - right, vertical_gap_top + distance_arrow_to_underline + next_underline_pos);
            context.lineTo(horizon_gap_left + right, vertical_gap_top + distance_arrow_to_underline + next_underline_pos);
            writeVerticalAxisValue(underline_value, center - pixcelLengthOfValue(underline_value), vertical_gap_top + distance_arrow_to_underline + next_underline_pos);
        }//vẽ số 0 gốc toạ độ
        else {
            writeVerticalAxisValue(0, root_cordinate_pos, vertical_gap_top + distance_arrow_to_underline + next_underline_pos);
        }
        next_underline_pos += (vertical_axis - distance_arrow_to_underline) / number_of_underline;
        underline_value -= (vertical_axis_top_value / number_of_underline);
    }
    context.stroke();
}

function setInputFilter(textbox, inputFilter) {
    ["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function (event) {
        if (textbox !== null) {
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
//                if(this.value === "") {
//                    document.getElementById("btnInputData").disabled = true;
//                } else {
//                    document.getElementById("btnInputData").disabled = false;
//                }
            });
        }
    });
}

var numberofbox;
function draw(step) {

    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        var canvasheight = parseInt(document.getElementById("canvasAnimation").height);
        var canvaswidth = parseInt(document.getElementById("canvasAnimation").width);
        document.getElementById("canvasAnimation").height = arrayheight;
        if (algorithmtype === 'openaddressing_hash') {
            document.getElementById("canvasAnimation").width = hasharraysize * (arraywidth + gapbetweenbox)
        } else {
            document.getElementById("canvasAnimation").width = (initarray.length) * (arraywidth + gapbetweenbox);
        }
        ctx.font = "15px Arial"; //must add same value to "fontsize"
        if (category === 6) {
            numberofbox = hasharraysize;
        } else {
            numberofbox = eachStepArr[currentstep].length;
        }

        //xóa draw cũ
        ctx.fillStyle = "#edf0f4";
        ctx.fillRect(0, 0, canvaswidth, canvasheight);
        //vẽ mảng của step hiện tại
        drawInitCurrent(step, ctx);
        //highlight
        drawHighlightAnimation(step, ctx);
        //highlightsorted
        drawHighlightSorted(step, ctx);
        //highlightcode
        highlightCode(step);
        //printlog
        printLog(step);
    }
    if (step === totalstep) {
        document.getElementById("btnNext").disabled = true;
        document.getElementById("PauseOrCon").value = 'Play';
    } else {
        document.getElementById("btnNext").disabled = false;
    }
    if (step <= 0) {
        document.getElementById("btnPrev").disabled = true;
    } else {
        document.getElementById("btnPrev").disabled = false;
    }
    if (step > 0) {
        document.getElementById("txtStepcount").innerHTML = '' + (step + 1) + "/ " + (totalstep + 1);
    } else {
        document.getElementById("txtStepcount").innerHTML = '' + 1 + "/ " + (totalstep + 1);
    }
    document.getElementById("progressStep").value = step;
    document.getElementById("slideStep").value = step;
}

function drawInitCurrent(currentstep, ctx) {

    for (var i = 0; i < numberofbox; i++) {
        ctx.fillStyle = "#AAAAAA";
        ctx.fillRect((i * arraywidth) + (i * 1), Yp, arraywidth, arrayheight);
        if (eachStepArr[currentstep][i] !== undefined && eachStepArr[currentstep][i] !== null) {
            ctx.fillStyle = "#000000";
//            ctx.fillText(eachStepArr[currentstep][i], (Xp * i * gapbetweennumber) * XYs + 18, Yp * XYs * 7, 60);
            if (eachStepArr[currentstep][i] > 9) {
                ctx.fillText(eachStepArr[currentstep][i], (i * arraywidth) + (i * gapbetweenbox) + (arraywidth / 3), Yp + (3 * arrayheight / 5), arraywidth, arrayheight);
            } else {
                ctx.fillText(eachStepArr[currentstep][i], (i * arraywidth) + (i * gapbetweenbox) + (2 * arraywidth / 5), Yp + (3 * arrayheight / 5), arraywidth, arrayheight);
            }
        }
        if (highlightcode[i] !== 0) {
            var line_name = "line_" + highlightcode[i];
            if (document.getElementById(line_name) !== null) {
                document.getElementById(line_name).style.background = "None";
            } 
        }
    }

}

function drawHighlightAnimation(currentstep, ctx) {
    for (var i = 0; i < numberofbox; i++) {
        for (var j = 0; j < highlightcheck[currentstep].length; j++) {
            if (highlightcheck[currentstep][j] === i) {
                if (color[currentstep] === "swap" || color[currentstep] === "found") {
                    ctx.fillStyle = "#c51162";
                    ctx.fillRect((i * arraywidth) + (i * 1), Yp, arraywidth, arrayheight);

                } else {
                    ctx.fillStyle = "#2962ff";
                    ctx.fillRect((i * arraywidth) + (i * 1), Yp, arraywidth, arrayheight);
                }
                if (eachStepArr[currentstep][i] !== undefined && eachStepArr[currentstep][i] !== null) {
                    ctx.fillStyle = "#000000";
                    if (eachStepArr[currentstep][i] > 9) {
                        ctx.fillText(eachStepArr[currentstep][i], (i * arraywidth) + (i * gapbetweenbox) + (arraywidth / 3), Yp + (3 * arrayheight / 5), arraywidth, arrayheight);
                    } else {
                        ctx.fillText(eachStepArr[currentstep][i], (i * arraywidth) + (i * gapbetweenbox) + (2 * arraywidth / 5), Yp + (3 * arrayheight / 5), arraywidth, arrayheight);
                    }
                }
            }
        }
    }

}

function drawHighlightSorted(currentstep, ctx) {
    for (var i = 0; i < numberofbox; i++) {
        if (currentstep !== 0 && highlightsorted[currentstep] !== null) {
            for (var j = 0; j < highlightsorted[currentstep].length; j++) {
                if (highlightsorted[currentstep][j] === i) {
                    ctx.fillStyle = "Green";
                    ctx.fillRect((i * arraywidth) + (i * 1), Yp, arraywidth, arrayheight);
                    ctx.fillStyle = "#000000";
                    if (eachStepArr[currentstep][i] > 9) {
                        ctx.fillText(eachStepArr[currentstep][i], (i * arraywidth) + (i * gapbetweenbox) + (arraywidth / 3), Yp + (3 * arrayheight / 5), arraywidth, arrayheight);
                    } else {
                        ctx.fillText(eachStepArr[currentstep][i], (i * arraywidth) + (i * gapbetweenbox) + (2 * arraywidth / 5), Yp + (3 * arrayheight / 5), arraywidth, arrayheight);
                    }
                }
            }
        }
    }
}

function highlightCode(currentstep) {
    removeHighlightedCode();
    for (var i = 0; i < highlightcode[currentstep].length; i++) {
        if (highlightcode[currentstep][i] !== 0) {
            var line_name = "line_" + highlightcode[currentstep][i];
            if (document.getElementById(line_name) !== null) {
                document.getElementById(line_name).style.background = "#90EE90";
            }
        }
    }

}

function removeHighlightedCode() {
    for (var i = 0; i < highlightcode.length; i++) {
        for (var j = 0; j < highlightcode[i].length; j++) {
            if (highlightcode[i][j] !== 0) {
                var line_name = "line_" + highlightcode[i][j];
                if (document.getElementById(line_name) !== null) {
                    document.getElementById(line_name).style.background = "None";
                }
            }
        }
    }
}

function printLog(currentstep) {
    var text = logarray[currentstep];
    document.getElementById("txtlog").innerHTML = text;
    var scrollBox = document.getElementById("txtlog");
    scrollBox.scrollTop = scrollBox.scrollHeight;
}

function bubbleSort(array) {

    var temparray = newarray(array);
    var count = 0;
    eachStepArr = [];
    highlightcheck = [];
    color = [];
    highlightcode = [];
    highlightsorted = [];
    logarray = [];
    eachStepArr.push(newarray(temparray));
    highlightcheck.push(0);
    color.push(0);
    highlightcode.push([1]);
    highlightsorted.push(null);
    logarray.push('Start sorting...<br>');
    for (var i = 0; i < temparray.length - 1; i++) {
        for (var j = 0; j < temparray.length - i - 1; j++) {
            count++;
            eachStepArr.push(newarray(temparray));
            highlightcheck.push([j, j + 1]);
            color.push("normal");
            highlightcode.push([2]);
            logarray.push(logarray[logarray.length - 1] + 'Checking with i = ' + i + ', j = ' + j + '<br>');
            if (temparray[j] > temparray[j + 1]) {
                logarray.push(logarray[logarray.length - 1] + 'Swap ' + temparray[j] + ' and ' + temparray[j + 1] + '<br>');
                var temp = temparray[j];
                temparray[j] = temparray[j + 1];
                temparray[j + 1] = temp;
                color.push("swap");
                eachStepArr.push(newarray(temparray));
                highlightcheck.push([j, j + 1]);
                highlightcode.push([5]);
                if (i > 0) {
                    highlightsorted.push(newsortedarray(i));
                } else {
                    highlightsorted.push(null);
                }
            }
            if (i > 0) {
                highlightsorted.push(newsortedarray(i));
            } else {
                highlightsorted.push(null);
            }
        }
    }
    highlightcheck.push(0);
    highlightcode.push([8]);
    eachStepArr.push(newarray(temparray));
    totalstep = eachStepArr.length - 1;
    highlightsorted.push(newsortedarray(initarray.length));
    logarray.push(logarray[logarray.length - 1] + 'Array sorted!');
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
}

function insertionSort(array) {
    var temparray = newarray(array);
    var count = 0;
    eachStepArr = [];
    highlightcheck = [];
    highlightsorted = [];
    highlightcode = [];
    color = [];
    logarray = [];
    eachStepArr.push(newarray(temparray));
    highlightcheck.push(0);
    highlightsorted.push(0);
    color.push("key");
    highlightcode.push([1]);
    logarray.push('Start sorting...<br>');
    var i, key, j, k;
    for (i = 1; i < temparray.length; i++) {
        key = temparray[i];
        j = i - 1;
        k = 0;
        eachStepArr.push(newarray(temparray));
        highlightcheck.push([i]);
        color.push("key");
        highlightsorted.push([i]);
        highlightcode.push([2]);
        logarray.push(logarray[logarray.length - 1] + 'key index = ' + i + ', key value = ' + temparray[i] + '<br>');
        while (j >= 0 && temparray[j] > key) {
            logarray.push(logarray[logarray.length - 1] + 'Set array[' + (j + 1) + '] = array[' + j + '], value ' + temparray[j + 1] + ' -> ' + temparray[j] + '<br>');
            temparray[j + 1] = temparray[j];
            eachStepArr.push(newarray(temparray));
            color.push("swap");
            highlightcheck.push([i - k]);
            if (j + 1 === i) {
                highlightsorted.push(null);
            } else {
                highlightsorted.push([i]);
            }
            highlightcode.push([5]);
            k++;
            j--;
        }
        logarray.push(logarray[logarray.length - 1] + 'Set array[' + (j + 1) + '] = key, value ' + temparray[j + 1] + ' -> ' + key + '<br>');
        temparray[j + 1] = key;
        eachStepArr.push(newarray(temparray));
        color.push("swap");
        highlightcheck.push([i - k]);
        highlightsorted.push([i]);
        highlightcode.push([8]);
    }
    highlightcode.push([9]);
    eachStepArr.push(newarray(temparray));
    color.push(0);
    highlightcheck.push(0);
    totalstep = eachStepArr.length - 1;
    highlightsorted.push(newSortedInsertionArray(initarray.length));
    logarray.push(logarray[logarray.length - 1] + 'Array sorted!');
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
}

function selectionSort(array) {

    var temparray = newarray(array);
    var count = 0;
    //init arrays
    eachStepArr = [];
    highlightcheck = [];
    highlightsorted = [];
    color = [];
    highlightcode = [];
    logarray = [];
    //first elements
    eachStepArr.push(newarray(temparray));
    highlightcheck.push(0);
    color.push(0);
    highlightcode.push([1]);
    highlightsorted.push(null);
    logarray.push('Start sorting...<br>');
    for (var i = 0; i < temparray.length - 1; i++) {
        var index = i;
        eachStepArr.push(newarray(temparray));
        highlightcheck.push(i);
        color.push(0);
        highlightcode.push([2]);
        highlightsorted.push([i]);
        logarray.push(logarray[logarray.length - 1] + 'i = ' + i + ', index = ' + index + '<br>');
        for (var j = i + 1; j < temparray.length; j++) {
            eachStepArr.push(newarray(temparray));
            highlightcheck.push([j]);
            color.push("check");
            highlightcode.push([3]);
            highlightsorted.push([i]);
            logarray.push(logarray[logarray.length - 1]);
            if (temparray[j] < temparray[index]) {
                index = j;
                eachStepArr.push(newarray(temparray));
                highlightcheck.push([j]);
                color.push("swap");
                highlightcode.push([5]);
                highlightsorted.push([i]);
                logarray.push(logarray[logarray.length - 1] + 'Set index = ' + index + '<br>');
            }
        }
        var smallerNumber = temparray[index];
        temparray[index] = temparray[i];
        temparray[i] = smallerNumber;
        eachStepArr.push(newarray(temparray));
        highlightcheck.push([i, index]);
        color.push("swap");
        highlightcode.push([10]);
        highlightsorted.push([i]);
        logarray.push(logarray[logarray.length - 1]);
    }
//last elements
    highlightcheck.push(0);
    highlightcode.push([11]);
    eachStepArr.push(newarray(temparray));
    totalstep = eachStepArr.length - 1;
    highlightsorted.push(newsortedarray(initarray.length));
    logarray.push(logarray[logarray.length - 1] + 'Array sorted!');
    //set step in userview
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
}

function sort(array) {
    for (var i = 0; i < array.length - 1; i++) {
        for (var j = 0; j < array.length - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                var temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}

function linearSearch(array) {
    sort(array);
    eachStepArr = [];
    highlightcheck = [];
    highlightsorted = [];
    color = [];
    highlightcode = [];
    logarray = [];
    eachStepArr.push(array);
    highlightcheck.push(0);
    highlightsorted.push(null);
    color.push(0);
    highlightcode.push([1]);
    logarray.push('Start searching number ' + searchnumber + ' in the array...<br>');
    for (var i = 0; i < array.length; i++) {
        eachStepArr.push(array);
        highlightcheck.push([i]);
        highlightsorted.push(null);
        color.push("check");
        highlightcode.push([2]);
        logarray.push(logarray[logarray.length - 1] + 'Checking with i = ' + i + ', array[' + i + '] = ' + array[i] + '<br>');
        if (array[i] === searchnumber) {
            eachStepArr.push(array);
            highlightcheck.push([i]);
            highlightsorted.push(null);
            color.push("found");
            highlightcode.push([3]);
            logarray.push(logarray[logarray.length - 1] + 'Found ' + searchnumber + " at position i = " + i + '<br>');
            break;
        } else if (i === array.length - 1) {
            eachStepArr.push(array);
            highlightcheck.push(0);
            highlightsorted.push(null);
            color.push(0);
            highlightcode.push([6]);
            logarray.push(logarray[logarray.length - 1] + 'Can not find ' + searchnumber + ' in the array <br>');
        }
    }

//set step in userview
    totalstep = eachStepArr.length - 1;
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
}

function binarySearchexe(arr, l, r, searchnumber) {
    var highlightcheckarr = [];
    for (var i = l; i <= r; i++) {
        highlightcheckarr.push(i);
    }
    if (r >= l) {
        var mid = parseInt(l + (r - l) / 2);
        eachStepArr.push(initarray);
        highlightcheck.push(highlightcheckarr);
        highlightsorted.push([mid]);
        color.push('check');
        highlightcode.push([4]);
        logarray.push(logarray[logarray.length - 1] + 'mid = ' + mid + ', checking at index ' + mid + '<br>');
        if (arr[mid] === searchnumber) {
            eachStepArr.push(initarray);
            highlightcheck.push([mid]);
            highlightsorted.push(null);
            color.push("found");
            highlightcode.push([5]);
            logarray.push(logarray[logarray.length - 1] + 'Found ' + searchnumber + ' in position ' + mid + '<br>');
            return mid;
        }
        if (arr[mid] > searchnumber) {
            eachStepArr.push(arr);
            highlightcheckarr = [];
            for (var i = l; i <= mid - 1; i++) {
                highlightcheckarr.push(i);
            }
            highlightcheck.push(highlightcheckarr);
            highlightsorted.push(null);
            color.push('check');
            highlightcode.push([8]);
            logarray.push(logarray[logarray.length - 1] + 'Select left<br>left = ' + l + ', right = ' + (mid - 1) + '<br>');
            return binarySearchexe(arr, l, mid - 1, searchnumber);
        }
        eachStepArr.push(arr);
        highlightcheckarr = [];
        for (var i = mid + 1; i <= r; i++) {
            highlightcheckarr.push(i);
        }
        highlightcheck.push(highlightcheckarr);
        highlightsorted.push(null);
        color.push('check');
        highlightcode.push([[10]]);
        logarray.push(logarray[logarray.length - 1] + 'Select right<br>left = ' + (mid + 1) + ', right = ' + r + '<br>');
        return binarySearchexe(arr, mid + 1, r, searchnumber);
    }
    eachStepArr.push(initarray);
    highlightcheck.push(0);
    highlightsorted.push(null);
    color.push(0);
    highlightcode.push([12]);
    logarray.push(logarray[logarray.length - 1] + 'Can not find ' + searchnumber + ' in the array <br>');
    return -1;
}

function binarySearch(array) {
    sort(array);
    eachStepArr = [];
    highlightcheck = [];
    highlightsorted = [];
    color = [];
    highlightcode = [];
    logarray = [];
    eachStepArr.push(array);
    highlightcheck.push(0);
    highlightsorted.push(null);
    color.push(0);
    highlightcode.push(0);
    logarray.push('Start searching number ' + searchnumber + ' in the array...<br>');
    var n = array.length;
    var left = 0;
    var right = n - 1;
    eachStepArr.push(array);
    var highlightcheckarr = [];
    for (var i = left; i <= right; i++) {
        highlightcheckarr.push(i);
    }
    highlightcheck.push(highlightcheckarr);
    highlightsorted.push(null);
    color.push('check');
    highlightcode.push(1);
    logarray.push(logarray[logarray.length - 1] + 'left = ' + left + ', right = ' + right + '<br>');
    binarySearchexe(array, left, right, searchnumber);
//set step in userview
    totalstep = eachStepArr.length - 1;
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
}

function interpolationSearch(array) {
    sort(array);
    eachStepArr = [];
    highlightcheck = [];
    highlightsorted = [];
    color = [];
    highlightcode = [];
    logarray = [];
    eachStepArr.push(array);
    highlightcheck.push(0);
    highlightsorted.push(null);
    color.push(0);
    highlightcode.push([1]);
    logarray.push('Start searching number ' + searchnumber + ' in the array...<br>');
    var n = array.length;
    var x = searchnumber;
    var lo = 0, hi = (n - 1);
    var highlightcheckarr = [];
    var found = false;
    for (var i = lo; i <= hi; i++) {
        highlightcheckarr.push(i);
    }
    eachStepArr.push(array);
    highlightcheck.push(highlightcheckarr);
    highlightsorted.push(null);
    color.push(0);
    highlightcode.push([2]);
    logarray.push(logarray[logarray.length - 1] + 'low = ' + lo + ', high = ' + hi + '<br>');
    while (lo <= hi && x >= array[lo] && x <= array[hi]) {
        if (lo === hi) {
            if (array[lo] === x) {
                eachStepArr.push(array);
                highlightcheck.push(highlightcheckarr);
                highlightsorted.push(null);
                color.push("found");
                highlightcode.push([6]);
                logarray.push(logarray[logarray.length - 1] + 'Found ' + searchnumber + ' in position ' + pos);
                found = true;
                break;
//                return lo;
            } else {
                eachStepArr.push(array);
                highlightcheck.push(highlightcheckarr);
                highlightsorted.push(null);
                color.push(0);
                highlightcode.push([8]);
                logarray.push(logarray[logarray.length - 1] + 'Can not find ' + searchnumber + ' in the array <br>');
//            return -1;
            }
        }
        var pos = parseInt(lo + (((hi - lo) /
                (array[hi] - array[lo])) * (x - array[lo])));
        eachStepArr.push(array);
        highlightcheck.push(highlightcheckarr);
        highlightsorted.push([pos]);
        color.push(0);
        highlightcode.push([10, 11]);
        logarray.push(logarray[logarray.length - 1] + 'Checking position ' + pos + '<br>');
        if (array[pos] === x) {
            eachStepArr.push(array);
            highlightcheck.push([pos]);
            highlightsorted.push(null);
            color.push("found");
            highlightcode.push([13]);
            logarray.push(logarray[logarray.length - 1] + 'Found ' + searchnumber + ' in position ' + pos);
            found = true;
            break;
//            return pos;
        }
        if (array[pos] < x) {
            lo = pos + 1;
            highlightcheckarr = [];
            for (var i = lo; i <= hi; i++) {
                highlightcheckarr.push(i);
            }
            eachStepArr.push(array);
            highlightcheck.push(highlightcheckarr);
            highlightsorted.push(null);
            color.push(0);
            highlightcode.push([16]);
            logarray.push(logarray[logarray.length - 1] + 'Select right!<br>' + 'low = ' + lo + ', high = ' + hi + '<br>');
        } else {
            hi = pos - 1;
            highlightcheckarr = [];
            for (var i = lo; i <= hi; i++) {
                highlightcheckarr.push(i);
            }
            eachStepArr.push(array);
            highlightcheck.push(highlightcheckarr);
            highlightsorted.push(null);
            color.push(0);
            highlightcode.push([18]);
            logarray.push(logarray[logarray.length - 1] + 'Select left!<br>' + 'low = ' + lo + ', high = ' + hi + '<br>');
        }
    }
    if (!found) {
        eachStepArr.push(array);
        highlightcheck.push(0);
        highlightsorted.push(null);
        color.push(0);
        highlightcode.push([21]);
        logarray.push(logarray[logarray.length - 1] + 'Can not find ' + searchnumber + ' in the array <br>');
//    return -1;
    }


//set step in userview
    totalstep = eachStepArr.length - 1;
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
}

function separatechainingHash(array) {
    eachStepArr = [];
    highlightcheck = [];
    highlightsorted = [];
    color = [];
    highlightcode = [];
    logarray = [];
}

function openaddressingHash(array) {
//    if(array[hasharraysize-1] === undefined) {
//        array[hasharraysize-1] = null;
//    }
    hashtable = new OpenAddressHashTable();
    addArraytoHashTable(hasharray);
    //init 
    eachStepArr = [];
    highlightcheck = [];
    highlightsorted = [];
    color = [];
    highlightcode = [];
    logarray = [];
    //start
    eachStepArr.push(hashtable.list);
    highlightcheck.push(0);
    highlightsorted.push(0);
    color.push(0);
    highlightcode.push(0);
    logarray.push('Start searching key = ' + searchnumber + '<br>');
    let index = getindex(searchnumber, hasharraysize);
    eachStepArr.push(hashtable.list);
    highlightcheck.push([index]);
    highlightsorted.push(0);
    color.push('check');
    highlightcode.push(0);
    logarray.push(logarray[logarray.length - 1] + 'Index: ' + searchnumber + ' % ' + hasharraysize + ' = ' + index + '<br>'
            + 'Checking index: ' + index + '. Value = ' + hashtable.list[index] + '<br>');
    let isFound = true;
    let start = index;
    if (hashtable.list[index] !== searchnumber) {
        if (hashtable.list[index] === undefined) {
            logarray.push(logarray[logarray.length - 1] + 'index value undefined!<br>Can not find ' + searchnumber + '!');
            isFound = false;
        }
        while (isFound === true) {
            index++;
            {
                if (index > hasharraysize - 1) {
                    index = 0;
                }
                if (index === start) {
                    logarray.push(logarray[logarray.length - 1] + 'Searched all index!<br>Can not find ' + searchnumber + '!');
                    isFound = false;
                    break;
                }

                eachStepArr.push(hashtable.list);
                highlightcheck.push([index]);
                highlightsorted.push(0);
                color.push('check');
                highlightcode.push(0);
                logarray.push(logarray[logarray.length - 1] + 'Checking index: ' + index + '. Value = ' + hashtable.list[index] + '<br>');
                if (hashtable.list[index] === searchnumber) {
                    break;
                }
                if (hashtable.list[index] === undefined) {
                    logarray.push(logarray[logarray.length - 1] + 'index value undefined!<br>Can not find ' + searchnumber + '!');
                    isFound = false;
                    break;
                }

            }
        }
    }
    if (isFound) {
        eachStepArr.push(hashtable.list);
        highlightcheck.push([index]);
        highlightsorted.push(0);
        color.push('found');
        highlightcode.push(0);
        logarray.push(logarray[logarray.length - 1] + 'Found ' + searchnumber + ' in position ' + index);
    } else {
        eachStepArr.push(hashtable.list);
        highlightcheck.push(0);
        highlightsorted.push(0);
        color.push(0);
        highlightcode.push(0);
//        logarray.push(logarray[logarray.length - 1] + 'Can not find ' + searchnumber + '!');
    }
//set step in userview
    totalstep = eachStepArr.length - 1;
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
}


