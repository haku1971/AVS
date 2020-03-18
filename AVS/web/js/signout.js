/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function signOut(){
                console.log('User signed out.');
                var auth2 = gapi.auth2.getAuthInstance();
                auth2.signOut().then(function () {
                    console.log('User signed out.');
                    auth2.disconnect();
                    document.location = '/AVS/LogoutController';
                });
            }

