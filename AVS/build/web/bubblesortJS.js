
N = 10; // Array Size
XYs = 5; // Element Visual Size
Xp = 1; // Start Pos X
Yp = 1; // Start Pos Y
var canvas;
//var play = true;
var currentstep = 0;
//.apply de tao ra 1 mang l co length = N , map (value 1: apply value into l,
//Number is value)
//var l = Array.apply(null, {length: N}).map(Number.call, Number);

var l = [9, 8, 7, 6, 9, 4, 3, 2, 1];
var sort = bubbleSort(l);
var run;
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
}


function init() {
    bubbleSort2(l);
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
    loadingAnimation();
    //setTimeout(loadingAnimation, 1500);

}
function next() {
    clearInterval(run);
    draw(currentstep);
    currentstep++;
    //sort.next();
}
function back() {

}
function play() {
    draw(currentstep);
    currentstep++;
    run = setTimeout(loadingAnimation, 1500);
}

function loadingAnimation() {
    draw(currentstep);
    currentstep++;
    run = setTimeout(loadingAnimation, 1500);
    //sort.next();
}

//function PauseAnimation() {
//    play = false;
//}

//ve,dc goi o init(main)
function draw(currentstep) {
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        for (var i = 0; i < mang[currentstep].length; i++) {
            ctx.fillStyle = "#AAAAAA";
            ctx.fillRect((Xp * i * 16) * XYs, Yp * XYs * 5 - 20, 30, 30);
            ctx.fillStyle = "#000000";
            ctx.fillText(mang[currentstep][i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);
            if (i == hightlight[currentstep] + 1) {
                if (color[currentstep] == true) {
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
}
function* bubbleSort(a) { // * is magic


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
}
var mang = [];
var hightlight = [];
var color = [];


function bubbleSort2(a) { // * is magic   
    var count = 0;

    for (var i = 0; i < a.length - 1; i++) {
        for (var j = 0; j < a.length - i - 1; j++) {
            if (a[j] > a[j + 1]) {
                var temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;               
                color.push(true);
            } else {
                color.push(false);
            }
            
            count++;
            mang.push(newarray(l));
            hightlight.push(j);
        }
    }
}

function newarray(array) {
    var newarray = [];
    array.forEach(function(item) {
        newarray.push(item);
    });
    
    return newarray;
}




