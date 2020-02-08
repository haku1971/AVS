
N = 10; // Array Size
XYs = 5; // Element Visual Size
Xp = 1; // Start Pos X
Yp = 1; // Start Pos Y
var canvas;
//var play = true;
var currentstep = 0;
var totalstep;
//.apply de tao ra 1 mang l co length = N , map (value 1: apply value into l,
//Number is value)
//var l = Array.apply(null, {length: N}).map(Number.call, Number);
//var speed = 500;
var l = [9, 8, 7, 6, 9, 4, 3, 2, 1];
//var sort = bubbleSort(l);
var run;
var boolRun = true;
var arr_by_user = [];
var speed = 1000;
//suffle chinh la random ra so
Array.prototype.shuffle = function () {
    //i = 100 vi lấy length của màng này =100
    var i = this.length,
            j, temp;
    if (i == 0)
        return this;
    while (--i) {
        j = Math.floor(Math.random() * (i + 1));
        temp = this[i];
        this[i] = this[j];
        this[j] = temp;
    }

    //return ra 1 mang chứa các số random j
    return this;
};


function init() {
    bubbleSort2(l);
//    speed = parseInt(document.getElementById("rangebar").value);
    canvas = document.getElementById('canvas');
    //l.shuffle();
    // an anim function triggered every 60th of a second
    /* function anim() {
     //chay muot ma ham anim.giong nhu la thread.run
     //requestAnimationFrame(anim);
     draw();
     
     sort.next(); // call next iteration of the bubbleSort function
     }
     anim();*/

    draw(currentstep);
    run = setTimeout(loadingAnimation, speed);
    boolRun = true;
    //setTimeout(loadingAnimation, 1500);

}
//tinh hinh la can 1 method hoac 1 phuong thuc co san nao do de gioi han 
//gioi han viec next hoac prev
//tuong tu cung chay san file javascript chi cho phep nhap vi tri 

function next() {
    clearInterval(run);
    if (currentstep < mang.length - 1) {
        currentstep++;
        draw(currentstep);
    }

    //check de cho phep next tiep hay ko
    boolRun = false;
    document.getElementById("PauseOrCon").value = 'Resume';
}

