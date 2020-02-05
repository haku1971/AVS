
N = 10; // Array Size
XYs = 5; // Element Visual Size
Xp = 1; // Start Pos X
Yp = 1; // Start Pos Y
var canvas;
var play = true;

//.apply de tao ra 1 mang l co length = N , map (value 1: apply value into l,
//Number is value)
//var l = Array.apply(null, {length: N}).map(Number.call, Number);

var l = [9, 8, 7, 6, 9, 4, 3, 2, 1];
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
//truyen l[i] ,x=0. N =size mang (100), outmin=0,outmax=359
function map_range(x, in_min, in_max, out_min, out_max) {
    //console.log((x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min);
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

}
//truyen l[i] vao
//dc goi trong draw()
function rainbow(x) {
    var m = map_range(x, 0, N, 0, 359);
    //build ra color by HSL
    return 'hsl(' + m + ',100%,50%)';
}


function init() {
    canvas = document.getElementById('canvas');
    //l.shuffle();
    var sort = bubbleSort(l);
    // an anim function triggered every 60th of a second
    /* function anim() {
     //chay muot ma ham anim.giong nhu la thread.run
     //requestAnimationFrame(anim);
     draw();
     
     sort.next(); // call next iteration of the bubbleSort function
     }
     anim();*/

    function loadingAnimation() {
        draw();
        setTimeout(loadingAnimation, 2000);
        sort.next();

    }
    if (play) {
        loadingAnimation();
    }
}
function PauseAnimation() {
    play = false;
}

//ve,dc goi o init(main)
function draw() {
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        for (var i = 0; i < l.length; i++) {
            ctx.fillStyle = "#AAAAAA";
            ctx.fillRect((Xp * i * 16) * XYs, Yp * XYs * 5 - 20, 30, 30);
            ctx.fillStyle = "#000000";
            ctx.fillText(l[i], (Xp * i * 16) * XYs + 10, Yp * XYs * 5, 60);

            //ctx.fillStyle = rainbow(l[i]);


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



