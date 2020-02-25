var initArray = [9, 8, 7, 6, 9, 4, 3, 2, 1, 1];
//export var initArray = [9, 8, 7, 6, 9, 4, 3, 2, 1, 1];
var gapbetweennumber = 10;
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
//window.init = init;
//window.shuffle = shuffle;
//window.initArray = initArray;
//window.next = next;
//window.back = back;
//window.resume = resume;

function init() {
    var mydata = JSON.stringify(initArray);
    console.log("datanormal: " + initArray);
    $.ajax({
        type: "POST",
        url: "SortStepServlet",
        data: {name: mydata}
        ,
        dataType: "json",
        //OK
        success: function (data) {
            console.log(data);
            drawGraph(data);
        }
        ,
        error: function (error) {
            console.log("error", error);
        }
    }
    );
    selectionSort(initArray);
    currentstep = -1;
    canvas = document.getElementById('canvasAnimation');
    draw(0);
    if (boolRun) {
        clearInterval(run);
        loadingAnimation();
    }
//    boolRun = true;
//    resume();

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

    //first elements
    eachStepArr.push(newarray(temparray));
    highlightcheck.push(0);
    color.push(0);
    highlightcode.push(1);
    highlightsorted.push(null);

    for (var i = 0; i < temparray.length - 1; i++) {
        var index = i;
        eachStepArr.push(newarray(temparray));
        highlightcheck.push(i);
        color.push(0);
        highlightcode.push(2);
        highlightsorted.push([i]);
        for (var j = i + 1; j < temparray.length; j++) {
            eachStepArr.push(newarray(temparray));
            highlightcheck.push([j]);
            color.push("check");
            highlightcode.push(3);
            highlightsorted.push([i]);
            if (temparray[j] < temparray[index]) {
                index = j;
                eachStepArr.push(newarray(temparray));
                highlightcheck.push([j]);
                color.push("swap");
                highlightcode.push(5);
                highlightsorted.push([i]);
            }
        }
        var smallerNumber = temparray[index];
        temparray[index] = temparray[i];
        temparray[i] = smallerNumber;
        eachStepArr.push(newarray(temparray));
        highlightcheck.push([i,index]);
        color.push("swap");
        highlightcode.push(8);
        highlightsorted.push([i]);
    }
    //last elements
    highlightcode.push(9);
    eachStepArr.push(newarray(temparray));
    totalstep = eachStepArr.length - 1;
    highlightsorted.push(newsortedarray(initArray.length));

    //set step in userview
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;

}

function shuffle() {
    var oldPos = initArray.length,
            newPos, temp;
    while (--oldPos) {
        newPos = Math.floor(Math.random() * (oldPos + 1));
        temp = initArray[oldPos];
        initArray[oldPos] = initArray[newPos];
        initArray[newPos] = temp;
    }
    init();
}

function integerArray(stringArr) {
    var intArr = [];
    for (var i = 0; i < stringArr.length; i++) {
        //if check ma la co ki tu khong phai so
        if (!isNormalInteger(stringArr[i])) {
            //hien ra alert() len trang index

            return null;
        }
        //neu khong thi xay dung ra mot cai mang     
        else {
            number = parseInt(stringArr[i]);
            intArr.push(number);
        }
    }

    return intArr;
}

