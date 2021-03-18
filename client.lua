RegisterNetEvent('co_notify:client:SendNotifys')
AddEventHandler('co_notify:client:SendNotifys', function(data)
    print("SendNotify - client	"..data.app)
	SendNUIMessage({ action = "bildirim", uygulama = data.app, baslik = data.title, icerik = data.content })
end)

function SendNotify(app, title, content)
    print("SendNotify - serverside => ")
	SendNUIMessage({ action = "bildirim", uygulama = app, baslik = title, icerik = content})
end