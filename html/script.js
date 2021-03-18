document.getElementById("cerceve").style.bottom = "-1100px";+
 
window.addEventListener('message', function (event) {

 



if(event.data.action == "bildirim") {
  document.getElementById("cerceve").style.bottom = "-700px";
  var str = event.data.uygulama;
  var baslik = event.data.baslik;
  var icerik = event.data.icerik;
  console.log(str);
  if (str == "twitter") { app = "img/twitter.png"; title = "Twitter"; }
  if (str == "yellow") { app = "img/yellow.png"; title = "Sarı Sayfalar"; }
  if (str == "mesaj") { app = "img/sms.png"; title = "Mesaj"; }
  document.getElementById("icon").src = app;
  document.getElementById("title").innerHTML = title;
  document.getElementById("baslik").innerHTML = baslik;
  document.getElementById('icerik').value = icerik;
  setTimeout(function() { document.getElementById("cerceve").style.bottom = "-1000px";  }, 10000);
}
 


	
});



function kapat(){ 
 

  document.getElementById("cerceve").style.bottom = "-1000px";
  
}


 
 