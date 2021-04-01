# gcphone kurulumu 

Bu gcphone en yaygın kullanılan gcphone içindir eğer triggerlarınızın isimlerinde farklı yazılar mevcutsa kendiniz konumlarını bulmanız gerekir.
 
[client/youtube.lua] youtube kurulumu
"youtube_Play" triggerini bulun ve içerisine bizim kodumuzu yerleştirin
```lua
RegisterNUICallback('youtube_Play', function(data)
    exports['co_notify']:SendNotify('youtube', data, "true") --EKLENMESİ GEREKEN KOD!
end)
```
 
 
