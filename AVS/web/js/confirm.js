/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function checkyes() {
  if (confirm('Do you want to save this change?')) {
    document.getElementById("changeinfor").submit();
  }else{
      event.preventDefault()
  }
}