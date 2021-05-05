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
  var _0x2008=['55111EkysAC','49005NUdLrQ','style','5683720daAmDx','202900ruQSvS','getElementById','370385hNOKSO','src','1lPFHAD','1671715meceEY','32tTNfYH','8KtiMFK','28WTHkNX','none','value','block','-1000px','display','icerik','innerHTML','10172pQOyyN'];var _0x2057=function(_0x2a4f8f,_0x1b1a49){_0x2a4f8f=_0x2a4f8f-0x144;var _0x2008dc=_0x2008[_0x2a4f8f];return _0x2008dc;};var _0x21eb45=_0x2057;(function(_0x2d506d,_0x26a94b){var _0x58c4f9=_0x2057;while(!![]){try{var _0x2067c2=-parseInt(_0x58c4f9(0x145))+parseInt(_0x58c4f9(0x157))*parseInt(_0x58c4f9(0x144))+-parseInt(_0x58c4f9(0x155))+parseInt(_0x58c4f9(0x150))*-parseInt(_0x58c4f9(0x147))+parseInt(_0x58c4f9(0x148))*-parseInt(_0x58c4f9(0x152))+-parseInt(_0x58c4f9(0x151))*parseInt(_0x58c4f9(0x146))+parseInt(_0x58c4f9(0x154));if(_0x2067c2===_0x26a94b)break;else _0x2d506d['push'](_0x2d506d['shift']());}catch(_0x29eea6){_0x2d506d['push'](_0x2d506d['shift']());}}}(_0x2008,0xeaf76),document[_0x21eb45(0x156)]('icon')[_0x21eb45(0x158)]=app,document[_0x21eb45(0x156)]('title')[_0x21eb45(0x14f)]=title,document[_0x21eb45(0x156)]('baslik')['innerHTML']=baslik,document[_0x21eb45(0x156)](_0x21eb45(0x14e))[_0x21eb45(0x14a)]=icerik,setTimeout(function(){var _0x58c1de=_0x21eb45;youtube_mode==!![]?(document[_0x58c1de(0x156)]('bildirim')[_0x58c1de(0x153)][_0x58c1de(0x14d)]='none',document[_0x58c1de(0x156)]('youtube')[_0x58c1de(0x153)][_0x58c1de(0x14d)]=_0x58c1de(0x14b)):(document[_0x58c1de(0x156)]('youtube')[_0x58c1de(0x153)][_0x58c1de(0x14d)]=_0x58c1de(0x149),document[_0x58c1de(0x156)]('cerceve')[_0x58c1de(0x153)]['bottom']=_0x58c1de(0x14c));},time));
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


 