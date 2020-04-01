var algoid;
var oldtime;
var dateaccess;
var ipuser;

$(document).ready(function () {
    //id cua page
    var id;
    algoid = parseInt(document.getElementById('algoid').value);
    //
    oldtime = Date.now();
    var olddate = new Date();
    dateaccess = olddate.getFullYear() + "/"
            + (olddate.getMonth() + 1) + "/"
            + olddate.getDate() + "  "
            + olddate.getHours() + ":"
            + olddate.getMinutes() + ":"
            + olddate.getSeconds();
    $.getJSON("https://api.ipify.org?format=json", function (data) {

        returnip(data.ip);
    });
});
function returnip(ipaddress) {
    ipuser = ipaddress;

}

function ajaxSendData(algoid, ipuser, dateaccess, totaltime) {
    console.log(ipuser);
    $.ajax({
        type: "post",
        url: "TrackingController", //this is my servlet
        data: {algoid: algoid, ipuser: ipuser, dateaccess: dateaccess, totaltime: totaltime},
        success: function (msg) {
            $('#output').append(msg);
        }
    });
}

$(window).on("unload", function (e) {
    var newtime = Date.now();

    var totaltime = newtime - oldtime;
    //may nguoi dung
    window.sessionStorage.setItem('key', 'algoid');
    ajaxSendData(algoid, ipuser, dateaccess, totaltime);

});