function inputByUser() {
    arr_by_user = document.getElementById("txtElement").value;
    arr_by_user = arr_by_user.split(',');
    if (integerArray(arr_by_user) !== null) {
        initArray = integerArray(arr_by_user);
    }
    init();
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

function isNormalInteger(str) {
    return /^\+?(0|[1-9]\d*)$/.test(str);
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

//hien thi ve
function loadingAnimation() {
    //check de cho phep load tiep hay ko
    if (currentstep < eachStepArr.length - 1) {
        currentstep++;
        draw(currentstep);
    }
    run = setTimeout(loadingAnimation, speed);
}

//ve ra lai cai mang
function draw(step) {

    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        var canvasheight = parseInt(document.getElementById("canvasAnimation").height);
        var canvaswidth = parseInt(document.getElementById("canvasAnimation").width);
        //xóa draw cũ
        ctx.fillStyle = "#FFFFFF";
        ctx.fillRect(0, 0, canvaswidth, canvasheight);

        //vẽ mảng của step hiện tại
        drawInitCurrent(step, ctx);
        
        //highlightsorted
        drawHighlightSorted(step, ctx);

        //highlight
        drawHighlightAnimation(step, ctx);

        

        //highlightcode
        highlightCode(step);



    }
    if (step === totalstep) {
        document.getElementById("btnNext").disabled = true;
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
    for (var i = 0; i < eachStepArr[currentstep].length; i++) {
        ctx.fillStyle = "#AAAAAA";
        ctx.fillRect((Xp * i * gapbetweennumber) * XYs, Yp * XYs * 5 - 20, 30, 30);
        ctx.fillStyle = "#000000";
        ctx.fillText(eachStepArr[currentstep][i], (Xp * i * gapbetweennumber) * XYs + 10, Yp * XYs * 5, 60);
        if (highlightcode[i] !== 0) {
            var line_name = "line_" + highlightcode[i];
            document.getElementById(line_name).style.background = "None";
        }
    }
}

function drawHighlightAnimation(currentstep, ctx) {
    for (var i = 0; i < eachStepArr[currentstep].length; i++) {
        if (currentstep !== 0 && currentstep !== eachStepArr.length - 1) {
            for (var j = 0; j < highlightcheck[currentstep].length; j++) {
                if (highlightcheck[currentstep][j] === i) {
                    if (color[currentstep] === "swap") {
                        ctx.fillStyle = "#c51162";
                        ctx.fillRect((Xp * i * gapbetweennumber) * XYs, Yp * XYs * 5 - 20, 30, 30);
                        ctx.fillStyle = "#000000";
                        ctx.fillText(eachStepArr[currentstep][i], (Xp * i * gapbetweennumber) * XYs + 10, Yp * XYs * 5, 60);
                    } else {
                        ctx.fillStyle = "#2962ff";
                        ctx.fillRect((Xp * i * gapbetweennumber) * XYs, Yp * XYs * 5 - 20, 30, 30);
                        ctx.fillStyle = "#000000";
                        ctx.fillText(eachStepArr[currentstep][i], (Xp * i * gapbetweennumber) * XYs + 10, Yp * XYs * 5, 60);
                    }
                }
            }

        }
    }
}

function drawHighlightSorted(currentstep, ctx) {
    for (var i = 0; i < eachStepArr[currentstep].length; i++) {
        if (currentstep !== 0 && highlightsorted[currentstep] !== null) {
            for (var j = 0; j < highlightsorted[currentstep].length; j++) {
                if (highlightsorted[currentstep][j] === i) {
                    ctx.fillStyle = "Green";
                    ctx.fillRect((Xp * i * gapbetweennumber) * XYs, Yp * XYs * 5 - 20, 30, 30);
                    ctx.fillStyle = "#000000";
                    ctx.fillText(eachStepArr[currentstep][i], (Xp * i * gapbetweennumber) * XYs + 10, Yp * XYs * 5, 60);
                }
            }

        }
    }
}

function highlightCode(currentstep) {
    //khởi tạo lại
    highlightcode.forEach(function (item) {
        if (item !== 0) {
            var line_name = "line_" + item;
            document.getElementById(line_name).style.background = "None";
        }
    });
    //hightlightcode 
    if (highlightcode[currentstep] !== 0) {
        var line_name = "line_" + highlightcode[currentstep];
        document.getElementById(line_name).style.background = "Red";
    }
}


function newarray(array) {
    var tempwarray = [];
    array.forEach(function (item) {
        tempwarray.push(item);
    });

    return tempwarray;
}

function newsortedarray(sorted) {
    var tempwarray = [];
    for (var i = sorted; i > 0; i--) {
        tempwarray.push(initArray.length - i);
    }
    return newarray(tempwarray);
}



//chinh speed khi user giu con tro chuot
function changeSpeed() {
    speed = 1000 / (parseInt(document.getElementById("rangebar").value));

}

//chưa sửa được lỗi


function drawGraph(data) {
    var my_canvas = document.getElementById("canvasGraph");
    var gctx = my_canvas.getContext("2d");

//cái data này lúc sau sẽ là Get và json convert
//var data = [['Bubble Sort', 140], ['Selection sort', 150], ['Quick Sort', 170], ['Heap Sort', 110], ['Insertion sort', 170]];

///////// Settings  ////////// 

    var bar_width = 50;
    var y_gap = 30;  // Gap below the graph 
    var bar_gap = 100; // Gap between Bars including width of the bar
    var x = 20; // Margin of graph from left  

    var y = my_canvas.height - y_gap;

    my_canvas.width = data.length * (bar_gap) + x;
////////////end of settings ////
    gctx.moveTo(x - 5, y);
    gctx.lineTo(my_canvas.width, y); // Base line of graph 
    gctx.stroke();
/// add shadow ///
    gctx.shadowColor = '#000000';
    gctx.shadowOffsetX = 3;
    gctx.shadowOffsetY = 3;
    gctx.shadowBlur = 3;
/////////// Draw the graph ////////

    for (var i = 0; i < data.length; i++) {
        gctx.shadowColor = '#ffffff'; // remove this line if you shadow on text is required
        gctx.font = '18px serif'; // font for base label showing classes 
        gctx.textAlign = 'left';
        gctx.textBaseline = 'top';
        gctx.fillStyle = '#008cf5';
        gctx.fillText(data[i].sortName, x, y + 5); // Write base text for classes 

        gctx.beginPath();
        gctx.lineWidth = 2;
        var y1 = y - data[i].number_of_step; // Coordinate for top of the Bar 
        var x1 = x;
        gctx.font = '12px serif'; // font at top of the bar 
        gctx.fillStyle = '#000000';
        gctx.fillText(data[i].number_of_step, x1, y1 - 20); // text at top of the bar 

        gctx.fillStyle = '#f52369'; // fill Colur of bar  
        gctx.shadowColor = '#000000'; // shadow color for bars 
        gctx.fillRect(x1, y1, bar_width, data[i].number_of_step);// Filled bar 

        x = x + bar_gap;

    }
}


function setInputFilter(textbox, inputFilter) {
    ["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function (event) {
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
    });
}




/*setInputFilter(document.getElementById("intLimitTextBox"), function(value) {
 return /^\d*$/.test(value) && (value === "" ||( parseInt(value) >=1 && parseInt(value) <= mang.length)); });*/
setInputFilter(document.getElementById("intLimitTextBox"), function (value) {
    return /^(\d+[, ]+)*$/.test(value);
});



