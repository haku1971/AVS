
N = 10; // Array Size
XYs = 5; // Element Visual Size
Xp = 1; // Start Pos X
Yp = 1; // Start Pos Y
var canvas;
var currentstep = 0;
var totalstep;
var initArray = [9, 8, 7, 6, 9, 4, 3, 2, 1];
var run;
var boolRun = true;
var arr_by_user = [];
var speed = 1000;
var eachStepArr = [];
var highlight = [];
var color = [];

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
    arr_by_user = arr_by_user.split('.');
    if (integerArray(arr_by_user) !== null) {
        initArray = integerArray(arr_by_user);
    }
    init();
}

function init() {
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

function bubbleSort2(array) { // * is magic   
    temparray = newarray(array);
    var count = 0;
    eachStepArr = [];
    highlight = [];
    color = [];
    eachStepArr.push(newarray(temparray));
    highlight.push(0);
    color.push(0);
    for (var i = 0; i < temparray.length - 1; i++) {
        for (var j = 0; j < temparray.length - i - 1; j++) {
            count++;
            eachStepArr.push(newarray(temparray));
            highlight.push(j);
            color.push("normal");
            if (temparray[j] > temparray[j + 1]) {
                var temp = temparray[j];
                temparray[j] = temparray[j + 1];
                temparray[j + 1] = temp;
                color.push("swap");
                eachStepArr.push(newarray(temparray));
                highlight.push(j);
            }
        }
    }
    eachStepArr.push(newarray(temparray));
    totalstep = eachStepArr.length - 1;
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
    document.getElementById("progressStep").max = eachStepArr.length - 1;
    document.getElementById("slideStep").max = eachStepArr.length - 1;
}

//chinh speed khi user giu con tro chuot
function changeSpeed() {
    var spMaxValue = parseInt(document.getElementById("rangebar").max);
    var spMinValue = parseInt(document.getElementById("rangebar").min);
    var spValue = parseInt(document.getElementById("rangebar").value);
    speed = Math.abs(spValue - (spMaxValue + spMinValue));
}

//chưa sửa được lỗi

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





