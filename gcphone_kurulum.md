# gcphone kurulumu 

Bu gcphone en yaygın kullanılan gcphone içindir eğer triggerlarınızın isimlerinde farklı yazılar mevcutsa kendiniz konumlarını bulmanız gerekir.
 
[client/youtube.lua] youtube kurulumu
"youtube_Play" triggerini bulun ve içerisine bizim kodumuzu yerleştirin
```lua
RegisterNUICallback('youtube_Play', function(data)
    exports['co_notify']:SendNotify('youtube', data, "true") --EKLENMESİ GEREKEN KOD!
end)
```

[client/client.lua] gelen mesaj ayarı.
"gcPhone:receiveMessage" triggerini aratın ve bulun daha sonra,  if message.owner == 0 then tam altına kodu ekleyin.
 ```lua
 if message.owner == 0 then
    exports['co_notify']:SendNotify('mesaj', message.transmitter.." Tarafından gelen mesaj.", message.message) --EKLENMESİ GEREKEN KOD!
```



[server/twitter.lua] twitter gelen post ayarı.
"gcPhone:twitter_postTweets" triggerini aratın ve bulun daha sonra, local srcIdentifier = getPlayerID(source)'den sonra aşşağıdaki kodları ekleyin.
 ```lua
	local xPlayer = ESX.GetPlayerFromId(source)
	local players = GetPlayers()

    for _, i in ipairs(players) do
	      TriggerClientEvent('co_notify:client:SendNotifys', i, { app = "twitter" , title = "@"..xPlayer.getName(), content = message , source = i })
	end
```
Düzgün halinin görünmesi gerekiyor
 ```lua
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local players = GetPlayers()
    for _, i in ipairs(players) do
	      TriggerClientEvent('co_notify:client:SendNotifys', i, { app = "twitter" , title = "@"..xPlayer.getName(), content = message , source = i })
	end
    TwitterPostTweet(message, image, sourcePlayer, srcIdentifier)
```


Twitterin aynısını sarı sayfalar için uygulayın mantık birebir aynı, trigger ismi "gcPhone:yellow_postIlan", dosya [server/yellowpages.lua]
