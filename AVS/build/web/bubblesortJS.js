var initArray = [9, 8, 7, 6, 9, 4, 3, 2, 1, 1];
//export var initArray = [9, 8, 7, 6, 9, 4, 3, 2, 1, 1];
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
var highlight = [];
var color = [];
//window.init = init;
//window.shuffle = shuffle;
//window.initArray = initArray;
//window.next = next;
//window.back = back;
//window.resume = resume;


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
    bubbleSort2(initArray);
    currentstep = -1;
    canvas = document.getElementById('canvas');
    draw(0);
    if (boolRun) {
        clearInterval(run);
        loadingAnimation();
    }
   
}

function next() {
    clearInterval(run);
    if (currentstep < eachStepArr.length - 1) {
        currentstep++;
        draw(currentstep);
    }
    boolRun = false;
    document.getElementById("PauseOrCon").value = 'Resume';
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
    document.getElementById("PauseOrCon").value = 'Resume';
}

function resume() {
    if (boolRun) {
        //đang trong trạng thái chạy
        clearInterval(run);
        document.getElementById("PauseOrCon").value = 'Resume';
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
function draw(currentstep) {
    
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        for (var i = 0; i < eachStepArr[currentstep].length; i++) {
            ctx.fillStyle = "#AAAAAA";
            ctx.fillRect((Xp * i * 16) * XYs, Yp * XYs * 5 - 20, 30, 30);
            ctx.fillStyle = "#000000";
            ctx.fillText(eachStepArr[currentstep][i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);

            //highlight
            if (currentstep !== 0 && currentstep !== eachStepArr.length - 1 && i === highlight[currentstep] + 1) {
                if (color[currentstep] === "swap") {
                    ctx.fillStyle = "#FF6767";
                    ctx.fillText(eachStepArr[currentstep][i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);
                    ctx.fillText(eachStepArr[currentstep][i - 1], (Xp * (i - 1) * 16) * XYs + 10, Yp * XYs * 5, 60);
                } else {
                    ctx.fillStyle = "#21A4F3";
                    ctx.fillText(eachStepArr[currentstep][i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);
                    ctx.fillText(eachStepArr[currentstep][i - 1], (Xp * (i - 1) * 16) * XYs + 10, Yp * XYs * 5, 60);
                }
            }
            if(highlightcode[i]!==0) {
            var line_name= "line_" + highlightcode[i];
             document.getElementById(line_name).style.background="None";
         }
        }
        if(highlightcode[currentstep]!==0) {
            var line_name= "line_" + highlightcode[currentstep];
             document.getElementById(line_name).style.background="Red";
         }
        
    }
    if (currentstep === totalstep) {
        document.getElementById("btnNext").disabled = true;
    } else {
        document.getElementById("btnNext").disabled = false;
    }
    if (currentstep === 0) {
        document.getElementById("btnPrev").disabled = true;
    } else {
        document.getElementById("btnPrev").disabled = false;
    }
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/ " + (totalstep + 1);
    document.getElementById("progressStep").value = currentstep;
    document.getElementById("slideStep").value = currentstep;
}


function newarray(array) {
    var newarray = [];
    array.forEach(function (item) {
        newarray.push(item);
    });

    return newarray;
}
var highlightcode= [];
function bubbleSort2(array) { // * is magic  
    
    var temparray = newarray(array);
    var count = 0;
    eachStepArr = [];
    highlight = [];
    color = [];
    eachStepArr.push(newarray(temparray));
    highlight.push(0);
    color.push(0);
    highlightcode.push(1);
    for (var i = 0; i < temparray.length - 1; i++) {
        for (var j = 0; j < temparray.length - i - 1; j++) {
            count++;
            eachStepArr.push(newarray(temparray));
            highlight.push(j);
            color.push("normal");
          highlightcode.push(2);
            if (temparray[j] > temparray[j + 1]) {             
                var temp = temparray[j];
                temparray[j] = temparray[j + 1];
                temparray[j + 1] = temp;
                color.push("swap");
                eachStepArr.push(newarray(temparray));
                highlight.push(j);
                highlightcode.push(3);
            }
        }
    }
    highlightcode.push(9);
    eachStepArr.push(newarray(temparray));
    totalstep = eachStepArr.length - 1;
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
    
}

//chinh speed khi user giu con tro chuot
function changeSpeed() {
    speed = 1000/(parseInt(document.getElementById("rangebar").value));
  
}

//chưa sửa được lỗi


function drawGraph(data) {
    var my_canvas = document.getElementById("canvas2");
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



