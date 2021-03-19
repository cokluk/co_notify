# co_notify

NoPixel style phone notification.

![alt text](https://cdn.discordapp.com/attachments/769585952389070849/822017853347069952/unknown.png)


[SERVER] Send message to source player. 
```lua
  TriggerClientEvent('co_notify:client:SendNotifys', source, { app = "twitter" , title = "@"..xPlayer.getName(), content = message   })
```
[SERVER] Send message to all players. 
```lua
for _, i in ipairs(players) do
   TriggerClientEvent('co_notify:client:SendNotifys', i, { app = "twitter" , title = "@"..xPlayer.getName(), content = message  })
end
```
