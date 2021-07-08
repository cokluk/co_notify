# co_notify 


| | | |
|:-------------------------:|:-------------------------:|:-------------------------:|
|<img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://cdn.discordapp.com/attachments/769585952389070849/822017853347069952/unknown.png">  SMS APP |  <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://user-images.githubusercontent.com/47196492/113233013-f3f3ce00-92a6-11eb-9c79-c4b643396b1e.png"> YouTube |<img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://cdn.discordapp.com/attachments/766379633318035456/822389056041779230/unknown.png"> Twitter |

NoPixel style phone notification.

 


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
TriggerClientEvent('co_notify:client:SendNotifys', -1, { app = "twitter" , title = "Title", content = "message"  })
```



 
![Sayaç](https://profile-counter.glitch.me/co_notify/count.svg)