//ham return ra 1 mang chua cac so ham nhan constructor la 1 mang
function integerArray(arr) {
    for (var i = 0; i < arr.length; i++) {
        //if check ma la co ki tu khong phai so
        if (!isNormalInteger(arr[i])) {
            //hien ra alert() len trang index
            window.alert("Please enter number slice by a comma");
            break;
        }
        //neu khong thi xay dung ra mot cai mang
        else {
            number_of_arr = parseInt(arr[i]);
            arr_by_user.push(number_of_arr);
        }
        return arr_by_user;
    }
}
//Nhập input bởi bàn phím
function inputByUser() {
    if (arr_by_user !== null) {
        arr_by_user = null;
    }
    //get về data người dùng nhập
    //neu mang input khac rong thi set ve thanh rong truoc da
    arr_by_user = document.getElementById("txtElement").value.split(',');
    l = integerArray(arr_by_user);
    bubbleSort2(l);
    canvas = document.getElementById('canvas');
    loadingAnimation();
    boolRun = true;
}
//function kiem tra la so Integer by regex
//đã test thử chất lượng hàm này
function isNormalInteger(str) {
    return /^\+?(0|[1-9]\d*)$/.test(str);
}
// nhảy step by giá trị nhập trên trang html
function chooseStep() {
    clearInterval(run);
    //lấy về value step của người dùng nhập
    stringstep = document.getElementById("txtSteps").value;
    //check xem là số nguyên hay không
    if (isNormalInteger(stringstep)) {
        stringstep = parseInt(stringstep);
        currentstep = stringstep;
        draw(currentstep);
        //hiện ra thông báo để người ta biết     
    } else {
        window.alert("Please input a integer number!");
    }
    boolRun = true;
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

function restart() {
    clearInterval(run);
    currentstep = 0;
    draw(currentstep);
    run = setTimeout(loadingAnimation, speed);
    document.getElementById("PauseOrCon").value = 'Pause';
    boolRun = true;
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
    if (currentstep < mang.length - 1) {
        currentstep++;
        draw(currentstep);
    }
    run = setTimeout(loadingAnimation, speed);
    //sort.next();
}


//ve ra lai cai mang
function draw(currentstep) {
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        for (var i = 0; i < mang[currentstep].length; i++) {
            ctx.fillStyle = "#AAAAAA";
            ctx.fillRect((Xp * i * 16) * XYs, Yp * XYs * 5 - 20, 30, 30);
            ctx.fillStyle = "#000000";
            ctx.fillText(mang[currentstep][i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);

            //highlight
            if (currentstep !== 0 && currentstep !== mang.length - 1 && i === highlight[currentstep] + 1) {
                if (color[currentstep] === "swap") {
                    ctx.fillStyle = "#FF6767";
                    ctx.fillText(mang[currentstep][i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);
                    ctx.fillText(mang[currentstep][i - 1], (Xp * (i - 1) * 16) * XYs + 10, Yp * XYs * 5, 60);
                } else {
                    ctx.fillStyle = "#21A4F3";
                    ctx.fillText(mang[currentstep][i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);
                    ctx.fillText(mang[currentstep][i - 1], (Xp * (i - 1) * 16) * XYs + 10, Yp * XYs * 5, 60);
                }
                //ctx.fillStyle = rainbow(l[i]);
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
}


/*function* bubbleSort(a) { // * is magic
 var swapped;
 var ctx = canvas.getContext('2d');
 do {
 swapped = false;
 for (var i = 0; i < a.length - 1; i++) {
 //Tat mau 2 cai truoc
 ctx.fillStyle = "#000000";
 ctx.fillText(l[i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);
 ctx.fillText(l[i - 1], (Xp * (i - 1) * 16) * XYs + 10, Yp * XYs * 5, 60);
 //mau xanh 2 cai dang xem xet i va i+1
 // ctx.fillStyle = "#AAAAAA";
 // ctx.fillRect((Xp * i * 16) * XYs,Yp * XYs*5-20, 30, 30);
 ctx.fillStyle = "#21A4F3";
 ctx.fillText(l[i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);
 ctx.fillText(l[i + 1], (Xp * (i + 1) * 16) * XYs + 10, Yp * XYs * 5, 60);
 if (a[i] > a[i + 1]) {
 //doi mau do 2 cai can so sanh
 ctx.fillStyle = "#FF6767";
 ctx.fillText(l[i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);
 ctx.fillText(l[i + 1], (Xp * (i + 1) * 16) * XYs + 10, Yp * XYs * 5, 60);
 
 var temp = a[i];
 a[i] = a[i + 1];
 a[i + 1] = temp;
 swapped = true;
 }
 yield swapped; // pause here
 }
 } while (swapped);
 }*/
var mang = [];
var highlight = [];
var color = [];

function newarray(array) {
    var newarray = [];
    array.forEach(function (item) {
        newarray.push(item);
    });

    return newarray;
}

function bubbleSort2(a) { // * is magic   
    var count = 0;
    mang.push(newarray(l));
    highlight.push(0);
    color.push(0);
    for (var i = 0; i < a.length - 1; i++) {
        for (var j = 0; j < a.length - i - 1; j++) {
            count++;
            mang.push(newarray(l));
            highlight.push(j);
            color.push("normal");
            if (a[j] > a[j + 1]) {
                var temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
                color.push("swap");
                mang.push(newarray(l));
                highlight.push(j);
            }
        }
    }
    mang.push(newarray(l));
    totalstep = mang.length - 1;
    document.getElementById("txtStepcount").innerHTML = '' + (currentstep + 1) + "/" + (totalstep + 1);
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





