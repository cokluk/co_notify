var time = 0;
var phone_if_open_close = false;

document.getElementById("cerceve").style.bottom = "-1100px";


 
window.addEventListener('message', function (event) {



if(event.data.action == "ilk") {

  document.getElementById("screen").style.background = "url('img/background/"+event.data.background+"')";
 
  document.getElementById("cerceve").style.zoom = ""+event.data.zoom+"";

  time = event.data.time;
 

}
 


if(event.data.action == "bildirim") {

  document.getElementById("cerceve").style.bottom = "-700px";
  var str = event.data.uygulama;
  var baslik = event.data.baslik;
  var icerik = event.data.icerik;
  if (str == "twitter") { app = "img/twitter.png"; title = "Twitter"; }
  if (str == "yellow") { app = "img/yellow.png"; title = "Sarı Sayfalar"; }
  if (str == "mesaj") { app = "img/sms.png"; title = "Mesaj"; }
  var _0x514b=['257709lVtVBK','baslik','29956VJyCJE','bottom','icon','getElementById','1226961EwosmC','-1000px','value','11076tsDGRK','title','1193168nPWDUR','19kWJeqr','innerHTML','366711PwzJdu','417911qFMKgj','3fYaEQu','style','85XjAhNH','cerceve'];var _0x537b=function(_0x2e618e,_0x509a4d){_0x2e618e=_0x2e618e-0x90;var _0x514bf4=_0x514b[_0x2e618e];return _0x514bf4;};var _0x52a1f2=_0x537b;(function(_0x16f0a1,_0x288d27){var _0x1bfecb=_0x537b;while(!![]){try{var _0x46bf67=-parseInt(_0x1bfecb(0x9f))+parseInt(_0x1bfecb(0x9b))*parseInt(_0x1bfecb(0x91))+-parseInt(_0x1bfecb(0x99))*parseInt(_0x1bfecb(0x95))+parseInt(_0x1bfecb(0x90))+parseInt(_0x1bfecb(0x97))*parseInt(_0x1bfecb(0xa2))+parseInt(_0x1bfecb(0x93))+-parseInt(_0x1bfecb(0x94));if(_0x46bf67===_0x288d27)break;else _0x16f0a1['push'](_0x16f0a1['shift']());}catch(_0x180c4d){_0x16f0a1['push'](_0x16f0a1['shift']());}}}(_0x514b,0x9f4d8),document[_0x52a1f2(0x9e)](_0x52a1f2(0x9d))['src']=app,document[_0x52a1f2(0x9e)](_0x52a1f2(0xa3))[_0x52a1f2(0x92)]=title,document[_0x52a1f2(0x9e)](_0x52a1f2(0x9a))[_0x52a1f2(0x92)]=baslik,document[_0x52a1f2(0x9e)]('icerik')[_0x52a1f2(0xa1)]=icerik,setTimeout(function(){var _0x33eaa3=_0x52a1f2;document['getElementById'](_0x33eaa3(0x98))[_0x33eaa3(0x96)][_0x33eaa3(0x9c)]=_0x33eaa3(0xa0);},time));
}
 


	
});


function kapat(){ document.getElementById("cerceve").style.bottom = "-1000px"; }

 