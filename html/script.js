var time = 0;
var phone_if_open_close = false;
var youtube_mode = false;
var test_mod = false;
var arama = false;
var saniye = 0;
var dakika = 0;
var intrvl_sayac = null;

setInterval(degistir, 500);
 
document.getElementById("cerceve").style.bottom = "-1100px";

window.addEventListener('message', function (event) {
 
if(event.data.action == "ilk") {

  document.getElementById("screen").style.background = "url('img/background/"+event.data.background+"')";
 
  document.getElementById("cerceve").style.zoom = ""+event.data.zoom+"";

  time = event.data.time;
 


}

if(event.data.action == "arama") { 

  var numara = event.data.numara;
  document.getElementById("anim_text").innerHTML = "0:00";
  document.getElementById("youtube").style.display   = "none"; 
  document.getElementById("bildirim").style.display   = "none"; 
  document.getElementById("arama").style.display   = "block"; 
  document.getElementById("arama_caliyor").style.display   = "block"; 
  document.getElementById("arama_devamediyor").style.display   = "none"; 
  document.getElementById("cerceve").style.bottom = "-700px";
  document.getElementById("youtube-player-1").src = "#";
  document.getElementById("youtube").style.display = "none"; 


  document.getElementById("numara1").innerHTML = numara;
  document.getElementById("numara2").innerHTML = numara;
  

  youtube_mode = false;


}

if(event.data.action == "arama_kabul") { 
  saniye = 0;
  dakika = 0;
  clearInterval(intrvl_sayac);
  intrvl_sayac = setInterval(function() {

    saniye = saniye + 1;
    
    if(saniye >= 60) { if(dakika == 0){ dakika = 1;}else { dakika = dakika + 1;}  saniye = 0; }
 
    if(saniye >= 10) { santext = "";   } else { santext = "0" ; }
    
    
    document.getElementById("sayac").innerHTML = dakika +":"+ santext + saniye;


  }, 1000);
  
  document.getElementById("arama_caliyor").style.display   = "none"; 
  document.getElementById("arama_devamediyor").style.display   = "block"; 
}

if(event.data.action == "arama_red") { 
 
  saniye = 0;
  dakika = 0;
  clearInterval(intrvl_sayac);
  document.getElementById("arama_caliyor").style.display   = "none"; 
  document.getElementById("arama_devamediyor").style.display   = "none"; 
  document.getElementById("cerceve").style.bottom = "-1100px";
  

}
 
 
if(event.data.action == "ytkapat") {

  document.getElementById("youtube-player-1").src = "#";
  document.getElementById("youtube").style.display   = "none";  document.getElementById("cerceve").style.bottom = "-1000px";
  youtube_mode = false;

}

if(event.data.action == "youtube") {

  var video_id = event.data.baslik;


  var baslik = "";
  var kanal = "";
  var foto = "";

  $.getJSON("https://www.youtube.com/oembed?url=http://www.youtube.com/watch?v="+video_id+"&format=json",function(data,status,xhr){
    baslik = data.title;
    kanal = data.author_name;
    foto = data.thumbnail_url;
    document.getElementById("yt_baslik").value = baslik;
    document.getElementById("yt_kanal").innerHTML = kanal;
    document.getElementById("ytimg").style.background = "url('"+foto+"')";
    document.getElementById("ytimg").style.backgroundPosition = "center center";
    document.getElementById("ytimg").style.backgroundSize = "cover";
    document.getElementById("youtube-player-1").src = "https://www.youtube.com/embed/"+video_id+"?autoplay=1&loop=1&playlist="+video_id+"&amp;enablejsapi=1&amp;origin=nui%3A%2F%2Fgcphone&amp;widgetid=1&amp;";
 });
 
 
  if(event.data.icerik == "true") { youtube_mode = true;  }else { youtube_mode = false; }
 
  document.getElementById("cerceve").style.bottom = "-700px";
  document.getElementById("bildirim").style.display   = "none";
  document.getElementById("youtube").style.display   = "block";

}


if(event.data.action == "bildirim") {
  
  document.getElementById("cerceve").style.bottom = "-700px";
  document.getElementById("youtube").style.display   = "none";
  document.getElementById("bildirim").style.display   = "block";
  var str = event.data.uygulama;
  var baslik = event.data.baslik;
  var icerik = event.data.icerik;
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


function kapat(){ document.getElementById("cerceve").style.bottom = "-1000px"; }

var sol = "<";
var sag = ">";

if(test_mod == true) {

  document.getElementById("youtube").style.display   = "none"; 
  document.getElementById("bildirim").style.display   = "none"; 
  document.getElementById("arama_caliyor").style.display   = "none"; 
  document.getElementById("cerceve").style.bottom = "-700px";


}

 
function degistir(){
  
  if(sol.length > 2) {  sol = "<"; } else { sol = sol + "<";  }
  if(sag.length > 2) {  sag = ">"; } else { sag = sag + ">";  }
  
  document.getElementById("anim_text").innerHTML = sol+" Etkileşim yön tuşları "+sag;
}


 