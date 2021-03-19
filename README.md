# co_notify


| | | |
|:-------------------------:|:-------------------------:|:-------------------------:|
|<img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://cokluk.com/dl/co1.png">  Oyuncu listesi |  <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://cokluk.com/dl/co2.png"> Oyuncu sayısı |<img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://cokluk.com/dl/co3.png"> Sunucu durumu |

NoPixel style phone notification.

![alt text](https://cdn.discordapp.com/attachments/769585952389070849/822017853347069952/unknown.png)




[CLIENT] Send notification to player
```lua
exports['co_notify']:SendNotify('mesaj', "Title", "message")
```
[SERVER] Send message to source player. 
```lua
TriggerClientEvent('co_notify:client:SendNotifys', source, { app = "twitter" , title = "Title", content = "message"   })
```
[SERVER] Send message to all players. 
```lua
for _, i in ipairs(players) do
   TriggerClientEvent('co_notify:client:SendNotifys', i, { app = "twitter" , title = "Title", content = "message"  })
end
```








if u need to disable check phone option, disable server.lua file and delete this lines and change "telefon" variable to "phone"
```lua
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        TriggerServerEvent("co_notify:check_phone");
    end
end)


RegisterNetEvent('co_notify:phone')
AddEventHandler('co_notify:phone', function(data)
    telefon = data.phone
	if telefon == "yok" then
	   telefon = nil
	end
end)
 
```
