/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var algoid;
var oldtime;
var dateaccess;
$(document).ready(function () {
    //id cua page
  algoid= parseInt(document.getElementById('algoid').value);  
    //
    oldtime= Date.now();
    var olddate = new Date();
     dateaccess =olddate.getFullYear() + "/"
            + (olddate.getMonth() + 1) + "/"
            + olddate.getDate() + "  "
            + olddate.getHours() + ":"
            + olddate.getMinutes() + ":"
            + olddate.getSeconds();
    
   
});


function ajaxSendData(algoid,ip_user,dateaccess,totaltime) {
    console.log(algoid);
console.log(oldtime);
console.log(dateaccess);
    $.ajax({
        type: "post",
        url: "TrackingController", //this is my servlet
        data: {algoid: algoid, ipuser: ip_user,dateaccess:dateaccess,totaltime:totaltime},
        success: function (msg) {
            $('#output').append(msg);
        }
    });
}

 $(window).on("unload", function(e) {
    var newtime= Date.now();
    
     var totaltime =  newtime - oldtime;
    
    //may nguoi dung
    window.sessionStorage.setItem('key', 'algoid');
    var ipofuser = window.sessionStorage.getItem('key');
    ajaxSendData(algoid,ipofuser,dateaccess,totaltime);
 });
 